From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Tue, 11 Oct 2016 11:14:23 +0800
Subject: [RESEND PATCH v6, 4/5] usb: Add MediaTek USB3 DRD Driver
In-Reply-To: <49293f1b-42b5-f06b-8fdc-f46fe996e237@gmail.com>
References: <1474437277-27201-1-git-send-email-chunfeng.yun@mediatek.com>
 <1474437277-27201-5-git-send-email-chunfeng.yun@mediatek.com>
 <49293f1b-42b5-f06b-8fdc-f46fe996e237@gmail.com>
Message-ID: <1476155663.15546.32.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-10-10 at 13:00 +0200, Matthias Brugger wrote:
> 
> On 09/21/2016 07:54 AM, Chunfeng Yun wrote:
> > This patch adds support for the MediaTek USB3 controller
> > integrated into MT8173. It can be configured as Dual-Role
> > Device (DRD), Peripheral Only and Host Only (xHCI) modes.
> >
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  drivers/usb/Kconfig                |    2 +
> >  drivers/usb/Makefile               |    1 +
> >  drivers/usb/mtu3/Kconfig           |   54 +++
> >  drivers/usb/mtu3/Makefile          |   19 +
> >  drivers/usb/mtu3/mtu3.h            |  422 +++++++++++++++++
> >  drivers/usb/mtu3/mtu3_core.c       |  871 +++++++++++++++++++++++++++++++++++
> >  drivers/usb/mtu3/mtu3_dr.c         |  379 ++++++++++++++++
> >  drivers/usb/mtu3/mtu3_dr.h         |  108 +++++
> >  drivers/usb/mtu3/mtu3_gadget.c     |  731 +++++++++++++++++++++++++++++
> >  drivers/usb/mtu3/mtu3_gadget_ep0.c |  883 ++++++++++++++++++++++++++++++++++++
> >  drivers/usb/mtu3/mtu3_host.c       |  294 ++++++++++++
> >  drivers/usb/mtu3/mtu3_hw_regs.h    |  473 +++++++++++++++++++
> >  drivers/usb/mtu3/mtu3_plat.c       |  490 ++++++++++++++++++++
> >  drivers/usb/mtu3/mtu3_qmu.c        |  599 ++++++++++++++++++++++++
> >  drivers/usb/mtu3/mtu3_qmu.h        |   43 ++
> >  15 files changed, 5369 insertions(+)
> >  create mode 100644 drivers/usb/mtu3/Kconfig
> >  create mode 100644 drivers/usb/mtu3/Makefile
> >  create mode 100644 drivers/usb/mtu3/mtu3.h
> >  create mode 100644 drivers/usb/mtu3/mtu3_core.c
> >  create mode 100644 drivers/usb/mtu3/mtu3_dr.c
> >  create mode 100644 drivers/usb/mtu3/mtu3_dr.h
> >  create mode 100644 drivers/usb/mtu3/mtu3_gadget.c
> >  create mode 100644 drivers/usb/mtu3/mtu3_gadget_ep0.c
> >  create mode 100644 drivers/usb/mtu3/mtu3_host.c
> >  create mode 100644 drivers/usb/mtu3/mtu3_hw_regs.h
> >  create mode 100644 drivers/usb/mtu3/mtu3_plat.c
> >  create mode 100644 drivers/usb/mtu3/mtu3_qmu.c
> >  create mode 100644 drivers/usb/mtu3/mtu3_qmu.h
> >
> 
> As Oliver already said, this patch is quiet big which makes it difficult 
> to review.
> I propose to provide a first implementation with minimal functionality 
> and incremental patches on top of this when the first got merged.
> 
> You could split the patch in three series/parts:
> 1. Host only
> 2. Peripheral only
> 3. Dual mode
> 
> What do you think?

Ok, I'll split the patch into some small ones as many as possible.

Thanks a lot
> 
> Regards,
> Matthias
> 
