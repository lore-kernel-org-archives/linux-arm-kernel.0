From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Feb 2017 16:52:09 -0600
Subject: [PATCH v2 3/3] media: dt-bindings: vpif: new optional property
In-Reply-To: <1487771027-7763-4-git-send-email-bgolaszewski@baylibre.com>
References: <1487771027-7763-1-git-send-email-bgolaszewski@baylibre.com>
 <1487771027-7763-4-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <20170227225209.26oieqwbafqjga2a@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2017 at 02:43:47PM +0100, Bartosz Golaszewski wrote:
> Add an optional property - enable-gpios - which can be used to specify
> the GPIOs that must be requested to select the vpif functionality.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  Documentation/devicetree/bindings/media/ti,da850-vpif.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/ti,da850-vpif.txt b/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
> index df7182a..23c5405 100644
> --- a/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
> +++ b/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
> @@ -13,6 +13,9 @@ Required properties:
>  - reg: physical base address and length of the registers set for the device;
>  - interrupts: should contain IRQ line for the VPIF
>  
> +Optional properties:
> +- enable-gpios: phandle of the GPIOs used to select the vpif functionality

What does this control exactly? The GPIOs belong in the node they are 
connected to and having GPIOs routed to this block seems strange.

There are inputs or outputs?

> +
>  Video Capture:
>  
>  VPIF has a 16-bit parallel bus input, supporting 2 8-bit channels or a
> @@ -30,6 +33,10 @@ I2C-connected TVP5147 decoder:
>  		reg = <0x217000 0x1000>;
>  		interrupts = <92>;
>  
> +		enable-gpios = <&tca6416 7 GPIO_ACTIVE_HIGH
> +				&tca6416 6 GPIO_ACTIVE_HIGH
> +				&tca6416 5 GPIO_ACTIVE_LOW>;
> +
>  		port at 0 {
>  			vpif_input_ch0: endpoint at 0 {
>  				reg = <0>;
> -- 
> 2.9.3
> 
