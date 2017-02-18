From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 18 Feb 2017 19:19:07 +0000
Subject: [RFC 4/4] iio: trigger: add GPIO trigger
In-Reply-To: <06f74b54-91fa-31c5-f015-52a6524059ef@metafoo.de>
References: <1487347429-31761-1-git-send-email-fabrice.gasnier@st.com>
 <1487347429-31761-5-git-send-email-fabrice.gasnier@st.com>
 <06f74b54-91fa-31c5-f015-52a6524059ef@metafoo.de>
Message-ID: <3e2653fe-874c-d761-b274-ffe889df18a7@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/02/17 16:16, Lars-Peter Clausen wrote:
> On 02/17/2017 05:03 PM, Fabrice Gasnier wrote:
>> GPIOs can be used to generate triggers for any IIO device.
>> Introduce generic GPIO trigger driver. It offers some options
>> to tune polarity (e.g. rising/falling edge), and label so trigger
>> name may be customized.
>> By default, gpio triggers will be named gpiotrigX, where X is gpio
>> number as returned by desc_to_gpio() call.
>> Rising edge is selected if polarity isn't set.
> 
> If you want to use the GPIO only as an interrupt, just use it as an
> interrupt directly, no need to go the route via the GPIO.
Absolutely.  The majority of the bindings will then just become standard
interrupt bindings and will be effectively handled for you.

Please work to extend the existing interrupt trigger driver rather than adding
this new one.  That one actually started as a gpio trigger then got
generalised into a interrupt trigger later so lets not do that again ;)

Jonathan
