From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Jul 2011 14:30:33 +0100
Subject: [PATCH] ARM: do not mark CPU 0 as hotpluggable
In-Reply-To: <4E27BA10.3060203@ti.com>
References: <1311204745-6276-1-git-send-email-mturquette@ti.com>
	<4E2796DA.80001@gmail.com> <4E27BA10.3060203@ti.com>
Message-ID: <20110721133033.GN26574@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2011 at 11:03:04AM +0530, Santosh Shilimkar wrote:
> Just talking on behalf of OMAP, we can't offline CPU0 and limitation
> would remain in future OMAPs too.

Apart from the broken IRQ migration, and the way CPU0 immediately
reawakes if it is offlined on OMAP4 (even when IRQs are migrated off
CPU0) because omap_read_auxcoreboot0() returns 0, is there any other
reason?

With fixed IRQ migration and forcing CPU0 into an infinite WFI loop,
I can offline CPU0 and still have a running system.
