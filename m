From: davem@davemloft.net (David Miller)
Date: Mon, 08 Jan 2018 14:30:46 -0500 (EST)
Subject: [PATCH] mdio-sun4i: Fix a memory leak
In-Reply-To: <20180106080009.5325-1-christophe.jaillet@wanadoo.fr>
References: <20180106080009.5325-1-christophe.jaillet@wanadoo.fr>
Message-ID: <20180108.143046.2103730003500033321.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sat,  6 Jan 2018 09:00:09 +0100

> If the probing of the regulator is deferred, the memory allocated by
> 'mdiobus_alloc_size()' will be leaking.
> It should be freed before the next call to 'sun4i_mdio_probe()' which will
> reallocate it.
> 
> Fixes: 4bdcb1dd9feb ("net: Add MDIO bus driver for the Allwinner EMAC")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied, thank you.
