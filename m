From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 10 Mar 2014 16:51:37 +0000
Subject: [PATCH 2/4] documentaion: DT: allow a A5 compatible string in
 global timer
In-Reply-To: <CAL_JsqLE6pWJMRvXbOOca4fFb9OUieMimnuxxo4AFKkSMiFvsg@mail.gmail.com>
References: <1394452294-24552-1-git-send-email-matthew.leach@arm.com>
 <1394452294-24552-3-git-send-email-matthew.leach@arm.com>
 <CAL_JsqLE6pWJMRvXbOOca4fFb9OUieMimnuxxo4AFKkSMiFvsg@mail.gmail.com>
Message-ID: <20140310165137.GO14999@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 10, 2014 at 04:27:09PM +0000, Rob Herring wrote:
> On Mon, Mar 10, 2014 at 6:51 AM, Matthew Leach <matthew.leach@arm.com> wrote:
> > The global timer is present on the Cortex A5. Add a compatibility
> > string to the DT binding to allow a Cortex A5 global timer.
> >
> > Signed-off-by: Matthew Leach <matthew.leach@arm.com>
> > ---
> >  Documentation/devicetree/bindings/arm/global_timer.txt | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/global_timer.txt b/Documentation/devicetree/bindings/arm/global_timer.txt
> > index 1e54898..0932891 100644
> > --- a/Documentation/devicetree/bindings/arm/global_timer.txt
> > +++ b/Documentation/devicetree/bindings/arm/global_timer.txt
> > @@ -4,8 +4,10 @@
> >
> >  ** Timer node required properties:
> >
> > -- compatible : Should be "arm,cortex-a9-global-timer"
> > -               Driver supports versions r2p0 and above.
> 
> Shouldn't you keep this information for the A9?

To me it feels like documenting the driver rather than the binding for
the hardware.

I'm happy to retain notes about the constraints imposed by Linux
drivers, but I'd prefer if it were the exception rather than the rule.

Mark.

> 
> > +- compatible : should contain
> > +            * "arm,cortex-a5-global-timer" for Cortex-A5 global timers.
> > +            * "arm,cortex-a9-global-timer" for Cortex-A9 global timers
> > +                or any compatible implementation.
> >
> >  - interrupts : One interrupt to each core
> >
> > --
> > 1.8.5.3
> >
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
