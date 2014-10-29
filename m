From: santosh.shilimkar@gmail.com (Santosh Shilimkar)
Date: Wed, 29 Oct 2014 12:05:37 -0700
Subject: [PATCH v1 4/4] ARM: dts: keystone-k2e: add DT bindings for PCI
 controller for port 1
In-Reply-To: <1414601134-31825-5-git-send-email-m-karicheri2@ti.com>
References: <1414601134-31825-1-git-send-email-m-karicheri2@ti.com>
 <1414601134-31825-5-git-send-email-m-karicheri2@ti.com>
Message-ID: <54513A81.4050801@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/2014 09:45 AM, Murali Karicheri wrote:
> K2E SoC has a second PCI port based on Synopsis Designware PCIe h/w.
> Add DT bindings to support PCI controller for port 1 for this SoC.
>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> CC: Santosh Shilimkar <ssantosh@kernel.org>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Pawel Moll <pawel.moll@arm.com>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Ian Campbell <ijc+devicetree@hellion.org.uk>
> CC: Kumar Gala <galak@codeaurora.org>
> CC: Russell King <linux@arm.linux.org.uk>
> CC: devicetree at vger.kernel.org
> ---
>   v1 - fixed email ID for Santosh and reworded commit description to be
>        consistent with the subject.
>   arch/arm/boot/dts/k2e.dtsi |   45 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
>
> diff --git a/arch/arm/boot/dts/k2e.dtsi b/arch/arm/boot/dts/k2e.dtsi
> index c358b4b..e60d128 100644
> --- a/arch/arm/boot/dts/k2e.dtsi
> +++ b/arch/arm/boot/dts/k2e.dtsi
> @@ -85,6 +85,51 @@
>   			#gpio-cells = <2>;
>   			gpio,syscon-dev = <&devctrl 0x240>;
>   		};
> +
> +		pcie at 21020000 {
> +			compatible = "ti,keystone-pcie","snps,dw-pcie";
> +			clocks = <&clkpcie1>;
> +			clock-names = "pcie";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			reg =  <0x21021000 0x2000>, <0x21020000 0x1000>, <0x02620128 4>;
> +			ranges = <0x81000000 0 0 0x23260000 0x4000 0x4000
> +				0x82000000 0 0x60000000 0x60000000 0 0x10000000>;
> +
> +			device_type = "pci";
> +			num-lanes = <2>;
> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0 0 0 1 &pcie_intc1 0>, // INT A
> +					<0 0 0 2 &pcie_intc1 1>, // INT B
> +					<0 0 0 3 &pcie_intc1 2>, // INT C
> +					<0 0 0 4 &pcie_intc1 3>; // INT D
Same comment as last patch. O.w looks fine.

Regards,
Santosh
