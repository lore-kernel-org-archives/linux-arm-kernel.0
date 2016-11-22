From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Nov 2016 22:08:10 +0100
Subject: [PATCH] dt-bindings: mfd: Improve readability for TPS65217
 interrupt sources
In-Reply-To: <20161122160013.GH10134@dell.home>
References: <20161121131515.8040-1-woogyom.kim@gmail.com>
 <20161122155759.GG10134@dell.home> <20161122160013.GH10134@dell.home>
Message-ID: <2502592.54T1nU6yzL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 22, 2016 4:00:13 PM CET Lee Jones wrote:
> > > diff --git a/include/dt-bindings/mfd/tps65217.h b/include/dt-bindings/mfd/tps65217.h
> > > index cafb9e6..0293fdd 100644
> > > --- a/include/dt-bindings/mfd/tps65217.h
> > > +++ b/include/dt-bindings/mfd/tps65217.h
> > > @@ -19,8 +19,8 @@
> > >  #ifndef __DT_BINDINGS_TPS65217_H__
> > >  #define __DT_BINDINGS_TPS65217_H__
> > >  
> > > -#define TPS65217_IRQ_USB   0
> > > -#define TPS65217_IRQ_AC            1
> > > -#define TPS65217_IRQ_PB            2
> > > +#define TPS65217_IRQ_USB_POWER             0       /* USB power state change */
> > > +#define TPS65217_IRQ_AC_POWER              1       /* AC power state change */
> > > +#define TPS65217_IRQ_PUSHBUTTON            2       /* Push button state change */
> > 
> > This changes the ABI.
> > 
> > It will require a DT Ack.
> 
> Tell a lie.  Sorry, I was getting false positives from my grep.  It
> looks like you use the same scheme from within include/linux.  I
> suggest that you probable don't want to do that.

Doing this change however would cause a bisection problem: you
can't rename just the constants in the header or just the driver
using those constants.

	Arnd
