From: davem@davemloft.net (David Miller)
Date: Mon, 12 Oct 2015 05:41:38 -0700 (PDT)
Subject: [PATCH] net: HNS: fix MDIO dependencies
In-Reply-To: <8114651.XErShuFr2W@wuerfel>
References: <8114651.XErShuFr2W@wuerfel>
Message-ID: <20151012.054138.644534181826942617.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 09 Oct 2015 14:53:54 +0200

> The newly introduced HNS_MDIO Kconfig symbol selects 'MDIO', but
> that is the wrong symbol as the code used by this driver is
> provided by PHYLIB rather than the MDIO driver. Also, there is
> no need to make this driver user selectable, because it is already
> selected by all drivers that need it.
> 
> This changes the Kconfig file to select the correct library, and
> to make the option silent.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 5b904d39406 ("net: add Hisilicon Network Subsystem MDIO support")

Applied, thanks.
