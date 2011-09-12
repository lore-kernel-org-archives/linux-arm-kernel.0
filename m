From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Sep 2011 08:41:55 +0100
Subject: [PATCH v2 09/10] ARM: kprobes: Add some benchmarking to test
	module
In-Reply-To: <1315811353.2255.35.camel@computer2>
References: <1315652706-2900-1-git-send-email-tixy@yxit.co.uk>
	<1315652706-2900-10-git-send-email-tixy@yxit.co.uk>
	<alpine.LFD.2.00.1109112241310.20358@xanadu.home>
	<1315811353.2255.35.camel@computer2>
Message-ID: <20110912074155.GA7007@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2011 at 08:09:13AM +0100, Tixy wrote:
> However, looking at the current implementations of sched_clock() they
> seems to have full 64-bit range, and git history shows a new common
> infrastructure for sched_clock being added at the end of last year. So
> is the full 64-bit range now defined for the sched_clock on API on ARM?

Yes - the scheduler requires the full 64-bit range from sched_clock()
so all implementations we had needed to be fixed.  Anything which doesn't
give the full 64-bit range is now considered buggy.
