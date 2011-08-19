From: davem@davemloft.net (David Miller)
Date: Fri, 19 Aug 2011 06:26:09 -0700 (PDT)
Subject: of_iomap() matched with plan iounmap()
In-Reply-To: <201108191426.19152.arnd@arndb.de>
References: <20110818170226.GA16721@huya.qualcomm.com>
	<20110818.203447.462383652600224162.davem@davemloft.net>
	<201108191426.19152.arnd@arndb.de>
Message-ID: <20110819.062609.1865751197015675220.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 19 Aug 2011 14:26:18 +0200

> We could of course change all existing users of of_iounmap on sparc to use
> the simpler prototype, because it also just calls iounmap.

Check again, on sparc64 it needs the resource to release it.

Only the 32-bit version on sparc evaluates to just a plain iounmap().
