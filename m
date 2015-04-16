From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 16 Apr 2015 12:47:50 +0100
Subject: [PATCH RESEND] Doc: dt: arch_timer: discourage clock-frequency use
In-Reply-To: <CAL_JsqJfyknhZxGvbWcj1Vj1FGRt40qT9b=xrbhm0wfu-BduTw@mail.gmail.com>
References: <1426874267-24413-1-git-send-email-mark.rutland@arm.com>
 <CAL_JsqJfyknhZxGvbWcj1Vj1FGRt40qT9b=xrbhm0wfu-BduTw@mail.gmail.com>
Message-ID: <20150416114749.GK2866@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Rob, are you happy to take this through your tree?
> 
> Yes, I'll take it.

Are you still planning on taking this for v4.1? I couldn't spot it in a
public branch yet.

Mark

> 
> Rob
> 
> >
> > Mark.
> >
> > [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/282804.html
> > [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/282830.html
> >
> >
> > diff --git a/Documentation/devicetree/bindings/arm/arch_timer.txt b/Documentation/devicetree/bindings/arm/arch_timer.txt
> > index 256b4d8..e774128 100644
> > --- a/Documentation/devicetree/bindings/arm/arch_timer.txt
> > +++ b/Documentation/devicetree/bindings/arm/arch_timer.txt
> > @@ -17,7 +17,10 @@ to deliver its interrupts via SPIs.
> >  - interrupts : Interrupt list for secure, non-secure, virtual and
> >    hypervisor timers, in that order.
> >
> > -- clock-frequency : The frequency of the main counter, in Hz. Optional.
> > +- clock-frequency : The frequency of the main counter, in Hz. Should be present
> > +  only where necessary to work around broken firmware which does not configure
> > +  CNTFRQ on all CPUs to a uniform correct value. Use of this property is
> > +  strongly discouraged; fix your firmware unless absolutely impossible.
> >
> >  - always-on : a boolean property. If present, the timer is powered through an
> >    always-on power domain, therefore it never loses context.
> > @@ -46,7 +49,8 @@ Example:
> >
> >  - compatible : Should at least contain "arm,armv7-timer-mem".
> >
> > -- clock-frequency : The frequency of the main counter, in Hz. Optional.
> > +- clock-frequency : The frequency of the main counter, in Hz. Should be present
> > +  only when firmware has not configured the MMIO CNTFRQ registers.
> >
> >  - reg : The control frame base address.
> >
> > --
> > 1.9.1
> >
> 
