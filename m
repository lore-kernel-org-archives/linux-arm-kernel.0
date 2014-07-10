From: tgih.jun@samsung.com (Seungwon Jeon)
Date: Thu, 10 Jul 2014 20:27:46 +0900
Subject: [PATCHv4 0/5] ARM: remove the sub-node and deprecated
 supports-highspeed property for dwmmc.
In-Reply-To: <1404985718-12203-1-git-send-email-jh80.chung@samsung.com>
References: <1404985718-12203-1-git-send-email-jh80.chung@samsung.com>
Message-ID: <001f01cf9c31$f91c0f50$eb542df0$%jun@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, July 10, 2014, Jaehoon Chung wrote:
> Since used the mmc_of_parse(), didn't parse the sub-node.
> So we can remove the sub-node, because almost SoC used the only one card per a host.
> And supports-highspeed can be replaced to "cap-mmc/sd-highspeed" property.
> 
> Changelog V4:
> 	- Fix the checkpatch error.
> Changelog V3:
> 	- Fix the wrong bus-width value.
> 	- Use the slot->host->quirks instead of brq->quirks.
> 	- Add tested-by and reviewd-by.
> Changelog V2:
> 	- Add the "mmc: dw_mmc: replace "disable-wp" from slot's quirks to host's quirk"
> 
> Jaehoon Chung (5):
>   mmc: dw_mmc: modify the dt-binding for removing slot-node and
>     supports-highspeed
>   ARM: dts: exynos: unuse the slot-node and deprecated the
>     supports-highspeed for dw-mmc
>   ARM: dts: socfpga: unuse the slot-node and deprecated the
>     supports-highspeed for dw-mmc
>   ARM: dts: rockchip: unuse the slot-node and deprecated the
>     supports-highspeed for dw-mmc
>   mmc: dw_mmc: replace "disable-wp" from slot's quirk to host's quirk
> 
>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   17 ++++---------
>  .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   12 ++++-----
>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |   12 ++++-----
>  arch/arm/boot/dts/exynos4412-odroidx.dts           |    8 ++----
>  arch/arm/boot/dts/exynos4412-origen.dts            |    8 ++----
>  arch/arm/boot/dts/exynos4412-trats2.dts            |    8 ++----
>  arch/arm/boot/dts/exynos5250-arndale.dts           |   18 ++++----------
>  arch/arm/boot/dts/exynos5250-cros-common.dtsi      |   26 ++++++--------------
>  arch/arm/boot/dts/exynos5250-smdk5250.dts          |   18 ++++----------
>  arch/arm/boot/dts/exynos5250-snow.dts              |    6 ++---
>  arch/arm/boot/dts/exynos5260-xyref5260.dts         |   18 ++++----------
>  arch/arm/boot/dts/exynos5410-smdk5410.dts          |   18 ++++----------
>  arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   16 +++---------
>  arch/arm/boot/dts/exynos5420-peach-pit.dts         |   16 +++---------
>  arch/arm/boot/dts/exynos5420-smdk5420.dts          |   16 +++---------
>  arch/arm/boot/dts/exynos5800-peach-pi.dts          |   16 +++---------
>  arch/arm/boot/dts/rk3066a-bqcurie2.dts             |   16 +++---------
>  arch/arm/boot/dts/socfpga_arria5.dtsi              |    9 +++----
>  arch/arm/boot/dts/socfpga_cyclone5.dtsi            |    9 +++----
>  arch/arm/boot/dts/socfpga_vt.dts                   |    9 +++----
>  drivers/mmc/host/dw_mmc.c                          |   12 ++++-----
>  21 files changed, 84 insertions(+), 204 deletions(-)

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks,
Seungwon Jeon
