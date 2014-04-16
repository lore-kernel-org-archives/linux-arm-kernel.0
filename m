From: davem@davemloft.net (David Miller)
Date: Wed, 16 Apr 2014 17:13:54 -0400 (EDT)
Subject: [RFC PATCH v3] ARM: uprobes need icache flush after xol write
In-Reply-To: <20140416202243.GI24070@n2100.arm.linux.org.uk>
References: <20140416152946.GA13564@redhat.com>
 <20140416.114740.1805744923904673839.davem@davemloft.net>
 <20140416202243.GI24070@n2100.arm.linux.org.uk>
Message-ID: <20140416.171354.2030799647571837439.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Wed, 16 Apr 2014 21:22:43 +0100

> I'm thinking that both flush_icache_alias() and flush_pfn_alias() want
> at least a preemption disabled around each so that we don't end up with
> two threads being preempted here.

Yes, you would need to disable preemption to keep another thread of
control from potentially using the same flush slot.
