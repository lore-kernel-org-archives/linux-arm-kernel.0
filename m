From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 4 Mar 2014 14:56:54 +0530
Subject: [PATCH 01/12] phy: rename struct omap_control_usb to struct
 omap_control_phy
In-Reply-To: <1393859254-10937-2-git-send-email-rogerq@ti.com>
References: <1393859254-10937-1-git-send-email-rogerq@ti.com>
 <1393859254-10937-2-git-send-email-rogerq@ti.com>
Message-ID: <53159C5E.2040701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Roger,

On Monday 03 March 2014 08:37 PM, Roger Quadros wrote:
> From: Kishon Vijay Abraham I <kishon@ti.com>
>
> Rename struct omap_control_usb to struct omap_control_phy since it can
> be used to control PHY of USB, SATA and PCIE. Also move the driver and
> include files under *phy* and made the corresponding changes in the users
> of phy-omap-control.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>   drivers/phy/Kconfig                  |  14 +-
>   drivers/phy/Makefile                 |   1 +
>   drivers/phy/phy-omap-control.c       | 320 +++++++++++++++++++++++++++++++++++
>   drivers/phy/phy-omap-usb2.c          |   8 +-
>   drivers/phy/phy-ti-pipe3.c           |   8 +-
>   drivers/usb/musb/omap2430.c          |   2 +-
>   drivers/usb/phy/Kconfig              |  10 --
>   drivers/usb/phy/Makefile             |   1 -
>   drivers/usb/phy/phy-omap-control.c   | 319 ----------------------------------
>   include/linux/phy/omap_control_phy.h |  89 ++++++++++
>   include/linux/usb/omap_control_usb.h |  89 ----------
>   11 files changed, 431 insertions(+), 430 deletions(-)
>   create mode 100644 drivers/phy/phy-omap-control.c
>   delete mode 100644 drivers/usb/phy/phy-omap-control.c
>   create mode 100644 include/linux/phy/omap_control_phy.h
>   delete mode 100644 include/linux/usb/omap_control_usb.h

you can use git format-patch -M if a file is moved from one place to 
another. The diff count will be less in that case and reviewing will be 
easier ;-)

Cheers
Kishon
