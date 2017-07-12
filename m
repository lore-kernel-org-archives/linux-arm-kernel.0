From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Wed, 12 Jul 2017 21:03:42 +0200
Subject: [PATCH v3.1 0/3] soc: amlogic: Add Amlogic SoC Information driver
In-Reply-To: <1498206498-19139-1-git-send-email-narmstrong@baylibre.com>
References: <1498206498-19139-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <CAFBinCAK0iXJ5zLg64oABXs7rno48Dni6Zc2dQ3_aadJS7wiSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Fri, Jun 23, 2017 at 10:28 AM, Neil Armstrong
<narmstrong@baylibre.com> wrote:
> Amlogic SoCs have a SoC information register for SoC type, package type and
> revision information.
> This patchset adds support for this register decoding and exposing with the
> SoC bus infrastructure, with dt-bindings and DT node.
I'm curious: are you going to take this through your tree or are we
waiting for someone's ACK here?

> Changes since v3.1 at [3] :
>  - Prepend amlogic to has-chip-id property
>
> Changes since v2 at [2] :
>  - Removed subnodes of socinfo node
>  - Checks has-chip-id property and if node is enabled
>
> Changes since v1 at [1] :
>  - Switch DT representation to use regmap ans sub-node of a simple-mfd node
>  - Updated DT, bindings and driver accordingly
>
> [1] http://lkml.kernel.org/r/1490950079-10145-1-git-send-email-narmstrong at baylibre.com
> [2] http://lkml.kernel.org/r/1496742340-10307-1-git-send-email-narmstrong at baylibre.com
> [3] http://lkml.kernel.org/r/1497441946-24379-1-git-send-email-narmstrong at baylibre.com
>
> Neil Armstrong (3):
>   dt-bindings: arm: amlogic: Add SoC information bindings
>   ARM64: dts: meson-gx: Add SoC info register
>   soc: Add Amlogic SoC Information driver
>
>  Documentation/devicetree/bindings/arm/amlogic.txt |  29 ++++
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi         |   6 +
>  drivers/soc/Kconfig                               |   1 +
>  drivers/soc/Makefile                              |   1 +
>  drivers/soc/amlogic/Kconfig                       |  12 ++
>  drivers/soc/amlogic/Makefile                      |   1 +
>  drivers/soc/amlogic/meson-gx-socinfo.c            | 177 ++++++++++++++++++++++
>  7 files changed, 227 insertions(+)
>  create mode 100644 drivers/soc/amlogic/Kconfig
>  create mode 100644 drivers/soc/amlogic/Makefile
>  create mode 100644 drivers/soc/amlogic/meson-gx-socinfo.c
>
> --
> 1.9.1
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
