From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Aug 2015 18:34:19 -0700
Subject: [GIT PULL v2 0/5] Samsung updates for v4.3
In-Reply-To: <55CCE517.2070003@kernel.org>
References: <55CCE517.2070003@kernel.org>
Message-ID: <20150821013419.GC4865@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 03:42:31AM +0900, Kukjin Kim wrote:
> Hello Arnd, Olof, Kevin
> 
> Here is re-spin of pull request for Samsung stuff for v4.3 as per Olof's
> suggestion.
> 
> Most of this pull-requests are to switch to support generic cpufreq
> driver for exynos3250, 4210, 4412 and 5250 and several exynos dt updates.
> 
> Note as I commented in each tag, each pull-request(signed tag) has a
> dependency with each other, so please keep the ordering in this time.
> 
> 1) tags/samsung-clk-driver
> 2) tags/samsung-late-dt
> 3) tags/samsung-soc
> 4) tags/samsung-late-cpufreq-driver
> 5) tags/samsung-defconfig-new
> 
> If any problems, please kindly let me know.

That ordering is awkward for us. driver->dt->soc->driver->defconfig is
not the way we do it.

I'll merge them into a next/late branch together, and we might or might not
send it in this merge window depending on how it goes.

The lesson to learn here (for us and you) is that if there is complex
contents, getting it sent in very early is important: rc2/rc3 is
ideal. We're likely to be less tolerant of messy dependencies as we start
to approach -rc6 and already have a lot of things merged up. We might
also have locked into ordering between branches by then that doesn't
match what you've used.


-Olof
