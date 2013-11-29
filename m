From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 29 Nov 2013 11:28:32 -0500
Subject: [PATCH v2 00/10] Reuse davinci-nand driver for Keystone arch
In-Reply-To: <1385033305-13179-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1385033305-13179-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <5298C0B0.4030404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ivan,
On Thursday 21 November 2013 06:28 AM, Ivan Khoronzhuk wrote:
> This series contains fixes and updates of Davinci nand driver in
> order to reuse it for Keystone platform.
> 
> The series is combination of two following series:
> - Davinci nand driver fixes and updates:
>   https://lkml.org/lkml/2013/11/20/271
> - Reuse davinci-nand driver for Keystone arch
>   https://lkml.org/lkml/2013/11/20/315
> 
> Ivan Khoronzhuk (10):
>   mtd: nand: davinci: fix driver registration
>   mtd: nand: davinci: return ENOMEM if memory allocation is failed
>   mtd: nand: davinci: check required ti,davinci-chipselect property
>   mtd: nand: davinci: simplify error handling
>   mtd: nand: davinci: move bindings under mtd
>   mtd: nand: davinci: extend description of bindings
>   mtd: nand: davinci: adjust DT properties to MTD generic
>   mtd: nand: davinci: reuse driver for Keystone arch
>   mtd: nand: davinci: don't set timings if AEMIF is used
>   mtd: nand: davinci: don't request AEMIF address range
> 
>  .../devicetree/bindings/arm/davinci/nand.txt       |   46 --------
>  .../devicetree/bindings/mtd/davinci-nand.txt       |   94 ++++++++++++++++
>  drivers/mtd/nand/Kconfig                           |    6 +-
>  drivers/mtd/nand/davinci_nand.c                    |  117 +++++++++++---------
>  4 files changed, 164 insertions(+), 99 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/davinci/nand.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/davinci-nand.txt
> 
Please drop patch 9 from the series considering we are handling it
differently and repost the entire series with David in cc. David
has been lining up the patches.

Regards,
Santosh
