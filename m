From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 20 May 2014 15:41:15 +0300
Subject: [PATCH v2 2/3] ARM: dts: overo: Add support for 4.3'' LCD output
In-Reply-To: <1400589069-21572-3-git-send-email-florian.vaussard@epfl.ch>
References: <1400589069-21572-1-git-send-email-florian.vaussard@epfl.ch>
 <1400589069-21572-3-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <537B4D6B.5070106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/05/14 15:31, Florian Vaussard wrote:

> +	lcd0: display at 0 {
> +		compatible = "samsung,lte430wq-f0c", "panel-dpi";
> +		label = "lcd";
> +
> +		gpios = <&gpio5 16 GPIO_ACTIVE_HIGH		/* gpio_144: enable */
> +			 &gpio5 17 GPIO_ACTIVE_HIGH>;		/* gpio_145: brightness */

The panel-dpi only takes one gpio, the enable. The backlight should be
handled with gpio-backlight driver.

The same applies for the Alto35 patch.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140520/7371f68b/attachment.sig>
