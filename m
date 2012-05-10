From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 10 May 2012 10:50:34 +0200
Subject: [PATCHv3] Add ADC driver for Atmel G20, G45 and X5 boards
In-Reply-To: <4FAB7D29.9000107@free-electrons.com>
References: <1336554366-16957-1-git-send-email-maxime.ripard@free-electrons.com>
 <201205091440.14587.arnd@arndb.de> <4FAB7D29.9000107@free-electrons.com>
Message-ID: <4FAB815A.8040109@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2012 10:32 AM, Maxime Ripard :
> Le 09/05/2012 16:40, Arnd Bergmann a ?crit :
>> On Wednesday 09 May 2012, Maxime Ripard wrote:
>>> Here is another version of the patches to bring ADC driver to Atmel boards.
>>> Since last version, here is what changed:
>>>   * Rebased on top of staging-next to move out of staging. Had to change to IIO
>>>     kfifo buffer along the way.
>>>   * Reworked the DT bindings according to Jean-Christophe reviews
>>>   * Made various fixes according to reviews
>>>   * Support for X5 boards
>>
>> What's the reason for providing both DT and non-DT probing in that driver?
>> Doesn't it make more sense to just require that everyone who uses this
>> device boots using the device tree?
> 
> Mostly historical actually.
> The first versions were made using only non-DT probing, and then DT was
> added, so I didn't remove it.
> I've no strong feeling about this however, I believe we can definitely
> drop it, moreover if it makes life easier for you to merge it.
> 
> I'll send an updated version.

Hold on Maxime,

Non-DT is important for us as several boards are not converted to DT and
I guess that some never will. Moreover, some AT91 SoC will certainly
never be converted to DT but all are equipped with ADC...

So I would really like to keep the non-DT probing. This will give the
ability for users to experiment IIO/ADC with whichever kernel revision,
whichever AT91 SoC they like.

Arnd, we will have to agree on a way to push this work into mainline,
but please consider keeping the non-DT part for this driver.

Best regards,
-- 
Nicolas Ferre
