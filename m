From: scottwood@freescale.com (Scott Wood)
Date: Wed, 9 Sep 2015 11:46:50 -0500
Subject: [PATCH v2 05/10] doc/bindings: Update clk-qoriq bindings for
 FSL's chassis-3.0 SoCs
In-Reply-To: <1441349872-4560-6-git-send-email-bhupesh.sharma@freescale.com>
References: <1441349872-4560-1-git-send-email-bhupesh.sharma@freescale.com>
 <1441349872-4560-6-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1441817210.29081.15.camel@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-09-04 at 12:27 +0530, Bhupesh Sharma wrote:
> This patch updates the 'clk-qoriq' device-tree bindings for
> chassis-3.0 compliant SoCs from FSL, for e.g. LS2080A
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> ---
>  .../devicetree/bindings/clock/qoriq-clock.txt      |   16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)

Why didn't you CC me on this?

> diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt 
> b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> index 16a3ec4..f0a4b1c 100644
> --- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> @@ -14,6 +14,7 @@ Chassis Version             Example Chips
>  ---------------              -------------
>  1.0                  p4080, p5020, p5040
>  2.0                  t4240, b4860
> +3.0                  ls2080a
>  
>  1. Clock Block Binding
>  
> @@ -32,9 +33,11 @@ Required properties:
>       * "fsl,b4420-clockgen"
>       * "fsl,b4860-clockgen"
>       * "fsl,ls1021a-clockgen"
> -     Chassis-version clock strings include:
> +     * "fsl,ls2080a-clockgen"

We don't need to update this for every new chip.  It says "such as".

> +     Chassis clock strings include:
>       * "fsl,qoriq-clockgen-1.0": for chassis 1.0 clocks
>       * "fsl,qoriq-clockgen-2.0": for chassis 2.0 clocks
> +     * "fsl,qoriq-clockgen-3.0": for chassis 3.0 clocks

With the new binding I don't see value in the generic version compatible.

>  - reg: Describes the address of the device's resources within the
>       address space defined by its parent bus, and resource zero
>       represents the clock register set
> @@ -96,18 +99,23 @@ Required properties:
>  - compatible : Should include one of the following:
>       * "fsl,qoriq-core-pll-1.0" for core PLL clocks (v1.0)
>       * "fsl,qoriq-core-pll-2.0" for core PLL clocks (v2.0)
> +     * "fsl,qoriq-core-pll-3.0" for core PLL clocks (v3.0)
>       * "fsl,qoriq-core-mux-1.0" for core mux clocks (v1.0)
>       * "fsl,qoriq-core-mux-2.0" for core mux clocks (v2.0)
> +     * "fsl,qoriq-core-mux-3.0" for core mux clocks (v3.0)
>       * "fsl,qoriq-sysclk-1.0": for input system clock (v1.0).
>               It takes parent's clock-frequency as its clock.
>       * "fsl,qoriq-sysclk-2.0": for input system clock (v2.0).
>               It takes parent's clock-frequency as its clock.
> +     * "fsl,qoriq-sysclk-3.0": for input system clock (v3.0).
> +             It takes parent's clock-frequency as its clock.
>       * "fsl,qoriq-platform-pll-1.0" for the platform PLL clock (v1.0)
>       * "fsl,qoriq-platform-pll-2.0" for the platform PLL clock (v2.0)
> +     * "fsl,qoriq-platform-pll-3.0" for the platform PLL clock (v3.0)

No new legacy compatibles please.

-Scott
