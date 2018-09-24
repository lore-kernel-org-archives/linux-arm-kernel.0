From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 24 Sep 2018 16:05:49 +0200
Subject: [PATCH] ARM: dts: rockchip: explicitly set vcc_sd0 pin to gpio on
 rk3188-radxarock
In-Reply-To: <20180921081341.23258-1-heiko@sntech.de>
References: <20180921081341.23258-1-heiko@sntech.de>
Message-ID: <1680177.p9B9Bbjx8F@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 21. September 2018, 10:13:41 CEST schrieb Heiko Stuebner:
> It is good practice to make the setting of gpio-pinctrls explicitly in the
> devicetree, and in this case even necessary.
> Rockchip boards start with iomux settings set to gpio for most pins and
> while the linux pinctrl driver also implicitly sets the gpio function if
> a pin is requested as gpio that is not necessarily true for other drivers.
> 
> The issue in question stems from uboot, where the sdmmc_pwr pin is set
> to function 1 (sdmmc-power) by the bootrom when reading the 1st-stage
> loader. The regulator controlled by the pin is active-low though, so
> when the dwmmc hw-block sets its enabled bit, it actually disables the
> regulator. By changing the pin back to gpio we fix that behaviour.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

applied for 4.20
