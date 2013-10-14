From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 14 Oct 2013 09:33:42 +0800
Subject: [PATCH 10/11] usb: chipidea: imx: add binding for supporting
 runtime pm
In-Reply-To: <201310140339.37042.marex@denx.de>
References: <1381570513-24927-11-git-send-email-peter.chen@freescale.com>
 <Pine.LNX.4.44L0.1310121039250.25996-100000@netrider.rowland.org>
 <20131014012206.GA3879@shlinux1.ap.freescale.net>
 <201310140339.37042.marex@denx.de>
Message-ID: <20131014013341.GC3879@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 03:39:36AM +0200, Marek Vasut wrote:
> Dear Peter Chen,
> 
> > On Sat, Oct 12, 2013 at 10:40:37AM -0400, Alan Stern wrote:
> > > On Sat, 12 Oct 2013, Peter Chen wrote:
> > > > Add property for supporting runtime power management
> > > > 
> > > > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > > > ---
> > > > 
> > > >  .../devicetree/bindings/usb/ci13xxx-imx.txt        |    2 ++
> > > >  1 files changed, 2 insertions(+), 0 deletions(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> > > > b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt index
> > > > b4b5b79..f666598 100644
> > > > --- a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> > > > +++ b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> > > > 
> > > > @@ -18,6 +18,7 @@ Optional properties:
> > > >  - vbus-supply: regulator for vbus
> > > >  - disable-over-current: disable over current detect
> > > >  - external-vbus-divider: enables off-chip resistor divider for Vbus
> > > > 
> > > > +- supports_runtime_pm: enable runtime pm support
> > > > 
> > > >  Examples:
> > > >  usb at 02184000 { /* USB OTG */
> > > > 
> > > > @@ -28,4 +29,5 @@ usb at 02184000 { /* USB OTG */
> > > > 
> > > >  	fsl,usbmisc = <&usbmisc 0>;
> > > >  	disable-over-current;
> > > >  	external-vbus-divider;
> > > > 
> > > > +	supports_runtime_pm;
> > > > 
> > > >  };
> > > 
> > > This does not sound like a property of the hardware.  What's the
> > > _hardware_ difference between parts that support runtime PM and parts
> > > that don't?
> > 
> > Thanks.
> > 
> > From my point, all hardware using chipidea core should support runtime pm.
> > But some of platforms need special glue layer operations to support
> > it, it will break other platforms if enable chipidea core runtime pm.
> > Since device tree describes hardware property, maybe I should move
> > it to glue layer, or do you have any suggestions?
> 
> You should certainly move it out of DT. This is linux-specific property, it has 
> nothing to do with HW. The best course of action would be to fix those platforms 
> that are broken by runtime PM.
> 

Thanks, I move it out of DT. But I can only verify it at i.mx platform,
I will add a flag at glue layer.

-- 

Best Regards,
Peter Chen
