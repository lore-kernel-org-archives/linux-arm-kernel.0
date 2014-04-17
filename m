From: robherring2@gmail.com (Rob Herring)
Date: Thu, 17 Apr 2014 09:01:00 -0500
Subject: [PATCH] clocksource: efm32: let CLKSRC_EFM32 select CLKSRC_OF
In-Reply-To: <534F8492.3070206@linaro.org>
References: <CAL_JsqKXYOdpCkixBLg8kAXwpkaLHhckJnTkzdNVeOQDYzxK3w@mail.gmail.com>
 <1397673612-24247-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAL_Jsq+Wm-jxeZoYXpC+W3Was5WTS2UqLJ__N5uPB43ZHUmrLw@mail.gmail.com>
 <20140416193036.GS5969@pengutronix.de>
 <534F8492.3070206@linaro.org>
Message-ID: <CAL_JsqLx_bL3b71ow=jjWDpduENCjgGvCBbRUje6WOKDGqeEbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 2:36 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 04/16/2014 09:30 PM, Uwe Kleine-K?nig wrote:
>>
>> Hello,
>>
>> On Wed, Apr 16, 2014 at 01:51:17PM -0500, Rob Herring wrote:
>>>
>>> On Wed, Apr 16, 2014 at 1:40 PM, Uwe Kleine-K?nig
>>> <u.kleine-koenig@pengutronix.de> wrote:
>>>>
>>>> The efm32 timer driver is only usable with CLKSRC_OF, so it makes sense
>>>> to let its Kconfig symbol select it. For compile coverage testing it's
>>>> not
>>>> needed though, so only select it if ARCH_EFM32 is enabled.
>>>>
>>>> This allows to drop ARCH_EFM32 selecting CLKSRC_OF which is done here
>>>> for simplicity, too.
>>>>
>>>> Reported-by: Rob Herring <robherring2@gmail.com>
>>>> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>>>> ---
>>>> [...]
>>>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>>>> --- a/drivers/clocksource/Kconfig
>>>> +++ b/drivers/clocksource/Kconfig
>>>> @@ -80,6 +80,7 @@ config CLKSRC_EFM32
>>>>          bool "Clocksource for Energy Micro's EFM32 SoCs" if !ARCH_EFM32
>>>>          depends on OF && ARM && (ARCH_EFM32 || COMPILE_TEST)
>>>>          select CLKSRC_MMIO
>>>> +       select CLKSRC_OF if ARCH_EFM32
>>>
>>>
>>> You already depend on OF, so I believe you don't need the if here.
>>
>> Rob and I discussed this shortly on irc, the summary is that the if is
>> not needed to prevent Kconfig breakage but adds more flexibility for the
>> COMPILE_TEST case. In the end Rob said:
>>
>>         1397676012 < robher> you can add my ack.
>>
>> which would be:
>>
>> Acked-by: Rob Herring <robherring2@gmail.com>
>
>
> Hi Rob,
>
> shall I use the mail address above or robh at kernel.org ?

kernel.org please.

Rob
