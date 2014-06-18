From: geoff@infradead.org (Geoff Levand)
Date: Wed, 18 Jun 2014 11:41:42 -0700
Subject: [PATCH 3/4] arm64: export effective Image size to bootloaders
In-Reply-To: <20140618164927.GA9612@leverpostej>
References: <1400233839-15140-1-git-send-email-mark.rutland@arm.com>
 <1400233839-15140-4-git-send-email-mark.rutland@arm.com>
 <1402950432.3708.22.camel@smoke> <20140618164927.GA9612@leverpostej>
Message-ID: <1403116902.17030.15.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, 2014-06-18 at 17:49 +0100, Mark Rutland wrote:
> On Mon, Jun 16, 2014 at 09:27:12PM +0100, Geoff Levand wrote:
> While I initially considered having a field to specify byte order, it's
> incredibly likely that bootloaders will not use it. Maintaining a fixed
> endianness everywhere makes it simpler for bootloaders to do the right
> thing, and matches what existing bootloaders are already doing. That's
> less pain for loaders and less pain for the kernel, as things are less
> likely to go wrong.
> 
> To me it makes more sense to ensure these fields have a consistent
> endianness, rather than adding more room for possible mistakes.

I guess my view is that any software expected to support arm64 in both
big and little endian configurations should be tested with such, and
with this it is pretty simple to test and fix, so we shouldn't over
engineer it, but I don't really care how we fix it.

> > Another advantage of having the byte order in the header is that
> > tools other than a boot loader that need to know the byte order
> > can get that info from the header, otherwise they would need to
> > guess the order with some kind of inspection.
> 
> What kind of tools do you envision which would need to know the
> endianness of the kernel but would be looking at the Image rather than
> the vmlinux?

I have no idea, but I can imagine it may be of use to someone who is
trying to figure out why things don't work and would like to know what
kind of image they have.

-Geoff
