Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC33C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:26:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 771F52146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GK1FGwAn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=android.com header.i=@android.com header.b="aMen4QYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771F52146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OROkyjxdoUX9S+tar++lkrFWC2iedErbAP/h4m8sIRU=; b=GK1FGwAnO184klXqpG/rEfuCy
	aleo3uoTv55EsrsUXqEKJryswGnF5G2nOcoEqMV5LUEX97eWBE1ehXqeOIgSLzVrJDBcb7DVW0V+V
	tia46SstPqrFlpzxNpX6G37SPeBKjtxOpiLgv/0+4mKxk5PV3Dyae0mY0NANw6X8lqJ34Rrj7A17a
	808vG/giwZJCeTUefF/6Gum595G/e1EV23ht/2yQuSfsIOLoBXJGWdP7OE/UgcyEwgyzUhMMoMU/t
	YrReD2WgMkKjku5aRrTkdCdeSqi43EE+3jbWeeBHY41QiVbwJZgEEY4LndLp6Hg3Q7GnAS1MN5rXt
	myG7Fj21Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYun0-0001L3-S2; Mon, 17 Dec 2018 15:26:38 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYumx-0001KP-5X
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 15:26:36 +0000
Received: by mail-pg1-x542.google.com with SMTP id d72so6271121pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 07:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=android.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=H42cQuxkvQm6ebYe5+6bEZy8w3sXRQw2dBbGg23gBYw=;
 b=aMen4QYBCL3PloC4VHmqA4z+f4WN9v0OK7jZcx3/wiszfK6Uh7cR1Q2BmbN/EqMbhm
 DmjbzmXw3TiYM9pxcg16PCkw/9xfZNApNykqi0VByPrOGx5sIRi/D5VD3jjDZbzKVF6m
 sI1PueOqef18tP4JaKe4S2BskbAkqd8TROHz/L3JjKH58q2NJnGelkSQF4y852zEmEH7
 8+U0CvLxcaFyuvGrGeet8vx0T+ZEGDM7OO362yaKa8AiEzBwgee3eHSXg/uOsDe+pxE2
 gmGsdTa1iXHxnuKVXltShpLJCPsQRk1o3TLo9DyZ8GfQBKQloi679OwJb0zSmZg+u5UZ
 e2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=H42cQuxkvQm6ebYe5+6bEZy8w3sXRQw2dBbGg23gBYw=;
 b=RRsblLLqqsG8Z+epOJrfkBSLTerbREaV4o1UbHS2C93p1STt8KJ3fyDg+9wdN9e/nH
 5setJxsZ91qZ0Y+zJ0fRbIOOFi2yQhmZ68IT68Cjv5qgVXWKsKwrasoPB0bH2cnUJMo/
 S8dZ2c/jZnNHgN1vKcT10r4NNgr4PEyKy5HN6yB/nycmjs3Pv0ewwyfbn618CoLpoD+w
 ZxLBeuPZaiL+q7Uw1kkmAkpooEukKolQbHdvlOjJitL1E9O5VN9Y8RdPathmGCJi06hQ
 oj0iW8AHyOZ78Desdm6+J/H8brCWpdJQ+cfb3unCb1e9istLN61+AXOIBj3MhFYe+YX2
 u4mw==
X-Gm-Message-State: AA+aEWbPn1lIoWZniV+E6LyMX504artQl02HD2pScnesSu4ghKDriJtb
 Qlhv0SP+tTw6povb1SxPr4nVng==
X-Google-Smtp-Source: AFSGD/XNO6YFZKdbqbk6fu41WgcKKEtdDsHNBW4Bg2OrVNt1D59D/xcN1ilJkBf5aCHzmzhT5CdvPg==
X-Received: by 2002:a63:ed15:: with SMTP id d21mr12399045pgi.305.1545060383765; 
 Mon, 17 Dec 2018 07:26:23 -0800 (PST)
Received: from nebulus.mtv.corp.google.com
 ([2620:0:1000:1612:b4fb:6752:f21f:3502])
 by smtp.googlemail.com with ESMTPSA id r6sm29494461pgk.91.2018.12.17.07.26.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Dec 2018 07:26:19 -0800 (PST)
Subject: Re: [PATCH v3 18/24] arm64: Add vDSO compat support
To: Vincenzo Frascino <vincenzo.frascino@arm.com>,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20181213165746.56930-1-vincenzo.frascino@arm.com>
 <20181213165746.56930-19-vincenzo.frascino@arm.com>
From: Mark Salyzyn <salyzyn@android.com>
Message-ID: <483c4226-b56d-69aa-1638-9f495d801273@android.com>
Date: Mon, 17 Dec 2018 07:26:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181213165746.56930-19-vincenzo.frascino@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_072635_214951_3E89A912 
X-CRM114-Status: GOOD (  19.53  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Collingbourne <pcc@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/13/2018 08:57 AM, Vincenzo Frascino wrote:
> This patch adds vDSO compat support to the arm64 building system.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>   arch/arm64/Kconfig         |  1 +
>   arch/arm64/Makefile        | 21 +++++++++++++++++++--
>   arch/arm64/kernel/Makefile |  6 +++++-
>   3 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index aafa18e2e7c4..ed9c36f0ccb9 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -103,6 +103,7 @@ config ARM64
>   	select GENERIC_STRNLEN_USER
>   	select GENERIC_TIME_VSYSCALL
>   	select GENERIC_GETTIMEOFDAY
> +	select GENERIC_COMPAT_VDSO
>   	select HANDLE_DOMAIN_IRQ
>   	select HARDIRQS_SW_RESEND
>   	select HAVE_ACPI_APEI if (ACPI && EFI)
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 6cb9fc7e9382..814d2b0ac017 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -49,9 +49,23 @@ $(warning Detected assembler with broken .inst; disassembly will be unreliable)
>     endif
>   endif
>   
> -KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst)
> +ifeq ($(CONFIG_GENERIC_COMPAT_VDSO), y)
> +  CROSS_COMPILE_ARM32 ?= $(CONFIG_CROSS_COMPILE_COMPAT_VDSO:"%"=%)
> +
> +  ifeq ($(CROSS_COMPILE_ARM32),)
> +    $(warning CROSS_COMPILE_ARM32 not defined or empty, the compat vDSO will not be built)
> +  else ifeq ($(shell which $(CROSS_COMPILE_ARM32)gcc 2> /dev/null),)
> +    $(error $(CROSS_COMPILE_ARM32)gcc not found, check CROSS_COMPILE_ARM32)
> +  else
> +    export CROSS_COMPILE_ARM32
> +    export CONFIG_COMPAT_VDSO := y
> +    compat_vdso := -DCONFIG_COMPAT_VDSO=1
> +  endif
> +endif
> +
> +KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst) $(compat_vdso)
>   KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
> -KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
> +KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst) $(compat_vdso)
>   
>   KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
>   KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
Does not build with clang

Do not hard-code gcc, use $(cc-name)

-- Mark

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
