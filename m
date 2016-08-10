From: robh@kernel.org (Rob Herring)
Date: Wed, 10 Aug 2016 13:35:12 -0500
Subject: [PATCH v2 1/3] ARM: dts: da850: Add basic DTS for the L138/C6748
 Dev Kit
In-Reply-To: <20160805141229.20784-2-kbeldan@baylibre.com>
References: <20160804144332.4841-1-kbeldan@baylibre.com>
 <20160805141229.20784-1-kbeldan@baylibre.com>
 <20160805141229.20784-2-kbeldan@baylibre.com>
Message-ID: <20160810183512.GA10503@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 05, 2016 at 02:12:27PM +0000, Karl Beldan wrote:
> The LCDK is the successor to the late Hawkboard.
> Among the differences are the flash (16bits vs 8bits) and some pins
> (MMC, LEDs, buttons, some external connectors), however the main
> components remain the same (eth. phy, audio codec, video decoder and
> DAC) except for the main PMIC, different and hard-wired on the LCDK (the
> LDOs and DCDCs are always on).
> A DT-only boot with this addition gives functional UART, reboot via
> watchdog, RTC, ethernet and MMC (I added the CD GPIO for the MMC
> although davinci_mmc doesn't call the OF facilities of mmc core).
> 
> Cc: Sekhar Nori <nsekhar@ti.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/davinci.txt |  4 ++
>  arch/arm/boot/dts/Makefile                        |  1 +
>  arch/arm/boot/dts/da850-lcdk.dts                  | 70 +++++++++++++++++++++++
>  arch/arm/mach-davinci/da8xx-dt.c                  |  1 +
>  4 files changed, 76 insertions(+)
>  create mode 100644 arch/arm/boot/dts/da850-lcdk.dts

Acked-by: Rob Herring <robh@kernel.org>
