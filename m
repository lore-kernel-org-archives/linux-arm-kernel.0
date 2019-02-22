Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D97C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:32:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD82F2075A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nIFzcYcM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD82F2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Aku/m800WIK+7XPo5jBUFKHVW8XUHC+KzcpVkO1h2dQ=; b=nIFzcYcMCpa3S9
	4coyHUa5E4cYsAi1bIgU6or2P5pNMPPDuAgKOR6P7q262+UySBhUvRb6lCPvpfcf+2tIFExCshLX3
	1cDGtEuC5LFatQwcOS3QpM4O2SLeivYb6xM4ImJontjZtam1YoQjO2lRuZh9RXwvzadnHVMbm15vv
	ZplUUUUNb9hhMYKcN382V8yKuwjYthnbF/oquZwMtH+eq6N7IpbLQwRYa+41b6lxV4ZKE3OggVYP6
	UTKa2ts2EWKSrl1C4efQnAohSywWBQWWM8o5Il8tA2z6Gulw9DJyCjM88GgO9SgI1vvzq6joPHSIT
	1SIzXv2Sc4HxM/pPwXOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxBsX-0007lh-T7; Fri, 22 Feb 2019 14:32:42 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxBsI-0007bW-VK
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 14:32:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6737680D;
 Fri, 22 Feb 2019 06:32:26 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B93D93F690;
 Fri, 22 Feb 2019 06:32:23 -0800 (PST)
Date: Fri, 22 Feb 2019 14:32:21 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v5 13/23] arm64: compat: Add vDSO
Message-ID: <20190222143221.GL42419@lakrids.cambridge.arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-14-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190222122430.21180-14-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_063227_167814_23658768 
X-CRM114-Status: GOOD (  15.17  )
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
Cc: linux-arch@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Dmitry Safonov <0x7f454c46@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 12:24:20PM +0000, Vincenzo Frascino wrote:
> diff --git a/arch/arm64/include/asm/vdso/compat_barrier.h b/arch/arm64/include/asm/vdso/compat_barrier.h
> new file mode 100644
> index 000000000000..b149761d9661
> --- /dev/null
> +++ b/arch/arm64/include/asm/vdso/compat_barrier.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018 ARM Limited
> + */
> +#ifndef __COMPAT_BARRIER_H
> +#define __COMPAT_BARRIER_H
> +
> +#include <asm/barrier.h>

I think it would be safer to not include this header, and explicitly
define the AArch32 barriers here in isolation.

> +
> +#if __LINUX_ARM_ARCH__ >= 8
> +#define aarch32_smp_mb()	dmb(ish)
> +#define aarch32_smp_rmb()	dmb(ishld)
> +#define aarch32_smp_wmb()	dmb(ishst)
> +#else
> +#define aarch32_smp_mb()	dmb(ish)
> +#define aarch32_smp_rmb()	aarch32_smp_mb()
> +#define aarch32_smp_wmb()	dmb(ishst)
> +#endif

Can't we just code an AArch32-specific version of dmb() here? AFAICT
that's the only reason we include the native barrier.h.

> +/*
> + * Warning: This code is meant to be used with
> + * ENABLE_COMPAT_VDSO only.
> + */
> +#ifndef ENABLE_COMPAT_VDSO
> +#error This header is meant to be used with ENABLE_COMPAT_VDSO only
> +#endif
> +
> +#undef smp_mb
> +#undef smp_rmb
> +#undef smp_wmb
> +
> +#define smp_mb()	aarch32_smp_mb()
> +#define smp_rmb()	aarch32_smp_rmb()
> +#define smp_wmb()	aarch32_smp_wmb()

This undeffing looks very fragile to me.

[...]

> diff --git a/arch/arm64/kernel/vdso32/.gitignore b/arch/arm64/kernel/vdso32/.gitignore
> new file mode 100644
> index 000000000000..4fea950fa5ed
> --- /dev/null
> +++ b/arch/arm64/kernel/vdso32/.gitignore
> @@ -0,0 +1,2 @@
> +vdso.lds
> +vdso.so.raw
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> new file mode 100644
> index 000000000000..ba57d2ae620f
> --- /dev/null
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -0,0 +1,184 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for vdso32
> +#
> +
> +# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
> +# the inclusion of generic Makefile.
> +ARCH_REL_TYPE_ABS := R_ARM_JUMP_SLOT|R_ARM_GLOB_DAT|R_ARM_ABS32
> +include $(srctree)/lib/vdso/Makefile
> +
> +CC_ARM32 := $(CROSS_COMPILE_ARM32)gcc

To match HOSTCC, it might make sense to call this COMPATCC

... and likewise, CROSS_COMPILE_COMPAT

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
