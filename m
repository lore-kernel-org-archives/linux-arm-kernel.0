From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 16 Aug 2013 16:21:10 -0600
Subject: [PATCH v2] extcon: palmas: Modified the compatible type to *ti,
 palmas-usb-vid*
In-Reply-To: <1376648448-27447-1-git-send-email-kishon@ti.com>
References: <1376648448-27447-1-git-send-email-kishon@ti.com>
Message-ID: <520EA5D6.3040409@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/16/2013 04:20 AM, Kishon Vijay Abraham I wrote:
> The Palmas device contains only a USB VID detector, so modified the
> compatible type to *ti,palmas-usb-vid*.

> diff --git a/Documentation/devicetree/bindings/extcon/extcon-palmas.txt b/Documentation/devicetree/bindings/extcon/extcon-palmas.txt

>  PALMAS USB COMPARATOR
>  Required Properties:
> - - compatible : Should be "ti,palmas-usb" or "ti,twl6035-usb"
> + - compatible : Should be "ti,palmas-usb-vid".

Has the old value been published in a release kernel? If so, it makes
sense to document both values, but say the old one is deprecated, and ...

> diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c

>  static struct of_device_id of_palmas_match_tbl[] = {
> -	{ .compatible = "ti,palmas-usb", },
> -	{ .compatible = "ti,twl6035-usb", },
> +	{ .compatible = "ti,palmas-usb-vid", },

... perhaps just add the new value here, and don't remove the old values?

If not, ignore this.
