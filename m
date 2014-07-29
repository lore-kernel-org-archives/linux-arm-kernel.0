From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Jul 2014 22:42:51 +0200
Subject: [PATCH 0/5] Add eMMC and SD card support for rk3288-evb
In-Reply-To: <1406665916-23396-1-git-send-email-dianders@chromium.org>
References: <1406665916-23396-1-git-send-email-dianders@chromium.org>
Message-ID: <2167758.ZBctteP0VZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 July 2014 13:31:51 Doug Anderson wrote:
> This series adds basic eMMC and SD card support for the rk3288-evb
> board based on Addy's posted dw_mmc patch from:
>   https://patchwork.kernel.org/patch/4520631/
> 
> The series is a little tricky because:
> * Addy's patch has a bug w/ DDR50 (see my response there), so I've
>   posted the original support without DDR50 and then a fix (that could
>   be squashed) enabling DDR50.
> * Jaehoon has some outstanding patches to remove the slot node.  Since
>   those haven't landed yet, I've posted my original patch with the
>   slot node and then some future patches that can land with Jaehoon's
>   patches.
> 
> Note that we don't have regulators specified yet (no regulator driver
> for rk808-based board).  We also don't yet support UHS modes (which
> require regulator support plus dw_mmc driver support for tuning).
> Those features can come later.

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

I wonder whether something can be done to generalize the tuning
support. Is this just about the clock phase, or something else?

	Arnd
