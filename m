From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 21 Nov 2016 09:06:54 -0800
Subject: [PATCH 1/2] ARM64: dts: Add support for Meson GXM
In-Reply-To: <20161121162905.14285-2-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Mon, 21 Nov 2016 17:29:04 +0100")
References: <20161121162905.14285-1-narmstrong@baylibre.com>
 <20161121162905.14285-2-narmstrong@baylibre.com>
Message-ID: <m2wpfw3gpd.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Following the Amlogic Linux kernel, it seem the only differences
> between the GXL and GXM SoCs are the CPU Clusters.
>
> This commit renames the gxl-s905d-p23x DTSI in a common file for
> S905D p20x and S912 q20x boards.
>
> Then adds a meson-gxm dtsi and reproduce the P23x to Q20x boards
> dts files since the S905D and S912 SoCs shares the same pinout
> and the P23x and Q20x boards are identical.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.txt  |   6 +
>  arch/arm64/boot/dts/amlogic/Makefile               |   2 +
>  .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi | 190 +++++++++++++++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts    |  19 +++
>  arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts    |   7 +
>  .../boot/dts/amlogic/meson-gxl-s905d-p230.dts      |   3 +-
>  .../boot/dts/amlogic/meson-gxl-s905d-p231.dts      |   3 +-
>  .../boot/dts/amlogic/meson-gxl-s905d-p23x.dtsi     | 188 --------------------
>  .../arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts |  77 +++++++++
>  .../arm64/boot/dts/amlogic/meson-gxm-s912-q201.dts |  58 +++++++
>  arch/arm64/boot/dts/amlogic/meson-gxm.dtsi         | 114 +++++++++++++
>  11 files changed, 477 insertions(+), 190 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
>  delete mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p23x.dtsi
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-s912-q201.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi

Applied.

Git tip: for future reference, set 'git config diff.renames true' so and
the diffstat shows a better summary when files are moved/renamed.

e.g, rather than the large ++ and -- above, you'd see:

 ...gxl-s905d-p23x.dtsi => meson-gx-p23x-q20x.dtsi} |   4 +-
 
Which is much more comforting to a maintainer than a bunch of
(potentially unrelated) adds and removes.

Thanks,

Kevin
