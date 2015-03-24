From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Mar 2015 15:36:37 -0700
Subject: [PATCH v3 1/9] regmap: Introduce regmap_get_max_register.
In-Reply-To: <1427236179-18580-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1427236116-18531-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1427236179-18580-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20150324223637.GB28997@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 10:29:39PM +0000, Srinivas Kandagatla wrote:

> This patch introduces regmap_get_max_register() function which would be
> used by the infrastructures like eeprom framework built on top of
> regmap.

In what way would it be used?

> +int regmap_get_max_register(struct regmap *map)
> +{
> +	return map->max_register ? : -EINVAL;
> +}

Please write the logic out properly, don't abuse the ternery operator.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150324/02923a85/attachment.sig>
