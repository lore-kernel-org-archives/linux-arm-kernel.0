From: cjb@laptop.org (Chris Ball)
Date: Tue, 26 Nov 2013 18:34:42 -0500
Subject: [PATCH 3/8] mmc: omap: Fix I2C dependency and make driver usable
 with device tree
In-Reply-To: <20131114172527.GD10317@atomide.com> (Tony Lindgren's message of
 "Thu, 14 Nov 2013 09:25:27 -0800")
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
 <1384396537-3486-4-git-send-email-tony@atomide.com>
 <20131114110533.GD16396@e106331-lin.cambridge.arm.com>
 <20131114172527.GD10317@atomide.com>
Message-ID: <87eh62enzh.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Thu, Nov 14 2013, Tony Lindgren wrote:
> Some features can be configured by the companion I2C chips,
> which may not be available at the probe time. Fix the issue
> by returning -EPROBE_DEFER when the MMC controller slots
> are not configured.
>
> While at it, let's also add minimal device tree support so
> omap24xx platforms can use this driver without legacy mode
> since we claim to support device tree for mach-omap2 based
> systems.
>
> Although adding the minimal device tree support is not strictly
> a fix, it does remove one of the last blockers for dropping a
> bunch of legacy platform data for mach-omap2.
>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: linux-mmc at vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Feel free to merge via your tree:

Acked-by: Chris Ball <cjb@laptop.org>

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
