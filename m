From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 5 Apr 2014 12:27:00 +0100
Subject: L2 cache suspend/resume
Message-ID: <20140405112700.GJ7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While looking through the L2 resume code paths, I notice that:

 * exynos
 * imx
 * tegra

all resume their L2 caches from assembly code, rather than using
outer_disable() before cpu_suspend(), and outer_resume() afterwards.
>From what I can see, these are all running in the secure world, so that
isn't the reason.

What is the reason for this difference?  Can these three be converted to
the outer_disable()...outer_resume() method?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
