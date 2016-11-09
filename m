From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 9 Nov 2016 15:34:25 +0100
Subject: [PATCH 1/6] dt-bindings: mdio-mux: Add documentation for mdio
 mux for NSP SoC
In-Reply-To: <1478683994-12008-2-git-send-email-yendapally.reddy@broadcom.com>
References: <1478683994-12008-1-git-send-email-yendapally.reddy@broadcom.com>
 <1478683994-12008-2-git-send-email-yendapally.reddy@broadcom.com>
Message-ID: <20161109143425.GE15386@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2016 at 04:33:09AM -0500, Yendapally Reddy Dhananjaya Reddy wrote:
> Add documentation for mdio mux available in Broadcom NSP SoC
> 
> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
> ---
>  .../devicetree/bindings/net/brcm,mdio-mux-nsp.txt  | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/brcm,mdio-mux-nsp.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/brcm,mdio-mux-nsp.txt b/Documentation/devicetree/bindings/net/brcm,mdio-mux-nsp.txt
> new file mode 100644
> index 0000000..b749a2b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/brcm,mdio-mux-nsp.txt
> @@ -0,0 +1,57 @@
> +Properties for an MDIO bus multiplexer available in Broadcom NSP SoC.
> +
> +This MDIO bus multiplexer defines buses that could access the internal
> +phys as well as external to SoCs. When child bus is selected, one needs

Hi Yendapally

Since we are in the networking subsystem, when we see phy, we think
Ethernet PHY. But broadcom mdio mux is generic and can have any sort
of PHY or device connected to it. To avoid confusion and
missunderstanding, please could you try to prefix each 'PHY' in the
with an indication of what type it is, 'Ethernet PHY', 'USB phy',
'SERDES PHY', or 'generic PHY/mdio device'.

And i mean this in general, not just this patch.

Thanks
	Andrew
