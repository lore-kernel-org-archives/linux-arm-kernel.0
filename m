From: dev@lynxeye.de (Lucas Stach)
Date: Thu, 21 Apr 2016 20:16:12 +0200
Subject: [PATCH v2] ARM: dts: tegra: correct Beaver pinmux
In-Reply-To: <1456514310-27605-1-git-send-email-dev@lynxeye.de>
References: <1456514310-27605-1-git-send-email-dev@lynxeye.de>
Message-ID: <1461262572.2494.0.camel@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 26.02.2016, 20:18 +0100 schrieb Lucas Stach:
> Update pinmux to get rid of invalid uses of the rsvd1 function, which
> lead
> to the mux settings on those pins to not be applied.
> 
> Also add correct drive settings, derived from the Tegra3 TRM, for
> SDIO1,
> which makes some more SD-cards work.
> 
Just a gentle ping on this patch, as I haven't seen it being applied
anywhere.

> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> ---
> ?arch/arm/boot/dts/tegra30-beaver.dts | 39 ++++++++++++++++++++++--
> ------------
> ?1 file changed, 24 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra30-beaver.dts
> b/arch/arm/boot/dts/tegra30-beaver.dts
> index 3dede39..1daed40 100644
> --- a/arch/arm/boot/dts/tegra30-beaver.dts
> +++ b/arch/arm/boot/dts/tegra30-beaver.dts
> @@ -255,14 +255,14 @@
> ?			};
> ?			sdmmc3_dat6_pd3 {
> ?				nvidia,pins = "sdmmc3_dat6_pd3";
> -				nvidia,function = "rsvd1";
> +				nvidia,function = "spdif";
> ?				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
> ?				nvidia,tristate =
> <TEGRA_PIN_DISABLE>;
> ?				nvidia,enable-input =
> <TEGRA_PIN_ENABLE>;
> ?			};
> ?			sdmmc3_dat7_pd4 {
> ?				nvidia,pins = "sdmmc3_dat7_pd4";
> -				nvidia,function = "rsvd1";
> +				nvidia,function = "spdif";
> ?				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
> ?				nvidia,tristate =
> <TEGRA_PIN_DISABLE>;
> ?				nvidia,enable-input =
> <TEGRA_PIN_ENABLE>;
> @@ -276,14 +276,14 @@
> ?			};
> ?			vi_vsync_pd6 {
> ?				nvidia,pins = "vi_vsync_pd6";
> -				nvidia,function = "rsvd1";
> +				nvidia,function = "ddr";
> ?				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
> ?				nvidia,tristate =
> <TEGRA_PIN_DISABLE>;
> ?				nvidia,enable-input =
> <TEGRA_PIN_ENABLE>;
> ?			};
> ?			vi_hsync_pd7 {
> ?				nvidia,pins = "vi_hsync_pd7";
> -				nvidia,function = "rsvd1";
> +				nvidia,function = "ddr";
> ?				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
> ?				nvidia,tristate =
> <TEGRA_PIN_DISABLE>;
> ?				nvidia,enable-input =
> <TEGRA_PIN_ENABLE>;
> @@ -801,7 +801,7 @@
> ?			};
> ?			hdmi_int_pn7 {
> ?				nvidia,pins = "hdmi_int_pn7";
> -				nvidia,function = "rsvd1";
> +				nvidia,function = "hdmi";
> ?				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
> ?				nvidia,tristate =
> <TEGRA_PIN_ENABLE>;
> ?				nvidia,enable-input =
> <TEGRA_PIN_ENABLE>;
> @@ -836,7 +836,7 @@
> ?			};
> ?			ulpi_data3_po4 {
> ?				nvidia,pins = "ulpi_data3_po4";
> -				nvidia,function = "rsvd1";
> +				nvidia,function = "uarta";
> ?				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
> ?				nvidia,tristate =
> <TEGRA_PIN_DISABLE>;
> ?				nvidia,enable-input =
> <TEGRA_PIN_ENABLE>;
> @@ -1102,21 +1102,21 @@
> ?			};
> ?			vi_d10_pt2 {
> ?				nvidia,pins = "vi_d10_pt2";
> -				nvidia,function = "rsvd1";
> +				nvidia,function = "ddr";
> ?				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
> ?				nvidia,tristate =
> <TEGRA_PIN_DISABLE>;
> ?				nvidia,enable-input =
> <TEGRA_PIN_ENABLE>;
> ?			};
> ?			vi_d11_pt3 {
> ?				nvidia,pins = "vi_d11_pt3";
> -				nvidia,function = "rsvd1";
> +				nvidia,function = "ddr";
> ?				nvidia,pull = <TEGRA_PIN_PULL_UP>;
> ?				nvidia,tristate =
> <TEGRA_PIN_DISABLE>;
> ?				nvidia,enable-input =
> <TEGRA_PIN_ENABLE>;
> ?			};
> ?			vi_d0_pt4 {
> ?				nvidia,pins = "vi_d0_pt4";
> -				nvidia,function = "rsvd1";
> +				nvidia,function = "ddr";
> ?				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
> ?				nvidia,tristate =
> <TEGRA_PIN_DISABLE>;
> ?				nvidia,enable-input =
> <TEGRA_PIN_ENABLE>;
> @@ -1146,7 +1146,7 @@
> ?			};
> ?			pu0 {
> ?				nvidia,pins = "pu0";
> -				nvidia,function = "rsvd1";
> +				nvidia,function = "owr";
> ?				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
> ?				nvidia,tristate =
> <TEGRA_PIN_DISABLE>;
> ?				nvidia,enable-input =
> <TEGRA_PIN_ENABLE>;
> @@ -1167,7 +1167,7 @@
> ?			};
> ?			pu3 {
> ?				nvidia,pins = "pu3";
> -				nvidia,function = "rsvd1";
> +				nvidia,function = "pwm0";
> ?				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
> ?				nvidia,tristate =
> <TEGRA_PIN_DISABLE>;
> ?				nvidia,enable-input =
> <TEGRA_PIN_ENABLE>;
> @@ -1188,7 +1188,7 @@
> ?			};
> ?			pu6 {
> ?				nvidia,pins = "pu6";
> -				nvidia,function = "rsvd1";
> +				nvidia,function = "pwm3";
> ?				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
> ?				nvidia,tristate =
> <TEGRA_PIN_DISABLE>;
> ?				nvidia,enable-input =
> <TEGRA_PIN_ENABLE>;
> @@ -1216,7 +1216,7 @@
> ?			};
> ?			pv3 {
> ?				nvidia,pins = "pv3";
> -				nvidia,function = "rsvd1";
> +				nvidia,function = "clk_12m_out";
> ?				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
> ?				nvidia,tristate =
> <TEGRA_PIN_DISABLE>;
> ?				nvidia,enable-input =
> <TEGRA_PIN_DISABLE>;
> @@ -1505,7 +1505,7 @@
> ?			};
> ?			pbb0 {
> ?				nvidia,pins = "pbb0";
> -				nvidia,function = "rsvd1";
> +				nvidia,function = "i2s4";
> ?				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
> ?				nvidia,tristate =
> <TEGRA_PIN_DISABLE>;
> ?				nvidia,enable-input =
> <TEGRA_PIN_ENABLE>;
> @@ -1570,7 +1570,7 @@
> ?			};
> ?			pcc1 {
> ?				nvidia,pins = "pcc1";
> -				nvidia,function = "rsvd1";
> +				nvidia,function = "i2s4";
> ?				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
> ?				nvidia,tristate =
> <TEGRA_PIN_DISABLE>;
> ?				nvidia,enable-input =
> <TEGRA_PIN_ENABLE>;
> @@ -1718,6 +1718,15 @@
> ?				nvidia,slew-rate-rising = <1>;
> ?				nvidia,slew-rate-falling = <1>;
> ?			};
> +			sdio1 {
> +				nvidia,pins = "drive_sdio1";
> +				nvidia,high-speed-mode =
> <TEGRA_PIN_DISABLE>;
> +				nvidia,schmitt =
> <TEGRA_PIN_DISABLE>;
> +				nvidia,pull-down-strength = <46>;
> +				nvidia,pull-up-strength = <42>;
> +				nvidia,slew-rate-rising = <1>;
> +				nvidia,slew-rate-falling = <1>;
> +			};
> ?			gpv {
> ?				nvidia,pins = "drive_gpv";
> ?				nvidia,pull-up-strength = <16>;
