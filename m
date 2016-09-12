From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Sep 2016 11:18:37 -0500
Subject: [PATCH v10 1/5] Documentation: bindings: add dt documentation
 for dfi controller
In-Reply-To: <1473051971-5500-2-git-send-email-hl@rock-chips.com>
References: <1473051971-5500-1-git-send-email-hl@rock-chips.com>
 <1473051971-5500-2-git-send-email-hl@rock-chips.com>
Message-ID: <20160912161836.GA16533@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 05, 2016 at 01:06:07PM +0800, Lin Huang wrote:
> This patch adds the documentation for rockchip dfi devfreq-event driver.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> Changes in v10:
> - None
> 
> Changes in v9:
> - reorder compatible and reg
> 
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
> index 0000000..f223313
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

Drop the '0x'. With that,

Acked-by: Rob Herring <robh@kernel.org>

> +		compatible = "rockchip,rk3399-dfi";
> +		reg = <0x00 0xff630000 0x00 0x4000>;
> +		rockchip,pmu = <&pmugrf>;
> +		clocks = <&cru PCLK_DDR_MON>;
> +		clock-names = "pclk_ddr_mon";
> +		status = "disabled";
> +	};
> -- 
> 2.6.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
