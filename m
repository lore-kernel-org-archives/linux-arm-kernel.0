From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 02 Sep 2016 17:50:54 +0900
Subject: [PATCH 1/5] Documentation: bindings: add dt documentation for dfi
 controller
In-Reply-To: <1472769085-20715-2-git-send-email-hl@rock-chips.com>
References: <1472769085-20715-1-git-send-email-hl@rock-chips.com>
 <CGME20160901223311epcas1p35e5c0ad56cd8604a8e48bd4edef8b13a@epcas1p3.samsung.com>
 <1472769085-20715-2-git-send-email-hl@rock-chips.com>
Message-ID: <57C93D6E.8090600@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016? 09? 02? 07:31, Lin Huang wrote:
> This patch adds the documentation for rockchip dfi devfreq-event driver.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v8:
> - delete a unuse blank line
> 
> Changes in v7:
> - None
> 
> Changes in v6:
> - None
> 
> Changes in v5:
> - None
> 
> Changes in v4:
> - None
> 
> Changes in v3:
> - None
> 
> Changes in v2:
> - None 
> 
> Changes in v1:
> - None
> 
>  .../bindings/devfreq/event/rockchip-dfi.txt           | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
> new file mode 100644
> index 0000000..d66aca6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
> @@ -0,0 +1,19 @@
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

As I already commented, you need to reorder between compatible and reg property.

> +		rockchip,pmu = <&pmugrf>;
> +		clocks = <&cru PCLK_DDR_MON>;
> +		clock-names = "pclk_ddr_mon";
> +		status = "disabled";
> +	};
> 


-- 
Best Regards,
Chanwoo Choi
