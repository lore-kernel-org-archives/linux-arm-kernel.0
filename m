From: robh@kernel.org (Rob Herring)
Date: Mon, 24 Sep 2018 14:31:43 -0700
Subject: [RFC PATCH 2/4] dt-bindings: mmc: arasan: Document
 'xlnx,zynqmp-8.9a' controller
In-Reply-To: <1537278339-9257-3-git-send-email-manish.narani@xilinx.com>
References: <1537278339-9257-1-git-send-email-manish.narani@xilinx.com>
 <1537278339-9257-3-git-send-email-manish.narani@xilinx.com>
Message-ID: <5baa1aef.1c69fb81.e8e5f.3dbb@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2018 at 07:15:37PM +0530, Manish Narani wrote:
> Add documentation for 'xlnx,zynqmp-8.9a' SDHCI controller and required
> properties followed by example.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index f6ddba3..72769e0 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -15,6 +15,7 @@ Required Properties:
>      - "arasan,sdhci-5.1": generic Arasan SDHCI 5.1 PHY
>      - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC PHY
>        For this device it is strongly suggested to include arasan,soc-ctl-syscon.
> +    - "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a": Xilinx ZynqMP Arasan SDHCI 8.9a PHY

xlnx,zynqmp-sdhci. The version number is for Arasan.

>    - reg: From mmc bindings: Register location and length.
>    - clocks: From clock bindings: Handles to clock inputs.
>    - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
> @@ -24,6 +25,9 @@ Required Properties for "arasan,sdhci-5.1":
>    - phys: From PHY bindings: Phandle for the Generic PHY for arasan.
>    - phy-names:  MUST be "phy_arasan".
>  
> +Required Properties for "xlnx,zynqmp-8.9a":
> +  - xlnx,device_id: SD controller device ID. Must be either <0> or <1>.
> +

What's this for?

>  Optional Properties:
>    - arasan,soc-ctl-syscon: A phandle to a syscon device (see ../mfd/syscon.txt)
>      used to access core corecfg registers.  Offsets of registers in this
> @@ -75,3 +79,13 @@ Example:
>  		phy-names = "phy_arasan";
>  		#clock-cells = <0>;
>  	};
> +
> +	sdhci: sdhci at ff160000 {

mmc at ...

> +		compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
> +		reg = <0x0 0xff160000 0x0 0x1000>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 48 4>;
> +		clock-names = "clk_xin", "clk_ahb";
> +		clocks = <&clk 54>, <&clk 31>;
> +		xlnx,device_id = <0>;
> +	};
> -- 
> 2.1.1
> 
