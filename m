From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Sep 2011 15:51:04 +0100
Subject: [RFC PATCH 2/3] ARM: mm: add l2x0 physical address parameter
	to init
In-Reply-To: <1317047561-11020-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1317047561-11020-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1317047561-11020-3-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20110926145104.GL22455@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2011 at 03:32:40PM +0100, Lorenzo Pieralisi wrote:
> This patch redefines the l2x0_init function, and it adds a
> parameter defining the L2 physical base address in preparation
> for L2 resume support. The device tree init code retrieves the
> physical address from the "reg" array and converts it to a
> physical address pointer.

I've no idea why many people have a really dire time understanding the
following basic fact.  I keep seeing the same things: virtual addresses
as integers and physical addresses as pointers.

Virtual addresses are pointers.
Physical addresses are NOT pointers but integers.

Why?  You CAN'T dereference a physical address when running in the virtual
address space (which is the space which the kernel runs in.)

Stop doing it.
