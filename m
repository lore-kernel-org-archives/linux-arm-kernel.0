From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Aug 2011 16:09:56 +0200
Subject: Subject: L2x0 OF properties do not include interrupt #
In-Reply-To: <000201cc575b$c1229010$4367b030$@rutland@arm.com>
References: <000201cc575b$c1229010$4367b030$@rutland@arm.com>
Message-ID: <201108101609.56995.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 August 2011, Mark Rutland wrote:

> I realise I'm a bit late to the party here, but I'd like to propose adding an
> optional interrupt parameter to the binding. I'm not aware of any
> implementations which use separate interrupts, but given the binding
> seems to be generic across L2CC implementations (and is not limited simply to
> the L2x0), having a list rather than a single interrupt may be appropriate for
> someone.

Sounds good, thanks for pointing this out.

How many possible interrupt sources are there? If there is only a small number
of those (e.g. at most 4), we might just list all of them and register
them from the driver even if they are all the same.

> This would boil down to (for the moment) a Documentation change along the lines of:
> 
> > diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
> > index f50e021..d4b387b 100644
> > --- a/Documentation/devicetree/bindings/arm/l2cc.txt
> > +++ b/Documentation/devicetree/bindings/arm/l2cc.txt
> > @@ -28,6 +28,7 @@ Optional properties:
> >  - arm,filter-ranges : <start length> Starting address and length of window to
> >    filter. Addresses in the filter window are directed to the M1 port. Other
> >    addresses will go to the M0 port.
> > +- interrupt : A combined interrupt.
> >  
> >  Example:
> >  
> > @@ -39,4 +40,5 @@ L2: cache-controller {
> >          arm,filter-latency = <0x80000000 0x8000000>;
> >          cache-unified;
> >          cache-level = <2>;
> > +        interrupt = <45>;
> >  };
> 
> Any thoughts?

Do we also need to document an interrupt-parent property, or is that implied?

	Arnd
