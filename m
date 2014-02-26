From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Feb 2014 11:15:07 +0000
Subject: [PATCH] scripts/link-vmlinux.sh: correct base address for some
 ARM special cases
In-Reply-To: <1393413080-26942-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1393413080-26942-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20140226111507.GW21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 12:11:20PM +0100, Uwe Kleine-K?nig wrote:
> The toolchain problem described in commit f6537f2f0eba
> (scripts/kallsyms: filter symbols not in kernel address space) makes it
> necessary to filter out some kernel symbols from /proc/kallsyms to make
> perf happy.
> 
> For that to work correctly the address used to filter should be just
> below the kernel text segment. Depending on kernel configuration
> CONFIG_PAGE_OFFSET is not the right address to use. See the comments
> introduced by this commit for the glory details.

Is there any reason why PAGE_OFFSET should not be DRAM_BASE for nommu?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
