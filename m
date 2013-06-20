From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 21:46:26 +0200
Subject: [GIT PULL 7/7] omap mailbox move to drivers for v3.11 merge window
In-Reply-To: <0MFrZm-1V3qHW1bmA-00EJsa@mx.kundenserver.de>
References: <0MFrZm-1V3qHW1bmA-00EJsa@mx.kundenserver.de>
Message-ID: <201306202146.27093.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Tony Lindgren wrote:
> The following changes since commit 317ddd256b9c24b0d78fa8018f80f1e495481a10:
> 
>   Linux 3.10-rc5 (2013-06-08 17:41:04 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/mailbox-signed
> 
> for you to fetch changes up to d2e993289cc5f1780ce74188e3a8d2b404748397:
> 
>   Merge tag 'omap-mailbox-for-v3.11' of git://github.com/sumananna/mailbox into omap-for-v3.11/mailbox (2013-06-17 03:51:54 -0700)
> 
> ----------------------------------------------------------------
> 
> Move OMAP Mailbox framework to drivers via Suman Anna <s-anna@ti.com>
> 
> The OMAP Mailbox driver framework is moved out of arch/arm folder
> into drivers/mailbox folder, to re-enable building it and also serve
> as a baseline for adapting to the new mailbox driver framework. The
> changes mainly contain:
>   - a minor bug fix and cleanup of mach-specific mailbox code
>   - remove any header dependencies from plat-omap for multi-platform
>     support
>   - represent mailbox device data through platform data/hwmod attrs
>   - move the omap mailbox code out of plat-omap/mach-omapX to
>     drivers/mailbox folder
> 

I've pulled this into next/drivers as well, rather than a separate
branch that we had for 3.10 (and dropped). I am a bit puzzled about
this series though. Is it right that for 3.10 we had plans for a
generic subsystem, and now it's just the omap drivers?

	Arnd
