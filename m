From: robh@kernel.org (Rob Herring)
Date: Fri, 13 Apr 2018 12:46:48 -0500
Subject: [PATCH 2/5] dt-bindings: display: atmel: add optional
 output-mode property
In-Reply-To: <20180409105918.20792-3-peda@axentia.se>
References: <20180409105918.20792-1-peda@axentia.se>
 <20180409105918.20792-3-peda@axentia.se>
Message-ID: <20180413174648.zxljbw634o2r4zty@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 09, 2018 at 12:59:15PM +0200, Peter Rosin wrote:
> Useful for beating cases where an output mode selection heuristic
> fails.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> index 82f2acb3d374..dc478455b883 100644
> --- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> +++ b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> @@ -10,6 +10,10 @@ Required properties:
>   - #address-cells: should be set to 1.
>   - #size-cells: should be set to 0.
>  
> +Optional properties:
> + - output-mode: override any output mode selection hueristic and force a
> +   particular output mode. One of "rgb444", "rgb565", "rgb666" and "rgb888".
> +

This needs to be generic, not just added to some random display 
controller binding.

It also belongs in the port or endpoint node as is done for camera 
interfaces.

Rob
