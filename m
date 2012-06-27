From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 27 Jun 2012 09:57:13 +0100
Subject: [PATCH v4] arm: Add basic support for new Marvell Armada 370
 and Armada XP SoC
In-Reply-To: <1340699313-29331-1-git-send-email-gregory.clement@free-electrons.com>
References: <1340699313-29331-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <4FEACAE9.2080901@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/06/12 09:28, Gregory Clement wrote:
>
> Arnd, Olof,
>
> You'll find in this patch set the third version of the initial support
> for a new family of ARMv7-compatible Marvell SoCs.
>
> As for the previous releases, both the Armada 370 and the Armada XP
> SoCs are supported in this directory, and we are able to build a
> single kernel image that boots on both SoCs. Both SoCs use the PJ4B
> processor, a Marvell-developed ARM core that implements the ARMv7
> instruction set. We are currently using Marvell evaluation boards for
> both of those SoCs, and the support for those boards is added in this
> patch set.
>
> We remained focused on a limited preliminary support which only
> includes the necessary code for timer and IRQ support, the serial
> controller is a standard 16550-compatible one. The diffstat looks
> like:
>
>   Documentation/devicetree/bindings/arm/armada-370-xp-mpic.txt      |   23 +
>   Documentation/devicetree/bindings/arm/armada-370-xp-timer.txt     |   11 +
>   Documentation/devicetree/bindings/arm/armada-370-xp.txt           |   24 +
>   Documentation/devicetree/bindings/arm/mvebu-system-controller.txt |   16 +
>   MAINTAINERS                                                       |    8 +
>   arch/arm/Kconfig                                                  |   14 +
>   arch/arm/Makefile                                                 |    1 +
>   arch/arm/boot/dts/armada-370-db.dts                               |   42 +
>   arch/arm/boot/dts/armada-370-xp.dtsi                              |   68 ++
>   arch/arm/boot/dts/armada-370.dtsi                                 |   35 +
>   arch/arm/boot/dts/armada-xp-db.dts                                |   50 +
>   arch/arm/boot/dts/armada-xp.dtsi                                  |   55 +
>   arch/arm/configs/mvebu_defconfig                                  |   46 +
>   arch/arm/mach-mvebu/Kconfig                                       |   16 +
>   arch/arm/mach-mvebu/Makefile                                      |    2 +
>   arch/arm/mach-mvebu/Makefile.boot                                 |    1 +
>   arch/arm/mach-mvebu/armada-370-xp.c                               |   63 ++
>   arch/arm/mach-mvebu/common.h                                      |   23 +
>   arch/arm/mach-mvebu/include/mach/armada-370-xp.h                  |   22 +
>   arch/arm/mach-mvebu/include/mach/debug-macro.S                    |   24 +
>   arch/arm/mach-mvebu/include/mach/timex.h                          |   13 +
>   arch/arm/mach-mvebu/include/mach/uncompress.h                     |   43 +
>   arch/arm/mach-mvebu/irq-armada-370-xp.c                           |  133 +++
>   arch/arm/mach-mvebu/system-controller.c                           |  105 ++
>   drivers/clocksource/Kconfig                                       |    3 +
>   drivers/clocksource/Makefile                                      |    3 +-
>   drivers/clocksource/time-armada-370-xp.c                          |  242 +++++
>   include/linux/time-armada-370-xp.h                                |   18 +
>   28 files changed, 1103 insertions(+), 1 deletion(-)
>
> This patch set, and the support for those SoCs, started as a
> collaborative effort from Marvell engineers (who have done the initial
> development work) and Free Electrons engineers (who are reshaping the
> code for mainline submission, adding device tree support, etc.). This
> effort has also received contributions from Ben Dooks from Codethink.
>
> The patch set is based on your arm-soc/for-next branch (updated on Monday
> 25th June).

Where should I pull from to have a test?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
