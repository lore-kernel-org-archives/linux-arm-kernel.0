From: balbi@ti.com (Felipe Balbi)
Date: Wed, 15 May 2013 17:35:25 +0300
Subject: [V9 PATCH 00/12] mv-usb phy driver
In-Reply-To: <CADApbeg33WqVqG1o9Dp34t_Riia5HNg4xhz+Tk3MDPoVwxb3Mg@mail.gmail.com>
References: <1365330586-649-1-git-send-email-chao.xie@marvell.com>
 <CADApbeg4BSUubbTw8tC-fuQ06JrRtAW9+rOdg=3rP_0Dr=LwkQ@mail.gmail.com>
 <CADApbeg33WqVqG1o9Dp34t_Riia5HNg4xhz+Tk3MDPoVwxb3Mg@mail.gmail.com>
Message-ID: <20130515143525.GF26183@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Apr 17, 2013 at 09:22:36AM +0800, Chao Xie wrote:
> On Wed, Apr 17, 2013 at 9:17 AM, Chao Xie <xiechao.mail@gmail.com> wrote:
> >
> > On Sun, Apr 7, 2013 at 6:29 PM, Chao Xie <chao.xie@marvell.com> wrote:
> >>
> >> The patches create the mv-usb phy driver
> >>
> >>
> >>   directly use devm_usb_get_phy_dev return value for error return.
> >>
> >> v9->v8
> >>   Remove u2o_xxx.
> >>   Add prefix for register definition
> >>   Move mutex to common PHY layer
> >>   Use module_platform_driver() to register driver
> >>   Use usleep_range to replace udelay
> >>
> >> Chao Xie (12):
> >>   usb: phy: protect phy init and shutdown for mutiple deivces
> >>   usb: phy: mv_usb2: add PHY driver for marvell usb2 controller
> >>   usb: gadget: mv_udc: use PHY driver for udc
> >>   usb: ehci: ehci-mv: use PHY driver for ehci
> >>   usb: phy: phy-mv-usb: use USB2 PHY driver for otg
> >>   usb: mv_u3d: usb phy drivers for phy operation
> >>   arm: mmp2: change the defintion of usb devices
> >>   arm: pxa910: change the defintion of usb devices
> >>   arm: ttc_dkb: modify usb support
> >>   arm: mmp: remove unused usb devices
> >>   arm: brownstone: add usb support for the board
> >>   usb: mv_usb: remove the phy callbacks in pdata
> >>
> >>  arch/arm/mach-mmp/brownstone.c          |   56 +++++
> >>  arch/arm/mach-mmp/include/mach/mmp2.h   |    4 +
> >>  arch/arm/mach-mmp/include/mach/pxa910.h |    7 +-
> >>  arch/arm/mach-mmp/mmp2.c                |    4 +
> >>  arch/arm/mach-mmp/pxa910.c              |    4 +
> >>  arch/arm/mach-mmp/ttc_dkb.c             |   39 +++-
> >>  drivers/usb/gadget/mv_u3d.h             |    3 +-
> >>  drivers/usb/gadget/mv_u3d_core.c        |   54 ++---
> >>  drivers/usb/gadget/mv_udc.h             |    2 +-
> >>  drivers/usb/gadget/mv_udc_core.c        |   50 ++---
> >>  drivers/usb/host/ehci-mv.c              |   49 ++---
> >>  drivers/usb/phy/Kconfig                 |    6 +
> >>  drivers/usb/phy/Makefile                |    1 +
> >>  drivers/usb/phy/phy-mv-usb.c            |   53 ++---
> >>  drivers/usb/phy/phy-mv-usb.h            |    2 +-
> >>  drivers/usb/phy/phy-mv-usb2.c           |  380
> >> +++++++++++++++++++++++++++++++
> >>  drivers/usb/phy/phy.c                   |    6 +
> >>  include/linux/platform_data/mv_usb.h    |    3 -
> >>  include/linux/usb/mv_usb2.h             |   29 +++
> >>  include/linux/usb/phy.h                 |   22 ++-
> >>  20 files changed, 624 insertions(+), 150 deletions(-)
> >>  create mode 100644 drivers/usb/phy/phy-mv-usb2.c
> >>  create mode 100644 include/linux/usb/mv_usb2.h
> >>
> >> --
> >> 1.7.4.1
> >>
> >>
> >
> hi, balbi
> You have given many valuable comments and suggestions for previous version.
> So i modified the driver based on your review feedback. Can you help to
> review the new version? Thanks.

sure, just give me a few more days and I'll get to these.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130515/682cf9ac/attachment.sig>
