From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 1 Mar 2012 19:50:51 +0000
Subject: [PATCH 0/4] ARM: kirkwood: fdt: convert kirkwood init funcs to fdt
In-Reply-To: <cover.1330625877.git.jason@lakedaemon.net>
References: <cover.1330625877.git.jason@lakedaemon.net>
Message-ID: <201203011950.51210.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 March 2012, Jason Cooper wrote:
> This series begins the process of converting all of the drivers initialized
> from kirkwood_init() to devicetree.
> 
> The first patch cleans up kirkwood_init() by moving a flag setting to it's
> appropriate location.  This will help later when converting the audio driver.
> 
> Next, I pull the functionality of kirkwood_init() into kirkwood_dt_init() in
> board-dt.c  This way, as drivers are converted, their init calls can be removed
> from kirkwood_dt_init() and non-fdt users won't be affected (they call
> kirkwood_init()).
> 
> Last, I converted the two easiest drivers, rtc and wdt.  The xor and crypto
> drivers remain for a later patch series.

Hi Jason,

Nice patch series! I've commented on a few details that need improving, but
it seems you're making good progress overall. Note that in other platforms,
we typically focus on converting all the devices outside of the soc first,
because that lets us get away from board files faster, but there is nothing
wrong in principle in converting the devices on the soc as well.

	Arnd
