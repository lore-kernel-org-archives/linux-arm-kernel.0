From: broonie@kernel.org (Mark Brown)
Date: Thu, 27 Nov 2014 18:45:44 +0000
Subject: [PATCH v4 3/7] regulator: of: Parse ena-gpios property from DTS
In-Reply-To: <1417087253-12306-4-git-send-email-k.kozlowski@samsung.com>
References: <1417087253-12306-1-git-send-email-k.kozlowski@samsung.com>
 <1417087253-12306-4-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20141127184544.GD7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 12:20:49PM +0100, Krzysztof Kozlowski wrote:

> +	constraints->ena_gpio = of_get_named_gpio_flags(np, "ena-gpios", 0,
> +							&gpio_flags);
> +	if (gpio_is_valid(constraints->ena_gpio)) {

No, this isn't sensible - in what way would an enable control GPIO be a
constraint?  The whole reason we have separate constraint and config
structures is that these are different things.  Keep the GPIO setup in
the configuration.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141127/779f525e/attachment.sig>
