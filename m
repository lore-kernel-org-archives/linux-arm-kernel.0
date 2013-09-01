From: jochen.armkernel@leahnim.org (Jochen De Smet)
Date: Sat, 31 Aug 2013 20:37:41 -0400
Subject: Undefined instruction (ldrshtgt?) on mirabox with 3.11-rc7
In-Reply-To: <20130831235434.GM6617@n2100.arm.linux.org.uk>
References: <52221A70.5060707@leahnim.org>
 <20130831200649.GJ6617@n2100.arm.linux.org.uk> <5222758D.2050306@leahnim.org>
 <20130831235434.GM6617@n2100.arm.linux.org.uk>
Message-ID: <52228C55.7040503@leahnim.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/31/2013 19:54, Russell King - ARM Linux wrote:
> On Sat, Aug 31, 2013 at 07:00:29PM -0400, Jochen De Smet wrote:
> Hmm, disassemble /m... I'm not up with gdb I'm afraid. 
Supposed to show mixed source/assembler I believe.
> Notice the destination addresses similarity to the address of the first
> instruction we think was executed - 0xc0208778 vs c0208378.  Here's
> the instruction opcodes for branches to those two locations:
>
> c02107d8:	1affdfe6 	bne	c0208778
> c02107d8:	1affdee6 	bne	c0208378
>
> See the single bit difference there on bit 8?
>
> So, this is what I think: either _something_ has cleared that bit, or
> you have a problem with your SDRAM wiring, or your SDRAM containing
> this location is going bad and is suffering from a bit error at this
> location.
>
> I'm afraid that I think you have a hardware problem.
The only counter-indication I have is that the 3.10 kernel I've been 
running has
never had any issues, nor the default 2.6.x kernel that came with it.  I 
might have
just gotten lucky with exactly what those compiled to though I suppose?

I've got 2 of these boxes, so I'll update the kernel on the second one 
to this version
as well and see if it reproduces there.

Thanks a lot for the fast diagnosis.

J.
