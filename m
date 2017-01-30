From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jan 2017 13:53:48 +0000
Subject: [PATCH] ARM: Kconfig: select GENERIC_CLOCKEVENTS_BROADCAST also
 on UP
In-Reply-To: <20170120163230.9357-1-l.stach@pengutronix.de>
References: <20170120163230.9357-1-l.stach@pengutronix.de>
Message-ID: <20170130135348.GS27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 05:32:30PM +0100, Lucas Stach wrote:
> Quite a few systems have deeper idle states where the local timer tick
> stops to fire, that rely on the GENERIC_CLOCKEVENTS_BROADCAST
> infrastructure to switch to a global (non-stopping) clockevent device.
> This is also true on UP systems, so select GENERIC_CLOCKEVENTS_BROADCAST
> unconditionally.
> 
> Instead only select ARCH_HAS_TICK_BROADCAST if SMP is present, as this
> is only implemented for SMP systems.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> v2: Only select GENERIC_CLOCKEVENTS_BROADCAST if the architecture
>     supports GENERIC_CLOCKEVENTS.

Provided this solves the problems identified by the 0-day builder with
your previous patch, please submit it to the patch system, thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
