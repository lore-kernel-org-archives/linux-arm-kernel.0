From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 10 Aug 2016 13:29:14 +0900
Subject: [PATCH v5 4/8] Documentation: bindings: add dt documentation for
 dfi controller
In-Reply-To: <1470799604-12877-5-git-send-email-hl@rock-chips.com>
References: <1470799604-12877-1-git-send-email-hl@rock-chips.com>
 <CGME20160810033623epcas1p127d334061fbe7874195033c6bec44509@epcas1p1.samsung.com>
 <1470799604-12877-5-git-send-email-hl@rock-chips.com>
Message-ID: <57AAAD9A.1090201@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lin,

On 2016? 08? 10? 12:26, Lin Huang wrote:
> This patch adds the documentation for rockchip dfi devfreq-event driver.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v5:
> -None
> 
> Changes in v4:
> -None
> 
> Changes in v3:
> -None
> 
> Changes in v2:
> -None 
> 
> Changes in v1:
> -None
> 
>  .../bindings/devfreq/event/rockchip-dfi.txt          | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
> new file mode 100644
> index 0000000..bf42255
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
> @@ -0,0 +1,20 @@
> +
> +* Rockchip rk3399 DFI device
> +
> +Required properties:
> +- compatible: Must be "rockchip,rk3399-dfi".
> +- reg: physical base address of each DFI and length of memory mapped region
> +- rockchip,pmu: phandle to the syscon managing the "pmu general register files"
> +- clocks: phandles for clock specified in "clock-names" property
> +- clock-names : the name of clock used by the DFI, must be "pclk_ddr_mon";
> +
> +Example:
> +	dfi: dfi at 0xff630000 {
> +		reg = <0x00 0xff630000 0x00 0x4000>;
> +		compatible = "rockchip,rk3399-dfi";

Usually, the compatible is first entry within Device-tree node.

> +		rockchip,pmu = <&pmugrf>;
> +		clocks = <&cru PCLK_DDR_MON>;
> +		clock-names = "pclk_ddr_mon";
> +		status = "disabled";
> +	};
> +
> 

Looks good to me. Just I want to change the sequence
between 'compatible' and 'reg' property.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Regards,
Chawnoo Choi
