From: stuart.yoder@freescale.com (Stuart Yoder)
Date: Tue, 24 Feb 2015 15:44:27 +0000
Subject: question about PMU interrupt in binding
Message-ID: <CY1PR0301MB0748CE5D60F401F4D395E3C387160@CY1PR0301MB0748.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen/Will,

Had a question about the definition of "interrupts" in the
PMU binding:

> commit d84c47837d800c0db1c9f2015a1565504417f812
> Author: Stephen Boyd <sboyd@codeaurora.org>
> Date:   Fri Feb 7 21:01:24 2014 +0000
> 
>     devicetree: bindings: Document Krait performance monitor units (PMU)
> 
>     Document the Krait PMU compatible string.
> 
>     Cc: <devicetree@vger.kernel.org>
>     Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>     Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
> index 3e1e498..ce73144 100644
> --- a/Documentation/devicetree/bindings/arm/pmu.txt
> +++ b/Documentation/devicetree/bindings/arm/pmu.txt
> @@ -16,7 +16,14 @@ Required properties:
>         "arm,arm11mpcore-pmu"
>         "arm,arm1176-pmu"
>         "arm,arm1136-pmu"
> -- interrupts : 1 combined interrupt or 1 per core.
> +       "qcom,krait-pmu"
> +- interrupts : 1 combined interrupt or 1 per core. If the interrupt is a per-cpu
> +               interrupt (PPI) then 1 interrupt should be specified.

If the interrupt is per-cpu do you mean 1 interrupt _per cpu_ should
be specified?  As written it seems to say _only_  "1 interrupt" should be
specificed.

Thanks,
Stuart
