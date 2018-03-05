From: broonie@kernel.org (Mark Brown)
Date: Mon, 5 Mar 2018 12:46:38 +0000
Subject: [PATCH 0/29] arm meltdown fix backporting review for lts 4.9
In-Reply-To: <20180302165415.GB8704@kroah.com>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <20180301152450.GA4061@kroah.com>
 <5cf40379-9098-da02-a471-8abd7d8f0be8@linaro.org>
 <20180302165415.GB8704@kroah.com>
Message-ID: <20180305124638.GG8588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2018 at 05:54:15PM +0100, Greg KH wrote:
> On Fri, Mar 02, 2018 at 05:14:50PM +0800, Alex Shi wrote:
> > On 03/01/2018 11:24 PM, Greg KH wrote:

> > > And why are you making this patchset up?  What is wrong with the patches
> > > in the android-common tree for this?

> > We believe the LTS is the base kernel for android/lsk, so the fixing
> > patches should get it first and then merge to other tree.

> But you know that android-common is already fine here, the needed
> patches are all integrated into there, so no additional work is needed
> for android devices.  So what devices do you expect to use this 4.9
> backport?

See below...

> What is "lsk"?

The Linaro Stable Kernel, it's LTS plus some feature backports.

> But really, I don't see this need as all ARM devices that I know of that
> are stuck on 4.9.y are already using the android-common tree.  Same for
> 4.4.y.  Do you know of any that are not, and that can not just use
> 4.14.y instead?

There's way more to ARM than just Android systems, assuming that getting
things into the Android kernel is enough is like assuming that x86 is
covered since the distros have their own backports - it covers a lot of
users but not everyone.  Off the top of my head there's things like
routers, NASs, cameras, IoT, radio systems, industrial appliances, set
top boxes and these days even servers.  Most of these segments are just
as conservative about taking new kernel versions on shipping product as
the phone vendors are, the practices that make people relucant to take
bigger updates in production are general engineering practices common
across industry.

I mostly talk to chip vendors so I can't off the top of my head name
specific end products with particular kernel versions.  What I can tell
you is that many of the chip vendors care deeply about LTS because their
customers demand it - off the top of my head at least Atmel, ST and TI
ship vanilla LTS kernels with no Android at all into large market
segments.  Some of these chips couldn't usefully run Android so there's
just no Android support, some also have Android available as an
alternative.  Some of them even have very complete upstream support
available with barely any vendor patch required at all (none in some
applications).

Things that are functioning well will inevitably be less visible -
that's good, that means there's less of a pain point there but it
doesn't mean there's not still a support need.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180305/feaac11b/attachment.sig>
