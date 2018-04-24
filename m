From: robh@kernel.org (Rob Herring)
Date: Tue, 24 Apr 2018 11:42:07 -0500
Subject: [PATCH 4/6] drm/panel: simple: Add support for Banana Pi 7"
 S070WV20-CT16 panel
In-Reply-To: <20180419093225.614-5-wens@csie.org>
References: <20180419093225.614-1-wens@csie.org>
 <20180419093225.614-5-wens@csie.org>
Message-ID: <20180424164207.ay4ai6lbspgv6anw@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2018 at 05:32:23PM +0800, Chen-Yu Tsai wrote:
> This panel is marketed as Banana Pi 7" LCD display. On the back is
> a sticker denoting the model name S070WV20-CT16.
> 
> This is a 7" 800x480 panel connected through a 24-bit RGB interface.
> However the panel only does 262k colors.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../display/panel/bananapi,s070wv20-ct16.txt  |  7 ++++++
>  drivers/gpu/drm/panel/panel-simple.c          | 25 +++++++++++++++++++
>  2 files changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> new file mode 100644
> index 000000000000..2ec35ce36e9a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> @@ -0,0 +1,7 @@
> +Banana Pi 7" (S070WV20-CT16) TFT LCD Panel
> +
> +Required properties:
> +- compatible: should be "bananapi,s070wv20-ct16"
> +
> +This binding is compatible with the simple-panel binding, which is specified
> +in simple-panel.txt in this directory.

Does this panel have a power supply (or more than 1) or backlight? I 
can't know that by just refering to simple-panel.txt.
