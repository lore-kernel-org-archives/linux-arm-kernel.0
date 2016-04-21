From: brad.mouring@ni.com (Brad Mouring)
Date: Thu, 21 Apr 2016 15:48:20 -0500
Subject: [PATCH v2 2/2] Documentation: devicetree: Add PL310 PM bindings
In-Reply-To: <CAL_Jsq+SzUaNGy8LtqHv9T8i3x9WLHd-5eCb4=z4DMRwZo8XfA@mail.gmail.com>
References: <1456265019-23900-1-git-send-email-brad.mouring@ni.com>
 <1461015411-14000-1-git-send-email-brad.mouring@ni.com>
 <1461015411-14000-3-git-send-email-brad.mouring@ni.com>
 <CAL_JsqL-LCt06ZYQL4FEu7vEdHaFCvBe5xnHbkZTf55yAf5Svw@mail.gmail.com>
 <20160419224122.GE19428@n2100.arm.linux.org.uk>
 <CAL_Jsq+SzUaNGy8LtqHv9T8i3x9WLHd-5eCb4=z4DMRwZo8XfA@mail.gmail.com>
Message-ID: <20160421204820.GA23290@zardoz.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2016 at 09:04:39AM -0500, Rob Herring wrote:
> On Tue, Apr 19, 2016 at 5:41 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Apr 19, 2016 at 04:38:14PM -0500, Rob Herring wrote:
> >> On Mon, Apr 18, 2016 at 4:36 PM, Brad Mouring <brad.mouring@ni.com> wrote:
> >> > Document the DT bindings for controlling ARM PL310 Power Control
> >> > settings.
> >> >
> >> > Signed-off-by: Brad Mouring <brad.mouring@ni.com>
> >>
> >> What happened to Josh's ack?
> >>
> >> > ---
> >> >  Documentation/devicetree/bindings/arm/l2c2x0.txt | 4 ++++
> >> >  1 file changed, 4 insertions(+)
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/arm/l2c2x0.txt b/Documentation/devicetree/bindings/arm/l2c2x0.txt
> >> > index fe0398c..c1c756e 100644
> >> > --- a/Documentation/devicetree/bindings/arm/l2c2x0.txt
> >> > +++ b/Documentation/devicetree/bindings/arm/l2c2x0.txt
> >> > @@ -84,6 +84,10 @@ Optional properties:
> >> >  - prefetch-instr : Instruction prefetch. Value: <0> (forcibly disable),
> >> >    <1> (forcibly enable), property absent (retain settings set by
> >> >    firmware)
> >> > +- arm,dynamic-clock-gating : L2 dynamic clock gating. Value: <0> (forcibly
> >> > +  disable), <1> or property absent (forcibly enable)
> >> > +- arm,standby-mode: L2 standby mode enable. Value <0> (forcibly disable),
> >> > +  <1>  or property absent (forcibly enable)
> >>
> >> What happened to "retain settings set by firmware"?
> >
> > I said we shouldn't.  Current behaviour is that we enable these features,
> > and moving to missing-means-retain means that everything today ends up
> > with these features disabled.  IOW, it's yet another change of actual
> > behaviour that every platform would see.
> 
> Right, but then the properties are different from prefetch-instr and
> others IIRC. We're letting the OS define the binding. If BSD doesn't
> enable these settings currently, then there is a mismatch between the
> binding and actual behavior. Saying "retain firmware settings" also
> defines specific OS behavior. I think absent should mean OS is free to
> do whatever it wants which could be retain firmware settings, enable
> or disable. In other words, it is undefined as this ship has already
> sailed.

Both positions have validity, I think the idealist in me sides with Rob
(for something with definite tradeoffs, it's odd to force an assumption
when there's no property) while the developer with experience sides with
Russell (why needlessly change behavior that may have wide-reaching
impact?) At this point, I don't have nearly the perspective to make a
call on which is overall the "right" choice for the community, so maybe
it should be an [RFC] instead? Thoughts?

Brad
