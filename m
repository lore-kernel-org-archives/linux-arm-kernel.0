From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 20 Jan 2015 17:13:04 +0000
Subject: [PATCH 0/7] Menelaus cleanup for DT, phase 1
In-Reply-To: <1419702779-16001-1-git-send-email-aaro.koskinen@iki.fi>
References: <1419702779-16001-1-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <20150120171304.GA32495@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 27 Dec 2014, Aaro Koskinen wrote:
> These patches start removal of board-specific callbacks from Menelaus:
> delete platform data and a callback from the driver to the board files.
> 
> Tested on top of 3.19-rc1 on N800/N810 which are the only in-tree users
> for the driver.
> 
> Aaro Koskinen (7):
>   mfd: menelaus: delete omap_has_menelaus
>   mfd: menelaus: drop support for SW controller VCORE
>   mfd: menelaus: add initial DT support
>   ARM: OMAP: N8x0: configure menelaus using DT
>   mfd: menelaus: delete platform data support
>   mfd: menelaus: make vcore and regulator controls internal
>   mfd: menelaus: use macro for magic number
> 
>  Documentation/devicetree/bindings/mfd/menelaus.txt | 30 ++++++++
>  arch/arm/boot/dts/omap2420-n8x0-common.dtsi        |  3 +
>  arch/arm/mach-omap2/board-n8x0.c                   | 57 --------------
>  arch/arm/mach-omap2/common-board-devices.h         |  2 -
>  arch/arm/mach-omap2/pdata-quirks.c                 |  1 -
>  drivers/mfd/menelaus.c                             | 86 ++++++++++++++--------
>  include/linux/mfd/menelaus.h                       | 25 -------
>  7 files changed, 87 insertions(+), 117 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/menelaus.txt

Scrap that.  Looks like I can't apply the other patches without
03/07.  Please sort this out with Felipe and re-submit.  Don't forget
to apply my Ack to the patches I said I "applied".

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
