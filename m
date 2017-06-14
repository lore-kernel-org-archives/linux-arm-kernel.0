From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 14 Jun 2017 18:35:37 +0200
Subject: [PATCH v4 10/11] dt-bindings: orion-mdio: document the new xmdio
 compatible
In-Reply-To: <20170614154911.14510-11-antoine.tenart@free-electrons.com>
References: <20170614154911.14510-1-antoine.tenart@free-electrons.com>
 <20170614154911.14510-11-antoine.tenart@free-electrons.com>
Message-ID: <20170614163537.GO15847@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 14, 2017 at 05:49:10PM +0200, Antoine Tenart wrote:
> A new compatible for Marvell xMDIO interfaces was added into the Marvell
> MDIO driver. Document this new compatible.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/net/marvell-orion-mdio.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/marvell-orion-mdio.txt b/Documentation/devicetree/bindings/net/marvell-orion-mdio.txt
> index ccdabdcc8618..b93a5b5a0472 100644
> --- a/Documentation/devicetree/bindings/net/marvell-orion-mdio.txt
> +++ b/Documentation/devicetree/bindings/net/marvell-orion-mdio.txt
> @@ -1,12 +1,12 @@
>  * Marvell MDIO Ethernet Controller interface
>  
>  The Ethernet controllers of the Marvel Kirkwood, Dove, Orion5x,
> -MV78xx0, Armada 370 and Armada XP have an identical unit that provides
> -an interface with the MDIO bus. This driver handles this MDIO
> -interface.
> +MV78xx0, Armada 370, Armada XP, Armada 7k and Armada 8k have an
> +identical unit that provides an interface with the MDIO bus or
> +with the xMDIO bus. This driver handles these interfaces.

Hi Antoine

This patches is looking good now. One nit. The description above
suggests Kirkwood, Dove, Orion5x, MV78xx0, Armada 370 and Armada XP
all have xmdio. Maybe better wording would be:

The Ethernet controllers of the Marvel Kirkwood, Dove, Orion5x,
MV78xx0, Armada 370, Armada XP, Armada 7k and Armada 8k have an
identical unit that provides an interface with the MDIO bus.
Additionally, Armada 7k and Armada 8k has a second unit which
provides an interface with the xMDIO bus. This driver handles
these interfaces.

      Andrew
