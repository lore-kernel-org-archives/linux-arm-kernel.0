Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C964BC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:10:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 935E52175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MLGdDEVI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kYmcCNnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935E52175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WDvvdgwwzEjyLjCZ3PGvxnps0Dranr3T2i1p1JCPbMU=; b=MLGdDEVIxasVUz
	KvJXLHeNGPsswtVSVV7FCA4BgqZ3ZwzLko9azLNnMAFQ9M5XGbWpETlyjNbHI8FC1xUCkhSSmJC/s
	8oH4Hu1ZC0Zp5+KwNsuR3XE7KOVzuGdNh2F5jjCvPuH/UeXPwIfjc6OYxbsOKg5qJXbBwQp3aN96T
	O7HBbGtdT68XfNpL2LpcG6xL3bBzErkliT1s+FaQsvFSU9WM/OqKZtDpiJcbF9MeismYaO2l1/Wuo
	6A4Rjr5+3qVR+kDHUiiCkb3lKLfje5clzNQR+gsW2ifGiNb4s9kprA7Uss0wb0a4kfwKHLbngrxam
	93bZpFBE0ma8Q9AdfTbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grmFx-0005kg-S6; Thu, 07 Feb 2019 16:10:29 +0000
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grmFq-0005jE-1M
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 16:10:28 +0000
Received: by mail-qk1-x744.google.com with SMTP id u188so229310qkh.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 08:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=nLKu2Ce48SbsIOliZjWYYBEGchd5P2cptNKDEpsxe7A=;
 b=kYmcCNnkuY2iAEyigKxDmit5+sQ0ZmcHHX2MwM9w1yNdosCIQBv/a1itlAepYXa13L
 6CBHHD+WcFY4s6gwO/5j+dC9Mwqr8mXOCHnwAD4+/I7AQv06md31uLmxfDzRDzVn+XH9
 9o0uFd3wx/1Oume2taJpqiAY2jAZmMI7kZwz95mYRrVWQoPUGsEAdZKeOjvBStVgNcwH
 oXJy9vy2oICkAivcxtgacsxAhOsl3n7+OUADosxdaS4h3sj56EqXRpPvZ1VndcVcaXUv
 rFrnHQ4gnnaCSnAjVn2d1PJphptAJQ5SajZUPlO8hOf/9y7n2H2EQfbGm+ekP8tmGQWs
 pAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=nLKu2Ce48SbsIOliZjWYYBEGchd5P2cptNKDEpsxe7A=;
 b=fTldOzgEEcwZomhOnu/VLhkikpnN8XsWwvrKGq17nftBG6fJBecLLwgUT4+7qGMH8s
 pcI9nR3vmJqUEft3dHO8sHMtXG1Hlqr7116WbydsDGTuXcQMj8tFub0KvvM5exwMIMCT
 FcsFjxB7I5lICKR2CYfGUdaqIRawV6G4tAl7s6Xc+IM+hn1vqnLDQIK5YTfw/Udn4QqW
 jL41QMLxz1CnCA5dCPusaoiNLJ8z4+1AYbKKZrEIO482FDEKME6dgDg1Xn7CRMP9s4Qi
 EfqfZCzyT1ZNCll5Fao6o7ge2Q1B+bhcA1ml5dBZAlVCwdjT2eWvO/KmtUrfh2pko2rD
 eWjA==
X-Gm-Message-State: AHQUAuaP/69m9J6M5xQtuYeCoWBNQOW0K32HFchsuBWzReItvuXec3n7
 OEhSE/omWZEfILoeJEuo1mvATQ==
X-Google-Smtp-Source: AHgI3Ib8wHs2EOKVBWXcyiIIYAhB852YPrAyjvKSHZs1Vt2ESLuqCOGBW1yI+jCL2rTXi3mN81wLyA==
X-Received: by 2002:a37:e406:: with SMTP id y6mr11995955qkf.216.1549555819238; 
 Thu, 07 Feb 2019 08:10:19 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca.
 [70.82.104.228])
 by smtp.gmail.com with ESMTPSA id a185sm24550182qkb.1.2019.02.07.08.10.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 08:10:17 -0800 (PST)
Date: Thu, 7 Feb 2019 11:10:16 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH 2/5] ARM: use unified assembler in headers
In-Reply-To: <b670feebd5e0bbc4c93d3f31f45bd0243b32425f.1549532513.git.stefan@agner.ch>
Message-ID: <nycvar.YSQ.7.76.1902071055380.2213@knanqh.ubzr>
References: <cover.1549532513.git.stefan@agner.ch>
 <b670feebd5e0bbc4c93d3f31f45bd0243b32425f.1549532513.git.stefan@agner.ch>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_081022_081822_3E26E9F8 
X-CRM114-Status: GOOD (  14.23  )
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
 will.deacon@arm.com, julien.thierry@arm.com, ndesaulniers@google.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
 natechancellor@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 7 Feb 2019, Stefan Agner wrote:

> Use unified assembler syntax (UAL) in headers. Divided syntax is
> considered depricated. This will also allow to build the kernel
> using LLVM's integrated assembler.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/include/asm/assembler.h | 8 ++++----
>  arch/arm/include/asm/vfpmacros.h | 8 ++++----
>  arch/arm/lib/bitops.h            | 8 ++++----
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index 28a48e0d4cca..60465b55683c 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -376,7 +376,7 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
>  	.macro	usraccoff, instr, reg, ptr, inc, off, cond, abort, t=TUSER()
>  9999:
>  	.if	\inc == 1
> -	\instr\cond\()b\()\t\().w \reg, [\ptr, #\off]
> +	\instr\()b\cond\()\t\().w \reg, [\ptr, #\off]

Similar comment here: you added a \() between \instr and b as needed, 
but the one between \cond and \t (which was already redundant before) 
may go.


Nicolas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
