From: tony@atomide.com (Tony Lindgren)
Date: Fri, 4 May 2012 17:13:23 -0700
Subject: [PATCH] ARM: move read_{boot,persistent}_clock to the
 architecture level
In-Reply-To: <1335617145-24649-1-git-send-email-marc.zyngier@arm.com>
References: <1335617145-24649-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20120505001323.GD5613@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marc Zyngier <marc.zyngier@arm.com> [120428 05:49]:
> At the moment, read_persistent_clock is implemented at the
> platform level, which makes it impossible to compile these
> platforms in a single kernel.
> 
> Implement these two functions at the architecture level, and
> provide a thin registration interface for both read_boot_clock
> and read_persistent_clock. The two affected platforms (OMAP and
> Tegra) are converted at the same time.
> 
> Compile tested only.

Sorry I'm a bit behind with emails again..

Boot tested on omap1 and omap2/3/4:

Tested-by: Tony Lindgren <tony@atomide.com>
