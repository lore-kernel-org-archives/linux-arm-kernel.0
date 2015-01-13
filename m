From: eddie.huang@mediatek.com (Eddie Huang)
Date: Tue, 13 Jan 2015 10:30:38 +0800
Subject: [PATCH v4 0/2] ARM: mediatek: Add watchdog driver
In-Reply-To: <1421076884-15860-1-git-send-email-matthias.bgg@gmail.com>
References: <1421076884-15860-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <1421116238.22982.3.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On Mon, 2015-01-12 at 16:34 +0100, Matthias Brugger wrote:
> Mediatek SoCs have a watchdog driver. This patch set adds driver and DTS
> binding. The driver also implements a restart handler to reboot the SoC.
> 
> Changes for v4:
> - fix indentation errors
> - delete unused include
> - reorganize while loop to eliminate code duplication
> - eliminate indirection to watchdog_device structure
> - delete unnecessary brackets
> 
> Changes for v3:
> - fix based on file name
> - fix style problems
> - fix error return value and warning message
> - delete unnecessary watchdog_set_drvdata
> - delete unused variable
> 
> Changes for v2:
> - we don't need to have the watchdog enabled to do a software reset
> - disable dual mode and irq mode when starting the watchdog
> - update commit message to name the SoCs the driver supports
> 
> Matthias Brugger (2):
>   watchdog: Add driver for Mediatek watchdog
>   ARM: mediatek: dts: Add bindings for watchdog
> 
>  .../devicetree/bindings/watchdog/mtk-wdt.txt       |  13 ++
>  drivers/watchdog/Kconfig                           |  10 +
>  drivers/watchdog/Makefile                          |   1 +
>  drivers/watchdog/mtk_wdt.c                         | 252 +++++++++++++++++++++
>  4 files changed, 276 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
>  create mode 100644 drivers/watchdog/mtk_wdt.c
> 

Test OK on mt8173 platform.

Tested-by: Eddie Huang <eddie.huang@mediatek.com>
