From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 18 Oct 2013 22:33 +0200
Subject: [PATCH] sh-pfc: r8a7791 PFC support V2
In-Reply-To: <20131016214605.3868.54890.sendpatchset@w520>
References: <20131016214605.3868.54890.sendpatchset@w520>
Message-ID: <1428789.AD4dgYWceb@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

Thanks for the patch.

On Thursday 17 October 2013 06:46:05 Magnus Damm wrote:
> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> 
> Add PFC support for the r8a7791 SoC V2 including pin groups for
> on-chip devices such as MSIOF, SCIF, USB, MMC, SDHI, DU.
> 
> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> Signed-off-by: Kunihito Higashiyama <kunihito.higashiyama.ur@renesas.com>
> Signed-off-by: Yoshikazu Fujikawa <yoshikazu.fujikawa.ue@renesas.com>
> Signed-off-by: Nobuyuki HIRAI <nobuyuki.hirai.xe@renesas.com>
> Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> [damm at opensource.se: Forward ported to upstream, minor fixes]
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Written against renesas-devel-20131016
> 
>  Based on the following broken out patches from BSP v0.5.0:
>  0739, 0766, 0771, 0774, 0777, 0782, 0798, 1056, 1057, 1235, 1261, 1271
> 
>  Changes since V1:
>  - Added r8a7791 PFC to OF table
>  - Remove left over incorrect filename in pfc-r8a7791.c
>  - Made GPL header shorter
>  - Kept ETH magic pin as-is (data sheet 0.5.0), added it to eth_groups[]
>  - Dropped VIN support
>  - Rearranged DU order, added du0 and du1 to pinmux_functions[]
> 
>  drivers/pinctrl/sh-pfc/Kconfig       |    5
>  drivers/pinctrl/sh-pfc/Makefile      |    1
>  drivers/pinctrl/sh-pfc/core.c        |    9
>  drivers/pinctrl/sh-pfc/core.h        |    1
>  drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 4214 +++++++++++++++++++++++++++++++
>  5 files changed, 4230 insertions(+)

[snip]

> --- /dev/null
> +++ work/drivers/pinctrl/sh-pfc/pfc-r8a7791.c	2013-10-17 
06:35:00.000000000

[snip]

> +/* - DU
> --------------------------------------------------------------------- */
> +static const unsigned int du_rgb666_pins[] = {
> +	/* R[7:2], G[7:2], B[7:2] */
> +	RCAR_GP_PIN(3, 7),  RCAR_GP_PIN(3, 6),  RCAR_GP_PIN(3, 5),
> +	RCAR_GP_PIN(3, 4),  RCAR_GP_PIN(3, 3),  RCAR_GP_PIN(3, 2),
> +	RCAR_GP_PIN(3, 15), RCAR_GP_PIN(3, 14), RCAR_GP_PIN(3, 13),
> +	RCAR_GP_PIN(3, 12), RCAR_GP_PIN(3, 11), RCAR_GP_PIN(3, 10),
> +	RCAR_GP_PIN(3, 23), RCAR_GP_PIN(3, 22), RCAR_GP_PIN(3, 21),
> +	RCAR_GP_PIN(3, 20), RCAR_GP_PIN(3, 19), RCAR_GP_PIN(3, 18),
> +};
> +static const unsigned int du_rgb666_mux[] = {
> +	DU1_DR7_MARK, DU1_DR6_MARK, DU1_DR5_MARK, DU1_DR4_MARK,
> +	DU1_DR3_MARK, DU1_DR2_MARK,
> +	DU1_DG7_MARK, DU1_DG6_MARK, DU1_DG5_MARK, DU1_DG4_MARK,
> +	DU1_DG3_MARK, DU1_DG2_MARK,
> +	DU1_DB7_MARK, DU1_DB6_MARK, DU1_DB5_MARK, DU1_DB4_MARK,
> +	DU1_DB3_MARK, DU1_DB2_MARK,
> +};
> +static const unsigned int du_rgb888_pins[] = {
> +	/* R[7:0], G[7:0], B[7:0] */
> +	RCAR_GP_PIN(3, 7),  RCAR_GP_PIN(3, 6),  RCAR_GP_PIN(3, 5),
> +	RCAR_GP_PIN(3, 4),  RCAR_GP_PIN(3, 3),  RCAR_GP_PIN(3, 2),
> +	RCAR_GP_PIN(3, 1),  RCAR_GP_PIN(3, 0),
> +	RCAR_GP_PIN(3, 15), RCAR_GP_PIN(3, 14), RCAR_GP_PIN(3, 13),
> +	RCAR_GP_PIN(3, 12), RCAR_GP_PIN(3, 11), RCAR_GP_PIN(3, 10),
> +	RCAR_GP_PIN(3, 9),  RCAR_GP_PIN(3, 8),
> +	RCAR_GP_PIN(3, 23), RCAR_GP_PIN(3, 22), RCAR_GP_PIN(3, 21),
> +	RCAR_GP_PIN(3, 20), RCAR_GP_PIN(3, 19), RCAR_GP_PIN(3, 18),
> +	RCAR_GP_PIN(3, 17), RCAR_GP_PIN(3, 16),
> +};
> +static const unsigned int du_rgb888_mux[] = {
> +	DU1_DR7_MARK, DU1_DR6_MARK, DU1_DR5_MARK, DU1_DR4_MARK,
> +	DU1_DR3_MARK, DU1_DR2_MARK, DU1_DR1_MARK, DU1_DR0_MARK,
> +	DU1_DG7_MARK, DU1_DG6_MARK, DU1_DG5_MARK, DU1_DG4_MARK,
> +	DU1_DG3_MARK, DU1_DG2_MARK, DU1_DG1_MARK, DU1_DG0_MARK,
> +	DU1_DB7_MARK, DU1_DB6_MARK, DU1_DB5_MARK, DU1_DB4_MARK,
> +	DU1_DB3_MARK, DU1_DB2_MARK, DU1_DB1_MARK, DU1_DB0_MARK,
> +};
> +static const unsigned int du_clk_out_0_pins[] = {
> +	/* CLKOUT */
> +	RCAR_GP_PIN(3, 25),
> +};
> +static const unsigned int du_clk_out_0_mux[] = {
> +	DU1_DOTCLKOUT0_MARK
> +};
> +static const unsigned int du_clk_out_1_pins[] = {
> +	/* CLKOUT */
> +	RCAR_GP_PIN(3, 26),
> +};
> +static const unsigned int du_clk_out_1_mux[] = {
> +	DU1_DOTCLKOUT1_MARK
> +};
> +static const unsigned int du_sync_1_pins[] = {
> +	/* EXVSYNC/VSYNC, EXHSYNC/HSYNC, EXDISP/EXODDF/EXCDE */
> +	RCAR_GP_PIN(3, 29), RCAR_GP_PIN(3, 28), RCAR_GP_PIN(3, 27),
> +};
> +static const unsigned int du_sync_1_mux[] = {
> +	DU1_EXODDF_DU1_ODDF_DISP_CDE_MARK,
> +	DU1_EXVSYNC_DU1_VSYNC_MARK, DU1_EXHSYNC_DU1_HSYNC_MARK
> +};
> +static const unsigned int du_cde_disp_pins[] = {
> +	/* CDE DISP */
> +	RCAR_GP_PIN(3, 31), RCAR_GP_PIN(3, 30),
> +};
> +static const unsigned int du0_clk_in_pins[] = {
> +	/* CLKIN */
> +	RCAR_GP_PIN(6, 31),
> +};
> +static const unsigned int du0_clk_in_mux[] = {
> +	DU0_DOTCLKIN_MARK
> +};
> +static const unsigned int du_cde_disp_mux[] = {
> +	DU1_CDE_MARK, DU1_DISP_MARK
> +};
> +static const unsigned int du1_clk_in_pins[] = {
> +	/* CLKIN */
> +	RCAR_GP_PIN(7, 20), RCAR_GP_PIN(7, 19), RCAR_GP_PIN(3, 24),
> +};
> +static const unsigned int du1_clk_in_mux[] = {
> +	DU1_DOTCLKIN_C_MARK, DU1_DOTCLKIN_B_MARK, DU1_DOTCLKIN_MARK
> +};

I'm still a bit unsure about the DU pin groups. Would it be possible to get 
access to the SoC datasheet ?

In the worst case I can take the patch as-is and fix any issue later, as the 
DU driver doesn't support the r8a7791 yet anyway. So,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I've taken the patch to my tree and will push it as-is, or with modifications 
to the DU pin groups as needed if I can get access to the documentation before 
the next merge window.

-- 
Regards,

Laurent Pinchart
