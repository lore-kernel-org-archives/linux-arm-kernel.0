From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Jan 2012 11:59:52 +0000
Subject: [RFC PATCH 1/5] arm:omap1/2/3/4:Convert 32k-Sync clocksource
 driver to platform_driver
In-Reply-To: <1326886086-27313-2-git-send-email-hvaibhav@ti.com>
References: <1326886086-27313-1-git-send-email-hvaibhav@ti.com>
 <1326886086-27313-2-git-send-email-hvaibhav@ti.com>
Message-ID: <20120118115952.GM16726@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 04:58:02PM +0530, Vaibhav Hiremath wrote:
> Convert counter_32k clocksource driver to standard platform_driver
> and move it drivers/clocksource/ directory.
> 
> Also, rename it to more generic name "omap-32k.c".

NAK.  sched_clock is supposed to be available early.  Platform device
driver initialization is FAR too late.

Note that some of the code you're moving has changed in current kernels.
