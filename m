From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Nov 2016 12:09:41 +0100
Subject: [PATCH 7/10] mmc: sdhci-xenon: Add support to PHYs of Marvell
 Xenon SDHC
In-Reply-To: <f7334e41-39dd-f868-ff10-199afaebe926@marvell.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <2204525.IWIYQVjIXl@wuerfel>
 <f7334e41-39dd-f868-ff10-199afaebe926@marvell.com>
Message-ID: <23084629.DpfWxNEgoY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, November 24, 2016 6:57:18 PM CET Ziji Hu wrote:
> > 
> > Please explain in the changelog why this is not a generic
> > phy driver (or three of them).
> > 
>         Actually we tried to put the PHY code into Linux PHY framework.
>         But it cannot fit in Linux common PHY framework.
> 
>         Our Xenon SDHC PHY register is a part of Xenon SDHC register set.
>         Besides, during MMC initialization, MMC sequence has to call several PHY functions to complete timing setting.
>         In those PHY setting functions, they have to access SDHC register and know current MMC setting, such as bus width, clock frequency and speed mode.
>         As a result, we have to implement PHY under MMC directory.
> 

Ok, that makes sense, just put the same text in the changelog comment.

	Arnd
