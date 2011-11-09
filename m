From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 9 Nov 2011 11:17:51 -0500 (EST)
Subject: [PATCH] ARM: kprobes: Fix build error in test code
In-Reply-To: <1320834975.2427.7.camel@linaro1>
References: <1319017634.2183.19.camel@linaro1>
 <1320834975.2427.7.camel@linaro1>
Message-ID: <alpine.LFD.2.02.1111091117230.3307@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Nov 2011, Jon Medhurst (Tixy) wrote:

> On Wed, 2011-10-19 at 10:47 +0100, Jon Medhurst (Tixy) wrote:
> > When compiling kprobes-test-thumb.c an error like below may occur:
> > 
> > /tmp/ccKcuJcG.s:19179: Error: offset out of range
> > 
> > This is caused by the compiler underestimating the size of the inline
> > assembler instructions containing ".space 0x1000" and failing to spill
> > the literal pool in time to prevent the generation of PC relative load
> > instruction with invalid offsets.
> > 
> > The fix implemented by this patch is to replace a single large .space
> > directive by a number of 4 byte .space's. This requires splitting the
> > macros which generate test cases for branch instructions into two forms:
> > one with, and one without support for inserting extra code between
> > branch and target.
> > 
> > Signed-off-by: Jon Medhurst <jon.medhurst@linaro.org>
> > ---
> 
> Nicolas, I noticed that you put this patch into the Linaro kernel tree,
> can I take that as an Acked-by? ;-)

Sure.


Nicolas
