From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 12 Sep 2016 13:38:35 -0700
Subject: [PATCH v2 0/4] ARM: amlogic: Add spifc support to Amlogic's GXBB
 family
In-Reply-To: <1473409738-27175-1-git-send-email-jbrunet@baylibre.com> (Jerome
 Brunet's message of "Fri, 9 Sep 2016 10:28:54 +0200")
References: <1473409738-27175-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <7heg4oq2es.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This patch series adds the necessary pins, clocks and device tree nodes to
> enable the spifc controller on the GXBB family. I had to add the nand pins
> in pintctrl as the pinmux setting left by u-boot was conflicting with the
> spifc pinmux during my test on the P200.

This series seems to be missing a patch which enables the SPIfc on the
P200 board for use with the on-board NOR flash.

Kevin

> Changes since v1 at : http://lkml.kernel.org/r/1473261223-15412-1-git-send-email-jbrunet at baylibre.com
>  * Omit patches :
>   - dt-bindings: spi-meson: Add GXBB Compatible string
>   - spi: meson: Add GXBB compatible
>   Sent as dedicated series
>  * Omit patch:
>   - clk: gxbb: expose spifc clock
>   Already applied
>  * Rename SPI flash controller pins from spifc_* to nor_* to keep the
>    name aligned with the datasheet
>
> Jerome Brunet (3):
>   pinctrl: amlogic: gxbb: add spi nor pins
>   pinctrl: amlogic: gxbb: add nand pins
>   ARM64: dts: amlogic: add spi nor pins
>
> Neil Armstrong (1):
>   ARM64: dts: meson-gxbb: Add SPIFC node
>
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 19 +++++++++++++++
>  drivers/pinctrl/meson/pinctrl-meson-gxbb.c  | 37 +++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
