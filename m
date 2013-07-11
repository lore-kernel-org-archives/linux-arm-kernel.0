From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Thu, 11 Jul 2013 18:50:44 +0900
Subject: [PATCH] ARM: shmobile: r8a7790 SMP prototype v4
In-Reply-To: <20130710104151.20742.56398.sendpatchset@w520>
References: <20130710104151.20742.56398.sendpatchset@w520>
Message-ID: <51DE7FF4.5050800@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 7/10/2013 7:41 PM, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add SMP prototype support for r8a7790 by enabling
> one cluster of either 4 x Cortex-A7 or 4 x Cortex-A15.
> 
> This patch only adds support for booting, at this point
> no CPU Hotplug is included. In v4 both the big and the
> LITTLE clusters are working with either architected timers
> (in physical mode only for CA7) or CMT and broadcast timer.
> 
> On r8a7790 the MD6 pin control boot processor, and on the
> Lager board SW8.7 can be used to select big or LITTLE.
> 
> In big boot mode the CPU cores will be configured as:
>  - CPU0, CPU1, CPU2, CPU3: enabled (CA15)
>  - CPU4, CPU5, CPU6, CPU7: disabled (CA7)
> 
> In LITTLE boot mode the CPU cores will be configured as:
>  - CPU0, CPU5, CPU6, CPU7: enabled (CA7)
>  - CPU1, CPU2, CPU3, CPU4: disabled (CA15)
> 
> Base addresses for RST and APMU are still hard coded
> but DT will be used for them in future versions.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

I still have some requests to this v4 patch and would like to explain
them in the patch format; please take a look at patches attached.

> In big boot mode the CPU cores will be configured as:
> In LITTLE boot mode the CPU cores will be configured as:

This patchset is boot-tested with both "big" and "LITTLE" boot mode.

Thanks,

Shinya Kuribayashi (4):
      ARM: shmobile: smp-r8a7790: remove the obsolete RESCNT register
      ARM: shmobile: smp-r8a7790: rename s/carescnt/rescnt/g
      ARM: shmobile: smp-r8a7790: rename s/cabar/bar/g as well
      ARM: shmobile: smp-r8a7790: power up a CPU core at .smp_boot_secondary stage

 arch/arm/mach-shmobile/smp-r8a7790.c | 67 ++++++++++++++++++++++---------------------------------------------

--
Shinya Kuribayashi
Renesas Electronics
