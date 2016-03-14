From: davem@davemloft.net (David Miller)
Date: Sun, 13 Mar 2016 22:20:11 -0400 (EDT)
Subject: [PATCH] net: macb: fix default configuration for GMAC on AT91
In-Reply-To: <1457624672-30666-1-git-send-email-nicolas.ferre@atmel.com>
References: <1457624672-30666-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20160313.222011.1724698990540701829.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Thu, 10 Mar 2016 16:44:32 +0100

> On AT91 SoCs, the User Register (USRIO) exposes a switch to configure the
> "Reduced" or "Traditional" version of the Media Independent Interface
> (RMII vs. MII or RGMII vs. GMII).
> As on the older EMAC version, on GMAC, this switch is set by default to the
> non-reduced type of interface, so use the existing capability and extend it to
> GMII as well. We then keep the current logic in the macb_init() function.
> 
> The capabilities of sama5d2, sama5d4 and sama5d3 GEM interface are updated in
> the macb_config structure to be able to properly enable them with a traditional
> interface (GMII or MII).
> 
> Reported-by: Romain HENRIET <romain.henriet@l-acoustics.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Applied.
