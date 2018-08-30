From: embed3d@gmail.com (Philipp Rossak)
Date: Thu, 30 Aug 2018 22:46:58 +0200
Subject: [linux-sunxi] [PATCH v3 21/30] iio: adc: sun4i-gpadc-iio: add
 support for H3 thermal sensor
In-Reply-To: <e919cbdd-a874-4b46-a505-9412d093f54a@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-22-embed3d@gmail.com>
 <20180830162734.uq65l6ox6uwrmulo@core>
 <e919cbdd-a874-4b46-a505-9412d093f54a@gmail.com>
Message-ID: <858dbcce-027a-5f48-ce66-06c79b6eeadd@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 30.08.2018 22:00, Philipp Rossak wrote:
> On 30.08.2018 18:27, Ond?ej Jirman wrote:
>>> +static int sun8i_h3_calibrate(struct sun4i_gpadc_iio *info)
>>> +{
>>> +//??? regmap_write(info->regmap, SUNXI_THS_CDATA_0_1,
>>> +//??????????? info->calibration_data[0]);
>>> +//??? regmap_write(info->regmap, SUNXI_THS_CDATA_2_3,
>>> +//??????????? info->calibration_data[1]);
>> This should probably be implemented, or left out completely.
>>
>> regards,
>> ?? o.
>>
> Thanks you are right!
> This should be implemented! I will fix this in the next version!
> 
> Thanks,
> Philipp

I just realized this function need to check if calibration datas are 
available. Writing zeros to the calibration data regs "breaks" the 
thermal sensor.

Philipp
