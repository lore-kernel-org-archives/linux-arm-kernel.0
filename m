From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 11 Oct 2012 11:58:15 -0400 (EDT)
Subject: [PATCH] ARM: decompressor: clear SCTLR.A bit for v7 cores
In-Reply-To: <20121011135925.GR4625@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.02.1210100939160.16518@xanadu.home>
 <1349959402-24164-1-git-send-email-robherring2@gmail.com>
 <20121011130955.GP4625@n2100.arm.linux.org.uk> <5076CA43.9070503@gmail.com>
 <20121011135925.GR4625@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1210111152580.16518@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 11 Oct 2012, Russell King - ARM Linux wrote:

> On Thu, Oct 11, 2012 at 08:31:47AM -0500, Rob Herring wrote:
> > This only affects v7 cores. It should not vary for v7 cores as unaligned
> > access is a required feature. So how is it going to vary on v7 CPUs?
> > We've got bigger problems if there are v7 cores that don't handle
> > unaligned accesses.
> 
> Oh, and this gives me a third reason to NAK this patch.  Why only ensure
> that the A bit is clear for v7 CPUs?  Why not v6, v5, v4 too?  Why does
> ARMv7 get this special treatment?

As I said, gcc knows that ARMv7 can perform word sized accesses even 
with misaligned pointers.  So when it is passed a pointer marked with 
the packed attribute, it will generate a series of byte accesses when 
compiling for anything but ARMv7, and use a single ldr or str when 
compiling for ARMv7.


Nicolas
