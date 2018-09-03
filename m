From: embed3d@gmail.com (Philipp Rossak)
Date: Mon, 3 Sep 2018 16:24:32 +0200
Subject: [PATCH v3 05/30] iio: adc: move SUN4I_GPADC_CHANNEL define to
 header file
In-Reply-To: <20180902210109.7bd4a567@archlinux>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-6-embed3d@gmail.com>
 <20180902210109.7bd4a567@archlinux>
Message-ID: <882cb5f9-867b-d120-5ef5-80a8bee2d628@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02.09.2018 22:01, Jonathan Cameron wrote:
> On Thu, 30 Aug 2018 17:44:53 +0200
> Philipp Rossak <embed3d@gmail.com> wrote:
> 
>> We are moving the SUN4I_GPADC_CHANNEL define to the header file.
> Maxime has raised this point in other patches...
> 
> Why?  Obvious what but I have no idea why you are doing this.
> 
> Thanks,
> 
> Jonathan
There are two reasons:
1. Personal taste: I like to have the #define stuff in the header file.
2. When I started the rework I had to get some better overview, so I 
moved it...

Since those two reasons are no good reasons to submit a patch I will 
drop it and keep it in the *.c file.

Philipp

>>
>> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
>> ---
>>   drivers/iio/adc/sun4i-gpadc-iio.c | 9 ---------
>>   include/linux/mfd/sun4i-gpadc.h   | 9 +++++++++
>>   2 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
>> index d95dd0fde2a6..666329940e1e 100644
>> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
>> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
>> @@ -109,15 +109,6 @@ struct sun4i_gpadc_iio {
>>   	struct device			*sensor_device;
>>   };
>>   
>> -#define SUN4I_GPADC_ADC_CHANNEL(_channel, _name) {		\
>> -	.type = IIO_VOLTAGE,					\
>> -	.indexed = 1,						\
>> -	.channel = _channel,					\
>> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>> -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
>> -	.datasheet_name = _name,				\
>> -}
>> -
>>   static struct iio_map sun4i_gpadc_hwmon_maps[] = {
>>   	{
>>   		.adc_channel_label = "temp_adc",
>> diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
>> index 139872c2e0fe..54c7c9375c1b 100644
>> --- a/include/linux/mfd/sun4i-gpadc.h
>> +++ b/include/linux/mfd/sun4i-gpadc.h
>> @@ -90,6 +90,15 @@
>>   /* 10s delay before suspending the IP */
>>   #define SUN4I_GPADC_AUTOSUSPEND_DELAY			10000
>>   
>> +#define SUN4I_GPADC_ADC_CHANNEL(_channel, _name) {		\
>> +	.type = IIO_VOLTAGE,					\
>> +	.indexed = 1,						\
>> +	.channel = _channel,					\
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
>> +	.datasheet_name = _name,				\
>> +}
>> +
>>   struct sun4i_gpadc_dev {
>>   	struct device			*dev;
>>   	struct regmap			*regmap;
> 
