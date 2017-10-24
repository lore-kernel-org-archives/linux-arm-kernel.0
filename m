From: robh@kernel.org (Rob Herring)
Date: Tue, 24 Oct 2017 13:46:54 -0500
Subject: [PATCH v7 10/10] of: mdio: Prevent of_mdiobus_register from
 scanning mdio-mux nodes
In-Reply-To: <20171018114458.17891-11-clabbe.montjoie@gmail.com>
References: <20171018114458.17891-1-clabbe.montjoie@gmail.com>
 <20171018114458.17891-11-clabbe.montjoie@gmail.com>
Message-ID: <20171024184654.ggfrsrjd3nobku5n@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 18, 2017 at 01:44:58PM +0200, Corentin Labbe wrote:
> Each child node of an MDIO node is scanned as a PHY when calling
> of_mdiobus_register() givint the following result:
> [   18.175379] mdio_bus stmmac-0: /soc/ethernet at 1c30000/mdio/mdio-mux has invalid PHY address
> [   18.175408] mdio_bus stmmac-0: scan phy mdio-mux at address 0
> [   18.175450] mdio_bus stmmac-0: scan phy mdio-mux at address 1
> [...]
> [   18.176420] mdio_bus stmmac-0: scan phy mdio-mux at address 30
> [   18.176452] mdio_bus stmmac-0: scan phy mdio-mux at address 31
> 
> Since mdio-mux nodes are not PHY, this patch a way to to not scan
> them.

This can be dropped now, right?
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  drivers/of/of_mdio.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
