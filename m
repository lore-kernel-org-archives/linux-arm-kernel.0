From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon, 5 Sep 2016 09:11:47 +0200
Subject: [PATCH v4 3/3] iio: adc: add support for Allwinner SoCs ADC
In-Reply-To: <20160905070716.GA6322@lukather>
References: <1472738705-20145-1-git-send-email-quentin.schulz@free-electrons.com>
 <1472738705-20145-4-git-send-email-quentin.schulz@free-electrons.com>
 <20160905070716.GA6322@lukather>
Message-ID: <9219f76c-384a-a7c3-5b13-ebaec980ab41@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/2016 09:07, Maxime Ripard wrote:
> Hi,
> 
> Nitpicks ahead.
> 
> On Thu, Sep 01, 2016 at 04:05:05PM +0200, Quentin Schulz wrote:
>> +	info->soc_specific = (struct soc_specific *)platform_get_device_id(pdev)->driver_data;
> 
> This line is still rather long. How about calling the field "data" and
> the structure gpadc_data?
> 

driver_data is coming from the platform_device_id
(http://lxr.free-electrons.com/source/include/linux/mod_devicetable.h#L498)
so can't really change that.
I could change the structure to gpadc_data, that would save me 2
characters, still 13 characters above the 80 characters limit however.

>> +
>> +	tzd = devm_thermal_zone_of_sensor_register(pdev->dev.parent, 0, info,
>> +						   &sun4i_ts_tz_ops);
> 
> A comment on why you put the parent device structure and not the
> device itself like you're doing on all the other calls in that probe
> would be nice.
> 

Indeed.

Thanks,
Quentin

> Thanks!
> Maxime
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160905/355a39fa/attachment.sig>
