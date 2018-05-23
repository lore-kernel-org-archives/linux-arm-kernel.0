From: robh@kernel.org (Rob Herring)
Date: Wed, 23 May 2018 11:37:21 -0500
Subject: [PATCH 2/6] dt-bindings: media: rcar-vin: Document data-active
In-Reply-To: <1526488352-898-3-git-send-email-jacopo+renesas@jmondi.org>
References: <1526488352-898-1-git-send-email-jacopo+renesas@jmondi.org>
 <1526488352-898-3-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <20180523163721.GB16505@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2018 at 06:32:28PM +0200, Jacopo Mondi wrote:
> Document 'data-active' property in R-Car VIN device tree bindings.
> The property is optional when running with explicit synchronization
> (eg. BT.601) but mandatory when embedded synchronization is in use (eg.
> BT.656) as specified by the hardware manual.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  Documentation/devicetree/bindings/media/rcar_vin.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/rcar_vin.txt b/Documentation/devicetree/bindings/media/rcar_vin.txt
> index c53ce4e..17eac8a 100644
> --- a/Documentation/devicetree/bindings/media/rcar_vin.txt
> +++ b/Documentation/devicetree/bindings/media/rcar_vin.txt
> @@ -63,6 +63,11 @@ from local SoC CSI-2 receivers (port1) depending on SoC.
>  	If both HSYNC and VSYNC polarities are not specified, embedded
>  	synchronization is selected.
> 
> +        - data-active: active state of data enable signal (CLOCKENB pin).
> +          0/1 for LOW/HIGH respectively. If not specified, use HSYNC as
> +          data enable signal. When using embedded synchronization this
> +          property is mandatory.

This doesn't match the common property's definition which AIUI is for 
the data lines' polarity. You need a new property. Perhaps a common one.

> +
>      - port 1 - sub-nodes describing one or more endpoints connected to
>        the VIN from local SoC CSI-2 receivers. The endpoint numbers must
>        use the following schema.
> --
> 2.7.4
> 
