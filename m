From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 23 Oct 2013 12:25:58 +0100
Subject: [Add SMP support for Allwinner A20: PATCH V5 0/3]
In-Reply-To: <1382027827-10080-1-git-send-email-cinifr@gmail.com>
References: <1382027827-10080-1-git-send-email-cinifr@gmail.com>
Message-ID: <20131023112558.GW3041@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 12:37:04AM +0800, Fan Rong wrote:
> V1 V2:
> The patchs add smp support for Allwinner A20. It add cpuregister node in dts for smp configure. The patchs also add a options for phy count timer to replace vir count timer as ARM arch timer clocksource.
> V3 Changes since V2:
> It delete platform.h and delete some code in platsmp.c that's not necessary. It delete phy count timer support because most linux kernel platform want to use vir count timer especially for kvm. SMP need arch timer as clocksource, It does use virtual counter timer and  no longer use physical counter timer, so bootloader ***must*** set CNTVOFF register for a20 before kernel booting. I have add support set CNTVOFF register for uboot, if you want to test it in a20 board, you need update your sunxi uboot from: https://groups.google.com/forum/#!topic/linux-sunxi/O0Za7H5_jQI
> V4 Changes since V3:
> It use smp_prepare_cpus replacing early_init as cpuconfigure map init funcation caller and use sun7i replacing sunxi7i as funcation name and variable name.
> V5 Changes since V4:
> Move smp from struct DT_MACHINE_START(SUNXI_DT, "Allwinner A1X (Device Tree)") to struct DT_MACHINE_START(SUN7I_DT, "Allwinner sun7i (A20) Family") in file sunxi.c
> 
> *** BLURB HERE ***

Seriously?

I explained to you several times what we were expecting, with references
to examples of what you should do, and you're still not listening?

You just make me feel like I'm wasting my time here. If you don't want
to make any effort, I won't either.

This is my last warning. Here is what is wrong about your patchset:
  - Wrap your commit log and cover letter to 80 chars
  - You don't have any introduction letter
  - The prefix is wrong, again, while you had it fixed in your v4

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131023/2efd4bf7/attachment.sig>
