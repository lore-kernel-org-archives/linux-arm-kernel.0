From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 Nov 2010 10:21:03 +0000
Subject: [PATCH 7/7] ARM: Thumb-2: Restore sensible zImage header
	layout for CONFIG_THUMB2_KERNEL
In-Reply-To: <AANLkTim5Nv_oFgpfYL7jtjcMP10ND6wp5B50veURVPcn@mail.gmail.com>
References: <1289913277-8822-1-git-send-email-dave.martin@linaro.org>
	<1289913277-8822-7-git-send-email-dave.martin@linaro.org>
	<20101116182643.GC21926@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1011161517260.6448@xanadu.home>
	<20101116203520.GE21926@n2100.arm.linux.org.uk>
	<AANLkTim5Nv_oFgpfYL7jtjcMP10ND6wp5B50veURVPcn@mail.gmail.com>
Message-ID: <1289989263.2351.15.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-11-17 at 09:16 +0000, Dave Martin wrote:
> On Tue, Nov 16, 2010 at 6:26 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Nov 16, 2010 at 01:14:37PM +0000, Dave Martin wrote:
> >> Maybe it is a better idea to preserve the current header as is with the
> >> ARM mode nops and perform the switch to Thumb mode using the branch
> >> instruction after those 8 nops.  This way the kernel image format will
> >> remain compatible with existing bootloaders without a need for
> >> bootloaders to know if the image is ARM or Thumb mode.
> >
> > That is definitely worth doing, and sounds like a better idea.
> 
> OK, that sounds reasonable -- I can try and propose a patch for this.
> If the contents of the first 32 bytes doesn't matter, we can replace
> the first two words with something like
> 
> adr r12, BSYM(real_start)
> bx r12

Would these be compiled to ARM or Thumb-2?

-- 
Catalin
