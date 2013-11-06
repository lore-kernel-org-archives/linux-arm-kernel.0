From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 6 Nov 2013 15:35:48 +0800
Subject: [PATCH v3 08/11] usb: phy-mxs: Enable IC fixes for related SoCs
In-Reply-To: <CAHXqBFKTTY8vxs9BzK1xQAa7HeRLSBucsxb4wkLejLWmCnckaA@mail.gmail.com>
References: <1383616183-10511-1-git-send-email-peter.chen@freescale.com>
 <1383616183-10511-9-git-send-email-peter.chen@freescale.com>
 <CAHXqBFKTTY8vxs9BzK1xQAa7HeRLSBucsxb4wkLejLWmCnckaA@mail.gmail.com>
Message-ID: <20131106073548.GD16332@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 10:02:35PM +0100, Micha? Miros?aw wrote:
> 2013/11/5 Peter Chen <peter.chen@freescale.com>
> >
> > Some PHY bugs are fixed by IC logic, but these bits are not
> > enabled by default, so we enable them at driver.
> >
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >  drivers/usb/phy/phy-mxs-usb.c |   32 ++++++++++++++++++++++++++++++--
> >  1 files changed, 30 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> > index c794011..b7e1744 100644
> > --- a/drivers/usb/phy/phy-mxs-usb.c
> > +++ b/drivers/usb/phy/phy-mxs-usb.c
> > @@ -31,6 +31,10 @@
> >  #define HW_USBPHY_CTRL_SET                     0x34
> >  #define HW_USBPHY_CTRL_CLR                     0x38
> >
> > +#define HW_USBPHY_IP                           0x90
> > +#define HW_USBPHY_IP_SET                       0x94
> > +#define HW_USBPHY_IP_CLR                       0x98
> > +
> >  #define BM_USBPHY_CTRL_SFTRST                  BIT(31)
> >  #define BM_USBPHY_CTRL_CLKGATE                 BIT(30)
> >  #define BM_USBPHY_CTRL_ENAUTOSET_USBCLKS       BIT(26)
> > @@ -60,6 +64,18 @@
> >   */
> >  #define MXS_PHY_SENDING_SOF_TOO_FAST           BIT(2)
> >
> > +/*
> > + * IC fix for MXS_PHY_ABNORAML_IN_SUSPEND, bit 17 is the effective bit
> > + * in HW_USBPHY_IP.
> > + */
> > +#define MXS_PHY_FIX_ABNORAML_IN_SUSPEND                BIT(17)
> [...]
> 
> s/ABNORAML/ABNORMAL/ ?
> 

thanks.

-- 

Best Regards,
Peter Chen
