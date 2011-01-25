From: tony@atomide.com (Tony Lindgren)
Date: Tue, 25 Jan 2011 11:50:39 -0800
Subject: [PATCH 01/14] ARM: bitops: ensure set/clear/change bitops take
	a word-aligned pointer
In-Reply-To: <E1Peudk-0003SJ-Aj@rmk-PC.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1Peudk-0003SJ-Aj@rmk-PC.arm.linux.org.uk>
Message-ID: <20110125195038.GR13589@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110117 11:20]:
> Add additional instructions to our assembly bitops functions to ensure
> that they only operate on word-aligned pointers.  This will be necessary
> when we switch these operations to use the word-based exclusive
> operations.

If it's still not too late, we've had this in the testing branch
in the linux-omap tree for about a week now. So far no problems,
for me file systems tested have been ext3 and nfs.

Tested-by: Tony Lindgren <tony@atomide.com>
