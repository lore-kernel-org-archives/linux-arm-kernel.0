From: horms@verge.net.au (Simon Horman)
Date: Wed, 9 Apr 2014 15:15:41 +0900
Subject: [PATCH] ARM: shmobile: lager: Correct setting of ethernet PHY
 LED mode
In-Reply-To: <1665021.dQPpZ5R559@avalon>
References: <1396916495-13018-1-git-send-email-horms+renesas@verge.net.au>
 <1665021.dQPpZ5R559@avalon>
Message-ID: <20140409061540.GA26994@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08, 2014 at 02:07:49PM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Tuesday 08 April 2014 09:21:35 Simon Horman wrote:
> > The correct binding is "micrel,led-mode", not "led-mode".
> > 
> > This corrects an error which was introduced when setting of ethernet PHY
> > LED mode was added by 82e62182d59bd1d0 ("ARM: shmobile: lager: Set ethernet
> > PHY LED mode").
> 
> Indeed. I wonder how I've missed that... :-( Sorry.

Thanks, I have queued this up.

> 
> > This makes the lager code consistent with the koelsch code which was added
> > by ae00d12a032490b3 ("ARM: shmobile: koelsch: Set ethernet PHY LED mode").
> > 
> > Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> > ---
> > 
> > * This is compile tested only (which is of negligible value)
> >   as I do not have physical access to a Lager board.
> > ---
> >  arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/r8a7790-lager.dts
> > b/arch/arm/boot/dts/r8a7790-lager.dts index a55c5f8..265cba1 100644
> > --- a/arch/arm/boot/dts/r8a7790-lager.dts
> > +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> > @@ -213,7 +213,7 @@
> >  		reg = <1>;
> >  		interrupt-parent = <&irqc0>;
> >  		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> > -		led-mode = <1>;
> > +		micrel,led-mode = <1>;
> >  	};
> >  };
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
