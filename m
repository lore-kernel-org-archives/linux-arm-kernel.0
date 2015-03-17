From: robherring2@gmail.com (Rob Herring)
Date: Mon, 16 Mar 2015 19:28:59 -0500
Subject: [PATCH 05/10] dt-bindings: add Marvell PMU documentation
In-Reply-To: <E1YWSNA-0006G9-Rr@rmk-PC.arm.linux.org.uk>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
 <E1YWSNA-0006G9-Rr@rmk-PC.arm.linux.org.uk>
Message-ID: <CAL_JsqLYjp+q0F6cpKrWy4H7pm+xkVwnSjbqeGrX=OLFTGmDtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 11:23 AM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Add the required DT binding documentation for the Marvell PMU driver.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/soc/dove/pmu.txt | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/dove/pmu.txt
>
> diff --git a/Documentation/devicetree/bindings/soc/dove/pmu.txt b/Documentation/devicetree/bindings/soc/dove/pmu.txt
> new file mode 100644
> index 000000000000..25d988e7ec35
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/dove/pmu.txt
> @@ -0,0 +1,49 @@
> +Device Tree bindings for Marvell PMU
> +
> +Required properties:
> + - compatible: value should be "marvell,dove-pmu".
> + - reg: two base addresses and sizes of the PM controller and PMU.
> + - interrupts: single interrupt number for the PMU interrupt
> + - interrupt-controller: must be specified as the PMU itself is an
> +    interrupt controller.
> + - #interrupt-cells: must be 1.
> + - #reset-cells: must be 1.
> +
> +Optional properties:
> + - None
> +
> +Power domain descriptions are listed as child nodes of the power management
> +node.  Each domain has the following properties:
> +
> +Required properties:
> + - #power-domain-cells: must be 0.
> +
> +Optional properties:
> + - marvell,pmu_pwr_mask: specifies the mask value for PMU power register
> + - marvell,pmu_iso_mask: specifies the mask value for PMU isolation register
> + - resets: points to the reset manager (PMU node) and reset index.
> +
> +Example:
> +
> +       pmu: power-management at d0000 {
> +               compatible = "marvell,dove-pmu";
> +               reg = <0xd0000 0x8000>, <0xd8000 0x8000>;
> +               interrupts = <33>;
> +               interrupt-controller;
> +               #interrupt-cells = <1>;
> +               #reset-cells = <1>;
> +
> +               vpu_domain: vpu-domain {
> +                       #power-domain-cells = <0>;
> +                       marvell,pmu_pwr_mask = <0x00000008>;
> +                       marvell,pmu_iso_mask = <0x00000001>;
> +                       resets = <&pmu 16>;
> +               };
> +
> +               gpu_domain: gpu-domain {
> +                       #power-domain-cells = <0>;
> +                       marvell,pmu_pwr_mask = <0x00000004>;
> +                       marvell,pmu_iso_mask = <0x00000002>;
> +                       resets = <&pmu 18>;
> +               };
> +       };
> --
> 1.8.3.1
>
