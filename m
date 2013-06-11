From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Tue, 11 Jun 2013 12:36:17 +0100
Subject: [PATCH v2 03/11] regmap: Add regmap_field APIs
In-Reply-To: <20130611104841.GX1403@sirena.org.uk>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856118-6503-1-git-send-email-srinivas.kandagatla@st.com>
 <20130611104841.GX1403@sirena.org.uk>
Message-ID: <51B70BB1.6040703@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/13 11:48, Mark Brown wrote:
> On Mon, Jun 10, 2013 at 10:21:58AM +0100, Srinivas KANDAGATLA wrote:
>> It is common to access regmap registers at bit level, using
>> regmap_update_bits or regmap_read functions, however the end user has to
>> take care of a mask or shifting. This becomes overhead when such use
>> cases are high. Having a common function to do this is much convenient
>> and less error prone.
> 
> So this looks basically good.  A couple of smallish nits below, if you
> could respin I'll apply this on a branch so it can be pulled in as
> dependency for the other things that use it.
> 
Thankyou for the comments,
I will fix it and send a v3 patch.

>> +	regmap_field_init(rm_field, regmap, reg_field);
>> +
>> +	return rm_field;
>> +
>> +}
>> +EXPORT_SYMBOL_GPL(devm_regmap_field_alloc);
>> +/**
>> + * regmap_field_alloc(): Allocate and initialise a register field
> 
> Needs a blank line between the two functions.
> 
>> +#include <linux/device.h>
>> +#include <linux/slab.h>
> 
>> +static inline void regmap_field_free(struct regmap_field *field)
>> +{
>> +	kfree(field);
>> +}
> 
>> +static inline void devm_regmap_field_free(struct device *dev,
>> +	struct regmap_field *field)
>> +{
>> +	devm_kfree(dev, field);
>> +}
> 
> Probably not worth inlining these, just put them in the code.
> 
> 
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
