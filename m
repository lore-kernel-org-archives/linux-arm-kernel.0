From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Dec 2015 19:37:08 +0000
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
In-Reply-To: <20151202192825.GF8644@n2100.arm.linux.org.uk>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
 <87610j7gmc.fsf@free-electrons.com>
 <20151202123310.GC8644@n2100.arm.linux.org.uk>
 <3059482.yN34NFeWWY@wuerfel>
 <20151202192825.GF8644@n2100.arm.linux.org.uk>
Message-ID: <20151202193707.GG8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 07:28:25PM +0000, Russell King - ARM Linux wrote:
> The first is easy to solve, and the second by replacing it with dove.h.
> The next problem is this:
> 
> arch/arm/plat-orion/common.c:25:30: fatal error: mach/bridge-regs.h: No such file or directory
> 
> which is impossible to solve, because plat-orion/common.c wants
> mach-dove/bridge-regs.h.

Another few breakages which is going to be difficult to solve:

drivers/hwmon/dove.c:35:30: fatal error: mach/bridge-regs.h: No such file or directory

drivers/soc/dove/pmu.c: In function 'dove_init_pmu_legacy':
drivers/soc/dove/pmu.c:404:46: error: 'IRQ_DOVE_PMU_START' undeclared (first use in this function)
drivers/soc/dove/pmu.c:404:46: note: each undeclared identifier is reported only once for each function it appears in

So, all in all this series gets a NAK from me as it totally destroys
my ability to do any further work on Dove.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
