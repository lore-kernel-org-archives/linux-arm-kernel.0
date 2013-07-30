From: nm@ti.com (Nishanth Menon)
Date: Tue, 30 Jul 2013 15:00:40 -0500
Subject: [PATCHv4 19/33] CLK: omap: add am33xx clock init file
In-Reply-To: <1374564028-11352-20-git-send-email-t-kristo@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-20-git-send-email-t-kristo@ti.com>
Message-ID: <51F81B68.2020708@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2013 02:20 AM, Tero Kristo wrote:
> clk-33xx.c now contains the clock init functionality for am33xx, including
> DT clock registration and adding of static clkdev entries.
>
> This patch also moves the omap2_clk_enable_init_clocks declaration to
> the driver include, as this is needed by the am33xx clock init code.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>   arch/arm/mach-omap2/clock.h |    1 -
>   drivers/clk/omap/clk-33xx.c |   85 +++++++++++++++++++++++++++++++++++++++++++
>   include/linux/clk/omap.h    |    1 +
>   3 files changed, 86 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/clk/omap/clk-33xx.c
>
> diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
> index d1a3125..6273f14 100644
> --- a/arch/arm/mach-omap2/clock.h
> +++ b/arch/arm/mach-omap2/clock.h
> @@ -267,7 +267,6 @@ void omap2_clk_dflt_find_idlest(struct clk_hw_omap *clk,
>   				void __iomem **idlest_reg,
>   				u8 *idlest_bit, u8 *idlest_val);
>   int omap2_clk_enable_autoidle_all(void);
> -void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks);
>   int omap2_clk_switch_mpurate_at_boot(const char *mpurate_ck_name);
>   void omap2_clk_print_new_rates(const char *hfclkin_ck_name,
>   			       const char *core_ck_name,
> diff --git a/drivers/clk/omap/clk-33xx.c b/drivers/clk/omap/clk-33xx.c
> new file mode 100644
> index 0000000..3ada30e
> --- /dev/null
> +++ b/drivers/clk/omap/clk-33xx.c
[...]
> +static const char *enable_init_clks[] = {
> +	"dpll_ddr_m2_ck",
> +	"dpll_mpu_m2_ck",
> +	"l3_gclk",
> +	"l4hs_gclk",
> +	"l4fw_gclk",
> +	"l4ls_gclk",
> +	/* Required for external peripherals like, Audio codecs */
> +	"clkout2_ck",
> +};

should be a sort of dt property?

-- 
Regards,
Nishanth Menon
