From: zonque@gmail.com (Daniel Mack)
Date: Thu, 19 Sep 2013 16:25:30 +0200
Subject: [RFC PATCH 01/15] phy: rename struct omap_control_usb to struct
 omap_control_phy
In-Reply-To: <1379595943-14622-2-git-send-email-rogerq@ti.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com>
 <1379595943-14622-2-git-send-email-rogerq@ti.com>
Message-ID: <523B095A.9070006@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.09.2013 15:05, Roger Quadros wrote:
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
>  drivers/phy/Kconfig                  |   14 ++-
>  drivers/phy/Makefile                 |    1 +
>  drivers/phy/phy-omap-control.c       |  300 ++++++++++++++++++++++++++++++++++
>  drivers/phy/phy-omap-pipe3.c         |    8 +-
>  drivers/phy/phy-omap-usb2.c          |    9 +-
>  drivers/usb/musb/omap2430.c          |    2 +-
>  drivers/usb/phy/Kconfig              |   10 -
>  drivers/usb/phy/Makefile             |    1 -
>  drivers/usb/phy/phy-omap-control.c   |  300 ----------------------------------
>  include/linux/phy/omap_control_phy.h |   83 ++++++++++
>  include/linux/usb/omap_control_usb.h |   83 ----------
>  11 files changed, 406 insertions(+), 405 deletions(-)
>  create mode 100644 drivers/phy/phy-omap-control.c
>  delete mode 100644 drivers/usb/phy/phy-omap-control.c
>  create mode 100644 include/linux/phy/omap_control_phy.h
>  delete mode 100644 include/linux/usb/omap_control_usb.h

In case you do another version of this set, please use "git format-patch
-M", which will detect renames and hence make the review much easier.


Daniel
