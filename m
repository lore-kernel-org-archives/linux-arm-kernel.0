From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 07 Nov 2017 11:38:59 +0100
Subject: [PATCH v3 1/4] clk: meson: gxbb: fix wrong clock for SARADC/SANA
In-Reply-To: <20171107054142.7935-1-yixun.lan@amlogic.com>
References: <20171107054142.7935-1-yixun.lan@amlogic.com>
Message-ID: <1510051139.1328.52.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-11-07 at 13:41 +0800, Yixun Lan wrote:
> According to the datasheet, in Meson-GXBB/GXL series,
> The clock gate bit for SARADC is HHI_GCLK_MPEG2 bit[22],
> while clock gate bit for SANA is HHI_GCLK_MPEG0 bit[10].
> 
> Test passed at gxl-s905x-p212 board.
> 
> The following published datasheets are wrong and should be updated
> [1] GXBB v1.1.4, page 57
> http://dn.odroid.com/S905/DataSheet/S905_Public_Datasheet_V1.1.4.pdf
> [2] GXL v0.3_20170314, page
> http://www.mediafire.com/file/5bpt054va5ut7v9/S905X_Datasheet_V0.3_20170314pub
> licversion-Wesion.pdf

You may mention those links in the cover letter, since mediafire links are
unlikely to last, better no mentioning them here. The version is enough.

> 
> Fixes: 7ba64d82b358 ("gxbb: clk: Adjust MESON_GATE macro to be shared..")

The commit where the issue is introduced is actually
Fixes: 738f66d3211d ("clk: gxbb: add AmLogic GXBB clk controller driver") 

Yes there has been a rework afterward, but the problem you are fixing originate
from that commit.


> Tested-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  drivers/clk/meson/gxbb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index b2d1e8ed7152..92168348ffa6 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -1139,7 +1139,7 @@ static MESON_GATE(gxbb_pl301, HHI_GCLK_MPEG0, 6);
>  static MESON_GATE(gxbb_periphs, HHI_GCLK_MPEG0, 7);
>  static MESON_GATE(gxbb_spicc, HHI_GCLK_MPEG0, 8);
>  static MESON_GATE(gxbb_i2c, HHI_GCLK_MPEG0, 9);
> -static MESON_GATE(gxbb_sar_adc, HHI_GCLK_MPEG0, 10);
> +static MESON_GATE(gxbb_sana, HHI_GCLK_MPEG0, 10);
>  static MESON_GATE(gxbb_smart_card, HHI_GCLK_MPEG0, 11);
>  static MESON_GATE(gxbb_rng0, HHI_GCLK_MPEG0, 12);
>  static MESON_GATE(gxbb_uart0, HHI_GCLK_MPEG0, 13);
> @@ -1190,7 +1190,7 @@ static MESON_GATE(gxbb_usb0_ddr_bridge, HHI_GCLK_MPEG2,
> 9);
>  static MESON_GATE(gxbb_mmc_pclk, HHI_GCLK_MPEG2, 11);
>  static MESON_GATE(gxbb_dvin, HHI_GCLK_MPEG2, 12);
>  static MESON_GATE(gxbb_uart2, HHI_GCLK_MPEG2, 15);
> -static MESON_GATE(gxbb_sana, HHI_GCLK_MPEG2, 22);
> +static MESON_GATE(gxbb_sar_adc, HHI_GCLK_MPEG2, 22);
>  static MESON_GATE(gxbb_vpu_intr, HHI_GCLK_MPEG2, 25);
>  static MESON_GATE(gxbb_sec_ahb_ahb3_bridge, HHI_GCLK_MPEG2, 26);
>  static MESON_GATE(gxbb_clk81_a53, HHI_GCLK_MPEG2, 29);
