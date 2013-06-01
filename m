From: olof@lixom.net (Olof Johansson)
Date: Fri, 31 May 2013 23:47:02 -0700
Subject: [PATCH] ARM: nomadik: fix clocksource warning
In-Reply-To: <41518453.ApMFpK6n11@wuerfel>
References: <41518453.ApMFpK6n11@wuerfel>
Message-ID: <20130601064702.GB9010@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 05:49:28PM +0200, Arnd Bergmann wrote:
> The clocksource API has changed slightly, which causes a harmless
> warning:
> 
> /git/arm-soc/drivers/clocksource/nomadik-mtu.c:259:28: warning: 'nmdk_timer_match' defined but not used [-Wunused-variable]
>  static struct of_device_id nmdk_timer_match[] __initconst = {
>                             ^
> 
> Fortunately, the same API change also lets us simplify the code
> while removing the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> ---
> 
> I've applied this patch on top of next/dt to remove the warning introduced
> by Linus' patch.

I didn't see that make it to the repo though?

Since you'd have to rebase anyway, I'll just apply it here and will
include it with the other branch updates.


-Olof
