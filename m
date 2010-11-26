From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Nov 2010 00:03:41 +0000
Subject: [PATCH 2/7] arm/pxa2xx: reorganize I2C files
In-Reply-To: <20101125235520.GC15948@trinity.fluff.org>
References: <1290633617-15311-1-git-send-email-bigeasy@linutronix.de>
	<1290633617-15311-3-git-send-email-bigeasy@linutronix.de>
	<20101125235520.GC15948@trinity.fluff.org>
Message-ID: <20101126000341.GB9310@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 25, 2010 at 11:55:20PM +0000, Ben Dooks wrote:
> > diff --git a/arch/arm/include/asm/pxa_i2c.h b/arch/arm/include/asm/pxa_i2c.h
> > new file mode 100644
> > index 0000000..f6da8a1
> > --- /dev/null
> > +++ b/arch/arm/include/asm/pxa_i2c.h
>
> Anyone an opinion on whther to alter all arch-arm machine includes
> or add a re-direct of plat/i2c.h to linux/i2c/pxa-i2c.h

We're not going to litter arch/arm/include/asm with SoC specific includes.
If we start doing this, we'll end up with thousands of files in
arch/arm/include/asm which have no real business being there.

So there's not much option but to NAK this patch before it gets out of
hand.

The reason for this change seems to be because x86 has a different register
layout, and x86 doesn't have the clk API.  For the former, that can be
dealt with an ifdef along side the register definitions.

For the latter, why not just implement a simple clk API implementation
which always returns success, rather than requiring special headers
for various ARM drivers?
