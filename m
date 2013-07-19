From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 19 Jul 2013 18:25:36 +0200
Subject: [PATCH RESEND 1/2] ARM: mmp: Add compatible entries for OLPC XO
 laptops
In-Reply-To: <20130716180605.A63C7FAAF3@dev.laptop.org>
References: <20130716180605.A63C7FAAF3@dev.laptop.org>
Message-ID: <20130719162536.GH16015@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:06 Tue 16 Jul     , Daniel Drake wrote:
> Add compatible entries to enable booting of OLPC XO-1.75 (MMP2) and
> OLPC XO-4 (MMP3).
> 
> Signed-off-by: Chris Ball <cjb@laptop.org>
> Signed-off-by: Daniel Drake <dsd@laptop.org>
> ---
>  Documentation/devicetree/bindings/arm/mrvl/intc.txt | 4 ++--
>  Documentation/devicetree/bindings/arm/mrvl/mrvl.txt | 8 ++++++++
>  arch/arm/mach-mmp/irq.c                             | 1 +
>  arch/arm/mach-mmp/mmp2-dt.c                         | 2 ++
>  4 files changed, 13 insertions(+), 2 deletions(-)
> 
> Resending after 1 month with no response.
> 
> diff --git a/Documentation/devicetree/bindings/arm/mrvl/intc.txt b/Documentation/devicetree/bindings/arm/mrvl/intc.txt
> index 8b53273..3554fb9 100644
> --- a/Documentation/devicetree/bindings/arm/mrvl/intc.txt
> +++ b/Documentation/devicetree/bindings/arm/mrvl/intc.txt
> @@ -1,8 +1,8 @@
>  * Marvell MMP Interrupt controller
>  
>  Required properties:
> -- compatible : Should be "mrvl,mmp-intc", "mrvl,mmp2-intc" or
> -  "mrvl,mmp2-mux-intc"
> +- compatible : One of: mrvl,mmp-intc mrvl,mmp2-intc mrvl,mmp3-intc
> +  mrvl,mmp2-mux-intc
>  - reg : Address and length of the register set of the interrupt controller.
>    If the interrupt controller is intc, address and length means the range
>    of the whold interrupt controller. If the interrupt controller is mux-intc,
> diff --git a/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt b/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
> index 117d741..236e884 100644
> --- a/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
> +++ b/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
> @@ -12,3 +12,11 @@ Required root node properties:
>  MMP2 Brownstone Board
>  Required root node properties:
>  	- compatible = "mrvl,mmp2-brownstone";
> +
> +OLPC XO-1.75 (CL2) based on MMP2
> +Required root node properties:
> +	- compatible = "olpc,xo-1.75";
> +
> +OLPC XO-4 (CL4) based on MMP3
> +Required root node properties:
> +	- compatible = "olpc,xo-cl4";
documentation not consistnt with code

Best Regards,
J.
> diff --git a/arch/arm/mach-mmp/irq.c b/arch/arm/mach-mmp/irq.c
> index 3c71246..d60b85a 100644
> --- a/arch/arm/mach-mmp/irq.c
> +++ b/arch/arm/mach-mmp/irq.c
> @@ -329,6 +329,7 @@ void __init mmp2_init_icu(void)
>  static const struct of_device_id intc_ids[] __initconst = {
>  	{ .compatible = "mrvl,mmp-intc", .data = &mmp_conf },
>  	{ .compatible = "mrvl,mmp2-intc", .data = &mmp2_conf },
> +	{ .compatible = "mrvl,mmp3-intc", .data = &mmp2_conf },
>  	{}
>  };
>  
> diff --git a/arch/arm/mach-mmp/mmp2-dt.c b/arch/arm/mach-mmp/mmp2-dt.c
> index 4ac2567..e67bd9f 100644
> --- a/arch/arm/mach-mmp/mmp2-dt.c
> +++ b/arch/arm/mach-mmp/mmp2-dt.c
> @@ -44,6 +44,8 @@ static void __init mmp2_dt_init(void)
>  
>  static const char *mmp2_dt_board_compat[] __initdata = {
>  	"mrvl,mmp2-brownstone",
> +	"olpc,xo-1.75",
> +	"olpc,xo-cl4",
>  	NULL,
>  };
>  
> -- 
> 1.8.1.4
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
