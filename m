From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 17 Mar 2014 17:04:24 +0200
Subject: [PATCH v2] gpio: davinci: fix gpio selection for OF
In-Reply-To: <5326F8C5.5090406@ti.com>
References: <5316FFCE.1060603@ti.com>	<1394018461-757-1-git-send-email-holler@ahsoftware.de>	<CACRpkdaF=jc9Z1XZCtH8VPuih01t--qyV-sgH1R_ix0VM4RzVA@mail.gmail.com>	<5322D529.4070904@ahsoftware.de>
 <CACRpkdaghneo1MvNCfxjTED+sJepHgeZCgmKsRteG9qrBNWAfQ@mail.gmail.com>
 <5326F8C5.5090406@ti.com>
Message-ID: <53270EF8.6020908@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/17/2014 03:29 PM, Sekhar Nori wrote:
> On Friday 14 March 2014 04:32 PM, Linus Walleij wrote:
>> On Fri, Mar 14, 2014 at 11:08 AM, Alexander Holler <holler@ahsoftware.de> wrote:
>>> Am 11.03.2014 11:15, schrieb Linus Walleij:
>>>> On Wed, Mar 5, 2014 at 12:21 PM, Alexander Holler <holler@ahsoftware.de> wrote:
>>>>
>>>>> The driver missed an of_xlate function to translate gpio numbers
>>>>> as found in the DT to the correct chip and number.
>>>>>
>>>>> While there I've set #gpio_cells to a fixed value of 2.
>>>>>
>>>>> I've used gpio-pxa.c as template for those changes and tested my changes
>>>>> successfully on a da850 board using entries for gpio-leds in a DT. So I didn't
>>>>> reinvent the wheel but just copied and tested stuff.
>>>>>
>>>>> Thanks to Grygorii Strashko for the hint to the existing code in gpio-pxa.
>>>>>
>>>>> Signed-off-by: Alexander Holler <holler@ahsoftware.de>
>>>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>>>
>>>> This v2 version applied, thanks!
>>>
>>> Thanks, but actually that should have been a fix for 3.14 with which the
>>> OF functionality for davinci gpio gets introduced. I assum with the
>>> patch in for-next, 3.14 will appear with that functionality broken and
>>> it will become a candidate for -stable.
>>
>> I just get the impression that DT support for DaVinci in v3.14 is so risky
>> and unstable that noone except those implementing it (i.e. you) is really
>> using it, is that correct?
>>
>> In that case it is hardly a fix that we need to rush out to the entire world.
> 
> One thing to note is that this driver is used by keystone too and all
> its users are DT-only. Although I do not see any in-kernel DT GPIO users
> even there.
> 
> I can confirm the patch does not break my gpiolib based test module
> (test with and without DT), but then it did not have an issue even before.

The issues isn't observed on Keystone2 as it has <32 gpios as of now, also GPIO
 support for keystone is going to be added in 3.15 (including DT changes).

Regards,
-grygorii
