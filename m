From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 04 Dec 2017 13:53:36 +0100
Subject: [PATCH] ARM: dts: imx6qdl-zii-rdu2: Remove device_type from PCI
 subnode
In-Reply-To: <1512234488-8760-1-git-send-email-festevam@gmail.com>
References: <1512234488-8760-1-git-send-email-festevam@gmail.com>
Message-ID: <1512392016.6394.4.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, den 02.12.2017, 15:08 -0200 schrieb Fabio Estevam:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> device_type = "pci" should be used for the SoC level PCI controller
> and
> it is already present at imx6qdl.dtsi.
> 
> Remove it from the subnode in order to fix the following build
> warnings with W=1:
> 
> arch/arm/boot/dts/imx6q-zii-rdu2.dtb: Warning (pci_bridge): Node /soc
> /pcie at 1ffc000/pci at 0 missing ranges for PCI bridge (or not a bridge)
> arch/arm/boot/dts/imx6q-zii-rdu2.dtb: Warning (pci_bridge): Node /soc
> /pcie at 1ffc000/pci at 0 missing bus-range for PCI bridge
> arch/arm/boot/dts/imx6q-zii-rdu2.dtb: Warning (unit_address_format):
> Failed prerequisite 'pci_bridge'
> arch/arm/boot/dts/imx6q-zii-rdu2.dtb: Warning (pci_device_reg):
> Failed prerequisite 'pci_bridge'
> arch/arm/boot/dts/imx6q-zii-rdu2.dtb: Warning (pci_device_bus_num):
> Failed prerequisite 'pci_bridge'
> 
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> ?arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 1 -
> ?1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> index 5ea9949..72f52fc 100644
> --- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> @@ -584,7 +584,6 @@
> ?
> ?	host at 0 {
> ?		reg = <0 0 0 0 0>;
> -		device_type = "pci";
> ?
> ?		#address-cells = <3>;
> ?		#size-cells = <2>;
