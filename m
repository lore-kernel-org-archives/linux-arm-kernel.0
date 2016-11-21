From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 21 Nov 2016 17:01:49 +0100
Subject: [RFC PATCH net v2 2/3] dt: bindings: add ethernet phy
 eee-disable-advert option documentation
In-Reply-To: <1479742524-30222-3-git-send-email-jbrunet@baylibre.com>
References: <1479742524-30222-1-git-send-email-jbrunet@baylibre.com>
 <1479742524-30222-3-git-send-email-jbrunet@baylibre.com>
Message-ID: <20161121160149.GF1922@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 04:35:23PM +0100, Jerome Brunet wrote:
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  Documentation/devicetree/bindings/net/phy.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/phy.txt b/Documentation/devicetree/bindings/net/phy.txt
> index bc1c3c8bf8fa..7f066b7c1e2c 100644
> --- a/Documentation/devicetree/bindings/net/phy.txt
> +++ b/Documentation/devicetree/bindings/net/phy.txt
> @@ -35,6 +35,11 @@ Optional Properties:
>  - broken-turn-around: If set, indicates the PHY device does not correctly
>    release the turn around line low at the end of a MDIO transaction.
>  
> +- eee-advert-disable: Bits to clear in the MDIO_AN_EEE_ADV register to
> +  disable EEE modes. Example
> +    * 0x4: disable EEE for 1000T,
> +    * 0x6: disable EEE for 100TX and 1000T
> +

Hi Jerome

I like the direction this patchset is taking. But hex values are
pretty unfriendly. Please add a set of boolean properties, and do the
mapping to hex in the C code.

That would also make extending this API easier. e.g. say you have a
10Gbps PHY with EEE, and you need to disable it. This hex value
quickly gets ugly, eee-advert-disable-10000 is nice and simple.

	Andrew
