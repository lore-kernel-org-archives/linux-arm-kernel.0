Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE08CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:04:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C49217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O2wV7hN/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bCX/UpUc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C49217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=NoMVFtLwnX8KLxNX85F1Iubx1nYSgfzZnyceivpLvrU=; b=O2wV7hN/518h3BrYvuvd33MMb0
	LsO99HlfBssh3+p3cE725rAHctbEQDrkjAO40twpIjPx5NwHA7zdk20QPGO5k+vBhkJZzP6SuxGxl
	0E6bbZDpSlsP4XCge10lmSXUDjiu/peTzShcuWoHHfK8lH2Sb5t88E9XHZ2AopMJVDU6fkQoN3Eik
	oROEy3diuLtH60Jli9m4kIXR9dlfgwgKUIjfARsWcvmgkfUNBfs5ypN8pOXREDvH/sFN2qdAM2Giy
	N/24kPLuq2dmLrygKiR+fmVlw/LA5yFZKsW4P6Yci5VcNeyQ2+uHpT3bNmbiO3LGOJNdwMkURZrlT
	GeYNkM3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZyvh-0004co-US; Thu, 20 Dec 2018 14:04:01 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZyvd-0004bE-MX
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 14:03:59 +0000
Received: by mail-wm1-x341.google.com with SMTP id m22so2329131wml.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 06:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:references:from:openpgp:autocrypt:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=JIxIFoeGjsKtNVE23FzL8DydGYZeNS0ljgI025CltDY=;
 b=bCX/UpUcLdy/iwQmPAHFdH/PHL/hGZnQe8b5S2+Amle+PmlSWOetnxtdkcW3oJMVCC
 3EqGwhkZETq5oe5vzYoA/qti++NVPYNxXKnWXS8SnZENAg/bBy6P1gHFq5hZy/ynFeD0
 cqnbXP+RXX+gv5Yf12RECx/cwlcDrUwtYOqwwZpO5XJqsfZEvUeIgnwyYqVSD0AgfUy6
 03KeeWs9Q0VqMJbqh8Jy4q347t3bXXM4itxm8S2xVbsOXGIYlyAz/83gtXZu98g5smfK
 noFdpzhE42eT4CxWFdxDY7m9mNHvT7RLWSs/d9JRdza+E37YzmcAe1XCEujD6oLBFN64
 hBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
 :organization:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=JIxIFoeGjsKtNVE23FzL8DydGYZeNS0ljgI025CltDY=;
 b=uhonzARUJHh1VKA1pgmE0q8yZmbZsFldMeF43Nv/vhUHlbJG+hPgPmRpwuVm3Q1XDh
 6uOgy2E4c9M9u0JmwicRTtRy1W7gKb6SqThbDNTUwio7mXhN5m8FwsZMsim0/2v3JC5O
 1V4vMrFVrzfZFqvu7AMop0O3GJ+s7x7M22uMb/ciyJAjJi3f5GyAk9MyOWsN9lkp1bbE
 K81sPlOsiIz/ZYNgpcX3gsou0gEJlYUkJmWnzVNhkXD5IcA0ySIiwbPEyz+Yt0Vk30Nl
 U4Zi02uThTs9I+YYD7s9sxoVJmdELJHL6b1w5UTY0b26zaIGKh0lcsFkhOe6PUqriktW
 gUNQ==
X-Gm-Message-State: AA+aEWbPzsEdXHzBBt+GPbtCQ+ebC4avu2uM/YiCQGCITqhSa0tVbiQK
 xIFi8vBqscHZoK5IVarAStFTaw==
X-Google-Smtp-Source: AFSGD/VgiBhAa9XE0yC/QP0MOb04xGpbEevRKgxkzCMzaE7X9+t79bk+sJNzf1idcZGDJOsTid+cWA==
X-Received: by 2002:a1c:63d5:: with SMTP id
 x204mr11439797wmb.137.1545314625831; 
 Thu, 20 Dec 2018 06:03:45 -0800 (PST)
Received: from [192.168.1.62] (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr.
 [176.150.251.154])
 by smtp.gmail.com with ESMTPSA id v4sm8708458wme.6.2018.12.20.06.03.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 06:03:45 -0800 (PST)
Subject: Re: [PATCH 3/9] ARM: oxnas: remove CPU hotplug implementation
To: Russell King <rmk+kernel@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-oxnas@groups.io,
 linux-samsung-soc@vger.kernel.org, linux-soc@vger.kernel.org
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
 <E1gXVI3-00088u-N6@rmk-PC.armlinux.org.uk>
From: Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <b1e2ac26-52a2-0614-4e14-0cb46e839d3f@baylibre.com>
Date: Thu, 20 Dec 2018 15:03:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <E1gXVI3-00088u-N6@rmk-PC.armlinux.org.uk>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_060357_782498_17293BF7 
X-CRM114-Status: GOOD (  26.92  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 13/12/2018 19:00, Russell King wrote:
> The CPU hotplug implementation on this platform is cargo-culted from
> the plat-versatile implementation, and is buggy.  Once a CPU hits the
> "low power" loop, it will wait for pen_release to be set to the CPU
> number to wake up again - but nothing in this implementation does that.
> 
> So, once a CPU has entered cpu_die() it will never, ever leave.
> 
> Remove this useless cargo-culted implementation.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  arch/arm/mach-oxnas/Makefile  |   1 -
>  arch/arm/mach-oxnas/hotplug.c | 109 ------------------------------------------
>  arch/arm/mach-oxnas/platsmp.c |   4 --
>  3 files changed, 114 deletions(-)
>  delete mode 100644 arch/arm/mach-oxnas/hotplug.c
> 
> diff --git a/arch/arm/mach-oxnas/Makefile b/arch/arm/mach-oxnas/Makefile
> index b625906a9970..61a34e1c0f22 100644
> --- a/arch/arm/mach-oxnas/Makefile
> +++ b/arch/arm/mach-oxnas/Makefile
> @@ -1,2 +1 @@
>  obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
> -obj-$(CONFIG_HOTPLUG_CPU) 	+= hotplug.o
> diff --git a/arch/arm/mach-oxnas/hotplug.c b/arch/arm/mach-oxnas/hotplug.c
> deleted file mode 100644
> index 854f29b8cba6..000000000000
> --- a/arch/arm/mach-oxnas/hotplug.c
> +++ /dev/null
> @@ -1,109 +0,0 @@
> -/*
> - *  Copyright (C) 2002 ARM Ltd.
> - *  All Rights Reserved
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -#include <linux/kernel.h>
> -#include <linux/errno.h>
> -#include <linux/smp.h>
> -
> -#include <asm/cp15.h>
> -#include <asm/smp_plat.h>
> -
> -static inline void cpu_enter_lowpower(void)
> -{
> -	unsigned int v;
> -
> -	asm volatile(
> -	"	mcr	p15, 0, %1, c7, c5, 0\n"
> -	"	mcr	p15, 0, %1, c7, c10, 4\n"
> -	/*
> -	 * Turn off coherency
> -	 */
> -	"	mrc	p15, 0, %0, c1, c0, 1\n"
> -	"	bic	%0, %0, #0x20\n"
> -	"	mcr	p15, 0, %0, c1, c0, 1\n"
> -	"	mrc	p15, 0, %0, c1, c0, 0\n"
> -	"	bic	%0, %0, %2\n"
> -	"	mcr	p15, 0, %0, c1, c0, 0\n"
> -	  : "=&r" (v)
> -	  : "r" (0), "Ir" (CR_C)
> -	  : "cc");
> -}
> -
> -static inline void cpu_leave_lowpower(void)
> -{
> -	unsigned int v;
> -
> -	asm volatile(	"mrc	p15, 0, %0, c1, c0, 0\n"
> -	"	orr	%0, %0, %1\n"
> -	"	mcr	p15, 0, %0, c1, c0, 0\n"
> -	"	mrc	p15, 0, %0, c1, c0, 1\n"
> -	"	orr	%0, %0, #0x20\n"
> -	"	mcr	p15, 0, %0, c1, c0, 1\n"
> -	  : "=&r" (v)
> -	  : "Ir" (CR_C)
> -	  : "cc");
> -}
> -
> -static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
> -{
> -	/*
> -	 * there is no power-control hardware on this platform, so all
> -	 * we can do is put the core into WFI; this is safe as the calling
> -	 * code will have already disabled interrupts
> -	 */
> -	for (;;) {
> -		/*
> -		 * here's the WFI
> -		 */
> -		asm(".word	0xe320f003\n"
> -		    :
> -		    :
> -		    : "memory", "cc");
> -
> -		if (pen_release == cpu_logical_map(cpu)) {
> -			/*
> -			 * OK, proper wakeup, we're done
> -			 */
> -			break;
> -		}
> -
> -		/*
> -		 * Getting here, means that we have come out of WFI without
> -		 * having been woken up - this shouldn't happen
> -		 *
> -		 * Just note it happening - when we're woken, we can report
> -		 * its occurrence.
> -		 */
> -		(*spurious)++;
> -	}
> -}
> -
> -/*
> - * platform-specific code to shutdown a CPU
> - *
> - * Called with IRQs disabled
> - */
> -void ox820_cpu_die(unsigned int cpu)
> -{
> -	int spurious = 0;
> -
> -	/*
> -	 * we're ready for shutdown now, so do it
> -	 */
> -	cpu_enter_lowpower();
> -	platform_do_lowpower(cpu, &spurious);
> -
> -	/*
> -	 * bring this CPU back into the world of cache
> -	 * coherency, and then restore interrupts
> -	 */
> -	cpu_leave_lowpower();
> -
> -	if (spurious)
> -		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
> -}
> diff --git a/arch/arm/mach-oxnas/platsmp.c b/arch/arm/mach-oxnas/platsmp.c
> index 442cc8a2f7dc..735141c0e3a3 100644
> --- a/arch/arm/mach-oxnas/platsmp.c
> +++ b/arch/arm/mach-oxnas/platsmp.c
> @@ -19,7 +19,6 @@
>  #include <asm/smp_scu.h>
>  
>  extern void ox820_secondary_startup(void);
> -extern void ox820_cpu_die(unsigned int cpu);
>  
>  static void __iomem *cpu_ctrl;
>  static void __iomem *gic_cpu_ctrl;
> @@ -94,9 +93,6 @@ static void __init ox820_smp_prepare_cpus(unsigned int max_cpus)
>  static const struct smp_operations ox820_smp_ops __initconst = {
>  	.smp_prepare_cpus	= ox820_smp_prepare_cpus,
>  	.smp_boot_secondary	= ox820_boot_secondary,
> -#ifdef CONFIG_HOTPLUG_CPU
> -	.cpu_die		= ox820_cpu_die,
> -#endif
>  };
>  
>  CPU_METHOD_OF_DECLARE(ox820_smp, "oxsemi,ox820-smp", &ox820_smp_ops);
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
