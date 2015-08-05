From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 5 Aug 2015 21:01:16 +0800
Subject: [PATCH v3 1/2] watchdog: imx2_wdt: add external reset support
 via 'ext-reset-output' dt prop
In-Reply-To: <1438097230-2653-2-git-send-email-tharvey@gateworks.com>
References: <1433448960-9257-2-git-send-email-tharvey@gateworks.com>
 <1438097230-2653-1-git-send-email-tharvey@gateworks.com>
 <1438097230-2653-2-git-send-email-tharvey@gateworks.com>
Message-ID: <20150805130115.GM12927@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 08:27:09AM -0700, Tim Harvey wrote:
> The IMX6 watchdog supports assertion of a signal (WDOG_B) which
> can be pinmux'd to an external pin. This is typically used for boards that
> have PMIC's in control of the IMX6 power rails. In fact, failure to use
> such an external reset on boards with external PMIC's can result in various
> hangs due to the IMX6 not being fully reset [1] as well as the board failing
> to reset because its PMIC has not been reset to provide adequate voltage for
> the CPU when coming out of reset at 800Mhz.
> 
> This uses a new device-tree property 'ext-reset-output' to indicate the
> board has such a reset and to cause the watchdog to be configured to assert
> WDOG_B instead of an internal reset both on a watchdog timeout and in
> system_restart.
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/333689.html
> 
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>
