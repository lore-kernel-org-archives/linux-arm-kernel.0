From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Jun 2013 11:48:41 +0100
Subject: [PATCH v2 03/11] regmap: Add regmap_field APIs
In-Reply-To: <1370856118-6503-1-git-send-email-srinivas.kandagatla@st.com>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856118-6503-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <20130611104841.GX1403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 10:21:58AM +0100, Srinivas KANDAGATLA wrote:
> It is common to access regmap registers at bit level, using
> regmap_update_bits or regmap_read functions, however the end user has to
> take care of a mask or shifting. This becomes overhead when such use
> cases are high. Having a common function to do this is much convenient
> and less error prone.

So this looks basically good.  A couple of smallish nits below, if you
could respin I'll apply this on a branch so it can be pulled in as
dependency for the other things that use it.

> +	regmap_field_init(rm_field, regmap, reg_field);
> +
> +	return rm_field;
> +
> +}
> +EXPORT_SYMBOL_GPL(devm_regmap_field_alloc);
> +/**
> + * regmap_field_alloc(): Allocate and initialise a register field

Needs a blank line between the two functions.

> +#include <linux/device.h>
> +#include <linux/slab.h>

> +static inline void regmap_field_free(struct regmap_field *field)
> +{
> +	kfree(field);
> +}

> +static inline void devm_regmap_field_free(struct device *dev,
> +	struct regmap_field *field)
> +{
> +	devm_kfree(dev, field);
> +}

Probably not worth inlining these, just put them in the code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130611/ebc65022/attachment.sig>
