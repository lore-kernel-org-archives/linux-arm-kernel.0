From: b32955@freescale.com (Huang Shijie)
Date: Mon, 2 Sep 2013 13:01:39 +0800
Subject: [PATCH 1/2] ARM: i.MX6: dts: change iomuxc pinctrl config to
 match Rev. 1 IMX6DQRM
In-Reply-To: <1377659855-9573-2-git-send-email-alison_chaiken@mentor.com>
References: <521C40D9.3070802@freescale.com>
 <1377659855-9573-1-git-send-email-alison_chaiken@mentor.com>
 <1377659855-9573-2-git-send-email-alison_chaiken@mentor.com>
Message-ID: <52241BB3.5030909@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?08?28? 11:17, alison_chaiken at mentor.com ??:
> @@ -759,23 +759,23 @@
>  				gpmi-nand {
>  					pinctrl_gpmi_nand_1: gpmi-nand-1 {
>  						fsl,pins = <
> -							MX6QDL_PAD_NANDF_CLE__NAND_CLE     0xb0b1
> -							MX6QDL_PAD_NANDF_ALE__NAND_ALE     0xb0b1
> -							MX6QDL_PAD_NANDF_WP_B__NAND_WP_B   0xb0b1
> -							MX6QDL_PAD_NANDF_RB0__NAND_READY_B 0xb000
> -							MX6QDL_PAD_NANDF_CS0__NAND_CE0_B   0xb0b1
> -							MX6QDL_PAD_NANDF_CS1__NAND_CE1_B   0xb0b1
> -							MX6QDL_PAD_SD4_CMD__NAND_RE_B      0xb0b1
> -							MX6QDL_PAD_SD4_CLK__NAND_WE_B      0xb0b1
> -							MX6QDL_PAD_NANDF_D0__NAND_DATA00   0xb0b1
> -							MX6QDL_PAD_NANDF_D1__NAND_DATA01   0xb0b1
> -							MX6QDL_PAD_NANDF_D2__NAND_DATA02   0xb0b1
> -							MX6QDL_PAD_NANDF_D3__NAND_DATA03   0xb0b1
> -							MX6QDL_PAD_NANDF_D4__NAND_DATA04   0xb0b1
> -							MX6QDL_PAD_NANDF_D5__NAND_DATA05   0xb0b1
> -							MX6QDL_PAD_NANDF_D6__NAND_DATA06   0xb0b1
> -							MX6QDL_PAD_NANDF_D7__NAND_DATA07   0xb0b1
> -							MX6QDL_PAD_SD4_DAT0__NAND_DQS      0x00b1
> +							MX6QDL_PAD_NANDF_CLE__NAND_CLE     0x1b0b0
> +							MX6QDL_PAD_NANDF_ALE__NAND_ALE     0x1b0b0
> +							MX6QDL_PAD_NANDF_WP_B__NAND_WP_B   0x1b0b0
> +							MX6QDL_PAD_NANDF_RB0__NAND_READY_B 0x1b0b0
> +							MX6QDL_PAD_NANDF_CS0__NAND_CE0_B   0x1b0b0
> +							MX6QDL_PAD_NANDF_CS1__NAND_CE1_B   0x1b0b0
> +							MX6QDL_PAD_SD4_CMD__NAND_RE_B      0x1b0b0
> +							MX6QDL_PAD_SD4_CLK__NAND_WE_B      0x1b0b0
> +							MX6QDL_PAD_NANDF_D0__NAND_DATA00   0x1b0b0
> +							MX6QDL_PAD_NANDF_D1__NAND_DATA01   0x1b0b0
> +							MX6QDL_PAD_NANDF_D2__NAND_DATA02   0x1b0b0
> +							MX6QDL_PAD_NANDF_D3__NAND_DATA03   0x1b0b0
> +							MX6QDL_PAD_NANDF_D4__NAND_DATA04   0x1b0b0
> +							MX6QDL_PAD_NANDF_D5__NAND_DATA05   0x1b0b0
> +							MX6QDL_PAD_NANDF_D6__NAND_DATA06   0x1b0b0
> +							MX6QDL_PAD_NANDF_D7__NAND_DATA07   0x1b0b0
> +							MX6QDL_PAD_SD4_DAT0__NAND_DQS      0x1b0b0
>  						>;
>  					};
>  				};
I tested this patch with the imx6q-ard board and imx6dl-ard board.

For the gpmi nand test result:
[1] imx6q-ard: We can pass the bonie++ stress test with the imx6q-ard board.

[2] imx6dl-ard: But we fails to read the nand ID with the imx6dl-ard board.
In other word, this gpmi can _not_ works with this patch.

But without this patch, the imx6dl-ard works fine.

In section 4.1, the spec tells us that the 0x1b0b0 is just the "default
settings for the each pad",
not the right settings for the each pad.



thanks
Huang Shijie
