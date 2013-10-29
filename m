From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 29 Oct 2013 18:28:55 -0500
Subject: [RESEND PATCH V2 1/2] ARM: dts: AM33xx: Add RNG node
In-Reply-To: <1377780731-3648-2-git-send-email-lokeshvutla@ti.com>
References: <1377780731-3648-1-git-send-email-lokeshvutla@ti.com>
 <1377780731-3648-2-git-send-email-lokeshvutla@ti.com>
Message-ID: <095F5C3C-4A82-4905-809B-5AD14E18E0CE@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Aug 29, 2013, at 7:52 AM, Lokesh Vutla wrote:

> Add the AM33xx RNG module's device tree data.
> Also add Documentation file describing the data
> for the RNG module.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> Changes since V1:
> - Drop "status=disabled" entry in dt node, Since
>  RNG is present on all AM33xx platforms.
> 
> .../devicetree/bindings/hwrng/omap_rng.txt         |   22 ++++++++++++++++++++
> arch/arm/boot/dts/am33xx.dtsi                      |    7 +++++++
> 2 files changed, 29 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/hwrng/omap_rng.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwrng/omap_rng.txt b/Documentation/devicetree/bindings/hwrng/omap_rng.txt
> new file mode 100644
> index 0000000..6a62acd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwrng/omap_rng.txt
> @@ -0,0 +1,22 @@
> +OMAP SoC HWRNG Module
> +
> +Required properties:
> +
> +- compatible : Should contain entries for this and backward compatible
> +  RNG versions:
> +  - "ti,omap2-rng" for OMAP2.
> +  - "ti,omap4-rng" for OMAP4, OMAP5 and AM33XX.
> +  Note that these two versions are incompatible.
> +- ti,hwmods: Name of the hwmod associated with the RNG module
> +- reg : Offset and length of the register set for the module
> +- interrupts : the interrupt number for the RNG module.
> +		Only used for "ti,omap4-rng".
> +
> +Example:
> +/* AM335x */
> +rng: rng at 48310000 {
> +	compatible = "ti,omap4-rng";
> +	ti,hwmods = "rng";
> +	reg = <0x48310000 0x2000>;
> +	interrupts = <111>;
> +};

For the DT-Binding portion:

Acked-by: Kumar Gala <galak@codeaurora.org>

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
