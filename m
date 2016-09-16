From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 16 Sep 2016 16:41:44 +0900
Subject: [PATCH v6 1/2] clk: uniphier: add core support code for UniPhier
 clock driver
In-Reply-To: <20160907003258.GP12510@codeaurora.org>
References: <1470112223-24835-1-git-send-email-yamada.masahiro@socionext.com>
 <1470112223-24835-2-git-send-email-yamada.masahiro@socionext.com>
 <20160819002507.GS361@codeaurora.org>
 <CAK7LNAQg-LcK-vsWVU-b0WsF=Y_NBNR_cWqNDJKyMqp7Svdvqg@mail.gmail.com>
 <20160819191612.GU361@codeaurora.org>
 <CAK7LNAQownrE0n8rAYGgUs9_byvok8W0V=c6gts_C=8Wvio86g@mail.gmail.com>
 <20160829182200.GD19826@codeaurora.org>
 <CAK7LNAQ9byodJTu-itbnhFrUGDQS5bxYUydyJ3zyZ+aLroQ6FA@mail.gmail.com>
 <20160907003258.GP12510@codeaurora.org>
Message-ID: <CAK7LNARO+6D=T=O7uWwgGEk_D9t3nOPjPBmdsYWzsrOyvQOorg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

2016-09-07 9:32 GMT+09:00 Stephen Boyd <sboyd@codeaurora.org>:
> On 09/05, Masahiro Yamada wrote:
>> 2016-08-30 3:22 GMT+09:00 Stephen Boyd <sboyd@codeaurora.org>:
>> > On 08/29, Masahiro Yamada wrote:
>> >> I tried this, but it did not work.
>> >>
>> >> To make dev_get_regmap() work,
>> >> the parent device needs to call dev_regmap_init_mmio() beforehand.
>> >>
>> >>
>> >> Since commit bdb0066df96e74a4002125467ebe459feff1ebef
>> >> (mfd: syscon: Decouple syscon interface from platform devices),
>> >> syscon_probe() is not called for platform devices,
>> >> so that never happens.
>> >>
>> >
>> > Ok. Is the syscon also a simple-mfd?
>> >
>> > It sounds like there's a device for the parent, but we've failed
>> > to attach a regmap to it. Maybe the core DT code should assign
>> > the regmap to the parent device when it creates it so that child
>> > devices don't need to know this detail? It could look for
>> > simple-mfd devices with compatible = "syscon" and then create the
>> > regmap? Here's a totally untested patch for that.
>> >
>>
>>
>> I was not quire sure about this,
>> but maybe worth submitting to DT subsystem?
>>
>> Anyway, I will go with syscon_node_to_regmap() for v7.
>> Of course, I am happy to replace it with dev_get_regmap()
>> when the issue is solved in the mainline.
>>
>
> Ok that's fine. Did my patch fix dev_get_regmap() for you though?
> That would be useful to know so that this patch can be merged in
> parallel to yours.

Sorry for my late reply.

Yup, your patch worked fine!


And, I've posted v7 for my SoC clk driver.



-- 
Best Regards
Masahiro Yamada
