From: broonie@kernel.org (Mark Brown)
Date: Mon, 4 May 2015 13:05:37 +0100
Subject: [PATCH v4 01/10] regmap: Introduce regmap_get_max_register.
In-Reply-To: <1427752587-17087-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1427752492-17039-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1427752587-17087-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20150504120537.GL15510@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 10:56:27PM +0100, Srinivas Kandagatla wrote:

> +int regmap_get_max_register(struct regmap *map)
> +{
> +	return map->max_register ? : -EINVAL;
> +}

Please don't abuse the ternery operator like this, write a proper if
statement that people can read.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150504/cbfdd60e/attachment.sig>
