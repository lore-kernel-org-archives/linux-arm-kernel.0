From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 14 Aug 2014 00:15:19 +0200
Subject: [PATCH v4 0/2] Add eMMC and SD card support for rk3288-evb
In-Reply-To: <1407885674-16469-1-git-send-email-dianders@chromium.org>
References: <1407885674-16469-1-git-send-email-dianders@chromium.org>
Message-ID: <1896828.oB75TXBbSp@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 12. August 2014, 16:21:12 schrieb Doug Anderson:
> This series adds basic eMMC and SD card support for the rk3288-evb
> board based on Addy's dw_mmc patch.

I've added both patches to the general dts branch for 3.18.
Currently as WIP and temporarily on github [0] until we reach -rc1.


Heiko


[0] https://github.com/mmind/linux-rockchip/tree/wip/v3.18-next/dts

> 
> Note that we don't have regulators specified yet (no regulator driver
> for rk808-based board).  We also don't yet support UHS modes or MMC
> DDR50 (which require regulator support plus dw_mmc driver support for
> tuning).  Those features can come later.
> 
> Changes in v4:
> - Add status="disabled".
> - Squash patch #1 and #4 since Jaehoon's patch landed.
> - Squashed patches #2 and #3 since Jaehoon's patch landed.
> 
> Changes in v3:
> - Removed DDR50 mode since it needs tuning, which isn't there yet.
> 
> Changes in v2:
> - Refer to the new title of Jaehoon's patch
> - New patchwork link for Addy's patch
> - Squashed in the DDR50 mode since Addy spun his patch.
> 
> Doug Anderson (2):
>   ARM: dts: Add emmc and sdmmc to the rk3288 device tree
>   ARM: dts: Enable emmc and sdmmc on the rk3288-evb boards
> 
>  arch/arm/boot/dts/rk3288-evb.dtsi | 24 ++++++++++++++++++++++++
>  arch/arm/boot/dts/rk3288.dtsi     | 20 ++++++++++++++++++++
>  2 files changed, 44 insertions(+)
