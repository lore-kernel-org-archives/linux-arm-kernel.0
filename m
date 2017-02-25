From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 25 Feb 2017 16:21:22 +0000
Subject: [RFC 4/4] iio: trigger: add GPIO trigger
In-Reply-To: <03234803-c75d-bd1a-492b-761c0d5218ff@st.com>
References: <1487347429-31761-1-git-send-email-fabrice.gasnier@st.com>
 <1487347429-31761-5-git-send-email-fabrice.gasnier@st.com>
 <06f74b54-91fa-31c5-f015-52a6524059ef@metafoo.de>
 <3e2653fe-874c-d761-b274-ffe889df18a7@kernel.org>
 <03234803-c75d-bd1a-492b-761c0d5218ff@st.com>
Message-ID: <efefd474-4cfc-1e46-0c73-4be584ade7eb@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/02/17 16:24, Fabrice Gasnier wrote:
> On 02/18/2017 08:19 PM, Jonathan Cameron wrote:
>> On 17/02/17 16:16, Lars-Peter Clausen wrote:
>>> On 02/17/2017 05:03 PM, Fabrice Gasnier wrote:
>>>> GPIOs can be used to generate triggers for any IIO device.
>>>> Introduce generic GPIO trigger driver. It offers some options
>>>> to tune polarity (e.g. rising/falling edge), and label so trigger
>>>> name may be customized.
>>>> By default, gpio triggers will be named gpiotrigX, where X is gpio
>>>> number as returned by desc_to_gpio() call.
>>>> Rising edge is selected if polarity isn't set.
>>>
>>> If you want to use the GPIO only as an interrupt, just use it as an
>>> interrupt directly, no need to go the route via the GPIO.
>> Absolutely.  The majority of the bindings will then just become standard
>> interrupt bindings and will be effectively handled for you.
>>
>> Please work to extend the existing interrupt trigger driver rather than adding
>> this new one.  That one actually started as a gpio trigger then got
>> generalised into a interrupt trigger later so lets not do that again ;)
> 
> Hi Lars, Jonathan
> 
> Ok, got it.
> I'll drop this and focus on interrupt trigger, if this is worth having DT for it (e.g. patch 1 & 2 of this RFC).
> 
> BTW, I figured out there has been this patch a year ago, on interrupt trigger, to add device tree support:
> http://www.spinics.net/lists/linux-iio/msg23126.html
> Any reason why it hasn't found its way in ?
Gregor being very busy I suspect and not having time to address the reviews.

I 'think' the conclusion then was we needed some representative device that
could exist in devicetree to allow us to specify that a particular interrupt
could be used to trigger sensor capture.

Not a big issue, but probably still needs implementing unless Gregor has had
a chance to look at this.

Jonathan


> 
> Thanks for reviewing,
> Best Regards,
> Fabrice
> 
>>
>> Jonathan
>>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
