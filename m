From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Mar 2013 16:31:06 +0000
Subject: [PATCH 4/9] mfd: max8925: fix trivial build warning for non-dt
In-Reply-To: <1360880818-4071454-5-git-send-email-arnd@arndb.de>
References: <1360880818-4071454-1-git-send-email-arnd@arndb.de>
 <1360880818-4071454-5-git-send-email-arnd@arndb.de>
Message-ID: <201303111631.06866.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 February 2013, Arnd Bergmann wrote:
> Patch fe527ea5a "mfd: max8925: Support dt for backlight"
> added a new function for DT probing but introduced a
> build warning for the case where CONFIG_OF is disabled:
> 
> drivers/video/backlight/max8925_bl.c: In function 'max8925_backlight_probe':
> drivers/video/backlight/max8925_bl.c:177:3: warning: statement with no effect [-Wunused-value]
> 
> A much nicer fix is to use the IS_ENABLED keyword to
> have the same effect of dropping the device tree specific
> function when it's not needed.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Qing Xu <qingx@marvell.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>

Hmm, it seems I already had this patch for the issue, but for some reason it
didn't apply for some time and when I looked at the problem again now, I found
more issues, and I'd suggest reverting commit fe527ea5a completely. There are
similar problems in the max8925_power patch.

	Arnd
