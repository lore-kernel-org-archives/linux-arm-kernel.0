From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 27 Jun 2018 15:56:11 +0530
Subject: [PATCH v2 04/13] clk: davinci: psc-dm646x: use two lookup entries
 for the aemif clock
In-Reply-To: <CAMpxmJXpAECkA7FTLx-nR_w0ZEBUw_A7qpu2P6e_mS6k=pTsUQ@mail.gmail.com>
References: <20180626092537.6737-1-brgl@bgdev.pl>
 <20180626092537.6737-5-brgl@bgdev.pl>
 <1da88059-2d5b-f035-1d4c-9e21ae141017@ti.com>
 <CAMpxmJXpAECkA7FTLx-nR_w0ZEBUw_A7qpu2P6e_mS6k=pTsUQ@mail.gmail.com>
Message-ID: <28c47ca0-60ca-beb2-cd78-63ef6595fcd5@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 June 2018 03:33 PM, Bartosz Golaszewski wrote:
> 2018-06-27 12:01 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
>> On Tuesday 26 June 2018 02:55 PM, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> We want to be able to get the clock both from the board file by its
>>> con_id and from the aemif driver by dev_id.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> I see the DM365 and DM644x EVM board files getting reference to aemif
>> clock using just the con_id, but don't see that for DM646x. Am I
>> overlooking something?
>>
>> Thanks,
>> Sekhar
> 
> It's being done indirectly from mach-davinci/aemif.c. I guess we can
> remove it again after last patch.

I see. One way to avoid that would be to merge this into 11/13. I prefer
that, but it prevents clean separation of clock and machine patches. So
okay with current way too.

Thanks,
Sekhar
