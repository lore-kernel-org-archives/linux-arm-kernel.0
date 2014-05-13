From: horms@verge.net.au (Simon Horman)
Date: Tue, 13 May 2014 10:11:28 +0900
Subject: [PATCH v2 4/4] ARM: shmobile: marzen-reference: Set SMSC lan to
 use irq-push-pull
In-Reply-To: <2152550.dZ0p2WIftv@avalon>
References: <1368586650-26263-1-git-send-email-horms+renesas@verge.net.au>
 <1368586650-26263-5-git-send-email-horms+renesas@verge.net.au>
 <10371644.BMkVSLAUGy@avalon> <2152550.dZ0p2WIftv@avalon>
Message-ID: <20140513011128.GD30252@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 12:26:35AM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Wednesday 15 May 2013 11:15:01 Laurent Pinchart wrote:
> > Hi Simon,
> > 
> > Thanks for the patch.
> > 
> > On Wednesday 15 May 2013 11:57:30 Simon Horman wrote:
> > > This change makes the DTS consistent with the platform data
> > > that exists in board-marzen.c.
> > > 
> > > Empirically it does not appear to be necessary.
> > > 
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> I've noticed that this patch hasn't landed in mainline. Do you still plan to 
> upstream it ?
> 
> While the board has a pull-up resistor on the IRQ signal and can thus 
> accommodate an open-drain configuration, using push-pull mode would lower the 
> rise time.

Sorry for letting that slip through the cracks (for an entire year!).
I'll queue it up after giving Magnus a chance to veto it.

> > > ---
> > > 
> > >  arch/arm/boot/dts/r8a7779-marzen-reference.dts | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
> > > b/arch/arm/boot/dts/r8a7779-marzen-reference.dts index 10cfc7f..fe32e1a
> > > 100644
> > > --- a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
> > > +++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
> > > @@ -40,6 +40,7 @@
> > > 
> > >  		phy-mode = "mii";
> > >  		interrupt-parent = <&irqpin0>;
> > >  		interrupts = <1 0x4>;
> > > 
> > > +		smsc,irq-push-pull;
> > > 
> > >  		reg-io-width = <4>;
> > >  		vddvario-supply = <&fixedregulator3v3>;
> > >  		vdd33a-supply = <&fixedregulator3v3>;
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
