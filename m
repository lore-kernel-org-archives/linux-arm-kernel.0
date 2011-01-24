From: Pawel.Moll@arm.com (Pawel Moll)
Date: Mon, 24 Jan 2011 16:12:16 +0000
Subject: [PATCH v2] arm: Configure reference clock for Versatile	Express
	timers
In-Reply-To: <20110124144753.GB22949@n2100.arm.linux.org.uk>
References: <1295373883-21513-1-git-send-email-pawel.moll@arm.com>
	<20110124144753.GB22949@n2100.arm.linux.org.uk>
Message-ID: <F01D8B85CFF58440B2A13965FBA90CA45911F4328E@GEORGE.Emea.Arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > -   writel(0, MMIO_P2V(V2M_TIMER0) + TIMER_CTRL);
> > -   writel(0, MMIO_P2V(V2M_TIMER1) + TIMER_CTRL);
> BTW, why are you removing the initialization of TIMER_CTRL ?  You
> don't
> describe why you do this in the commit log so I suspect it's a
> mistake.

Uh, apologies. The explanation got lost while moving the patch between one tree and another...

I've removed them, because the sp804 driver is initializing these registers in sp804_clocksource_init() and sp804_set_mode(), just a jiffy later.

Cheers!

Pawe?

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
