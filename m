From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 14 Sep 2018 12:39:47 -0700
Subject: [PATCH] arm64: dts: meson: Fix erroneous SPI bus warnings
In-Reply-To: <20180913181245.25484-17-robh@kernel.org> (Rob Herring's message
 of "Thu, 13 Sep 2018 13:12:41 -0500")
References: <20180913181245.25484-17-robh@kernel.org>
Message-ID: <7hk1nnuav0.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robh@kernel.org> writes:

> dtc has new checks for SPI buses. The meson dts files have a node named
> spi' which causes false positive warnings. As the node is a pinctrl child
> node, change the node name to be 'spi-pins' to fix the warnings.
>
> arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dtb: Warning (spi_bus_bridge): /soc/periphs at c8834000/pinctrl at 4b0/spi: incorrect #address-cells for SPI bus
>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: linux-amlogic at lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please apply to the sub-arch tree. The dtc changes haven't landed, but 
> will for 4.20.

Applied, will queue for v4.20.

Kevin
