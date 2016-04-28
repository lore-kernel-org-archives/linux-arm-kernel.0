From: robh@kernel.org (Rob Herring)
Date: Wed, 27 Apr 2016 21:37:30 -0500
Subject: [PATCH v4 04/11] drm: sun4i: Add DT bindings documentation
In-Reply-To: <1461590572-4027-5-git-send-email-maxime.ripard@free-electrons.com>
References: <1461590572-4027-1-git-send-email-maxime.ripard@free-electrons.com>
 <1461590572-4027-5-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160428023730.GA1514@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 03:22:45PM +0200, Maxime Ripard wrote:
> The display pipeline of the Allwinner A10 is involving several loosely
> coupled components.
> 
> Add a documentation for the bindings.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  .../bindings/display/sunxi/sun4i-drm.txt           | 258 +++++++++++++++++++++
>  1 file changed, 258 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt

> +The display engine pipeline (and its entry point, since it can be
> +either directly the backend or the frontend) is represented as an
> +extra node.
> +
> +Required properties:
> +  - compatible: value must be one of:
> +    * allwinner,sun5i-a13-display-engine
> +
> +  - allwinner,pipelines: list of phandle to the display engine
> +    frontends available.


> +display-engine {
> +	compatible = "allwinner,sun5i-a13-display-engine";
> +	pipelines = <&fe0>;

Missing allwinner prefix.

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
