From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 15 Jul 2015 16:20:09 +0530
Subject: [PATCH v4 0/2] USB OTG PHY driver for NXP LPC18xx family
In-Reply-To: <1436474906-2669-1-git-send-email-manabian@gmail.com>
References: <1436474906-2669-1-git-send-email-manabian@gmail.com>
Message-ID: <55A63AE1.50701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 10 July 2015 02:18 AM, Joachim Eastwood wrote:
> This patch set adds support for the internal USB OTG PHY found
> on NXP LPC18xx and LPC43xx devices. Driver takes care of
> enabling the PHY and setting the clock rate which is need for
> USB0 support on this platform.
> 
> This version address moves the dt node under the creg syscon
> and rebases the patch set on 4.2-rc1.

merged this to linux-phy tree.

Cheers
Kishon

> 
> Changes in v4:
>  - rebase on 4.2-rc1
>  - move dt node under creg where the control reg is
> 
> Changes in v3:
>  - depend on MFD_SYSCON
> 
> Changes in v2:
>  - use PTR_ERR_OR_ZERO in phy driver
>  - rename binding doc
>  - update doc commit message
> 
> Joachim Eastwood (2):
>   phy: add lpc18xx usb otg phy driver
>   phy: dt bindings: add NXP LPC18xx/43xx USB OTG PHY bindings
> 
>  .../bindings/phy/phy-lpc18xx-usb-otg.txt           |  26 ++++
>  drivers/phy/Kconfig                                |  11 ++
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-lpc18xx-usb-otg.c                  | 143 +++++++++++++++++++++
>  4 files changed, 181 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-lpc18xx-usb-otg.txt
>  create mode 100644 drivers/phy/phy-lpc18xx-usb-otg.c
> 
