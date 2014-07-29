From: davem@davemloft.net (David Miller)
Date: Tue, 29 Jul 2014 16:48:05 -0700 (PDT)
Subject: [PATCH 1/2] net: mvpp2: fix 10 Mbit/s usage
In-Reply-To: <1406496096-11039-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1406496096-11039-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140729.164805.1053373886252313798.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Sun, 27 Jul 2014 23:21:35 +0200

> This commit is similar to commit 4d12bc63ab5e ("net: mvneta: fix
> operation in 10 Mbit/s mode"), but this time for the mvpp2 driver. The
> driver was properly taking into account the 1 Gbit/s and 100 Mbit/s
> speeds, but not the 10 Mbit/s, which was handled as 100
> Mbit/s. However, the MVPP2_GMAC_CONFIG_MII_SPEED bit in the
> MVPP2_GMAC_AUTONEG_CONFIG register must remain cleared to allow 10
> Mbit/s operation. This commit therefore fixes 10 Mbit/s operation.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied.
