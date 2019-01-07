Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1708AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:43:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0A442183E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZbT0YTUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A442183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yW0xadeTYJC/2KKlkc+MC1FE+LyyE6nuFi7n+Pmj70g=; b=ZbT0YTUWAn9Nee
	TwVKIA7/Ul/auVDSiYI4N6IjghG3fh3hPhJGjzh9ddEo2cTZJIRKrVkaA30AkHi0sNtjQwlHSQZRd
	f0roBSs17wkF8j3qrUGx2HNufX07G5Qib/u1DXsVuO03CNtGpFBrZEeiS3yzvwman532gi16O/2AS
	2arqMfPmV0Y3OLetGH7jZ+lWmGVkIf1I7paDx85ZFpxx6j81cbpt0yxNe3wCo4AMvXOEdVKG5bbWK
	kJfjN65/MN6DugLi32msJObeqW3n6JuUK8ah/UM6i+HlImqEEzpTsCHjOswDTx6gbWY/mIJmTwkFF
	2+3blBiLgCuNv6vq18VQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggao8-0004n6-Cj; Mon, 07 Jan 2019 19:43:32 +0000
Received: from mail-ed1-f66.google.com ([209.85.208.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggao5-0004mb-0T
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 19:43:30 +0000
Received: by mail-ed1-f66.google.com with SMTP id o10so1990892edt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 11:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=QbcsgA437JRwXRdJuKKrTWpwd9J769Z1gTHyqC2hzVw=;
 b=aC9bJb7rGMQh2vc1fxMIuWtqKbbenfIavKx5cIGK019g47RcYcwiTd8JCHl2jbMZ71
 0pWBXCjeMYTNlmCp/gqKKj9Q6qMluvGD3Bciv4m4PWHqH+nYgy4TtJyi/GVA8vGqrDe+
 ho1iWFyLzuKz28mHMYMz6Qu2w2fY/sRz7b8LrkN3Iw77rFd9MCSE4zSjBm3WZRyIoBGW
 mp7szc8mDduiUTtc1MyEhYhUPEJVWHm7nS3+OzO1/lvF6pwcA7yqSvdaxfXRB9Bw1i3R
 BduHdFLTDugyjNahCNUk9HHYKCMzkzqy8vLh7ACMp5VYXuI7XLQWJWXt5O2qwa1ZJJ7B
 uIZQ==
X-Gm-Message-State: AA+aEWaqqLW19YBTGDF8toMkl08bhVoti99S4n/6SHTuDb3WkLnKEZ2f
 qkNbNmKUOiB9fJn7ai1094iwUz4CjTA=
X-Google-Smtp-Source: AFSGD/XICWzeAB+Axq/KZkTrA3BqyYJ0HYyf/e4yhqC1UTcXCNi5iayZIQpWwhoMTqaWfY0WEEfM6w==
X-Received: by 2002:aa7:c152:: with SMTP id r18mr57710418edp.258.1546890207126; 
 Mon, 07 Jan 2019 11:43:27 -0800 (PST)
Received: from kozik-lap ([194.230.155.148])
 by smtp.googlemail.com with ESMTPSA id c29sm31310075eda.75.2019.01.07.11.43.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 07 Jan 2019 11:43:26 -0800 (PST)
Date: Mon, 7 Jan 2019 20:43:24 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] ARM: mach-s3c24xx: Fix boolean expressions in
 osiris_dvs_notify
Message-ID: <20190107194324.GC3313@kozik-lap>
References: <20190103201408.GA27754@embeddedor>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190103201408.GA27754@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_114329_046995_5A9ECC20 
X-CRM114-Status: GOOD (  12.45  )
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
Cc: linux-samsung-soc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, Ben Dooks <ben@simtec.co.uk>,
 Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 03, 2019 at 02:14:08PM -0600, Gustavo A. R. Silva wrote:
> Fix boolean expressions by using logical AND operator '&&'
> instead of bitwise operator '&'.
> 
> This issue was detected with the help of Coccinelle.
> 
> Fixes: 4fa084af28ca ("ARM: OSIRIS: DVS (Dynamic Voltage Scaling) supoort.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  arch/arm/mach-s3c24xx/mach-osiris-dvs.c | 8 ++++----

Thanks, applied with fixing up -Wparentheses warning. I think you should
update your GCC.

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
