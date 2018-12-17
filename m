Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B26C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:23:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504C120672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EsjvgxxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504C120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LovvjoaSsAfG5fzBHQ+H+3KrieA4V6GJev72mOwqgtQ=; b=EsjvgxxZyUec9n
	vBt5UvEMo9Wczs4Gvsqxo2amcSXYtEQnYuYbu27zI7wnF6EK8fcJtkFHn4GTPIOk3udj1pfqtVBnf
	Lqkf1GafYt6wK0CUf8ogt6jYRT+4Vs6r3GQq179R5rrGr1MMLZkJi6fZW/ufMYMPaZyH5c8Ign4hh
	9P0OHg3jeqXgGIpqpZPF11jBKmyp68vjidVimthxn3I3THK+mNduKKMZqaLVhEc0c3toTEON0XG++
	mUdTZ5VQ3We+uY+LNziq/nEpBbLrY4+U1jBA1FA+GwLNmphdB5pdXjMvwEWDzC+TmYEnygvD3NtA1
	U3kgElF4EgMxDVvcg7Rg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYoBO-0006Rq-0b; Mon, 17 Dec 2018 08:23:22 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYoBJ-0006Qv-UU
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 08:23:20 +0000
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wBH8GTt5027949; Mon, 17 Dec 2018 09:22:52 +0100
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx08-00178001.pphosted.com with ESMTP id 2pcqmahbuw-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Mon, 17 Dec 2018 09:22:52 +0100
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6F2E84D;
 Mon, 17 Dec 2018 08:22:49 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
 by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6341E403;
 Mon, 17 Dec 2018 08:22:47 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 17 Dec
 2018 09:22:46 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Mon, 17 Dec 2018 09:22:46 +0100
From: Patrice CHOTARD <patrice.chotard@st.com>
To: Russell King <rmk+kernel@armlinux.org.uk>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-arm-msm@vger.kernel.org"
 <linux-arm-msm@vger.kernel.org>, "linux-omap@vger.kernel.org"
 <linux-omap@vger.kernel.org>, "linux-oxnas@groups.io"
 <linux-oxnas@groups.io>, "linux-samsung-soc@vger.kernel.org"
 <linux-samsung-soc@vger.kernel.org>, "linux-soc@vger.kernel.org"
 <linux-soc@vger.kernel.org>
Subject: Re: [PATCH 4/9] ARM: sti: remove pen_release and boot_lock
Thread-Topic: [PATCH 4/9] ARM: sti: remove pen_release and boot_lock
Thread-Index: AQHUkw3Y0DLFhoxB3ESaJyyK6FvnmKWCjIEA
Date: Mon, 17 Dec 2018 08:22:45 +0000
Message-ID: <b24d6a8c-a1ef-9274-0ef8-7b080b365122@st.com>
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
 <E1gXVI9-000897-25@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1gXVI9-000897-25@rmk-PC.armlinux.org.uk>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-ID: <B2ADECE59424EE47A5FD54BDDDB536CC@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-17_02:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_002318_282925_B6226F3E 
X-CRM114-Status: GOOD (  28.42  )
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

Hi Russel

On 12/13/18 7:00 PM, Russell King wrote:
> The pen_release implementation was created for Versatile platforms to
> work around boot loaders that did not differentiate between the
> various different secondary CPUs on this ARM development platform.
> This should not be true of modern platforms where we send IPIs to
> specific CPUs to wake them up.  Remove the pen_release stuff from
> SoCs that make use of the per-CPU IPI mechanism.
> 
> The boot_lock is something that was required for ARM development
> platforms to ensure that the delay calibration worked properly.  This
> is not necessary for modern platforms that have better bus bandwidth
> and do not need to calibrate the delay loop for secondary cores.
> Remove the boot_lock entirely.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  arch/arm/mach-sti/Makefile  |  2 +-
>  arch/arm/mach-sti/headsmp.S | 43 -------------------------------
>  arch/arm/mach-sti/platsmp.c | 62 ++-------------------------------------------
>  3 files changed, 3 insertions(+), 104 deletions(-)
>  delete mode 100644 arch/arm/mach-sti/headsmp.S
> 
> diff --git a/arch/arm/mach-sti/Makefile b/arch/arm/mach-sti/Makefile
> index acb330916333..f85ff059cfba 100644
> --- a/arch/arm/mach-sti/Makefile
> +++ b/arch/arm/mach-sti/Makefile
> @@ -1,2 +1,2 @@
> -obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
> +obj-$(CONFIG_SMP)		+= platsmp.o
>  obj-$(CONFIG_ARCH_STI) 		+= board-dt.o
> diff --git a/arch/arm/mach-sti/headsmp.S b/arch/arm/mach-sti/headsmp.S
> deleted file mode 100644
> index e0ad451700d5..000000000000
> --- a/arch/arm/mach-sti/headsmp.S
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -/*
> - *  arch/arm/mach-sti/headsmp.S
> - *
> - * Copyright (C) 2013 STMicroelectronics (R&D) Limited.
> - *		http://www.st.com
> - *
> - * Cloned from linux/arch/arm/mach-vexpress/headsmp.S
> - *
> - *  Copyright (c) 2003 ARM Limited
> - *  All Rights Reserved
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -#include <linux/linkage.h>
> -#include <linux/init.h>
> -
> -/*
> - * ST specific entry point for secondary CPUs.  This provides
> - * a "holding pen" into which all secondary cores are held until we're
> - * ready for them to initialise.
> - */
> -ENTRY(sti_secondary_startup)
> -	mrc	p15, 0, r0, c0, c0, 5
> -	and	r0, r0, #15
> -	adr	r4, 1f
> -	ldmia	r4, {r5, r6}
> -	sub	r4, r4, r5
> -	add	r6, r6, r4
> -pen:	ldr	r7, [r6]
> -	cmp	r7, r0
> -	bne	pen
> -
> -	/*
> -	 * we've been released from the holding pen: secondary_stack
> -	 * should now contain the SVC stack for this core
> -	 */
> -	b	secondary_startup
> -ENDPROC(sti_secondary_startup)
> -
> -1:	.long	.
> -	.long	pen_release
> diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
> index 231f19e17436..21668501c9bb 100644
> --- a/arch/arm/mach-sti/platsmp.c
> +++ b/arch/arm/mach-sti/platsmp.c
> @@ -28,72 +28,15 @@
>  
>  #include "smp.h"
>  
> -static void write_pen_release(int val)
> -{
> -	pen_release = val;
> -	smp_wmb();
> -	sync_cache_w(&pen_release);
> -}
> -
> -static DEFINE_SPINLOCK(boot_lock);
> -
> -static void sti_secondary_init(unsigned int cpu)
> -{
> -	/*
> -	 * let the primary processor know we're out of the
> -	 * pen, then head off into the C entry point
> -	 */
> -	write_pen_release(-1);
> -
> -	/*
> -	 * Synchronise with the boot thread.
> -	 */
> -	spin_lock(&boot_lock);
> -	spin_unlock(&boot_lock);
> -}
> -
>  static int sti_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  {
> -	unsigned long timeout;
> -
> -	/*
> -	 * set synchronisation state between this boot processor
> -	 * and the secondary one
> -	 */
> -	spin_lock(&boot_lock);
> -
> -	/*
> -	 * The secondary processor is waiting to be released from
> -	 * the holding pen - release it, then wait for it to flag
> -	 * that it has been released by resetting pen_release.
> -	 *
> -	 * Note that "pen_release" is the hardware CPU ID, whereas
> -	 * "cpu" is Linux's internal ID.
> -	 */
> -	write_pen_release(cpu_logical_map(cpu));
> -
>  	/*
>  	 * Send the secondary CPU a soft interrupt, thereby causing
>  	 * it to jump to the secondary entrypoint.
>  	 */
>  	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
>  
> -	timeout = jiffies + (1 * HZ);
> -	while (time_before(jiffies, timeout)) {
> -		smp_rmb();
> -		if (pen_release == -1)
> -			break;
> -
> -		udelay(10);
> -	}
> -
> -	/*
> -	 * now the secondary core is starting up let it run its
> -	 * calibrations, then wait for it to finish
> -	 */
> -	spin_unlock(&boot_lock);
> -
> -	return pen_release != -1 ? -ENOSYS : 0;
> +	return 0;
>  }
>  
>  static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
> @@ -103,7 +46,7 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
>  	u32 __iomem *cpu_strt_ptr;
>  	u32 release_phys;
>  	int cpu;
> -	unsigned long entry_pa = __pa_symbol(sti_secondary_startup);
> +	unsigned long entry_pa = __pa_symbol(secondary_startup);
>  
>  	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
>  
> @@ -158,6 +101,5 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
>  
>  const struct smp_operations sti_smp_ops __initconst = {
>  	.smp_prepare_cpus	= sti_smp_prepare_cpus,
> -	.smp_secondary_init	= sti_secondary_init,
>  	.smp_boot_secondary	= sti_boot_secondary,
>  };
> 

Even if this patch is breaking the secondary CPU's bringup, it can be
merged as explained in the commit message.

I will send an additionnal patch to restore the secondary CPU's bringup.

Thanks for this clean-up.

Patrice
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
