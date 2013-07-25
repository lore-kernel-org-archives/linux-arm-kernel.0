From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 24 Jul 2013 20:39:21 -0400 (EDT)
Subject: [GIT PULL] MCPM backends update
In-Reply-To: <alpine.LFD.2.03.1307221521200.15022@syhkavp.arg>
References: <alpine.LFD.2.03.1307221521200.15022@syhkavp.arg>
Message-ID: <alpine.LFD.2.03.1307242035340.15022@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


FYI: the ARMv7 cache disable consolidation patch currently being 
discussed is _not_ part of this pull request.


On Mon, 22 Jul 2013, Nicolas Pitre wrote:

> Hello gents,
> 
> Would you please pull the following into ARM-SOC:
> 
> 	git://git.linaro.org/people/nico/linux mcpm+tc2
> 
> This contains
> 
> - Fixes to the existing Vexpress DCSCB backend.
> 
> - Lorenzo's minimal SPC driver required by the TC2 MCPM backend.
>   As discussed on the list, this is not considered to be a MFD driver.
>   This hardly qualify as a bus driver either.  Conceptually, this is
>   a very platform specific register multiplex driver allowing subsystem
>   drivers to hook into.  I therefore moved it to 
>   drivers/platform/vexpress/ which seems to please everyone.
> 
> - The MCPM backend enabling SMP secondary boot and CPU hotplug
>   on the VExpress TC2 big.LITTLE platform.
> 
> - MCPM suspend method to the TC2 backend allowing basic CPU 
>   idle/suspend.  The cpuidle driver that hooks into this will be 
>   submitted separately.
> 
> This is based on v3.11-rc2.  The diffstat follows:
> 
>  .../devicetree/bindings/arm/vexpress-spc.txt       |  36 +++
>  arch/arm/mach-vexpress/Kconfig                     |   9 +
>  arch/arm/mach-vexpress/Makefile                    |   1 +
>  arch/arm/mach-vexpress/dcscb.c                     |  58 ++--
>  arch/arm/mach-vexpress/tc2_pm.c                    | 304 +++++++++++++++++++++
>  drivers/platform/Kconfig                           |   4 +-
>  drivers/platform/Makefile                          |   1 +
>  drivers/platform/vexpress/Kconfig                  |   9 +
>  drivers/platform/vexpress/Makefile                 |   1 +
>  drivers/platform/vexpress/spc.c                    | 253 +++++++++++++++++
>  include/linux/vexpress.h                           |  17 ++
>  11 files changed, 671 insertions(+), 22 deletions(-)
> 
> 
> Nicolas
> 
