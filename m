From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 13 Mar 2013 15:05:16 +0530
Subject: [patch 0/7] tick: Optimize broadcast handling and prevent expiry
 ping pong
In-Reply-To: <20130306111351.883117670@linutronix.de>
References: <20130306111351.883117670@linutronix.de>
Message-ID: <51404854.8030303@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Wednesday 06 March 2013 04:48 PM, Thomas Gleixner wrote:
> Jason decoded a problem related to the broadcast timer mode. The
> reprogramming of the cpu local timer causes a huge number of
> retries. Also there is a situation where the CPU which does not handle
> the broadcast timer interrupt exits and reenters broadcast mode before
> the broadcast interrupt got handled by another CPU. This can lead to
> an interesting ping pong of the broadcast and the cpu local timer
> code.
> 
> This series addresses these problems. The first two patches convert
> the broadcast code to proper cpumask_var_t instead of adding more
> bitmaps later.
> 
> The rest of the series is adopted from the quick patches which I
> posted earlier while discussing the issue with Jason et. al.
> 
> Please give it a proper testing on your affected hardware.
> 
I have tested this revised patches on OMAP4 and OMAP5 platforms
with CPUidle enabled against 3.9-rc2. As expected they seems to
work without any issue and also fixes the reported retry issue.

Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
