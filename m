From: neko@bakuhatsu.net (Matt Sealey)
Date: Mon, 19 Aug 2013 17:23:40 -0500
Subject: [PATCH] dma: imx-sdma: Add ROM script addresses to driver
In-Reply-To: <1376914563-10912-1-git-send-email-s.hauer@pengutronix.de>
References: <1376914563-10912-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CAHCPf3t1_5zhSOrfVFHgeVPa25sT+ewv1=OZA8X4_YZXb9cSeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please could you describe how the compatible property allows matching
and covers both the ROM version *and* the distributed firmware file
that is also referenced in the device tree for each sdma node for each
SoC supported? As far as I recall, the offsets for the (potentially
buggy) on-chip version and the one in the BSP (and hopefully in
upstream kernels at some soon-approaching version) are not the same
for a good swath of these chips.

How would the driver hope to match this up without causing some DMA
explosions and/or invalid device trees if the BSP firmware is
described, the BSP firmware file is not found, and the driver is left
with the ROM version?

Ta,
Matt

On Mon, Aug 19, 2013 at 7:16 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> The following series adds the ROM script addresses to the driver.
> These have been provided by platform_data for platform based systems,
> but with devicetree the driver no longer supports the ROM script
> addresses. This means that the sdma driver currently needs a firmware
> to work. By adding the script addresses to the driver it can work
> without additional firmware.
>
> Sascha
>
> ----------------------------------------------------------------
> Sascha Hauer (3):
>       dma: imx-sdma: Use struct for driver data
>       dma: imx-sdma: Add ROM script addresses to driver
>       ARM: i.MX: remove sdma script address arrays from platform data
>
>  .../devicetree/bindings/dma/fsl-imx-sdma.txt       |   7 +-
>  arch/arm/mach-imx/mm-imx25.c                       |  17 --
>  arch/arm/mach-imx/mm-imx3.c                        |  67 ++----
>  arch/arm/mach-imx/mm-imx5.c                        |  14 --
>  drivers/dma/imx-sdma.c                             | 241 ++++++++++++++++++---
>  5 files changed, 230 insertions(+), 116 deletions(-)
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
