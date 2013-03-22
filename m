From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Fri, 22 Mar 2013 22:21:17 +0100
Subject: [PATCH v4 0/5] move s3c24xx-irq to drivers/irqchip and add dt
 support
In-Reply-To: <201303222104.54225.arnd@arndb.de>
References: <201303221843.37668.heiko@sntech.de>
 <201303222104.54225.arnd@arndb.de>
Message-ID: <201303222221.18605.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 22. M?rz 2013, 22:04:54 schrieb Arnd Bergmann:
> On Friday 22 March 2013, Heiko St?bner wrote:
> > As suggested by Rob Herring move back to get the parent releationship
> > from dt like in the first versions, but set the handler from the
> > interrupt property rather than from a specific list.
> > 
> > This version also implements (hopefully correctly) an idea from him and
> > Arnd Bergmann to have the parent relationship not described in the
> > controller node but the device nodes instead.
> > 
> > Therefore the main controller continues to use a two-cell descriptor to
> > set hwirq and trigger type but the sub-controller switches to a
> > three-cell descriptor where the third bit describes the hwirq of its
> > parent irq in the main controller.
> > 
> > As a result a serial node would then look like:
> >         serial at 50000000 {
> >         
> >                 compatible = "samsung,s3c2410-uart";
> >                 reg = <0x50000000 0x4000>;
> >                 interrupt-parent = <&subintc>;
> >                 interrupts = <0 4 28>, <1 4 28>;
> >         
> >         };
> > 
> > Tested on a s3c2416-based board.
> > 
> > As it depends on changes already pending for 3.10 it should probably go
> > thru the samsung tree.
> 
> Hi Heiko,
> 
> I should probably read the original discussion thread again. I already
> commented on the binding here, but I may have missed something important
> that led to it being the way it is now.

Hi Arnd,

Not really ... it's only my current interpretation of your short suggestion to 
handle the parent relationship in the interrupt descriptor of the device node 
and not in the controller node itself.

Your other mail did contain a lot of interesting thoughts on how to improve 
the current state - thanks for them.


Heiko
