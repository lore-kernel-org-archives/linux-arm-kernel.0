From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Jun 2014 11:35:40 +0100
Subject: [PATCHv3 4/4] arm64: Enable TEXT_OFFSET fuzzing
In-Reply-To: <20140620085008.GG25104@arm.com>
References: <1403174963-10730-1-git-send-email-mark.rutland@arm.com>
 <1403174963-10730-5-git-send-email-mark.rutland@arm.com>
 <20140620085008.GG25104@arm.com>
Message-ID: <20140620103540.GG30188@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 09:50:08AM +0100, Will Deacon wrote:
> On Thu, Jun 19, 2014 at 11:49:23AM +0100, Mark Rutland wrote:
> > The arm64 Image header contains a text_offset field which bootloaders
> > are supposed to read to determine the offset (from a 2MB aligned "start
> > of memory" per booting.txt) at which to load the kernel. The offset is
> > not well respected by bootloaders at present, and due to the lack of
> > variation there is little incentive to support it. This is unfortunate
> > for the sake of future kernels where we may wish to vary the text offset
> > (even zeroing it).
> > 
> > This patch adds options to arm64 to enable fuzz-testing of text_offset.
> > CONFIG_ARM64_RANDOMIZE_TEXT_OFFSET forces the text offset to a random
> > 16-byte aligned value value in the range [0..2MB) upon a build of the
> > kernel. It is recommended that distribution kernels enable randomization
> > to test bootloaders such that any compliance issues can be fixed early.
> 
> [...]
> 
> > diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
> > index 1c1b756..566bf80 100644
> > --- a/arch/arm64/Kconfig.debug
> > +++ b/arch/arm64/Kconfig.debug
> > @@ -28,4 +28,20 @@ config PID_IN_CONTEXTIDR
> >  	  instructions during context switch. Say Y here only if you are
> >  	  planning to use hardware trace tools with this kernel.
> >  
> > +config ARM64_RANDOMIZE_TEXT_OFFSET
> > +	bool "Randomize TEXT_OFFSET at build time (EXPERIMENTAL)"
> 
> Lose the (EXPERIMENTAL) suffix -- this already lives under Kconfig.debug.

Sure.

> 
> > +	default N
> 
> I think this is redundant.

I think so too. Gone.

Cheers,
Mark.
