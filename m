From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 13 Feb 2017 09:14:47 +0100
Subject: [PATCH 4/8] drm/sun4i: Add optional 'mode' property to TCON
In-Reply-To: <20170211174405.28395-5-plaes@plaes.org>
References: <20170211174405.28395-1-plaes@plaes.org>
 <20170211174405.28395-5-plaes@plaes.org>
Message-ID: <20170213081447.r2jhkcx3ex5tsspi@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Feb 11, 2017 at 07:44:01PM +0200, Priit Laes wrote:
> Add variable to enable either 'rgb' or 'lvds' output.
> 
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> index b82c004..c367ede 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> @@ -43,6 +43,9 @@ Required properties:
>   - reset-names: the reset names mentioned above
>   - clock-output-names: Name of the pixel clock created
>  
> +- mode: Defines which encoder will be enabled. Values are 'rgb', 'lvds'.
> +  Defaults to 'rgb' if not set.
> +

Unfortunately, this won't really work. You could very well have two
panels and switch from one to another by changing the pin muxing, so
we have to use an enpoint for that.

This is pretty much the same case that we have with the A10s where we
need to have two output endpoints for the TV Encoder and HDMI,
something we cannot support right now in our binding, since we assume
that we have the two channels that only have one user, which turned
out to be wrong.

I guess an easy way would be to have an extra property defining which
channel the endpoint is attached to.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170213/232111eb/attachment.sig>
