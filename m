From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Aug 2014 09:48:12 +0100
Subject: [PATCH] arm: irq: fix the affinity when migrate a irq
In-Reply-To: <1408087917-22603-1-git-send-email-zhangwm@marvell.com>
References: <1408087917-22603-1-git-send-email-zhangwm@marvell.com>
Message-ID: <20140815084812.GU30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 15, 2014 at 03:31:57PM +0800, Neil Zhang wrote:
> Commit ffde1de64012 ("irqchip: Gic: Support forced affinity setting")
> has enable the forcing cpu affinity of interrupts for gic.
> 
> The current code of migrate_one_irq will pass the current affinity mask
> to irq_set_affinity with force is true, it may select the cpu being
> offlined as the target CPU again, then the interrupt won't be migrated
> correctly.

NAK.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
