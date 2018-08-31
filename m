From: embed3d@gmail.com (Philipp Rossak)
Date: Fri, 31 Aug 2018 14:01:08 +0200
Subject: [PATCH v3 21/30] iio: adc: sun4i-gpadc-iio: add support for H3
 thermal sensor
In-Reply-To: <20180831091137.wkbbipssyd6mqfbt@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-22-embed3d@gmail.com>
 <20180831091137.wkbbipssyd6mqfbt@flea>
Message-ID: <b834bc83-e3fa-511b-7c29-bd3a9af01d5b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31.08.2018 11:11, Maxime Ripard wrote:
>> +	regmap_write(info->regmap, SUN8I_H3_THS_CTRL0,
>> +			SUN4I_GPADC_CTRL0_T_ACQ(0xff));
>> +
>> +	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2,
>> +			SUN8I_H3_THS_ACQ1(0x3f));
>> +
>> +	regmap_write(info->regmap, SUN8I_H3_THS_STAT,
>> +			SUN8I_H3_THS_INTS_TDATA_IRQ_0);
>> +
>> +	regmap_write(info->regmap, SUN8I_H3_THS_FILTER,
>> +			SUN4I_GPADC_CTRL3_FILTER_EN |
>> +			SUN4I_GPADC_CTRL3_FILTER_TYPE(0x2));
>> +
>> +	regmap_write(info->regmap, SUN8I_H3_THS_INTC,
>> +			SUN8I_H3_THS_INTC_TDATA_IRQ_EN0 |
>> +			SUN8I_H3_THS_TEMP_PERIOD(0x55));
>> +
>> +	regmap_read(info->regmap, SUN8I_H3_THS_CTRL2, &value);
>> +
>> +	regmap_write(info->regmap, SUN8I_H3_THS_CTRL2,
>> +			SUN8I_H3_THS_TEMP_SENSE_EN0 | value);
> Ideally, all these values should have a comment explaining what they
> are.
> 
> And we really start to have a lot of registers defines. We'd be better
> off using regmap_fields.

I will rework this in the next version.

Thanks,
Philipp
