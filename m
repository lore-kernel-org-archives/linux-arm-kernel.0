From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 21 Aug 2011 00:05:33 +0100
Subject: [PATCH 2/6] ARM: add Highbank core platform support
In-Reply-To: <201108191611.36147.arnd@arndb.de>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
	<201108181734.25397.arnd@arndb.de>
	<20110818154048.GD21865@n2100.arm.linux.org.uk>
	<201108191611.36147.arnd@arndb.de>
Message-ID: <20110820230533.GA344@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2011 at 04:11:35PM +0200, Arnd Bergmann wrote:
> Is that a bad thing? Platforms that don't need the special case can
> simply call sp804_clocksource_init_dt() which scans the device tree,
> while other platforms do whatever is necessary to the registers
> and then call the existing sp804_clockevents_init.

It means we're not solving the problem.  We end up with some platforms
which do the sp804 init from DT, others which are DT but ignore the
DT stuff for sp804.  That's not very consistent, and in the long run
is rather confusing.
