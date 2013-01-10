From: florian@openwrt.org (Florian Fainelli)
Date: Thu, 10 Jan 2013 15:40:36 +0100
Subject: [PATCH 2/2] Fix phy_attach - forward dev_flags for phy_attach
In-Reply-To: <1357819234-27752-3-git-send-email-konszert@marvell.com>
References: <1357819234-27752-1-git-send-email-konszert@marvell.com>
 <1357819234-27752-3-git-send-email-konszert@marvell.com>
Message-ID: <50EED2E4.80008@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 01/10/13 13:00, Kosta Zertsekel a ?crit :
> Change-Id: Ie3191f95c36eada6d0c673460de5393641128182
> ---
>   drivers/net/ethernet/marvell/pxa168_eth.c | 2 +-
>   net/dsa/slave.c                           | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

I think that you should have actually two patches, one for pxa168_eth 
and one for net/dsa/slave.c.

Also, please prefix your patches with what was usually used on these 
files before: "pxa168_eth:" and "net: dsa:" respectively.

By the way, most, if not all of the phy_connect() users in 
drivers/net/ethernet/ also do not ensure they pass the phy device flags, 
so you might want to fix this globally and not just for Marvell driver.

Thanks.
--
Florian
