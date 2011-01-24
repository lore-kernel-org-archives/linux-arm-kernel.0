From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 24 Jan 2011 19:13:27 -0000
Subject: [PATCH v2] arm: Configure reference clock for Versatile	Express
	timers
In-Reply-To: <20110124171007.GI24104@n2100.arm.linux.org.uk>
References: <1295373883-21513-1-git-send-email-pawel.moll@arm.com>
	<20110124144753.GB22949@n2100.arm.linux.org.uk>
	<F01D8B85CFF58440B2A13965FBA90CA45911F4328E@GEORGE.Emea.Arm.com>
	<20110124161453.GB24104@n2100.arm.linux.org.uk>
	<F01D8B85CFF58440B2A13965FBA90CA45911F432AE@GEORGE.Emea.Arm.com>
	<20110124171007.GI24104@n2100.arm.linux.org.uk>
Message-ID: <000601cbbbfa$c83d4db0$58b7e910$@moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Right, I'm chucking your original patch out of my tree.

Ok, I'd like to separate these two things.

First is the reference clock configuration, and this change is really important. I'll send v3 in a second, which does not touch the TIMER_CTRL lines. I hope you are happy about this.

The second thing is the SP804 reset... You said:

> Some platforms have four timers. Should we leave two uninitialized?

VE _has_ four timers - two dual-timer modules - and you don't initialize V2M_TIMER[23]. True, the (potential) problem lies at "twin timers", sharing common interrupt, but if you want to reset all available timers on all platforms, we should perform the rites on them as well.

I also had a look at the TRM and the reset value for the control register is 0, but I'm guessing you are worried about boot monitor leftovers.

Cheers!

Pawe?
