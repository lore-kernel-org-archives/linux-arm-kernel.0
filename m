From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 22 Mar 2017 09:58:24 +0100
Subject: [PATCH 06/15] ARM: dts: r8a779x: fix PCI bus dtc warnings
In-Reply-To: <20170322020313.24338-6-robh@kernel.org>
References: <20170322020313.24338-1-robh@kernel.org>
 <20170322020313.24338-6-robh@kernel.org>
Message-ID: <CAMuHMdVMyjVv471KB6+SCbNBs6EAaFUm1-2xwj2y-qgriFht0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Wed, Mar 22, 2017 at 3:03 AM, Rob Herring <robh@kernel.org> wrote:
> dtc recently added PCI bus checks. Fix these warnings.

It's always a good idea to put the warnings in the commit message:

arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_bridge): Node
/pci at ee090000/usb at 0,1 node name is not "pci" or "pcie"
arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_bridge): Node
/pci at ee090000/usb at 0,1 missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_bridge): Node
/pci at ee090000/usb at 0,1 incorrect #address-cells for PCI bridge
arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_bridge): Node
/pci at ee090000/usb at 0,1 incorrect #size-cells for PCI bridge
arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_bridge): Node
/pci at ee090000/usb at 0,1 missing bus-range for PCI bridge
arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_bridge): Node
/pci at ee090000/usb at 0,2 node name is not "pci" or "pcie"
arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_bridge): Node
/pci at ee090000/usb at 0,2 missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_bridge): Node
/pci at ee090000/usb at 0,2 incorrect #address-cells for PCI bridge
arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_bridge): Node
/pci at ee090000/usb at 0,2 incorrect #size-cells for PCI bridge
arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_bridge): Node
/pci at ee090000/usb at 0,2 missing bus-range for PCI bridge
arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_bridge): Node
/pci at ee0d0000/usb at 0,1 node name is not "pci" or "pcie"
arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_bridge): Node
/pci at ee0d0000/usb at 0,1 missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_bridge): Node
/pci at ee0d0000/usb at 0,1 incorrect #address-cells for PCI bridge
arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_bridge): Node
/pci at ee0d0000/usb at 0,1 incorrect #size-cells for PCI bridge
arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_bridge): Node
/pci at ee0d0000/usb at 0,1 missing bus-range for PCI bridge
arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_bridge): Node
/pci at ee0d0000/usb at 0,2 node name is not "pci" or "pcie"
arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_bridge): Node
/pci at ee0d0000/usb at 0,2 missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_bridge): Node
/pci at ee0d0000/usb at 0,2 incorrect #address-cells for PCI bridge
arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_bridge): Node
/pci at ee0d0000/usb at 0,2 incorrect #size-cells for PCI bridge
arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_bridge): Node
/pci at ee0d0000/usb at 0,2 missing bus-range for PCI bridge
arch/arm/boot/dts/r8a7790-lager.dtb: Warning (unit_address_format):
Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_device_reg): Failed
prerequisite 'pci_bridge'
arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_device_bus_num):
Failed prerequisite 'pci_bridge'

The above indeed go away with your patch, but I don't know why ;-)

> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: linux-renesas-soc at vger.kernel.org
> ---
> Sub-arch maintainers, please apply to your trees unless arm-soc wants
> to take the whole lot.
>
>  arch/arm/boot/dts/r8a7790.dtsi | 16 ++++++----------
>  arch/arm/boot/dts/r8a7791.dtsi | 16 ++++++----------
>  arch/arm/boot/dts/r8a7794.dtsi | 16 ++++++----------
>  3 files changed, 18 insertions(+), 30 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index 6d10450de6d7..c16a37e9fb5d 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -1598,16 +1598,14 @@
>                                  0x0800 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
>                                  0x1000 0 0 2 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
>
> -               usb at 0,1 {
> +               usb at 1,0 {
>                         reg = <0x800 0 0 0 0>;
> -                       device_type = "pci";
>                         phys = <&usb0 0>;
>                         phy-names = "usb";
>                 };

Both Documentation/devicetree/bindings/pci/pci.txt and ePAPR refer to
http://www.firmware.org/1275/bindings/pci/pci2_1.pdf
http://www.firmware.org/1275/practice/imap/imap0_9d.pdf
which no longer exist.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
