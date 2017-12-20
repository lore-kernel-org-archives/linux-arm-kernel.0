From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 20 Dec 2017 18:14:52 +0900
Subject: [PATCH] clk: samsung: s3c: Remove unneeded enumeration
In-Reply-To: <1511749908-29777-1-git-send-email-cw00.choi@samsung.com>
References: <CGME20171127023145epcas1p1b97c3c66ce624f5362c8d9bf74997c7f@epcas1p1.samsung.com>
 <1511749908-29777-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <5A3A2A0C.8040601@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sylwester,

Gently Ping.

Regards,
Chanwoo Choi

On 2017? 11? 27? 11:31, Chanwoo Choi wrote:
> This patch just removes the unneeded enumeration for PLL index.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/clk/samsung/clk-s3c2412.c | 11 ++---------
>  drivers/clk/samsung/clk-s3c2443.c | 17 ++++-------------
>  drivers/clk/samsung/clk-s3c64xx.c | 17 ++++++-----------
>  3 files changed, 12 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-s3c2412.c b/drivers/clk/samsung/clk-s3c2412.c
> index b8340a49921b..1555e407529e 100644
> --- a/drivers/clk/samsung/clk-s3c2412.c
> +++ b/drivers/clk/samsung/clk-s3c2412.c
> @@ -27,11 +27,6 @@
>  #define CLKSRC		0x1c
>  #define SWRST		0x30
>  
> -/* list of PLLs to be registered */
> -enum s3c2412_plls {
> -	mpll, upll,
> -};
> -
>  static void __iomem *reg_base;
>  
>  #ifdef CONFIG_PM_SLEEP
> @@ -144,10 +139,8 @@ struct samsung_mux_clock s3c2412_muxes[] __initdata = {
>  };
>  
>  static struct samsung_pll_clock s3c2412_plls[] __initdata = {
> -	[mpll] = PLL(pll_s3c2440_mpll, MPLL, "mpll", "xti",
> -						LOCKTIME, MPLLCON, NULL),
> -	[upll] = PLL(pll_s3c2410_upll, UPLL, "upll", "urefclk",
> -						LOCKTIME, UPLLCON, NULL),
> +	PLL(pll_s3c2440_mpll, MPLL, "mpll", "xti", LOCKTIME, MPLLCON, NULL),
> +	PLL(pll_s3c2410_upll, UPLL, "upll", "urefclk", LOCKTIME, UPLLCON, NULL),
>  };
>  
>  struct samsung_gate_clock s3c2412_gates[] __initdata = {
> diff --git a/drivers/clk/samsung/clk-s3c2443.c b/drivers/clk/samsung/clk-s3c2443.c
> index d94b85a42356..9580a6baf4d7 100644
> --- a/drivers/clk/samsung/clk-s3c2443.c
> +++ b/drivers/clk/samsung/clk-s3c2443.c
> @@ -41,11 +41,6 @@ enum supported_socs {
>  	S3C2450,
>  };
>  
> -/* list of PLLs to be registered */
> -enum s3c2443_plls {
> -	mpll, epll,
> -};
> -
>  static void __iomem *reg_base;
>  
>  #ifdef CONFIG_PM_SLEEP
> @@ -225,10 +220,8 @@ struct samsung_clock_alias s3c2443_common_aliases[] __initdata = {
>  /* S3C2416 specific clocks */
>  
>  static struct samsung_pll_clock s3c2416_pll_clks[] __initdata = {
> -	[mpll] = PLL(pll_6552_s3c2416, MPLL, "mpll", "mpllref",
> -						LOCKCON0, MPLLCON, NULL),
> -	[epll] = PLL(pll_6553, EPLL, "epll", "epllref",
> -						LOCKCON1, EPLLCON, NULL),
> +	PLL(pll_6552_s3c2416, MPLL, "mpll", "mpllref", LOCKCON0, MPLLCON, NULL),
> +	PLL(pll_6553, EPLL, "epll", "epllref", LOCKCON1, EPLLCON, NULL),
>  };
>  
>  PNAME(s3c2416_hsmmc0_p) = { "sclk_hsmmc0", "sclk_hsmmcext" };
> @@ -279,10 +272,8 @@ struct samsung_clock_alias s3c2416_aliases[] __initdata = {
>  /* S3C2443 specific clocks */
>  
>  static struct samsung_pll_clock s3c2443_pll_clks[] __initdata = {
> -	[mpll] = PLL(pll_3000, MPLL, "mpll", "mpllref",
> -						LOCKCON0, MPLLCON, NULL),
> -	[epll] = PLL(pll_2126, EPLL, "epll", "epllref",
> -						LOCKCON1, EPLLCON, NULL),
> +	PLL(pll_3000, MPLL, "mpll", "mpllref", LOCKCON0, MPLLCON, NULL),
> +	PLL(pll_2126, EPLL, "epll", "epllref", LOCKCON1, EPLLCON, NULL),
>  };
>  
>  static struct clk_div_table armdiv_s3c2443_d[] = {
> diff --git a/drivers/clk/samsung/clk-s3c64xx.c b/drivers/clk/samsung/clk-s3c64xx.c
> index 7306867a0ab8..6db01cf5ab83 100644
> --- a/drivers/clk/samsung/clk-s3c64xx.c
> +++ b/drivers/clk/samsung/clk-s3c64xx.c
> @@ -56,11 +56,6 @@
>  #define GATE_ON(_id, cname, pname, o, b) \
>  		GATE(_id, cname, pname, o, b, CLK_IGNORE_UNUSED, 0)
>  
> -/* list of PLLs to be registered */
> -enum s3c64xx_plls {
> -	apll, mpll, epll,
> -};
> -
>  static void __iomem *reg_base;
>  static bool is_s3c6400;
>  
> @@ -364,12 +359,12 @@ static void __init s3c64xx_clk_sleep_init(void) {}
>  
>  /* List of PLL clocks. */
>  static struct samsung_pll_clock s3c64xx_pll_clks[] __initdata = {
> -	[apll] = PLL(pll_6552, FOUT_APLL, "fout_apll", "fin_pll",
> -						APLL_LOCK, APLL_CON, NULL),
> -	[mpll] = PLL(pll_6552, FOUT_MPLL, "fout_mpll", "fin_pll",
> -						MPLL_LOCK, MPLL_CON, NULL),
> -	[epll] = PLL(pll_6553, FOUT_EPLL, "fout_epll", "fin_pll",
> -						EPLL_LOCK, EPLL_CON0, NULL),
> +	PLL(pll_6552, FOUT_APLL, "fout_apll", "fin_pll",
> +					APLL_LOCK, APLL_CON, NULL),
> +	PLL(pll_6552, FOUT_MPLL, "fout_mpll", "fin_pll",
> +					MPLL_LOCK, MPLL_CON, NULL),
> +	PLL(pll_6553, FOUT_EPLL, "fout_epll", "fin_pll",
> +					EPLL_LOCK, EPLL_CON0, NULL),
>  };
>  
>  /* Aliases for common s3c64xx clocks. */
> 
