From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 24 Sep 2017 15:51:55 +0200
Subject: [PATCH v3 5/5] mtd: spi-nor: cadence-quadspi: Add runtime PM
 support
In-Reply-To: <038919d3-ff32-d0a7-4c0a-3be16436052d@ti.com>
References: <20170924105924.23923-1-vigneshr@ti.com>
 <20170924105924.23923-6-vigneshr@ti.com>
 <3a1160f9-a0ae-c84c-d209-af97c3c3b0f6@gmail.com>
 <4ee69ea4-14cc-4305-bf3f-8fe76d43bf6b@ti.com>
 <fa700cdf-f0b5-779b-4f38-3138a7612cc2@gmail.com>
 <038919d3-ff32-d0a7-4c0a-3be16436052d@ti.com>
Message-ID: <e4ad5d80-9093-b667-f0a5-d3105be4e8cf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2017 03:27 PM, Vignesh R wrote:
> 
> 
> On 9/24/2017 6:42 PM, Marek Vasut wrote:
>> On 09/24/2017 03:08 PM, Vignesh R wrote:
>>>
>>>
>>> On 9/24/2017 5:31 PM, Marek Vasut wrote:
>>>> On 09/24/2017 12:59 PM, Vignesh R wrote:
>>>>> Add pm_runtime* calls to cadence-quadspi driver. This is required to
>>>>> switch on QSPI power domain on TI 66AK2G SoC during probe.
>>>>>
>>>>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>>>>
>>>> Are you planning to add some more fine-grained PM control later?
>>>
>>> Yes, I will need to add fine-grained PM control at some point. But, for
>>> now SoC does not really support low power mode or runtime power saving
>>> option.
>>> The fact that driver still uses clk_prepare_*() calls to enable/disable
>>> clocks instead of pm_*() calls makes it a bit tricky though.
>>>
>>> Just figured out I forgot to add cleanup code in error handling path of
>>> probe(). Will fix that and send a v4.
>>
>> OK, fine. Cleanups are welcome. The SoCFPGA doesn't do much runtime PM
>> either, so it's fine for now.
>>
> 
> Ok thanks! Do you know if pm_runtime_get_sync() can enable clocks for
> QSPI on SoCFPGA or if clk_prepare_enable() is needed? Just trying to see
> if its possible to get rid of clk_*() calls in favor of pm_*() calls.

Not of the top of my head, sorry. +CC Matthew, he should know.

-- 
Best regards,
Marek Vasut
