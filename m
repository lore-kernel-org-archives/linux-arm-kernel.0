From: dianders@chromium.org (Doug Anderson)
Date: Thu, 4 Dec 2014 08:08:57 -0800
Subject: [PATCH] ARM: dts: rockchip: set dw_mmc max-freq 150Mhz
In-Reply-To: <1417661375-2872-1-git-send-email-addy.ke@rock-chips.com>
References: <1417661375-2872-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <CAD=FV=U8eGRFs5G+QfuRF0z1y_7G540r+uCQzPtgOT=KKD7s0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addy,

On Wed, Dec 3, 2014 at 6:49 PM, Addy Ke <addy.ke@rock-chips.com> wrote:
> All of mmc controllers include SDMMC, SDIO0, SDIO1, and EMMC on RK3288
> are limited to 150Mhz. It was mainly caused by two reasons:
> - RK3288's IO pad(except DDR IO pad) is generic, which can only support
>   the max of 150Mhz.
> - Mmc controller was designed at 150Mhz, and the pressure test by IC team
>   was based on this freequency point.
>
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> ---
>  arch/arm/boot/dts/rk3288.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)

Your explanation is reasonable.  The 150MHz rate is also listed in the
latest datasheet.  It's unfortunate that we won't get full speed of
SDR104 or hs200 on this SoC, but correctness certainly outweighs
performance.

Reviewed-by: Doug Anderson <dianders@chromium.org>

I have tested that this prevents the speed from going above 150MHz on
rk3288-pinky on SD Cards, so:

Tested-by: Doug Anderson <dianders@chromium.org>

-Doug
