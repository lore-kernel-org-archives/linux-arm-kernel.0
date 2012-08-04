From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 4 Aug 2012 22:09:02 +0800
Subject: [PATCH V2] MXS: Remove MMAP_MIN_ADDR setting from mxs_defconfig
In-Reply-To: <1344020088-8156-1-git-send-email-marex@denx.de>
References: <1344020088-8156-1-git-send-email-marex@denx.de>
Message-ID: <20120804140859.GA3405@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Again, patch subject should be like "ARM: mxs: ...".

On Fri, Aug 03, 2012 at 08:54:48PM +0200, Marek Vasut wrote:
> The CONFIG_DEFAULT_MMAP_MIN_ADDR was set to 65536 in mxs_defconfig,
> this caused severe breakage of userland applications since the upper
> limit for ARM is 32768. By default CONFIG_DEFAULT_MMAP_MIN_ADDR is
> set to 4096 and can also be changed via /proc/sys/vm/mmap_min_addr
> if needed.
> 
> Quoting Russell King [1]:
> 
> "4096 is also fine for ARM too. There's not much point in having
> defconfigs change it - that would just be pure noise in the config
> files."
> 
> the CONFIG_DEFAULT_MMAP_MIN_ADDR can be removed from the defconfig
> altogether.
> 
> This problem was introduced by:
> 
> commit cde7c41feaa06cb6bfc748b2fc3c7d809091c2b0
> Author: Wolfram Sang <w.sang@pengutronix.de>
> Date:   Fri Apr 29 15:06:40 2011 +0200
> 
>     ARM: configs: add defconfig for mach-mxs
> 

We generally quote another commit in commit message like

cde7c41 (ARM: configs: add defconfig for mach-mxs)

> [1] http://marc.info/?l=linux-arm-kernel&m=134401593807820&w=2
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Wolfgang Denk <wd@denx.de>

We should Cc stable.

I just fixed them and queued the patch for 3.6-rc.

Regards,
Shawn
