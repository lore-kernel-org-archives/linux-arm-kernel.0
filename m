From: tony@atomide.com (Tony Lindgren)
Date: Tue, 25 Jan 2011 11:51:18 -0800
Subject: [PATCH 02/14] ARM: bitops: switch set/clear/change bitops to
	use ldrex/strex
In-Reply-To: <E1Peue4-0003SN-Gk@rmk-PC.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1Peue4-0003SN-Gk@rmk-PC.arm.linux.org.uk>
Message-ID: <20110125195118.GS13589@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110117 11:23]:
> Switch the set/clear/change bitops to use the word-based exclusive
> operations, which are only present in a wider range of ARM architectures
> than the byte-based exclusive operations.

This too been in use for about a week now with ext3 and nfs:

Tested-by: Tony Lindgren <tony@atomide.com>
