From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 May 2017 13:48:25 +0100
Subject: [PATCH] mmc: sdhci-xenon: kill xenon_clean_phy()
In-Reply-To: <20170516122211.GA27959@lunn.ch>
References: <20170516061720.1755-1-jszhang@marvell.com>
 <20170516122211.GA27959@lunn.ch>
Message-ID: <20170516124825.GF22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 16, 2017 at 02:22:11PM +0200, Andrew Lunn wrote:
> If the memory has been allocated using the devm_ API, calling kfree
> here is wrong, and can lead to a double free.
> 
> So this patch should probably have a fixes: tag. Should it also goto
> stable?

No, sdhci-xenon has only hit mainline during the recent merge window,
so it's not in any kernel other than 4.12-rc1.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
