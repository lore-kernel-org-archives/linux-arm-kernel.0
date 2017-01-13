From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Jan 2017 15:52:29 +0000
Subject: [PATCH 3/3] rtc: stm32: use 32-bit cast for BIT() macro
In-Reply-To: <20170113153311.2611510-3-arnd@arndb.de>
References: <20170113153311.2611510-1-arnd@arndb.de>
 <20170113153311.2611510-3-arnd@arndb.de>
Message-ID: <20170113155229.GS14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 04:32:53PM +0100, Arnd Bergmann wrote:
> -#define PWR_CR_DBP			BIT(8)
> +#define PWR_CR_DBP			(u32)BIT(8)

Shouldn't that have parens around it as it's no longer a simple expression.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
