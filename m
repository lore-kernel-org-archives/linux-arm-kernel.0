From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 15 May 2012 11:18:38 +0200
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20120515091838.GC6820@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 10:54:36AM +0200, Thomas Petazzoni wrote:
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
>  Documentation/devicetree/bindings/arm/armada-mpic.txt  |   23 +
>  Documentation/devicetree/bindings/arm/armada-timer.txt |   11 
>  Documentation/devicetree/bindings/arm/armada.txt       |   24 +
>  MAINTAINERS                                            |    8 
>  arch/arm/Kconfig                                       |   12 
>  arch/arm/Makefile                                      |    1 
>  arch/arm/boot/dts/a370-db.dts                          |   41 ++
>  arch/arm/boot/dts/a370.dtsi                            |   23 +
>  arch/arm/boot/dts/armada.dtsi                          |   67 ++++
>  arch/arm/boot/dts/axp-db.dts                           |   40 ++
>  arch/arm/boot/dts/axp.dtsi                             |   43 +++
>  arch/arm/configs/armada_defconfig                      |   47 +++
>  arch/arm/mach-armada/Kconfig                           |   19 +
>  arch/arm/mach-armada/Makefile                          |    3 

Hi Thomas

Is mach-armada a good idea? What are many different armada chipsets families:

Armada 100, 300, 500, 600, 1000, 15000, XP. 

You only seem to support 300 and XP. Where would the others go? 300 is
actually mach-dove, etc. 

	 Andrew
