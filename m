From: ijc@hellion.org.uk (Ian Campbell)
Date: Mon, 17 Nov 2014 12:22:34 +0000
Subject: [PATCH 2/2] dt-bindings: simplefb-sunxi: Add sunxi simplefb
 extensions
In-Reply-To: <1416224086-5698-3-git-send-email-hdegoede@redhat.com>
References: <1416224086-5698-1-git-send-email-hdegoede@redhat.com>
 <1416224086-5698-3-git-send-email-hdegoede@redhat.com>
Message-ID: <1416226954.5466.8.camel@hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-11-17 at 12:34 +0100, Hans de Goede wrote:
> +- sunxi,pipeline:
> +  <0> for the de_be0 -> lcdc0 -> output pipeline
> +  <1> for the de_be1 -> lcdc1 -> output pipeline

Can we express this as a more descriptive string rather than a number,
to better handle future developments?

Otherwise both patches in this series look good to me.

> +- sunxi,output: One of: "hdmi", "lcd", "vga", and "composite"  
> +
> +Example:
> +
> +chosen {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	ranges;
> +
> +	framebuffer at 0 {
> +		compatible = "sunxi,framebuffer", "simple-framebuffer";
> +		sunxi,pipeline = <0>;
> +		sunxi,output = "hdmi";
> +		clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
> +			 <&ahb_gates 44>;
> +		status = "disabled";
> +	};
> +};
