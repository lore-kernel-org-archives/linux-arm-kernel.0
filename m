From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Sep 2011 09:20:24 +0100
Subject: [PATCH] arm: sched_clock: Enable HAVE_SCHED_CLOCK support
	without init_sched_clock
In-Reply-To: <20110915073511.GA31732@july>
References: <20110915073511.GA31732@july>
Message-ID: <20110915082024.GF6267@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2011 at 04:35:12PM +0900, Kyungmin Park wrote:
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> On Samsung Exynos4 series, EVT0 chip uses the s5p_timer with HAVE_SCHED_CLOCK and remains use the MCT timer without init_sched_clock.

So in other words, sched_clock on exynos4 is broken because the update
function won't be called, and it'll wrap well below the 64-bit ns range
required of it.

NAK.
