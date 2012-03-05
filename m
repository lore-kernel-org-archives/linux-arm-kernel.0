From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 5 Mar 2012 14:49:20 +0000
Subject: [PATCH v2 11/17] ASoC: fsl: create fsl_utils to accommodate the
 common functions
In-Reply-To: <1330957865-19085-12-git-send-email-shawn.guo@linaro.org>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
 <1330957865-19085-12-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120305144920.GR3224@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 10:30:59PM +0800, Shawn Guo wrote:

> +/**
> + * fsl_asoc_get_codec_dev_name - determine the dev_name for a codec node
> + *
> + * @np: pointer to the I2C device tree node
> + * @buf: buffer to be filled with the dev_name of the I2C device
> + * @len: the length of the buffer
> + *
> + * This function determines the dev_name for an I2C node.  This is the name
> + * that would be returned by dev_name() if this device_node were part of a
> + * 'struct device'  It's ugly and hackish, but it works.
> + *
> + * The dev_name for such devices include the bus number and I2C address. For
> + * example, "cs4270.0-004f".
> + */
> +int fsl_asoc_get_codec_dev_name(struct device_node *np, char *buf, size_t len)

This doesn't seem at all Freescale specific, it should be a generic
helper, and in fact there already is one - the machine driver can set
codec_of_node in the card structure to point to the device node and then
the core should figure out binding to the device for you.  If it doesn't
we should fix the core.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120305/cf084766/attachment.sig>
