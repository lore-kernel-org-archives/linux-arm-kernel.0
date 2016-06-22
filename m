From: a0393675@ti.com (Keerthy)
Date: Wed, 22 Jun 2016 14:05:17 +0530
Subject: [PATCH 0/4] Get kexec working on SMP omap variants
In-Reply-To: <1466495565-17480-1-git-send-email-tony@atomide.com>
References: <1466495565-17480-1-git-send-email-tony@atomide.com>
Message-ID: <576A4DC5.1050906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 21 June 2016 01:22 PM, Tony Lindgren wrote:
> Hi all,
>
> Here are some patches to make kexec work for SMP omaps. To test
> these you need to use the latest kexec-tools.git kexec with
> Russell's recent patches in "[PATCH 0/2] Simple fix to the ARM
> kexec tools implementation" thread fixed for 6x. Or else you
> need to use appended DTB.
>
> I've tested these so far on 4430 duovero, omap5-uevm, and
> beagle-x15.

More testing done with above configuration + kexec_tools change below:
initrd_base = kernel_base + _ALIGN(len * 7, getpagesize());

kexec works fine on:

am437x-gp-evm, am437x-sk-evm
am335x-bone
dra72-evm
dra7-evm
omap5-uevm

Tested-by: Keerthy <j-keerthy@ti.com>

Regards,
Keerthy

>
> Regards,
>
> Tony
>
>
> Tony Lindgren (4):
>    ARM: OMAP4+: Initialize SAR RAM base early for proper CPU1 reset for
>      kexec
>    ARM: OMAP4+: Prevent CPU1 related hang with kexec
>    ARM: OMAP4+: Reset CPU1 properly for kexec
>    ARM: OMAP4+: Allow kexec on SMP variants
>
>   arch/arm/mach-omap2/Makefile              |  4 +-
>   arch/arm/mach-omap2/common.h              |  8 ++-
>   arch/arm/mach-omap2/io.c                  |  3 +
>   arch/arm/mach-omap2/omap-hotplug.c        |  6 ++
>   arch/arm/mach-omap2/omap-mpuss-lowpower.c | 29 ++++++++--
>   arch/arm/mach-omap2/omap-smp.c            | 96 ++++++++++++++++++++++---------
>   arch/arm/mach-omap2/omap4-common.c        | 14 ++---
>   7 files changed, 118 insertions(+), 42 deletions(-)
>
