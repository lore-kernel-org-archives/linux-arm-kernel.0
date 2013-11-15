From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Nov 2013 23:21:09 +0000
Subject: ACPI vs DT at runtime
In-Reply-To: <201311152056.47846.arnd@arndb.de>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115175241.GB27174@quad.lixom.net>
 <20131115180832.GR16735@n2100.arm.linux.org.uk>
 <201311152056.47846.arnd@arndb.de>
Message-ID: <20131115232109.GT16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 08:56:47PM +0100, Arnd Bergmann wrote:
> On Friday 15 November 2013, Russell King - ARM Linux wrote:
> > On Fri, Nov 15, 2013 at 09:52:41AM -0800, Olof Johansson wrote:
> > > If we knew exactly what we wanted, it'd be a different story. _We
> > > don't_. We're into year FOUR of the device tree conversion and we're just
> > > now reaching a point where we think we know what a good solution looks
> > > like. The first two years were easy -- they were the trivial devices we're
> > > now talking about on ACPI. After that it got harder. Going through all
> > > of that again with ACPI? No. No way. Microsoft gets to do it and while
> > > they're busy sorting it out, we'll boot with device tree.
> > 
> > However, there's a very big danger here.  I disagree with the stance
> > you're taking.
> > 
> > It seems that under ACPI and DT, we refer to properties by string names.
> > That's good, but do we really want to have different string names for the
> > same property.
> 
> For all I know, doing this in ACPI is something that is only now being
> discussed as Intel wants to be able to reuse the existing features from
> DT enabled drivers in the kernel and share the implementation between
> embedded x86 SoCs and embedded ARM/PowerPC/MIPS/... SoCs. That part actually
> isn't as crazy.
> 
> The existing ACPI usage however is basically all binary and cannot be
> shared with DT, in particular it won't help for the orthogonal problem of
> using ACPI to get "enterprise server" features on ARM64.

That's strange, because the patches I've seen from people who want to
add ACPI support to AMBA are all based around very similar strings to
those in DT to lookup the same data in ACPI.

What's been done there is the function which reads from DT has been
duplicated, and instead of reading the information from DT, it reads it
from ACPI instead using string names without the vendor prefix.

That tells me that what I've stated in my previous email to which you
replied is _definitely_ possible to do.  That means it's certainly
possible to do this without reinventing the wheel, and without having
to rewrite lots of parsing code, precisely along the lines I set out
in my original email.
