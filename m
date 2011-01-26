From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 26 Jan 2011 16:06:40 -0500 (EST)
Subject: [PATCH 03/14] ARM: v6k: remove CPU_32v6K dependencies in
	asm/spinlock.h
In-Reply-To: <AANLkTikG4bPmesNPvLGt8G+Q8YWwRzyYL3i+uL1FE=K2@mail.gmail.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1PeueP-0003SR-03@rmk-PC.arm.linux.org.uk>
	<AANLkTinnhivretaRHpYwCYouk-_jWKZQEo7x4sbheJVL@mail.gmail.com>
	<20110125165919.GD17286@n2100.arm.linux.org.uk>
	<AANLkTimK06nJPtQoym3HxXeDD-s4nUrN0vWjp_JcgTjx@mail.gmail.com>
	<20110125174636.GE17286@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101251618230.8580@xanadu.home>
	<AANLkTi=zVsr8G=eYfp7v_QQvBBDCX+Es+T-4c4Fu=QVF@mail.gmail.com>
	<alpine.LFD.2.00.1101261023470.8580@xanadu.home>
	<20110126155203.GA10141@n2100.arm.linux.org.uk>
	<AANLkTikG4bPmesNPvLGt8G+Q8YWwRzyYL3i+uL1FE=K2@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1101261558470.8580@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Jan 2011, Dave Martin wrote:

> On Wed, Jan 26, 2011 at 3:52 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > So I don't think weak symbols work like we want them to.
> >
> 
> That was the conclusion I came to also ... the linker seems to resolve
> references in each object before discarding sections, so the weak
> reference has already become concrete and section discard breaks it.

Well, I must add to the chorus.

And it seems to be impossible to obtain the name of the currently active 
section from gas either, which would have made the conditional omission 
of the fixup possible, or similar.

Bummer.


Nicolas
