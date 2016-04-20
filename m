From: brad.mouring@ni.com (Brad Mouring)
Date: Wed, 20 Apr 2016 09:23:21 -0500
Subject: [PATCH v2 2/2] Documentation: devicetree: Add PL310 PM bindings
In-Reply-To: <CAL_JsqL-LCt06ZYQL4FEu7vEdHaFCvBe5xnHbkZTf55yAf5Svw@mail.gmail.com>
References: <1456265019-23900-1-git-send-email-brad.mouring@ni.com>
 <1461015411-14000-1-git-send-email-brad.mouring@ni.com>
 <1461015411-14000-3-git-send-email-brad.mouring@ni.com>
 <CAL_JsqL-LCt06ZYQL4FEu7vEdHaFCvBe5xnHbkZTf55yAf5Svw@mail.gmail.com>
Message-ID: <20160420142321.GA23956@zardoz.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 04:38:14PM -0500, Rob Herring wrote:
> On Mon, Apr 18, 2016 at 4:36 PM, Brad Mouring <brad.mouring@ni.com> wrote:
> > Document the DT bindings for controlling ARM PL310 Power Control
> > settings.
> >
> > Signed-off-by: Brad Mouring <brad.mouring@ni.com>
> 
> What happened to Josh's ack?

This is not the change that Josh reviewed, if he does agree with it, I'll
put his ack on it. This was done purposefully.

> > ---
> >  Documentation/devicetree/bindings/arm/l2c2x0.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/l2c2x0.txt b/Documentation/devicetree/bindings/arm/l2c2x0.txt
> > index fe0398c..c1c756e 100644
> > --- a/Documentation/devicetree/bindings/arm/l2c2x0.txt
> > +++ b/Documentation/devicetree/bindings/arm/l2c2x0.txt
> > @@ -84,6 +84,10 @@ Optional properties:
> >  - prefetch-instr : Instruction prefetch. Value: <0> (forcibly disable),
> >    <1> (forcibly enable), property absent (retain settings set by
> >    firmware)
> > +- arm,dynamic-clock-gating : L2 dynamic clock gating. Value: <0> (forcibly
> > +  disable), <1> or property absent (forcibly enable)
> > +- arm,standby-mode: L2 standby mode enable. Value <0> (forcibly disable),
> > +  <1>  or property absent (forcibly enable)
> 
> What happened to "retain settings set by firmware"?
>
> Rob
This is the difference. There was discussion that this would be a
functional regression for some, and Russell (while noting that he
generally agreed with keeping fw settings) noted that this would be
a possible functional regression sprung on those who wanted PM.

In all honesty, I don't really care one way or the other, since
we'll be defining this property in our dtbs. I'm all ears if you
have a strong oppinion (and this *does* seem like the sort of
setting that can be overridden in the kernel, but should be left
otherwise as the fw set it).

Brad
