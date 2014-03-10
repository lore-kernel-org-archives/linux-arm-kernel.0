From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 10 Mar 2014 18:11:29 +0000
Subject: [PATCH 2/4] documentaion: DT: allow a A5 compatible string in
 global timer
In-Reply-To: <CAL_JsqLEUknsO6DccSyd4p5gd1=1KUN5s=W6L0iOoiERxMaPbw@mail.gmail.com>
References: <1394452294-24552-1-git-send-email-matthew.leach@arm.com>
 <1394452294-24552-3-git-send-email-matthew.leach@arm.com>
 <CAL_JsqLE6pWJMRvXbOOca4fFb9OUieMimnuxxo4AFKkSMiFvsg@mail.gmail.com>
 <20140310165137.GO14999@e106331-lin.cambridge.arm.com>
 <CAL_JsqLEUknsO6DccSyd4p5gd1=1KUN5s=W6L0iOoiERxMaPbw@mail.gmail.com>
Message-ID: <20140310181129.GP14999@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 10, 2014 at 05:57:32PM +0000, Rob Herring wrote:
> On Mon, Mar 10, 2014 at 11:51 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Mon, Mar 10, 2014 at 04:27:09PM +0000, Rob Herring wrote:
> >> On Mon, Mar 10, 2014 at 6:51 AM, Matthew Leach <matthew.leach@arm.com> wrote:
> >> > The global timer is present on the Cortex A5. Add a compatibility
> >> > string to the DT binding to allow a Cortex A5 global timer.
> >> >
> >> > Signed-off-by: Matthew Leach <matthew.leach@arm.com>
> >> > ---
> >> >  Documentation/devicetree/bindings/arm/global_timer.txt | 6 ++++--
> >> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/arm/global_timer.txt b/Documentation/devicetree/bindings/arm/global_timer.txt
> >> > index 1e54898..0932891 100644
> >> > --- a/Documentation/devicetree/bindings/arm/global_timer.txt
> >> > +++ b/Documentation/devicetree/bindings/arm/global_timer.txt
> >> > @@ -4,8 +4,10 @@
> >> >
> >> >  ** Timer node required properties:
> >> >
> >> > -- compatible : Should be "arm,cortex-a9-global-timer"
> >> > -               Driver supports versions r2p0 and above.
> >>
> >> Shouldn't you keep this information for the A9?
> >
> > To me it feels like documenting the driver rather than the binding for
> > the hardware.
> >
> > I'm happy to retain notes about the constraints imposed by Linux
> > drivers, but I'd prefer if it were the exception rather than the rule.
> 
> Isn't the driver constraint based on the global timer h/w being broken
> on pre r2p0? If it is truly a Linux limitation that could be fixed,
> then I agree.

Unfortunately, I must admit ignorance on this matter.

>From a quick look, the comparator behaviour on Cortex-A9 cores prior to
r2p0 seems to make it unusable in practice (though I'm not aware of the
precise behaviour, perhaps there is some possible workaround).

We can note the problem in the binding document, but we don't need to
refer to any particular driver. :)

Cheers,
Mark.
