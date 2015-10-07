From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 7 Oct 2015 13:01:12 +0200
Subject: [PATCH] watchdog: at91sam9: keep watchdog running in idle mode
In-Reply-To: <1444163325-3041-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1444163325-3041-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <20151007110112.GD3485@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain,

On 06/10/2015 at 22:28:45 +0200, Sylvain Rochet wrote :
> Since turning on idle-halt in commit 5161b31dc39a (watchdog:
> at91sam9_wdt: better watchdog support"), SoCs compatible with
> at91sam9260-wdt not using a device tree no longer reboot if the watchdog
> times out while the CPU is in idle state. Removing the
> AT91_WDT_WDIDLEHLT flag that was set by default fixes this.
> 
> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
> Fixes: 5161b31dc39a ("watchdog: at91sam9_wdt: better watchdog support")
> Cc: <stable@vger.kernel.org> # 3.14+

Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

However, we don't really care about that for kernels after 3.18 as no
users are using pdata anymore.
I think you could send a follow-up patch removing pdata support
completely.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
