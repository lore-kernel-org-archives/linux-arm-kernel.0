From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 May 2018 17:36:44 +0100
Subject: [PATCH v3 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
In-Reply-To: <CAD=FV=UpWEMSPUYOHmLQ0g_mF990kwn4_zm=ZCNttLKZiz7i=Q@mail.gmail.com>
References: <20180530093701.GD6920@sirena.org.uk>
 <CAD=FV=W-MLU9c-SvfLgKAKGP1eHN5xO-013f2M09XUa+QeHzrA@mail.gmail.com>
 <20180530150241.GO6920@sirena.org.uk>
 <CAD=FV=XJd-udEE6az0xP7i6x0oGsnd=BSCyZ0Og_+RjNCMXnCQ@mail.gmail.com>
 <20180530154849.GQ6920@sirena.org.uk>
 <CAD=FV=X2u=hMyWinSDtim-PmFwAy5mXcwg3HeYojAHcsUFhV3g@mail.gmail.com>
 <20180530160744.GS6920@sirena.org.uk>
 <CAD=FV=WVGu0f+=q-C9kiEmaLEUJqGY+Jbns83h72uF-9iasrUw@mail.gmail.com>
 <20180530161311.GT6920@sirena.org.uk>
 <CAD=FV=UpWEMSPUYOHmLQ0g_mF990kwn4_zm=ZCNttLKZiz7i=Q@mail.gmail.com>
Message-ID: <20180530163644.GW6920@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 09:31:55AM -0700, Doug Anderson wrote:
> On Wed, May 30, 2018 at 9:13 AM, Mark Brown <broonie@kernel.org> wrote:

> > If we're just going to use the most recently set voltage then hopefully
> > the hardware already knew that, and it might not be the lowest available
> > voltage if the last consumer to get turned off was holding the voltage
> > higher.

> To circle back to the original point: the problem is that (IMHO) the
> hardware is doing the wrong thing by still counting Linux's vote for a
> voltage even though Linux also voted that the regulator should be
> disabled.  So basically we're working around the hardware by
> pretending to vote for a dummy lower voltage whenever Linux wants the
> regulator disabled.  From Linux's point of view everything works as
> normal--we just tell the hardware a falsehood so it doesn't count our
> vote for a voltage while the regulator is disabled.

Yeah, and I don't think that's unreasonable for the core to do - just
drop the voltage to the constraint minimum after it has turned off the
regulator, then recheck and raise if needed before it enables again.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180530/aed2a9fd/attachment.sig>
