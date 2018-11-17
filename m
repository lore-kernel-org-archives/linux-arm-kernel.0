From: davem@davemloft.net (David Miller)
Date: Fri, 16 Nov 2018 19:23:59 -0800 (PST)
Subject: [PATCH net] net: mvneta: Don't advertise 2.5G modes
In-Reply-To: <20181109081733.24458-1-maxime.chevallier@bootlin.com>
References: <20181109081733.24458-1-maxime.chevallier@bootlin.com>
Message-ID: <20181116.192359.2155059571366826538.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Fri,  9 Nov 2018 09:17:33 +0100

> Using 2.5G speed relies on the SerDes lanes being configured
> accordingly. The lanes have to be reconfigured to switch between
> 1G and 2.5G, and for now only the bootloader does this configuration.
> 
> In the case we add a Comphy driver to handle switching the lanes
> dynamically, it's better for now to stick with supporting only 1G and
> add advertisement for 2.5G once we really are capable of handling both
> speeds without problem.
> 
> Since the interface mode is initialy taken from the DT, we want to make
> sure that adding comphy support won't break boards that don't update
> their dtb.
> 
> Fixes: da58a931f248 ("net: mvneta: Add support for 2500Mbps SGMII")
> Reported-by: Andrew Lunn <andrew@lunn.ch>
> Reported-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Applied.
