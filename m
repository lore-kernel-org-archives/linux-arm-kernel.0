From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Jan 2011 18:18:40 +0000
Subject: [PATCH] arm: Configure reference clock for Versatile Express
	timers
In-Reply-To: <000001cbb739$ef879490$ce96bdb0$@moll@arm.com>
References: <1295368773-14531-1-git-send-email-pawel.moll@arm.com>
	<20110118174428.GG16980@n2100.arm.linux.org.uk>
	<000001cbb739$ef879490$ce96bdb0$@moll@arm.com>
Message-ID: <20110118181840.GH16980@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 18, 2011 at 06:02:56PM -0000, Pawel Moll wrote:
> > This patch performs required magic and also removes code clearing
> > > timer's control registers, as exactly the same operations are
> > > performed by the timer driver few jiffies later.
> > It would be nice if these registers were documented...
> 
> The best I can do is to create some more meaningful constants.

I was actually referring to the manuals - last time I looked these
register bits are not documented in the user guide for the system.
DUI0447A, 4.4.9: "You can, however, use the System Controller to change
the timer reference from 32.768kHz to 1MHz."

The only other reference to "System Controller" is at the beginning of
the document in the preface: "ARM PrimeCell System Controller (SP810)
Technical Reference Manual (ARM DDI 0254)".

Section 4.4.1 refers to the memory map, which tells me that the System
Control ARM SP810 is at CS7 + 0x1000.

Section 4.2 is titled "System control registers" but actually describes
the "System registers" described in table 4-1.  4.3 describes those
system registers.  4.4 describes the other peripherals.

DDI0254 is not published, so there's nothing on the register layout.
