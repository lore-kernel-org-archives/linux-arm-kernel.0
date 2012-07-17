From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Jul 2012 13:24:10 +0000
Subject: [PATCH 3/8] ARM: MCS814x: add Device Tree bindings documentation
In-Reply-To: <1342363754-30808-4-git-send-email-florian@openwrt.org>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
 <1342363754-30808-4-git-send-email-florian@openwrt.org>
Message-ID: <201207171324.11392.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 15 July 2012, Florian Fainelli wrote:

> diff --git a/Documentation/devicetree/bindings/arm/mcs814x/mcs814x-pci.txt b/Documentation/devicetree/bindings/arm/mcs814x/mcs814x-pci.txt
> new file mode 100644
> index 0000000..de59b04
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mcs814x/mcs814x-pci.txt
> @@ -0,0 +1,16 @@
> +Moschip MCS814x PCI controller bindings
> +---------------------------------------
> +
> +Required properties:
> +- compatible: should be "moschip,mcs814x-pci"
> +- reg: should contain the base register address and length of the PCI controller
> +  configuration register as well as the base register address and length of the
> +  PCI eeprom emulator
> +- interrupts: should contain the interrupt line of the abort interrupt
> +- #address-cells: should be 3
> +- #size-cells: should be 2
> +- ranges: should contain the properly encoded PCI ranges of the IO, non-prefetchable
> +  and prefetchable memory regions
> +- #interrupt-cells: should be 1
> +- interrupt-map-mask: should be 0
> +- interrupt-map: should be the properly encoded PCI slot/pin to interrupt line

interrupt-map-mask of 0 implies that all devices are wired to the
same IRQ lines, which is rather unusual. Better leave that open
so the interrupt-map can be written to work on any board.

> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 6eab917..943e4f3 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -28,6 +28,7 @@ linux	Linux-specific binding
>  marvell	Marvell Technology Group Ltd.
>  maxim	Maxim Integrated Products
>  mosaixtech	Mosaix Technologies, Inc.
> +moschp		Moschip Semiconductors
>  national	National Semiconductor
>  nintendo	Nintendo
>  nvidia	NVIDIA

This string does not match what you use everywhere else. Please fix
either the documentation here or every other instance. The stock
ticker symbol is MOSCHIP.BO, so using "moschip" is probably better
than "moschp".

	Arnd
