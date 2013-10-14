From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 14 Oct 2013 09:44:31 +0800
Subject: [PATCH 11/12] usb: phy-mxs: update binding for adding
 disconnect line property
In-Reply-To: <201310121147.07217.marex@denx.de>
References: <1381568986-19802-1-git-send-email-peter.chen@freescale.com>
 <1381568986-19802-12-git-send-email-peter.chen@freescale.com>
 <201310121147.07217.marex@denx.de>
Message-ID: <20131014014430.GF3879@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 12, 2013 at 11:47:06AM +0200, Marek Vasut wrote:
> Dear Peter Chen,
> 
> > This property is used to disconnect line between USB PHY and
> > USB controller.
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >  Documentation/devicetree/bindings/usb/mxs-phy.txt |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/mxs-phy.txt
> > b/Documentation/devicetree/bindings/usb/mxs-phy.txt index 1a9bd85..099b0bb
> > 100644
> > --- a/Documentation/devicetree/bindings/usb/mxs-phy.txt
> > +++ b/Documentation/devicetree/bindings/usb/mxs-phy.txt
> > @@ -5,6 +5,9 @@ Required properties:
> >  - reg: Should contain registers location and length
> >  - interrupts: Should contain phy interrupt
> >  - fsl,anatop: phandle for anatop register
> > +- disconnect_line_without_vbus: needs to disconnect
> > +connection between USB PHY and controller, it can avoid
> > +unexpected wakeup interrupt when the PHY is out of power
> 
> Uh oh, this might needs some rewording. I didn't understand the reason for this 
> prop before I checked the 12/12 patch.
> 

So, the better sequence like below, correct?

Binding doc patch
source code change patch
dts file patch

-- 

Best Regards,
Peter Chen
