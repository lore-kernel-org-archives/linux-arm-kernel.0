From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 28 Feb 2017 09:34:41 +0100
Subject: [PATCH 1/2] dt-bindings: iio: stm32-adc: add option to set
 resolution
In-Reply-To: <79e01c5c-d27c-89ea-4d8f-9e66a6c091e6@st.com>
References: <1487177757-19427-1-git-send-email-fabrice.gasnier@st.com>
 <1487177757-19427-2-git-send-email-fabrice.gasnier@st.com>
 <c2b73482-ae01-34b5-3c16-b7e63893259e@kernel.org>
 <b9f59559-c7a8-f575-0868-bd3b149a35c9@st.com>
 <d64bd76d-a2c6-6148-c126-fa73e96019a1@kernel.org>
 <79e01c5c-d27c-89ea-4d8f-9e66a6c091e6@st.com>
Message-ID: <f486bd08-b562-5101-01ba-c8e36ac0d83b@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2017 09:21 AM, Fabrice Gasnier wrote:
> On 02/25/2017 04:11 PM, Jonathan Cameron wrote:
>> On 24/02/17 16:04, Fabrice Gasnier wrote:
>>> On 02/19/2017 01:09 PM, Jonathan Cameron wrote:
>>>> On 15/02/17 16:55, Fabrice Gasnier wrote:
>>>>> Add documentation for 'st,adc-res' dt optional property.
>>>>>
>>>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>>> I'm happy with this, but would like to leave time for a device tree review.
>>>>
>>>> Ultimately we may well want to make this a generic property and call it
>>>> something
>>>> like adc-resolution but perhaps we need to wait until we have a few more
>>>> devices
>>>> supporting setting it via device tree to figure out what the best
>>>> interface is.
>>>> It would exactly be a problem to support this as a deprecated binding at
>>>> that
>>>> point.
>>>
>>> Hi Jonathan,
>>>
>>> I agree with you on this... It may be better to have generic property
>>> for this, especially if you see that it will come in the near future.
>>> May I suggest this prop to be less restrictive, e.g. like
>>> resolution-bits as is may also be worth for other device types, e.g.
>>> DAC as an example ?>
>> Sure, why not - no loss of meaning here.  We may never use it for anything
>> else but that doesn't matter.
> 
> Hi Jonathan,
> 
> Following Rob's comment, how you see such a common property can be
> integrated. Currently I don't see much devices are doing this.
> Do you have ideas or preferences on this ?
> 
> - Do you think replacing 'st,adc-res' by 'resolution-bits' in current
> patchset is enough for now ?

That name would be a bit confusing. Considering that the devicetree
describes th capabilities of the hardware this name would suggest that this
is the resolution supported by the device.

If we want to allow selecting runtime configuration parameters for IIO
devices from the devicetree we should probably follow the precedence set by
the clock framework and use properties with the 'assigned-' prefix.

But to be honest I'm not convinced yet that the whole approach of allowing
runtime configuration parameters to be configured via the devicetree is the
right approach. Converters and sensors often have a lot of runtime
configurable parameters, typically we expose them to the application layer
to allow maximum flexibility. Why is the resolution special in this case and
should be pre-configured via the devicetree instead?

- Lars
