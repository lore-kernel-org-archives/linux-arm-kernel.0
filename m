From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 7 Feb 2013 13:21:46 +0800
Subject: [PATCH v2] ARM: mxs: Select ARM_CPU_SUSPEND
In-Reply-To: <1360201645-2456-1-git-send-email-festevam@gmail.com>
References: <1360201645-2456-1-git-send-email-festevam@gmail.com>
Message-ID: <20130207052145.GC7697@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 06, 2013 at 11:47:25PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Select ARM_CPU_SUSPEND so that suspend/resume can be tested on mxs platforms.
> 
> Tested on a mx28evk board:
> 
> $ echo enabled > /sys/devices/80000000.apb/80040000.apbx/80074000.serial/tty/ttyAMA0/power/wakeup
> $ echo mem > /sys/power/state
> [  507.040000] PM: Syncing filesystems ... done.
> [  507.060000] mmc0: card e624 removed
> [  507.160000] Freezing user space processes ... (elapsed 0.01 seconds) done.
> [  507.180000] Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
> [  507.200000] Suspending console(s) (use no_console_suspend to debug)
> 
> (Then send any character via DUART to wakeup the system).
> 
> [  507.220000] PM: suspend of devices complete after 10.468 msecs
> [  507.220000] PM: late suspend of devices complete after 3.531 msecs
> [  507.230000] PM: noirq suspend of devices complete after 5.187 msecs
> [  507.230000] PM: noirq resume of devices complete after 2.312 msecs
> [  507.230000] PM: early resume of devices complete after 2.437 msecs
> [  507.320000] PM: resume of devices complete after 81.312 msecs
> [  507.360000] Restarting tasks ... done.
> [  507.530000] mmc0: new SDHC card at address e624
> [  507.550000] mmcblk0: mmc0:e624 SU04G 3.69 GiB
> [  507.560000]  mmcblk0: p1 p2 p3
> [  509.240000] libphy: 800f0000.etherne:01 - Link is Down
> [  511.240000] libphy: 800f0000.etherne:01 - Link is Up
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

It's late for 3.9, so queued it for 3.10.

Shawn
