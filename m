From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 15 May 2012 12:18:55 +0100
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <4FB23B9F.6040708@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/12 09:54, Thomas Petazzoni wrote:
> Arnd, Olof,
>
> You'll find in this patch set the initial support for a new family of
> ARMv7-compatible Marvell SoCs, that we have choosen to support in the
> arch/arm/mach-armada/ directory.
>
> At the moment, both the Armada 370 and the Armada XP SoCs are
> supported in this directory, and we are able to build a single kernel
> image that boots on both SoCs. Both SoCs use the PJ4B processor, a
> Marvell-developed ARM core that implements the ARMv7 instruction
> set. We are currently using Marvell evaluation boards for both of
> those SoCs, and the support for those boards is added in this patch
> set.
>
> This preliminary support only includes the necessary code for timer
> and IRQ support, the serial controller is a standard 16550-compatible
> one. The diffstat looks like:
>
>   Documentation/devicetree/bindings/arm/armada-mpic.txt  |   23 +
>   Documentation/devicetree/bindings/arm/armada-timer.txt |   11
>   Documentation/devicetree/bindings/arm/armada.txt       |   24 +
>   MAINTAINERS                                            |    8
>   arch/arm/Kconfig                                       |   12
>   arch/arm/Makefile                                      |    1
>   arch/arm/boot/dts/a370-db.dts                          |   41 ++
>   arch/arm/boot/dts/a370.dtsi                            |   23 +
>   arch/arm/boot/dts/armada.dtsi                          |   67 ++++
>   arch/arm/boot/dts/axp-db.dts                           |   40 ++
>   arch/arm/boot/dts/axp.dtsi                             |   43 +++
>   arch/arm/configs/armada_defconfig                      |   47 +++
>   arch/arm/mach-armada/Kconfig                           |   19 +
>   arch/arm/mach-armada/Makefile                          |    3
>   arch/arm/mach-armada/Makefile.boot                     |    1
>   arch/arm/mach-armada/a370-dt.c                         |   41 ++
>   arch/arm/mach-armada/axp-dt.c                          |   41 ++
>   arch/arm/mach-armada/common.c                          |   56 +++
>   arch/arm/mach-armada/common.h                          |   27 +
>   arch/arm/mach-armada/include/mach/armada.h             |  234 ++++++++++++++++
>   arch/arm/mach-armada/include/mach/bridge-regs.h        |   28 +
>   arch/arm/mach-armada/include/mach/debug-macro.S        |   23 +
>   arch/arm/mach-armada/include/mach/gpio.h               |   13
>   arch/arm/mach-armada/include/mach/hardware.h           |   18 +
>   arch/arm/mach-armada/include/mach/io.h                 |   24 +
>   arch/arm/mach-armada/include/mach/irqs.h               |   96 ++++++
>   arch/arm/mach-armada/include/mach/system.h             |   21 +
>   arch/arm/mach-armada/include/mach/timex.h              |   13
>   arch/arm/mach-armada/include/mach/uncompress.h         |   41 ++
>   arch/arm/mach-armada/irq.c                             |  116 ++++++++
>   arch/arm/mach-armada/time.c                            |  243 +++++++++++++++++
>   31 files changed, 1398 insertions(+)
>
> This patch set, and the support for those SoCs, is at the moment a
> collaborative effort from Marvell engineers (who have done the initial
> development work) and Free Electrons engineers (who are reshaping the
> code for mainline submission, adding device tree support, etc.). Other
> contributors are expected to join this effort.
>
> The patch set is based on your arm-soc/for-next branch.

Is there a git tree that can be pulled from?

> We intend to quickly build on top of this initial support with the
> following elements:
>
>   * Usage of the clock framework

I'd say that was a pretty important part even if it just a couple of
static clocks for the tclk and fabric clock.

>   * Usage the pinctrl subsystem and GPIO subsystems for pin-muxing and
>     GPIO support
>
>   * SMP support
>
>   * L2 cache support
>
>   * Integration with device drivers. Many of the IPs used in these
>     Marvell SoCs are similar to the ones used in previous Marvell SoCs
>     (for SATA, USB and more), but the drivers for those IPs will
>     require modification to add a device tree binding.
>
> Of course, we welcome all comments on this initial submission and are
> ready to quickly submit updated versions of the patch set to take into
> those comments.
>
> Best regards,
>
> Thomas Petazzoni


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
