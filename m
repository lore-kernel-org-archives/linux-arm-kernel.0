From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 16 Sep 2014 15:38:41 +0200
Subject: [PATCH v5 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <20140916005129.GC3379@peterchendt>
References: <1410777378-12726-1-git-send-email-antoine.tenart@free-electrons.com>
 <1410777378-12726-8-git-send-email-antoine.tenart@free-electrons.com>
 <20140916005129.GC3379@peterchendt>
Message-ID: <20140916133841.GA4869@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 16, 2014 at 08:51:30AM +0800, Peter Chen wrote:
> On Mon, Sep 15, 2014 at 12:36:13PM +0200, Antoine Tenart wrote:
> > Add a USB2 ChipIdea driver for ci13xxx, with optional PHY, clock
> > and DMA mask, to support USB2 ChipIdea controllers that don't need
> > specific functions.
> > 
> > Tested on the Marvell Berlin SoCs USB controllers.
> > 
> > Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> > ---
> >  drivers/usb/chipidea/Makefile       |   1 +
> >  drivers/usb/chipidea/ci_hdrc_usb2.c | 137 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 138 insertions(+)
> >  create mode 100644 drivers/usb/chipidea/ci_hdrc_usb2.c
> > 
> 
> compile error:
> 
> /home/peter/work/projects/usb/drivers/usb/chipidea/ci_hdrc_usb2.c: In function 'ci_hdrc_usb2_dt_probe':
> /home/peter/work/projects/usb/drivers/usb/chipidea/ci_hdrc_usb2.c:30:2: error: implicit declaration of function 'of_phy_get' [-Werror=implicit-function-declaration]
> /home/peter/work/projects/usb/drivers/usb/chipidea/ci_hdrc_usb2.c:30:16: warning: assignment makes pointer from integer without a cast [enabled by default]

Did you apply the series introducing the support for the generic PHY
framework in the USB subsystem first? One of the patches includes
'linux/phy/phy.h' in 'linux/usb/otg.h'. That's why I did not encounter
this error.

Anyway, you're right and 'linux/phy/phy.h' should be explicitly included
here.


Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
