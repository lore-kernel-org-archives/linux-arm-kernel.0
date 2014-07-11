From: yoshihiro.shimoda.uh@renesas.com (Yoshihiro Shimoda)
Date: Fri, 11 Jul 2014 09:54:15 +0900
Subject: [PATCH v2 0/2] ARM: shmobile: lager: USBHS callback elimination
In-Reply-To: <1404978840-31917-1-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1404978840-31917-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Message-ID: <53BF35B7.9000105@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulrich,

(2014/07/10 16:53), Ulrich Hecht wrote:
> Changes in v2:
> - move phy handle to struct usbhs_priv
> - add new default pipe type to driver
> - remove pipe type from Lager board code
> 
> Ulrich Hecht (2):
>   usb: renesas_usbhs: add R-Car Gen. 2 init and power control
>   ARM: shmobile: lager: remove USBHS callbacks
> 
>  arch/arm/mach-shmobile/board-lager.c | 126 ++++-------------------------------
>  drivers/usb/renesas_usbhs/Makefile   |   2 +-
>  drivers/usb/renesas_usbhs/common.c   |  66 ++++++++++++++++--
>  drivers/usb/renesas_usbhs/common.h   |   2 +
>  drivers/usb/renesas_usbhs/rcar2.c    |  76 +++++++++++++++++++++
>  drivers/usb/renesas_usbhs/rcar2.h    |   4 ++
>  include/linux/usb/renesas_usbhs.h    |   6 ++
>  7 files changed, 163 insertions(+), 119 deletions(-)
>  create mode 100644 drivers/usb/renesas_usbhs/rcar2.c
>  create mode 100644 drivers/usb/renesas_usbhs/rcar2.h
> 

I tested these patches on Lager legacy, and these patches worked correctly.

Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda
