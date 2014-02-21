From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 21 Feb 2014 16:57:11 +0800
Subject: [PATCH v10 04/15] usb: doc: phy-mxs: update binding for adding
 anatop phandle
In-Reply-To: <20140221091444.GB7541@e106331-lin.cambridge.arm.com>
References: <1392873284-9386-1-git-send-email-peter.chen@freescale.com>
 <1392873284-9386-5-git-send-email-peter.chen@freescale.com>
 <20140221091444.GB7541@e106331-lin.cambridge.arm.com>
Message-ID: <20140221085710.GA13483@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 09:14:44AM +0000, Mark Rutland wrote:
> On Thu, Feb 20, 2014 at 05:14:33AM +0000, Peter Chen wrote:
> > Add anatop phandle which is used to access anatop registers to
> > control PHY's power and other USB operations.
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >  Documentation/devicetree/bindings/usb/mxs-phy.txt |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/mxs-phy.txt b/Documentation/devicetree/bindings/usb/mxs-phy.txt
> > index b43d4c9e..fc6659d 100644
> > --- a/Documentation/devicetree/bindings/usb/mxs-phy.txt
> > +++ b/Documentation/devicetree/bindings/usb/mxs-phy.txt
> > @@ -5,10 +5,12 @@ Required properties:
> >    for imx6dq and imx6dl, "fsl,imx6sl-usbphy" for imx6sl
> >  - reg: Should contain registers location and length
> >  - interrupts: Should contain phy interrupt
> > +- fsl,anatop: phandle for anatop register, it is only for imx6 SoC series
> 
> This is now required?

Yes, it is required.

> 
> What happens to those existing DTBs that claim compatibility with
> "fsl,imx6q-usbphy" but don't have an fsl,anatop property?
> 

The flag stands for the SoC has anatop will be 0, no anatop operation
will be done, the old-version dts can work with update driver, but less
features and one or two bug exists.

Peter

-- 

Best Regards,
Peter Chen
