From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 14 Jan 2014 10:37:42 +0800
Subject: [PATCH V4 1/6] ARM: dts: imx6q: add common compatible name for
 reused modules
In-Reply-To: <20140113142249.GW23525@S2101-09.ap.freescale.net>
References: <1389614031-7253-1-git-send-email-b20788@freescale.com>
 <20140113121016.GJ16215@pengutronix.de>
 <20140113142249.GW23525@S2101-09.ap.freescale.net>
Message-ID: <20140114023738.GA1914@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 10:22:51PM +0800, Shawn Guo wrote:
> Anson, the change below is a demonstration of Sascha's suggestion.
> Sascha, correct me if I misunderstood your comment.

<snip>

> @@ -88,36 +88,66 @@ struct imx6_pm_base {
>  	void __iomem *vbase;
>  };
>  
> -static const u32 imx6q_mmdc_io_dsm_offset[] __initconst = {
> -	0x5ac, 0x5b4, 0x528, 0x520, /* DQM0 ~ DQM3 */
> -	0x514, 0x510, 0x5bc, 0x5c4, /* DQM4 ~ DQM7 */
> -	0x56c, 0x578, 0x588, 0x594, /* CAS, RAS, SDCLK_0, SDCLK_1 */
> -	0x5a8, 0x5b0, 0x524, 0x51c, /* SDQS0 ~ SDQS3 */
> -	0x518, 0x50c, 0x5b8, 0x5c0, /* SDQS4 ~ SDQS7 */
> -	0x784, 0x788, 0x794, 0x79c, /* GPR_B0DS ~ GPR_B3DS */
> -	0x7a0, 0x7a4, 0x7a8, 0x748, /* GPR_B4DS ~ GPR_B7DS */
> -	0x59c, 0x5a0, 0x750, 0x774, /* SODT0, SODT1, DDRMODE_CTL, DDRMODE */
> -	0x74c			    /* GPR_ADDS */
> +struct imx6_pm_socdata {
> +	u32 cpu_type;
> +	const char *mmdc_compat;
> +	const char *src_compat;
> +	const char *iomuxc_compat;
> +	const char *gpc_compat;
> +	const u32 mmdc_io_offset[MX6_MAX_MMDC_IO_NUM];
> +};
> +
> +static const struct imx6_pm_socdata imx6q_pm_data __initconst = {
> +	.cpu_type = MXC_CPU_IMX6Q,
> +	.mmdc_compat = "fsl,imx6q-mmdc",
> +	.src_compat = "fsl,imx6q-src",
> +	.iomuxc_compat = "fsl,imx6q-iomuxc",
> +	.gpc_compat = "fsl,imx6q-gpc",
> +	.mmdc_io_offset = {
> +		0x5ac, 0x5b4, 0x528, 0x520, /* DQM0 ~ DQM3 */
> +		0x514, 0x510, 0x5bc, 0x5c4, /* DQM4 ~ DQM7 */
> +		0x56c, 0x578, 0x588, 0x594, /* CAS, RAS, SDCLK_0, SDCLK_1 */
> +		0x5a8, 0x5b0, 0x524, 0x51c, /* SDQS0 ~ SDQS3 */
> +		0x518, 0x50c, 0x5b8, 0x5c0, /* SDQS4 ~ SDQS7 */
> +		0x784, 0x788, 0x794, 0x79c, /* GPR_B0DS ~ GPR_B3DS */
> +		0x7a0, 0x7a4, 0x7a8, 0x748, /* GPR_B4DS ~ GPR_B7DS */
> +		0x59c, 0x5a0, 0x750, 0x774, /* SODT0, SODT1, DDRMODE_CTL, DDRMODE */
> +		0x74c,			    /* GPR_ADDS */
> +	},
>  };
>  
> -static const u32 imx6dl_mmdc_io_dsm_offset[] __initconst = {
> -	0x470, 0x474, 0x478, 0x47c, /* DQM0 ~ DQM3 */
> -	0x480, 0x484, 0x488, 0x48c, /* DQM4 ~ DQM7 */
> -	0x464, 0x490, 0x4ac, 0x4b0, /* CAS, RAS, SDCLK_0, SDCLK_1 */
> -	0x4bc, 0x4c0, 0x4c4, 0x4c8, /* DRAM_SDQS0 ~ DRAM_SDQS3 */
> -	0x4cc, 0x4d0, 0x4d4, 0x4d8, /* DRAM_SDQS4 ~ DRAM_SDQS7 */
> -	0x764, 0x770, 0x778, 0x77c, /* GPR_B0DS ~ GPR_B3DS */
> -	0x780, 0x784, 0x78c, 0x748, /* GPR_B4DS ~ GPR_B7DS */
> -	0x4b4, 0x4b8, 0x750, 0x760, /* SODT0, SODT1, DDRMODE_CTL, DDRMODE */
> -	0x74c			    /* GPR_ADDS */
> +static const struct imx6_pm_socdata imx6dl_pm_data __initconst = {
> +	.cpu_type = MXC_CPU_IMX6DL,
> +	.mmdc_compat = "fsl,imx6dl-mmdc",
> +	.src_compat = "fsl,imx6dl-src",
> +	.iomuxc_compat = "fsl,imx6dl-iomuxc",
> +	.gpc_compat = "fsl,imx6dl-gpc",
> +	.mmdc_io_offset = {
> +		0x470, 0x474, 0x478, 0x47c, /* DQM0 ~ DQM3 */
> +		0x480, 0x484, 0x488, 0x48c, /* DQM4 ~ DQM7 */
> +		0x464, 0x490, 0x4ac, 0x4b0, /* CAS, RAS, SDCLK_0, SDCLK_1 */
> +		0x4bc, 0x4c0, 0x4c4, 0x4c8, /* DRAM_SDQS0 ~ DRAM_SDQS3 */
> +		0x4cc, 0x4d0, 0x4d4, 0x4d8, /* DRAM_SDQS4 ~ DRAM_SDQS7 */
> +		0x764, 0x770, 0x778, 0x77c, /* GPR_B0DS ~ GPR_B3DS */
> +		0x780, 0x784, 0x78c, 0x748, /* GPR_B4DS ~ GPR_B7DS */
> +		0x4b4, 0x4b8, 0x750, 0x760, /* SODT0, SODT1, DDRMODE_CTL, DDRMODE */
> +		0x74c,			    /* GPR_ADDS */
> +	},
>  };
>  
> -static const u32 imx6sl_mmdc_io_dsm_offset[] __initconst = {
> -	0x30c, 0x310, 0x314, 0x318, /* DQM0 ~ DQM3 */
> -	0x5c4, 0x5cc, 0x5d4, 0x5d8, /* GPR_B0DS ~ GPR_B3DS */
> -	0x300, 0x31c, 0x338, 0x5ac, /* CAS, RAS, SDCLK_0, GPR_ADDS */
> -	0x33c, 0x340, 0x5b0, 0x5c0, /* SODT0, SODT1, DDRMODE_CTL, DDRMODE */
> -	0x330, 0x334, 0x320,	    /* SDCKE0, SDCKE1, RESET */
> +static const struct imx6_pm_socdata imx6sl_pm_data __initconst = {
> +	.cpu_type = MXC_CPU_IMX6SL,
> +	.mmdc_compat = "fsl,imx6sl-mmdc",
> +	.src_compat = "fsl,imx6sl-src",
> +	.iomuxc_compat = "fsl,imx6sl-iomuxc",
> +	.gpc_compat = "fsl,imx6sl-gpc",
> +	.mmdc_io_offset = {
> +		0x30c, 0x310, 0x314, 0x318, /* DQM0 ~ DQM3 */
> +		0x5c4, 0x5cc, 0x5d4, 0x5d8, /* GPR_B0DS ~ GPR_B3DS */
> +		0x300, 0x31c, 0x338, 0x5ac, /* CAS, RAS, SDCLK_0, GPR_ADDS */
> +		0x33c, 0x340, 0x5b0, 0x5c0, /* SODT0, SODT1, DDRMODE_CTL, DDRMODE */
> +		0x330, 0x334, 0x320,	    /* SDCKE0, SDCKE1, RESET */
> +	},
>  };
>  
>  /*

<snip>

> +	pm_info->cpu_type = socdata->cpu_type;
> +	pm_info->mmdc_io_num = ARRAY_SIZE(socdata->mmdc_io_offset);

I just recall this does not work now.  The ARRAY_SIZE() will just be
MX6_MAX_MMDC_IO_NUM for all 3 SoCs.  We need to add a filed mmdc_io_num
into imx6_pm_socdata and assign a correct number for each SoC.

Shawn

> +	mmdc_offset_array = socdata->mmdc_io_offset;
