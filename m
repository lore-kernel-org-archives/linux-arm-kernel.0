From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 30 Aug 2017 17:19:42 +0200
Subject: [net-next PATCHv6 1/2] dt-bindings: net: Add DT bindings for
 Socionext Netsec
In-Reply-To: <1504088752-6204-1-git-send-email-jaswinder.singh@linaro.org>
References: <1504088657-6102-1-git-send-email-jaswinder.singh@linaro.org>
 <1504088752-6204-1-git-send-email-jaswinder.singh@linaro.org>
Message-ID: <20170830151942.GB22289@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 30, 2017 at 03:55:52PM +0530, Jassi Brar wrote:
> This patch adds documentation for Device-Tree bindings for the
> Socionext NetSec Controller driver.
> 
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
>  .../devicetree/bindings/net/socionext-netsec.txt   | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/socionext-netsec.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/socionext-netsec.txt b/Documentation/devicetree/bindings/net/socionext-netsec.txt
> new file mode 100644
> index 0000000..12d596c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/socionext-netsec.txt
> @@ -0,0 +1,46 @@
> +* Socionext NetSec Ethernet Controller IP
> +
> +Required properties:
> +- compatible: Should be "socionext,netsecv5"
> +- reg: Address and length of the register sets, the first is the main
> +	registers, then the rdlar and tdlar regions for the SoC
> +- interrupts: Should contain ethernet controller interrupt
> +- clocks: phandle to any clocks to be switched by runtime_pm
> +- phy-mode: See ethernet.txt file in the same directory

> +- max-speed: See ethernet.txt file in the same directory
> +- max-frame-size: See ethernet.txt file in the same directory, if 9000 or
> +	above jumbo frames are enabled
> +- local-mac-address: See ethernet.txt file in the same directory

These three are required, not optimal?

> +- phy-handle: phandle to select child phy
> +
> +Optional properties:
> +- use-jumbo: Boolean property to suggest if jumbo packets should be used or not
> +
> +For the child phy
> +
> +- compatible "ethernet-phy-ieee802.3-c22" is needed

This is normally considered optional. Why require it?

     Andrew
