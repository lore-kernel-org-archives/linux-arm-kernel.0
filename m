From: wni@nvidia.com (Wei Ni)
Date: Mon, 8 Jul 2013 17:36:05 +0800
Subject: [lm-sensors] [PATCH 1/2] ARM: dt: t30 cardhu: add dt entry for
 lm90
In-Reply-To: <20130708095024.041a6d57@endymion.delvare>
References: <1372928979-26938-1-git-send-email-wni@nvidia.com>
 <1372928979-26938-2-git-send-email-wni@nvidia.com>
 <51D70483.70203@wwwdotorg.org>	<51DA6BD4.1040300@nvidia.com>
 <20130708095024.041a6d57@endymion.delvare>
Message-ID: <51DA8805.50709@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2013 03:50 PM, Jean Delvare wrote:
> On Mon, 8 Jul 2013 15:35:48 +0800, Wei Ni wrote:
>> On 07/06/2013 01:38 AM, Stephen Warren wrote:
>>> On 07/04/2013 03:09 AM, Wei Ni wrote:
>>>> Enable thermal sensor lm90 for t30 cardhu.
>>>
>>>> diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
>>>
>>>> +		nct1008: nct1008 {
>>>> +			compatible = "lm90,nct1008";
>>>
>>> "lm90" isn't a valid vendor prefix. I believe the value you want is
>>> "onnn,nct1008". Same comment for patch 2/2.
>>
>> The lm90 doesn't support device tree very well.
> 
> I doubt it, but if this is the case, then please fix it, instead of
> working the problem around in a different place.
> 
>> In the DT, we need to
>> named as "lm90" so that the lm90 driver can be loaded,
> 
> Not that I am an expert with regards to DT, but this doesn't make any
> sense to me. AFAIK DT is about devices, not which drivers handle them.
> 
>> and we also need
>> to add "nct1008" to indicate this is the nct1008 device, so that the
>> lm90 driver can be loaded with the right i2c_device_id->driver_data.
>>
>> I set the " compatible = "lm90,nct1008" ", this is the simplest way, and
>> we doesn't need to change the lm90.c.
> 
> There's no problem with changing the lm90 driver, if this is the right
> thing to do.

Ok, I will add DT support in the lm90.c in my next version patch.

Thanks.
Wei.

> 
