From: alim.akhtar@gmail.com (Alim Akhtar)
Date: Mon, 17 Aug 2015 21:51:26 +0530
Subject: [PATCH 2/3] mmc: dw_mmc: simplify the SDMMC_CLKEN_LOW_PWR logic
In-Reply-To: <CAOMqctQ_gA=QxRVFQ8L=q7kBX3GROvz9mnHGu2yo1VrBO1Le6w@mail.gmail.com>
References: <cover.1439381423.git.hramrach@gmail.com>
 <3d03bfe2c18789eefa038018467c9c63c94ae4a2.1439381423.git.hramrach@gmail.com>
 <55D13F07.70309@samsung.com>
 <CAOMqctQ8DHj6qPg8zR93OGRHXAZDd0yUmG_J8Vz7dGFuDpCgRQ@mail.gmail.com>
 <55D1C4CD.4040200@samsung.com>
 <CAGOxZ51oHoX+zQSO8tRp8V5RUmDg8CAnM9HO5FQ5h6JeCy=1og@mail.gmail.com>
 <CAOMqctQ_gA=QxRVFQ8L=q7kBX3GROvz9mnHGu2yo1VrBO1Le6w@mail.gmail.com>
Message-ID: <CAGOxZ53FipjSbYMeBfr_+OWxn_WxpDfbfr8Vzs4uX6t3TBS3vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

On Mon, Aug 17, 2015 at 8:25 PM, Michal Suchanek <hramrach@gmail.com> wrote:
>  Hello,
>
> On 17 August 2015 at 16:42, Alim Akhtar <alim.akhtar@gmail.com> wrote:
>> HI
>>
>> On Mon, Aug 17, 2015 at 4:56 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>> On 08/17/2015 02:52 PM, Michal Suchanek wrote:
>>>> Hello,
>>>>
>>>> On 17 August 2015 at 03:55, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>>> Hi, Michal.
>>>>>
>>>>> On 08/12/2015 09:23 PM, Michal Suchanek wrote:
>>>>>> The driver has open-coded test for SDIO cards. Use the mmc core provided
>>>>>> MMC_QUIRK_BROKEN_CLK_GATING flag instead.
>>>>>
>>>>> Did you use the clock-gating for SDIO cards?
>>>>> Doesn't MMC_CAP_SDIO_IRQ bit set? Which case is broken?
>>>>> Could you explain to me more?
>>>>
>>>> The core flag for disabling power saving is MMC_QUIRK_BROKEN_CLK_GATING.
>>>
>>> I understood your intention. And i read the comment into mmc/core/quirks.c
>>> I will test SDIO card with this patch. Thanks.
>>>
>> When you test, please check if SDIO IRQ still works, we need to put
>> dw_mmc in low_power mode otherwise SDIO IRQ will be not be generated
>> by dw_mmc host controller.
>>
>
> As far as I understand the logic which is removed in this patch and
> the core logic which replaces it is the same -  low power by means of
> clock gating is *not* enabled for SDIO cards in either case.
>
> The original code also checks for SDIO IRQ and disables clock gating
> regardless of card type which is probably redundant. If not it should
> be fixed in mmc core.
>
> My recent kernel builds which I run on a system with mwifiex card
> probably include this patch.
>
I have no objection to this patch as such, it just that some extra
testing on few other boards will be good, which I am sure Jeahoon will
take care.
Thanks!!

> Thanks
>
> Michal



-- 
Regards,
Alim
