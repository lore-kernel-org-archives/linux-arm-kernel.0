From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 22 Nov 2018 09:45:26 +0100
Subject: [RFC PATCH v3 09/17] pinctrl: sunxi: add support for suniv
 F1C100s (newer F-series SoCs)
In-Reply-To: <fc20d96f5531d7d1eb5ce3d5cf920c8bf59cad58.1542824904.git.mesihkilinc@gmail.com>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
 <fc20d96f5531d7d1eb5ce3d5cf920c8bf59cad58.1542824904.git.mesihkilinc@gmail.com>
Message-ID: <20181122084526.gc5qfez4ppxstq3d@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 21, 2018 at 09:30:42PM +0300, Mesih Kilinc wrote:
> +static const struct sunxi_pinctrl_desc suniv_f1c100s_pinctrl_data = {
> +	.pins = suniv_f1c100s_pins,
> +	.npins = ARRAY_SIZE(suniv_f1c100s_pins),
> +	.irq_banks = 3,
> +	.disable_strict_mode = true,
> +};

One thing I forgot to check before giving my Acked-by, you shouldn't
disable the strict mode here, this is only meant as a legacy option,
new drivers need to enforce it.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181122/478fd4e9/attachment.sig>
