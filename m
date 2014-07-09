From: davem@davemloft.net (David Miller)
Date: Tue, 08 Jul 2014 20:02:10 -0700 (PDT)
Subject: [PATCH] net: mvneta: fix operation in 10 Mbit/s mode
In-Reply-To: <1404809383-5597-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404809383-5597-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140708.200210.1665388475429292104.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Tue,  8 Jul 2014 10:49:43 +0200

> As reported by Maggie Mae Roxas, the mvneta driver doesn't behave
> properly in 10 Mbit/s mode. This is due to a misconfiguration of the
> MVNETA_GMAC_AUTONEG_CONFIG register: bit MVNETA_GMAC_CONFIG_MII_SPEED
> must be set for a 100 Mbit/s speed, but cleared for a 10 Mbit/s speed,
> which the driver was not properly doing. This commit adjusts that by
> setting the MVNETA_GMAC_CONFIG_MII_SPEED bit only in 100 Mbit/s mode,
> and relying on the fact that all the speed related bits of this
> register are cleared at the beginning of the mvneta_adjust_link()
> function.
> 
> This problem exists since c5aff18204da0 ("net: mvneta: driver for
> Marvell Armada 370/XP network unit") which is the commit that
> introduced the mvneta driver in the kernel.
> 
> Cc: <stable@vger.kernel.org> # v3.8+
> Fixes: c5aff18204da0 ("net: mvneta: driver for Marvell Armada 370/XP network unit")
> Reported-by: Maggie Mae Roxas <maggie.mae.roxas@gmail.com>
> Cc: Maggie Mae Roxas <maggie.mae.roxas@gmail.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied and queued up for -stable, thanks.
