From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Wed, 05 Aug 2015 11:59:01 +0530
Subject: [PATCH-v5 4/5] Documentation: binding: add sclk adjustment
 properties to i2c-pxa
In-Reply-To: <20150727141152.GC15004@beef>
References: <1437482466-16126-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1437482466-16126-5-git-send-email-vaibhav.hiremath@linaro.org>
 <20150727141152.GC15004@beef>
Message-ID: <55C1AD2D.90109@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 27 July 2015 07:41 PM, Matt Porter wrote:
> On Tue, Jul 21, 2015 at 06:11:05PM +0530, Vaibhav Hiremath wrote:
>> With addition of PXA910 family of devices, the TWSI module supports
>> new feature which allows us to adjust SCLK. i2c-pxa driver takes input
>> configuration in nsec and converts it to respective bit-fields,
>>
>>   - i2c-sclk-low-time-ns : SCLK low time (tlow)
>>     This property is used along with mode selection.
>>   - i2c-sclk-high-time-ns : SCLK high time (thigh)
>>   - i2c-start-hold-time-ns : Used in case of high speed mode for start bit
>>     hold/setup wait counter.
>>   - i2c-stop-hold-time-ns : Used in case of high speed mode for stop bit
>>     hold/setup wait counter.
>>   - i2c-sda-hold-time-ns : Used to calculate hold/setup wait counter for
>>     standard and fast mode.
>
> Again, these should have a mrvl prefix..very specific to this PXA
> controller.
>

Sorry for delayed response, was down with health issue for week.

Coming back to your comment,

No, they are not Marvell specific. If you refer back to my V1, we
discussed about it and concluded that we should use generic property
here.
There are quite a few drivers using same properties for similar purpose.

Thanks,
Vaibhav
