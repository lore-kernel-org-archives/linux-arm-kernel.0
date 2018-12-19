Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD270C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:03:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA286218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q7DVq/JS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA286218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=el02GHdafuWoX/kvYqVsmOZdsiH+BTCgQprZRHlDdQA=; b=Q7DVq/JSZ7AD3N
	CxxowoXZtKulfjoRZndJYq+UWeTaHf/jqW4MCaU0o39tUZgA3sZnkz0ipgySldSmPtpPV9zyEdQWJ
	1TiD6Ha6IKgQJg8tFwoqhlaoCAl3hLPNM97DG6O+DpAW/zIkUQwRhKqOb8IEFe8fokrJcOnQhbZAj
	3gJ2FeqBY4yXtGPbIPuPjeO4XVE3RDBBo8TR5OAddvDcvtdXVyPUe/58Ted2XnjGXY7csxJYRxEyG
	J0h2Gv69WLIU7W3ZaG6QAsN58jGe/cNKKDKdtPOAKf4f8DbRSvRmXYzut4jsrPZyv+qu06GRJXP7/
	V5TYXrGLUVgpUpBnmsVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZcRr-0006HS-26; Wed, 19 Dec 2018 14:03:43 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZcRj-0006DR-1C
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 14:03:41 +0000
Received: by mail-ot1-f65.google.com with SMTP id f18so19134273otl.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 06:03:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=87Q7t3au6AiYONenqf5bXOf5YLbZmUmIIK0zrYw8Hcw=;
 b=nYJpPLzUqljkjGbH1Jcf45PObukwSq/oN1uuavOKM3nYXDdqSf0YLeN2S6YN5Ax1Mf
 0IHca1N2039a9k7IR/PCFBQu/GBh/nOIaJcy+GapHY4Awlt/ihxX3BWnUFucHK4gk0DW
 0YVf2UfRO7U/Eur1WeGubGRauhX7juDySx9nMHqIogmojRoOQSVxMY9hgRiBfTYYmetQ
 BlfA9oEgYsgYsm5RJoWbK7cjaxdqYBpjovU3eKilXjq6lAGI+L9HblUmtSk1IeMlgqPl
 xn/D/z+GvevqkNWUQJ4lDIAfRLzdQwHXnPuT3XtcwAz+f8GnWu1XU+o/CCazrG35Gmit
 9prg==
X-Gm-Message-State: AA+aEWZ+5VdF+n3adBkhfcBHFTo2PPvDIzjxTyUDOtzST10IGzrzqDNm
 3CnRb7Zy92xPmDc8N9S4IQ==
X-Google-Smtp-Source: AFSGD/XzNGl2JnxcMIsUYgcd3IY+N80IVcHEYNvfAS8bHRjJBgUlUj1/b2jaHmLT2xiGS1vLmAdwXg==
X-Received: by 2002:a9d:6c94:: with SMTP id c20mr14651848otr.251.1545228203951; 
 Wed, 19 Dec 2018 06:03:23 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id 4sm9109358otw.39.2018.12.19.06.03.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 19 Dec 2018 06:03:23 -0800 (PST)
Date: Wed, 19 Dec 2018 08:03:22 -0600
From: Rob Herring <robh@kernel.org>
To: Mesih Kilinc <mesihkilinc@gmail.com>
Subject: Re: [RFC PATCH 03/10] dt-bindings: dmaengine: Add Allwinner suniv
 F1C100s DMA
Message-ID: <20181219140322.GA6620@bogus>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
 <7322bdfcd38cdcd8ccec56fea25492e4945d498f.1543782328.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7322bdfcd38cdcd8ccec56fea25492e4945d498f.1543782328.git.mesihkilinc@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_060335_071399_198B8EAF 
X-CRM114-Status: GOOD (  12.15  )
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Vinod Koul <vkoul@kernel.org>, Mesih Kilinc <mesihkilinc@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Jaroslav Kysela <perex@perex.cz>, linux-sunxi@googlegroups.com,
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon,  3 Dec 2018 00:23:10 +0300, Mesih Kilinc wrote:
> Add compatible string for Allwinner suniv F1C100s DMA.
> 
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> ---
>  Documentation/devicetree/bindings/dma/sun4i-dma.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
