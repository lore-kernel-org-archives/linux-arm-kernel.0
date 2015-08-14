From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Aug 2015 13:48:03 +0100
Subject: [PATCH] ARM: smp: Collapse arch_cpu_idle_dead() into cpu_die()
In-Reply-To: <1439539139-8783-1-git-send-email-sboyd@codeaurora.org>
References: <1439539139-8783-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150814124803.GV7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 12:58:59AM -0700, Stephen Boyd wrote:
> The only caller of cpu_die() on ARM is arch_cpu_idle_dead(), so
> let's simplify the code by renaming cpu_die() to
> arch_cpu_idle_dead(). While were here, drop the __ref annotation
> because __cpuinit is gone nowadays.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Ok.  Please put it in the patch system, thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
