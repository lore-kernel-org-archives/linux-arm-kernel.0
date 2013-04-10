From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Apr 2013 20:15:26 +0100
Subject: Removal of NWFPE in its entirety, and VFP emulation code
In-Reply-To: <20130410132126.GD26992@mudshark.cambridge.arm.com>
References: <20130410104002.GF14496@n2100.arm.linux.org.uk>
 <20130410132126.GD26992@mudshark.cambridge.arm.com>
Message-ID: <20130410191526.GN14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 02:21:27PM +0100, Will Deacon wrote:
> Hi Russell,
> 
> On Wed, Apr 10, 2013 at 11:40:02AM +0100, Russell King - ARM Linux wrote:
> > I have just committed a patch to remove the arch/arm/nwfpe code from
> > the kernel, and the VFP code emulating the FP operations.
> 
> [...]
> 
> I just had a play with your for-next branch, and noticed a couple of issues
> arising from this:
> 
> 	1. Removing vfpinstr.h leads to a couple of build failures, as it is
> 	   still included by arch/arm/kvm/coproc.c (for fmrx, which we should
> 	   continue to provide) and arch/arm/vfp/vfpmodule.c (similarly, but
> 	   also fmxr).

Grr, this is why relative include paths are bad news.  It breaks the
localisation of includes.  Okay, I'll add that include back, even
though nothing in arch/arm/vfp will be using it.

I'll leave everything else though... the functions in vfp.h will take
too much time to work out what's required and what isn't, and I don't
have the available bandwidth before I go away to work out what functions
are used and what aren't.
