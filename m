From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 05 Sep 2017 12:18:41 -0700
Subject: [PATCH v3 0/9] ARM64: dts: meson: update around mmc
In-Reply-To: <20170831135226.19784-1-jbrunet@baylibre.com> (Jerome Brunet's
 message of "Thu, 31 Aug 2017 15:52:17 +0200")
References: <20170831135226.19784-1-jbrunet@baylibre.com>
Message-ID: <7hlgltar8u.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This patchset feature updates around mmc. It is linked to this series [0]
> but does not strictly depends on it. It adds:
>
> * The regulator settling times for the gpio regulator of nanopi-k2 and
>   the libretech-cc.
> * UHS modes for the p20x, nanopi-k2 and the libretech-cc
> * clk-gate pins: these are the pinmuxes used for the clk-stop work
>   around explained here [1]
>
> It also removes cap-sd-highspeed from eMMC nodes.
>
> Special note on SDR104:
> While the PCB of the p200 and the libretech-cc does not seems to handle
> SDR104 completely, the nanopi-k2 seems to be handling it correctly.
>
> The patch enabling this mode on the nanopi-k2 is the last one of this
> series. It should propabably be left out until more people can test
> sdr104 on the nanopi-k2
>
> This series has been tested on the gxbb-200, the gxbb-nanopi-k2 and the
> gxl-s905x-libretech-cc
>
> Changes since v2 [3]:
> * Rebase on Kevin's v4.14/dt64 branch
>
> Changes since v1 [2]:
> * Reorder patches to put fixes first, then enhancements
> * Fix error in the SDIO clk_gate pins (GPIOX_5 instead GPIOX_4)
>
> [0]: https://lkml.kernel.org/r/20170828142915.27020-1-jbrunet at baylibre.com
> [1]: https://lkml.kernel.org/r/20170821160301.21899-11-jbrunet at baylibre.com
> [2]: https://lkml.kernel.org/r/20170804180816.18737-1-jbrunet at baylibre.com
> [3]: https://lkml.kernel.org/r/20170821160637.22456-1-jbrunet at baylibre.com
>
> Jerome Brunet (9):
>   ARM64: dts: meson-gx: Use correct mmc clock source 0
>   ARM64: dts: meson: remove cap-sd-highspeed from emmc nodes
>   ARM64: dts: meson: add mmc clk gate pins
>   ARM64: dts: meson-gxbb: nanopi-k2: add card regulator settle times
>   ARM64: dts: meson-gxl: libretech-cc: add card regulator settle times
>   ARM64: dts: meson-gxl: libretech-cc: enable high speed modes
>   ARM64: dts: meson-gxbb: p20x: enable sdcard UHS modes
>   ARM64: dts: meson-gxbb: nanopi-k2: enable sdcard UHS modes
>   ARM64: dts: meson-gxbb: nanopi-k2: enable sdr104 mode

Applied to v4.14/dt64, and submitted to arm-soc.  It may miss this merge
window, but if it does, we can submit for the first round of fixes after
-rc1 is out.

Thanks,

Kevin
