From: tony@atomide.com (Tony Lindgren)
Date: Thu, 23 Sep 2010 10:52:28 -0700
Subject: [PATCH 7/7] omap3: make coresight register save across OFF
	modes a sysfs option
In-Reply-To: <4C8209E2.3080803@ti.com>
References: <13B9B4C6EF24D648824FF11BE896716203BADA0745@dlee02.ent.ti.com>
	<1280077520-7538-8-git-send-email-virtuoso@slind.org>
	<20100806123711.GI28519@shisha.kicks-ass.net>
	<20100806124726.GN23778@atomide.com> <4C8209E2.3080803@ti.com>
Message-ID: <20100923175227.GO4211@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Cousson, Benoit <b-cousson@ti.com> [100904 01:49]:
> 
> These patches are still using static virtual to physical mapping in
> io.h,  shouldn't we take the opportunity of this series to fix that
> and use ioremap instead?

Hmm, well the amba device should ioremap, but we need the virt address
for sleep34xx.S also. So to me it seems like we're missing the static
ioremap entries for plat-omap/io.c for the virtual addresses.

Alexander, can you please check that and repost the remaining
three patches one more time?

Thanks,

Tony
