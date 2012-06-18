From: stigge@antcom.de (Roland Stigge)
Date: Mon, 18 Jun 2012 14:56:48 +0200
Subject: [PATCH] spi: spi-pl022: Adjust probe() to of_get_named_gpio()
 returning -EPROBE_DEFER
In-Reply-To: <CAAAP30GAwQZtjAjtX=Q8K0Szo83QwqCZNtr09GxrgcvcR-CKeA@mail.gmail.com>
References: <1340011219-31657-1-git-send-email-stigge@antcom.de>
 <CACRpkdYTE0imxEAdq0=wJO49iBAj=8xGjn_PevFm1Bsr3MvUQg@mail.gmail.com>
 <CAAAP30GAwQZtjAjtX=Q8K0Szo83QwqCZNtr09GxrgcvcR-CKeA@mail.gmail.com>
Message-ID: <4FDF2590.4010901@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2012 01:51 PM, Alexandre Pereira da Silva wrote:
> On Mon, Jun 18, 2012 at 8:47 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Mon, Jun 18, 2012 at 11:20 AM, Roland Stigge <stigge@antcom.de> wrote:
>>
>>> The patch to gpiolib-of.c providing -EPROBE_DEFER as a hint to defer
>>> of_get_named_gpio*() to a later probe() breaks spi-pl022.c.
>>>
>>> This patch adjusts to this change, using -EPROBE_DEFER as indication to defer.
>>>
>>> Signed-off-by: Roland Stigge <stigge@antcom.de>
>>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Acked-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
> 
>>> Should this patch be joined with gpiolib-of's patch to of_get_named_gpio()? Or
>>> should they just be issued as a series?
>>
>> If it's not bisectable unless you change this in the same patch then join
>> them. Else I'd put them in a series and try to figure out a good tree for
>> merging them.
> 
> Ok, so lets keep the original patch as is for now.

When Linus Acked both patches for *spi-pl022* (dt + gpio/defer fix), and
they are not yet applied, please merge them. No need to introduce
intermediate breakage.

You can keep my Signed or Acked line for exactly this.

We'll keep the patch for *gpiolib-of* separate, of course.

Thanks,

Roland
