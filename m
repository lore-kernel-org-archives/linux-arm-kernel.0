Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F62DC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:36:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E25B2083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VAK0y8Db";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ub1GweDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E25B2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PkgXKU5DlkbE+YrIoLtE4OfMoEzlf+N4ayx3QJQ8z90=; b=VAK0y8Db/GmiPT
	IhFIzHVp97P9/Qz/I7MvzTTDugNJSxKbzgQN4dZ5fw47zQ536J1JVFdmwoNqsGUOBKT0RuCJy6xL4
	N2TnGA8rG92A9hKvksMcB4knEyRmXX2HxbEmQ7nfY2L6frD1cKSSAL09ZWv3C/U7KGSE3lFpoCe0c
	n6T/ZwypgWahxV7VbpYq9fgWZfPdzeAN5ZZ4Xi0NyFyWyMB6v7GHflSZuHxMQmQY6Bkllmxkz0AAJ
	5hVZ3igWywe+Cm6KuJOCcYqMc9IzIthEzX8T37V9en1xMkZTlnS+IbPmBKVK6j9cYqsHv3GWIOfzZ
	B2mmOBOt73egSRtFUnSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVK3B-0002Ge-8M; Fri, 07 Dec 2018 17:36:29 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVK38-0002Fb-Qa
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 17:36:28 +0000
Received: by mail-pf1-x444.google.com with SMTP id b7so2260172pfi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 09:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=InQ3Z4HbCnPz3pvoWdA9mJyPnl/wWHBDkosKcL+xHjA=;
 b=Ub1GweDrbck0HEDikd6VmDp3NZUnXJfgE7yLlUV93wtPtSFfnTLkSQnyW6mI5Bl+wz
 aHBALh5gTRD0kKbyM07Xfs0jE46LZL95LkGluLXcWx9IbKatZtU5GrZkNrfwJ4DMKYK2
 wZY3fHSIxwWFcC8xUqdEDhZs46fwcoxszNNtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=InQ3Z4HbCnPz3pvoWdA9mJyPnl/wWHBDkosKcL+xHjA=;
 b=EqnpCik0J414dSFbZenjyAaiXBpKh/JmpuirlTDVrnwFd7fh6whMxu7NDvAWh759FS
 6FGyPqumiS0eam1UQSvM7oddeX8Tx4hej0g4iyq+TV8pbmJTdhVH/btVF1Vycxe+xq0k
 cidwM0Jts0anWSF5GlcVlaWno32luXE+QXquOkm0eDMvtcJ7maE2c+eoIMTJDYhoN6/I
 1PQDGGmnNCx4Lx8PQGhQYSW6xosMI5yQZJ4bidR3sFO+VY382j9KBfjdl2q7T7URQOju
 LVuluK44kOzF38G9xR0i8NlJtuKysktZJiyHy8VGYviV+1G6HHg1zikf73bUfkPERpxl
 0VRQ==
X-Gm-Message-State: AA+aEWY4VqoWc05dJgAK+vj0mbDFb2dd8FIQkubiTX9VwIUNAjmpAlSM
 jagpLrsmfACOaEq70S0cIBQHjMXASHw=
X-Google-Smtp-Source: AFSGD/X+/VAWh2v+fQZtH8PGpkgwuQ3tR7+x5gfUjCvsB9wqNUHo9eBf/d7r/2NDadmzD9hiJmkLqA==
X-Received: by 2002:a62:824c:: with SMTP id w73mr3116811pfd.150.1544204175926; 
 Fri, 07 Dec 2018 09:36:15 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id e86sm6012638pfb.6.2018.12.07.09.36.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 09:36:15 -0800 (PST)
Date: Fri, 7 Dec 2018 10:36:13 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] coresight: Use of_node_name_eq for node name comparisons
Message-ID: <20181207173613.GA27493@xps15>
References: <20181205195050.4759-34-robh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181205195050.4759-34-robh@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_093626_862557_30121480 
X-CRM114-Status: GOOD (  16.61  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 01:50:50PM -0600, Rob Herring wrote:
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/hwtracing/coresight/of_coresight.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
> index 89092f83567e..7045930fc958 100644
> --- a/drivers/hwtracing/coresight/of_coresight.c
> +++ b/drivers/hwtracing/coresight/of_coresight.c
> @@ -80,8 +80,8 @@ static struct device_node *of_coresight_get_port_parent(struct device_node *ep)
>  	 * Skip one-level up to the real device node, if we
>  	 * are using the new bindings.
>  	 */
> -	if (!of_node_cmp(parent->name, "in-ports") ||
> -	    !of_node_cmp(parent->name, "out-ports"))
> +	if (of_node_name_eq(parent, "in-ports") ||
> +	    of_node_name_eq(parent, "out-ports"))
>  		parent = of_get_next_parent(parent);

Applied - thanks.

>  
>  	return parent;
> -- 
> 2.19.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
