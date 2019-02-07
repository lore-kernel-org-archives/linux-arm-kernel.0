Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29F0C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:53:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7070121904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i/lPBxZU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CVut03Jt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7070121904
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=87hEyWpCzZORSqwlEa30JigoNLWcsdN8JisawA2jte4=; b=i/lPBxZUROTI9i
	jRgKSyEic9W0ydbyhX2F/fbk2y0PSTeJDQD3XLwZoncrpAW6JwNASiFQyAR22+xp5Ea93GS3NoBIb
	HVV9dZJkdGa5dR9jg5gIjXso1RleGMeiv02RTk8GXW89/wg8X9f0axHRg4z97CxKzQDoEu7EHfUA0
	Wj8vhyIiny/zpZeyL4bUD39SmmN0oM1E2WKEkwnaDInv8Af95FjA9ulvbE+L7jQHZR8oYK5Mw2peR
	dVyyYVo3kERyU/ZG9RjP8egzczy+1NlyehNZ2oVkxJ1eDUENxVShM4fpOczKrtqbrIK2GdKM/vxdx
	dIlwVVRkLU1I1EMWQltA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grlz4-0006A9-JF; Thu, 07 Feb 2019 15:53:02 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grlz0-00066K-1G
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 15:53:00 +0000
Received: by mail-qt1-x841.google.com with SMTP id b15so346990qto.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 07:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=N3sRoWnV8l9cuish6xpPYCWFViw68bxZ7EA3iVa8O1s=;
 b=CVut03Jtn8IM+EcNxiK6siZZHgvwBNTkWRJ/DbHXGHeW9XZieuz3U0QMflo32eYDCK
 YZEcpTmOw1oqbwkZlcKXedeRksRe0eh0m9p/SKFp0FS8500yGKQQ8fcVkUgMCka2qGRQ
 Z5ipqvZYbTmYvTZdRQgkfccPZRTgx7C3hW/U77eveMpRGCxHcoeoiQJ4Bt1V6RrnqLId
 +qx/sqtI38t+RH3KVicP2dqX4/FZDcp4FYktDb/Z+H1IpU5Pws84DxQ/a+rdpnfNOuyy
 FyFWnvYkuJlFUgkT7icdrXuXysr0ntTcgTLoZtO9Ulc7kLaH6lOnmmOz8F7WvASmDkOB
 mCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=N3sRoWnV8l9cuish6xpPYCWFViw68bxZ7EA3iVa8O1s=;
 b=WNUgY6XDVGY8mHiv17mZxe9mr7dFesZQtJ7krdisDoBuEdydvpKVdSF+s8/jFID9ol
 QnWYm8VWEkVXTBtIls8TqkV0f+A4WI0fPnxacbDkOJ+BHSb2pEtCGJ9HAwv/tSJHedw6
 SP3qaZiM24EEQp8bA3ZeWUKqPOBZ2WlBtPixJLdLpeLXcffU2ZL3cZ1GZo7cQtDv/oDe
 DQYIm4Ym62426SA7aTEDarZFAW4cR4DHA62gVS4IjhRLyYCn54GGxgxneGHryLQjK52L
 PZhxp+K3zlLDX/k5dyoVqzH6IqdHE/eTV02MjUW9/yS4XEFTb8a22SMuOplrQ4W8iyYa
 gzDg==
X-Gm-Message-State: AHQUAubr899vnKL8IgBmBkCT7qiDnAW5G5GADFOfNGiwt/S6vxQtbtDU
 4Md6RL47R2MsqzzisWWFxg8eow==
X-Google-Smtp-Source: AHgI3IYAZcgvr8QUtHv1ptPc4VTZhVvVqb5q9Kbmz3qvexxqneYJ9T8n8UmA1DHR9y0+pYQ9X4xtMA==
X-Received: by 2002:aed:23a3:: with SMTP id j32mr12241830qtc.205.1549554775825; 
 Thu, 07 Feb 2019 07:52:55 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca.
 [70.82.104.228])
 by smtp.gmail.com with ESMTPSA id e35sm4744164qte.8.2019.02.07.07.52.54
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 07:52:55 -0800 (PST)
Date: Thu, 7 Feb 2019 10:52:53 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH 1/5] ARM: use unified assembler in macros
In-Reply-To: <5b710816f634307d6a67ffcf7e4b538818dcb2a3.1549532513.git.stefan@agner.ch>
Message-ID: <nycvar.YSQ.7.76.1902071051030.2213@knanqh.ubzr>
References: <cover.1549532513.git.stefan@agner.ch>
 <5b710816f634307d6a67ffcf7e4b538818dcb2a3.1549532513.git.stefan@agner.ch>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_075258_249206_3A86692F 
X-CRM114-Status: GOOD (  16.86  )
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
Cc: mark.rutland@arm.com, Arnd Bergmann <arnd@arndb.de>,
 ard.biesheuvel@linaro.org, Will Deacon <will.deacon@arm.com>,
 julien.thierry@arm.com, ndesaulniers@google.com,
 Russell King - ARM Linux <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 thierry.reding@gmail.com, natechancellor@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 7 Feb 2019, Stefan Agner wrote:

> Use unified assembler syntax (UAL) in macros. Divided syntax is
> considered depricated. This will also allow to build the kernel
> using LLVM's integrated assembler.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/lib/copy_from_user.S | 2 +-
>  arch/arm/lib/copy_to_user.S   | 2 +-
>  arch/arm/lib/memcpy.S         | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
> index 0d4c189c7f4f..712ca399f559 100644
> --- a/arch/arm/lib/copy_from_user.S
> +++ b/arch/arm/lib/copy_from_user.S
> @@ -91,7 +91,7 @@
>  	.endm
>  
>  	.macro str1b ptr reg cond=al abort
> -	str\cond\()b \reg, [\ptr], #1
> +	strb\cond\() \reg, [\ptr], #1

You don't need the \() any longer. This was used simply to separate the 
b suffix from the cond parameter name. 


Nicolas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
