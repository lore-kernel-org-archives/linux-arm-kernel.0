From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 6 Jun 2016 11:37:50 -0700
Subject: [PATCH v4 4/7] dt: mdio-mux: Add mdio multiplexer driver node
In-Reply-To: <1465216900-11755-5-git-send-email-pramod.kumar@broadcom.com>
References: <1465216900-11755-1-git-send-email-pramod.kumar@broadcom.com>
 <1465216900-11755-5-git-send-email-pramod.kumar@broadcom.com>
Message-ID: <5755C2FE.1090303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2016 05:41 AM, Pramod Kumar wrote:
> Add integrated MDIO multiplexer driver node which contains
> two mux PCIe bus and one ethernet bus along with phys
> lying on these bus.
> 
> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
> ---
> +		mdio_mux_iproc: mdio-mux at 6602023c {
> +			compatible = "brcm,mdio-mux-iproc";
> +			reg = <0x6602023c 0x14>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			mdio at 0 {
> +				reg = <0x0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				pci_phy0: pci-phy at 0 {
> +					compatible = "brcm,ns2-pcie-phy";
> +					reg = <0x0>;
> +					#phy-cells = <0>;
> +				};
> +			};
> +
> +			mdio at 7 {
> +				reg = <0x7>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				pci_phy1: pci-phy at 0 {
> +					compatible = "brcm,ns2-pcie-phy";
> +					reg = <0x0>;
> +					#phy-cells = <0>;
> +				};

Are these two PHYs always available in the NS2 SoC, or does that depend
on interfaces exposed at the board level? Should not they be flagged
with a disabled status property by default and enabled in their
respective board files?
-- 
Florian
