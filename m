From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Nov 2016 09:50:51 +0100
Subject: [PATCH 3/6] reset: hisilicon: add reset-hi3660
In-Reply-To: <1479800961-6249-4-git-send-email-zhangfei.gao@linaro.org>
References: <1479800961-6249-1-git-send-email-zhangfei.gao@linaro.org>
 <1479800961-6249-4-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <2220300.Yj4lYzeH2z@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 22, 2016 3:49:18 PM CET Zhangfei Gao wrote:
> 
> +static const struct hisi_reset_channel_data hi3660_iomcu_rst[] = {
> +       [HI3660_RST_I2C0] = HISI_RST_SEP(0x20, 3),
> +       [HI3660_RST_I2C1] = HISI_RST_SEP(0x20, 4),
> +       [HI3660_RST_I2C2] = HISI_RST_SEP(0x20, 5),
> +       [HI3660_RST_I2C6] = HISI_RST_SEP(0x20, 27),
> +};
> +
> +static struct hisi_reset_controller_data hi3660_iomcu_controller = {
> +       .nr_channels = ARRAY_SIZE(hi3660_iomcu_rst),
> +       .channels = hi3660_iomcu_rst,
> +};
> +
> +static const struct hisi_reset_channel_data hi3660_crgctrl_rst[] = {
> +       [HI3660_RST_I2C3] = HISI_RST_SEP(0x78, 7),
> +       [HI3660_RST_I2C4] = HISI_RST_SEP(0x78, 27),
> +       [HI3660_RST_I2C7] = HISI_RST_SEP(0x60, 14),
> +       [HI3660_RST_SD] = HISI_RST_SEP(0x90, 18),
> +       [HI3660_RST_SDIO] = HISI_RST_SEP(0x90, 20),
> +       [HI3660_RST_UFS] = HISI_RST_SEP(0x84, 12),
> +       [HI3660_RST_UFS_ASSERT] = HISI_RST_SEP(0x84, 7),
> +       [HI3660_RST_PCIE_SYS] = HISI_RST_SEP(0x84, 26),
> +       [HI3660_RST_PCIE_PHY] = HISI_RST_SEP(0x84, 27),
> +       [HI3660_RST_PCIE_BUS] = HISI_RST_SEP(0x84, 31),
> +       [HI3660_RST_USB3OTG_PHY] = HISI_RST_SEP(0x90, 3),
> +       [HI3660_RST_USB3OTG] = HISI_RST_SEP(0x90, 5),
> +       [HI3660_RST_USB3OTG_32K] = HISI_RST_SEP(0x90, 6),
> +       [HI3660_RST_USB3OTG_AHB] = HISI_RST_SEP(0x90, 7),
> +       [HI3660_RST_USB3OTG_MUX] = HISI_RST_SEP(0x90, 8),
> +};

I think you can avoid the trap of the ABI incompatibility if
you just define those as in the binding as tuples, using #reset-cells=2.

In particular for the first set, it seems really silly to redefine
the numbers when there is just a simple integer number.

	Arnd
