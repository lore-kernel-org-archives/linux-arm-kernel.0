From: robh@kernel.org (Rob Herring)
Date: Mon, 9 Apr 2018 13:37:13 -0500
Subject: [PATCH v2 4/5] drm: bridge: lvds-encoder: allow specifying the
 input bus format
In-Reply-To: <20180326212447.7380-5-peda@axentia.se>
References: <20180326212447.7380-1-peda@axentia.se>
 <20180326212447.7380-5-peda@axentia.se>
Message-ID: <20180409183713.xk7qt4mukb24vr64@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 26, 2018 at 11:24:46PM +0200, Peter Rosin wrote:
> If the bridge changes the bus format, allow this to be described in
> the bridge, instead of providing false information about the bus
> format of the connector or panel.

I guess this is dead, but I'll comment here anyway because this issue 
has come up several times and I think something is needed.

> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../bindings/display/bridge/lvds-transmitter.txt   |  6 ++++++
>  drivers/gpu/drm/bridge/lvds-encoder.c              | 25 ++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> index 50220190c203..8d40a2069252 100644
> --- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> @@ -30,6 +30,12 @@ Required properties:
>    device-specific version corresponding to the device first
>    followed by the generic version.
>  
> +Optional properties:
> +
> +- interface-pix-fmt:
> +  List of valid input bus formats of the encoder. Recognized bus formats
> +  are listed in ../bus-format.txt

We already have bus interface properties defined in 
media/video-interfaces.txt. It's the same problem though the bus/pixel 
formats are somewhat different. "bus-width" is probably enough to handle 
your particular case, but I'd imagine that could easily not be the case. 
If so, we should extend the existing binding rather than diverge with 
something new.

Rob
