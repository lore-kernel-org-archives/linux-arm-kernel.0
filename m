From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 25 Feb 2017 15:11:59 +0000
Subject: [PATCH 1/2] dt-bindings: iio: stm32-adc: add option to set
 resolution
In-Reply-To: <b9f59559-c7a8-f575-0868-bd3b149a35c9@st.com>
References: <1487177757-19427-1-git-send-email-fabrice.gasnier@st.com>
 <1487177757-19427-2-git-send-email-fabrice.gasnier@st.com>
 <c2b73482-ae01-34b5-3c16-b7e63893259e@kernel.org>
 <b9f59559-c7a8-f575-0868-bd3b149a35c9@st.com>
Message-ID: <d64bd76d-a2c6-6148-c126-fa73e96019a1@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/02/17 16:04, Fabrice Gasnier wrote:
> On 02/19/2017 01:09 PM, Jonathan Cameron wrote:
>> On 15/02/17 16:55, Fabrice Gasnier wrote:
>>> Add documentation for 'st,adc-res' dt optional property.
>>>
>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> I'm happy with this, but would like to leave time for a device tree review.
>>
>> Ultimately we may well want to make this a generic property and call it something
>> like adc-resolution but perhaps we need to wait until we have a few more devices
>> supporting setting it via device tree to figure out what the best interface is.
>> It would exactly be a problem to support this as a deprecated binding at that
>> point.
> 
> Hi Jonathan,
> 
> I agree with you on this... It may be better to have generic property
> for this, especially if you see that it will come in the near future.
> May I suggest this prop to be less restrictive, e.g. like
> resolution-bits as is may also be worth for other device types, e.g.
> DAC as an example ?>
Sure, why not - no loss of meaning here.  We may never use it for anything
else but that doesn't matter.
>>
>> Give me a poke if we hear nothing from Rob or Mark for say another week.
> 
> No news yet, but it can wait a little longer.
Rob / Mark, can you take a look at this if you have time?

Thanks,

Jonathan
> 
> Please advise,
> Regards,
> Fabrice
> 
>>
>> Thanks,
>>
>> Jonathan
>>
>>> ---
>>>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
>>> index 5dfc88e..45f7ff2 100644
>>> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
>>> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
>>> @@ -57,6 +57,9 @@ Optional properties:
>>>  - dmas: Phandle to dma channel for this ADC instance.
>>>    See ../../dma/dma.txt for details.
>>>  - dma-names: Must be "rx" when dmas property is being used.
>>> +- st,adc-res: Resolution (bits) to use for conversions. Must match device
>>> +  available resolutions (e.g. can be 6, 8, 10 or 12 on stm32f4). Default
>>> +  is maximum resolution if unset.
>>>
>>>  Example:
>>>      adc: adc at 40012000 {
>>> @@ -84,6 +87,7 @@ Example:
>>>              st,adc-channels = <8>;
>>>              dmas = <&dma2 0 0 0x400 0x0>;
>>>              dma-names = "rx";
>>> +            st,adc-res = <8>;
>>>          };
>>>          ...
>>>          other adc child nodes follow...
>>>
>>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
