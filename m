From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 26 Jul 2013 16:30:29 -0600
Subject: [PATCH] bcm53xx: initial support for the BCM5301/BCM470X SoC
 with ARM CPU
In-Reply-To: <51F2F554.8030709@broadcom.com>
References: <1373982727-5492-1-git-send-email-hauke@hauke-m.de>
 <20130716151435.GB3871@linaro.org> <2043662.BcW19XTTMG@lenovo>
 <20130719020611.GA4941@glitch> <20130723185733.GB6811@ohporter.com>
 <CAGVrzcYnoN9NnJGvubS7=bVJDk37xSt4BimtvDWghe7OHEWALQ@mail.gmail.com>
 <20130724231106.GB29801@glitch>
 <CAGVrzcYudfgqs_eafje4BT2z2qE0kSJPx1B-xrq0WxtUkGxSFw@mail.gmail.com>
 <20130726000412.GH5022@linaro.org> <51F2F554.8030709@broadcom.com>
Message-ID: <51F2F885.2040002@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm CC'ing in the DT bindings maintainers in case they have any comment.

On 07/26/2013 04:16 PM, Christian Daudt wrote:
> On 13-07-25 05:04 PM, Matt Porter wrote:
>> On Thu, Jul 25, 2013 at 11:23:21PM +0100, Florian Fainelli wrote:
>>> 2013/7/25 Domenico Andreoli <cavokz@gmail.com>:
>>>> On Tue, Jul 23, 2013 at 08:05:28PM +0100, Florian Fainelli wrote:
>>>>> 2013/7/23 Matt Porter <matt.porter@linaro.org>:
>>>>>> On Fri, Jul 19, 2013 at 04:06:11AM +0200, Domenico Andreoli wrote:
>>>>>> It's pretty easy to see that the "ti" vendor prefix has no
>>>>>> relation at
>>>>>> all to their TXN symbol so that blows that convention out of the
>>>>>> water.
>>>>>> Rather, the prefix is based on somebody's notion of how that vendor's
>>>>>> part are normally referred to. In TI-land, it's TI AM335x or TI OMAP,
>>>>>> never TXN OMAP. :)
>>>>>>
>>>>>> For Broadcom, every part is BCMxxxxx so "bcm" is appropriate.
>>>>> It was appropriate before being the "wrong" vendor prefix was
>>>>> allocated, now that "brcm" has been allocated we should stick to it
>>>>> because otherwise we will break existing and on-going DT work.
>>>> I still prefer bcm to brcm and I find enough evidence that bcm would be
>>>> better in the long term.
>>>>
>>>> So if Broadcomers can agree on bcm, now it's still the cheapest time to
>>>> fix in that direction, later will not be better.
>>> If we are to fix it in stone, once and for all, let's go for the full
>>> name
>>> which would avoid any kind of future confusion (this also seems to be
>>> the
>>> tendency with new vendor prefixes these days). That way we could make
>>> everyone happy with say: "broadcom,bcm2835". Would that work for
>>> everyone?
>> I really like that.
>>
>> -Matt
>>
> broadcom works for me also.
>  thanks,
>    csd

I have no strong objection at this point in principle to renaming the
vendor prefix used by the RPi support, although it will cause a bunch of
pointless churn in the drivers to match the new compatible values,  and
in the pinctrl bindings for the custom properties there...
