From: julian.calaby@gmail.com (Julian Calaby)
Date: Tue, 7 Mar 2017 21:21:19 +1100
Subject: [linux-sunxi] [PATCH 5/15] clk: sunxi-ng: sun5i: Export video PLLs
In-Reply-To: <4bb77a9793d4ba25bf633eff6abe41910bb7fc3c.1488876832.git-series.maxime.ripard@free-electrons.com>
References: <cover.bc06ffa88f847ddd9ddd7c259415d5f61b55307b.1488876832.git-series.maxime.ripard@free-electrons.com>
 <4bb77a9793d4ba25bf633eff6abe41910bb7fc3c.1488876832.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGRGNgUvNgQonORN0iTV-e2NJzUJpzQUnn13w+C7MwzvR8uZUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Tue, Mar 7, 2017 at 7:56 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The video PLLs are used directly by the HDMI controller. Export them so
> that we can use them in our DT node.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/sunxi-ng/ccu-sun5i.h      | 6 ++++--
>  include/dt-bindings/clock/sun5i-ccu.h | 3 +++
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun5i.h b/drivers/clk/sunxi-ng/ccu-sun5i.h
> index 8144487eb7ca..16f7aa92957e 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun5i.h
> +++ b/drivers/clk/sunxi-ng/ccu-sun5i.h
> @@ -28,15 +28,17 @@
>  #define CLK_PLL_AUDIO_4X       6
>  #define CLK_PLL_AUDIO_8X       7
>  #define CLK_PLL_VIDEO0         8
> -#define CLK_PLL_VIDEO0_2X      9
> +
> +/* The PLL_VIDEO0_2X is exported for HDMI */
> +
>  #define CLK_PLL_VE             10
>  #define CLK_PLL_DDR_BASE       11
>  #define CLK_PLL_DDR            12
>  #define CLK_PLL_DDR_OTHER      13
>  #define CLK_PLL_PERIPH         14
>  #define CLK_PLL_VIDEO1         15
> -#define CLK_PLL_VIDEO1_2X      16
>
> +/* The PLL_VIDEO0_2X is exported for HDMI */

PLL_VIDEO*1*_2X, right?

>  /* The CPU clock is exported */
>
>  #define CLK_AXI                        18

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
