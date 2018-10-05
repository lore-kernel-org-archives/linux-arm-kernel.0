From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Oct 2018 10:46:19 +0100
Subject: [PATCH 5/5] ARM: spectre-v2: per-CPU vtables to work around
 big.Little systems
In-Reply-To: <20181005090941eucas1p14031cd38d78e9d561975925bf977727d~aq0-OFZeE1866318663eucas1p1b@eucas1p1.samsung.com>
References: <20180919094802.GH30658@n2100.armlinux.org.uk>
 <CGME20180919095028epcas3p3e1a927bb7e88c6891d43abfdc51603e7@epcas3p3.samsung.com>
 <E1g2Z6e-0003es-CI@rmk-PC.armlinux.org.uk>
 <20181005090941eucas1p14031cd38d78e9d561975925bf977727d~aq0-OFZeE1866318663eucas1p1b@eucas1p1.samsung.com>
Message-ID: <20181005094618.GG30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 05, 2018 at 11:09:40AM +0200, Marek Szyprowski wrote:
> This patch causes lots of kernel 'BUG' messages on all Samsung Exynos
> boards.? It started to appear since it has been merged to linux-next
> on 20181002.? I wonder if this issue is Exynos specific or there are
> some patches missing in linux-next, which should fix those 'BUGS'.
> If this is Exynos specific, please let us know what should be changed
> in Exynos platform code to avoid this issue.

Thanks for the report.

It looks like my solution for big.Little isn't possible... back to
the drawing board, and big.Little will have to remain vulnerable to
Spectre for another release cycle.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
