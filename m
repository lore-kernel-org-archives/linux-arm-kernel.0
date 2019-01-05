Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EED5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:05:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C1E22087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MVl1ANLp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kqatag9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1E22087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YvluHod43WAEKnE/xYhYkXfVbQY4J6SrqiVrFh8b5zw=; b=MVl1ANLp+KOHtl
	bnQIIJ5KGS1lpuUcaZXu9yJkPsWYroV3Y3ON8HPHeCLJBMY0Gf70+Ee+ip9wC8NswCV2pKxkafK8U
	ztM5txTp7IhqVy9ifmJTvKs09cWov5UexqTlmMUU+g0lQrwK+xkvQNQLlh/RlLjYEwwWwg5uKMtTx
	Q03ED2SsVd8IU9OR9ea85ZRypIR+NhCLLyzohvi24xONNk5BDrhmKWsqPfDYLtKDxTXzim8AYvQlG
	5/BLjkEhOLGHe6QSbdT9AXnVsjBbFwhNu5tJ16RuIk5/lxVO4uJ3dFEG/iPnaaN1bNiwDd1ZKj8XW
	RXOFg44/CdkyM7cVD/kQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfoSC-00087M-6O; Sat, 05 Jan 2019 16:05:40 +0000
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfoS8-00086d-6B
 for linux-arm-kernel@lists.infradead.org; Sat, 05 Jan 2019 16:05:38 +0000
Received: by mail-qk1-x744.google.com with SMTP id g125so23180719qke.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 05 Jan 2019 08:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=DofsYHGlHReMdEjck/lc0c31k6QtolUTRKj3J6/OETU=;
 b=kqatag9Jn3wzz5RHgcpAWsulW5XfTUGkR/B1pNtmyDojwEzx5rIkiIIg/qLaxm77zv
 nKPfgjpOIosNHB7IY7K748m+XoVrpW4laoU2zbllNLH1qBHACkH7/ZL4EgRT/Mqmy4IW
 5U05/jvmBNY+oSbd/YqoBbFbBqRw9NU3Pj8kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=DofsYHGlHReMdEjck/lc0c31k6QtolUTRKj3J6/OETU=;
 b=j1Dq2iP8mFTLCvblZFIW4U+7q87pxUq6jdWKGO9HlErPimrOdSDr8w3IXa9BRLeeVV
 o/1wyLmHDEhCAlGvabD4GE4rX+E+cWCgwRrn0UuQaoWcfxGzIqzLA7F9o8U8z5wZCFQd
 a9Deh/k7asIPxzYbOtuI1ecRbk9RyAeVLfl3vBw+oQ+tyaaa3AWCNDP6VHVCVDGn3AhS
 KRevk3mb438JGo1y7V5jZUVzCgG5rQKq7egL8M6diy45VBNWCmo41AzcNUuL1D4X5hO7
 OLkNURahPA0WDMICn/bVroEUb3EDejA0KQn4G7pVg+FbuWFAYo7qa2hES8/WVhXV0NlW
 qMIg==
X-Gm-Message-State: AJcUukfc+KWocvh+mq0g8mXTOedO+p6Yq02bKNvPB+sDlwL/kDscYFZ9
 yozzu+4uR4YnqJbqqY5bI8WulQ==
X-Google-Smtp-Source: ALg8bN6BTLnd5jbcD82FI1pfk/Z5cUa8xhspCc2lJfNwXw4R/f/xIFojEa3s8aKT+aPsqGlSJg34tQ==
X-Received: by 2002:a37:5189:: with SMTP id
 f131mr50513248qkb.309.1546704332160; 
 Sat, 05 Jan 2019 08:05:32 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca.
 [70.82.104.228])
 by smtp.gmail.com with ESMTPSA id v2sm26664205qte.75.2019.01.05.08.05.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 05 Jan 2019 08:05:30 -0800 (PST)
Date: Sat, 5 Jan 2019 11:05:24 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v2 1/3] ARM: fix argument count to match macro definition
In-Reply-To: <591c1d362838b8a83e1fdfea37f7b48fd85dbf44.1546551693.git.stefan@agner.ch>
Message-ID: <nycvar.YSQ.7.76.1901051104550.1783@knanqh.ubzr>
References: <cover.1546551693.git.stefan@agner.ch>
 <591c1d362838b8a83e1fdfea37f7b48fd85dbf44.1546551693.git.stefan@agner.ch>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190105_080536_229034_D3CF223A 
X-CRM114-Status: GOOD (  16.20  )
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
Cc: mark.rutland@arm.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
 peterz@infradead.org, will.deacon@arm.com, julien.thierry@arm.com,
 ndesaulniers@google.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
 mingo@redhat.com, natechancellor@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 3 Jan 2019, Stefan Agner wrote:

> The macro str8w takes 10 arguments, abort being the 10th. In this
> particular instantiation the abort argument is passed as 11th
> argument leading to an error when using LLVM's integrated
> assembler:
>   <instantiation>:46:47: error: too many positional arguments
>     str8w r0, r3, r4, r5, r6, r7, r8, r9, ip, , abort=19f
>                                                 ^
>   arch/arm/lib/copy_template.S:277:5: note: while in macro instantiation
>   18: forward_copy_shift pull=24 push=8
>       ^
> 
> The argument is not used in the macro hence this does not change
> code generation.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/lib/copy_template.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/lib/copy_template.S b/arch/arm/lib/copy_template.S
> index 652e4d98cd47..2d54491b0e22 100644
> --- a/arch/arm/lib/copy_template.S
> +++ b/arch/arm/lib/copy_template.S
> @@ -241,7 +241,7 @@
>  		orr	r9, r9, ip, lspush #\push
>  		mov	ip, ip, lspull #\pull
>  		orr	ip, ip, lr, lspush #\push
> -		str8w	r0, r3, r4, r5, r6, r7, r8, r9, ip, , abort=19f
> +		str8w	r0, r3, r4, r5, r6, r7, r8, r9, ip, abort=19f
>  		bge	12b
>  	PLD(	cmn	r2, #96			)
>  	PLD(	bge	13b			)
> -- 
> 2.20.1
> 
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
