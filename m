From: Pawel.Moll@arm.com (Pawel Moll)
Date: Mon, 24 Jan 2011 16:38:20 +0000
Subject: [PATCH v2] arm: Configure reference clock for Versatile Express
	timers
In-Reply-To: <20110124161453.GB24104@n2100.arm.linux.org.uk>
References: <1295373883-21513-1-git-send-email-pawel.moll@arm.com>
	<20110124144753.GB22949@n2100.arm.linux.org.uk>
	<F01D8B85CFF58440B2A13965FBA90CA45911F4328E@GEORGE.Emea.Arm.com>
	<20110124161453.GB24104@n2100.arm.linux.org.uk>
Message-ID: <F01D8B85CFF58440B2A13965FBA90CA45911F432AE@GEORGE.Emea.Arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I've removed them, because the sp804 driver is initializing these
> > registers in sp804_clocksource_init() and sp804_set_mode(), just
> > a jiffy later.
> What if we have some other more preferable clock events which
> rules in set_mode not being called?  How do we ensure that these
> timers won't create some spurious interrupts?

Good point. The sp804_clockevent_init() should do this. A patch is just going out...

Pawe?

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
