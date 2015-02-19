From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 19 Feb 2015 10:12:48 -0800
Subject: [PATCH 2/4] of: DT quirks infrastructure
In-Reply-To: <CAL_JsqKT3+URcad6X=i+73NLRnVstbpvFJxxT=ru7KJmp_XuVQ@mail.gmail.com>
References: <1424271576-1952-1-git-send-email-pantelis.antoniou@konsulko.com>
 <1424271576-1952-3-git-send-email-pantelis.antoniou@konsulko.com>
 <54E54586.5070602@gmail.com>
 <CAL_JsqKT3+URcad6X=i+73NLRnVstbpvFJxxT=ru7KJmp_XuVQ@mail.gmail.com>
Message-ID: <20150219181248.GA7713@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 19, 2015 at 12:01:14PM -0600, Rob Herring wrote:
> On Wed, Feb 18, 2015 at 8:08 PM, Frank Rowand <frowand.list@gmail.com> wrote:
> > On 2/18/2015 6:59 AM, Pantelis Antoniou wrote:
> >> Implement a method of applying DT quirks early in the boot sequence.
> >>
> >> A DT quirk is a subtree of the boot DT that can be applied to
> >> a target in the base DT resulting in a modification of the live
> >> tree. The format of the quirk nodes is that of a device tree overlay.
> >
> > The use of the word "quirk" is a different mental model for me than what
> > this patch series appears to be addressing.  I would suggest totally
> > removing the word "quirk" from this proposal to avoid confusing the
> > mental models of future generations of kernel folks.
> 
> This comes from me as quirks are a different usecase I had in mind,
> but one that could use a similar mechanism. Although, in the case of
> quirks, I would expect them to be overlays built into the kernel. It
> would be more a way to update old dtbs.
> 
> > What this patch series seems to be proposing is a method to apply DT
> > overlays as soon as unflatten_device_tree() completes.  In other words,
> > making the device tree a dynamic object, that is partially defined by
> > the kernel during boot.  Well, to be fair, the kernel chooses among
> > several possible alternatives encoded in the DT blob.  So the device
> > tree is no longer a static object that describes the hardware of the
> > system.  It may not sound like a big deal, but it seems to me to be
> > a fundamental shift in what the device tree blob is.  Something that
> > should be thought about carefully and not just applied as a patch to
> > solve a point problem.
> 
> I agree. I would not want to see every board for an SOC become an
> overlay for example. I think it has to be limited to truly plugable
> h/w (e.g. capes) or minor changes. We just have to define what is
> minor. :)
> 

Everything that isn't OIR capable but fixed at boot time. OIR can and
should be handled with "real" overlays. OIR implies removal; I would
assume that what is discused here is insertion-only, and runtime removal
is neither required nor wanted. Or at least that is our use case.

Guenter
