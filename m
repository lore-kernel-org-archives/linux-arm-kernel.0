From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Thu, 31 Oct 2013 09:18:12 -0300
Subject: [PATCH 0/3] sunxi clock fixes
In-Reply-To: <52555135.1080501@elopez.com.ar>
References: <1379725392-30202-1-git-send-email-emilio@elopez.com.ar>
 <52555135.1080501@elopez.com.ar>
Message-ID: <52724A84.1010806@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El 09/10/13 09:51, Emilio L?pez escribi?:
> Hi Mike,
>
> El 20/09/13 22:03, Emilio L?pez escribi?:
>> Hi,
>>
>> This small series contains two bug fixes and a patch to solve the issue
>> of accidental clock gating, as discussed earlier on my RFC patch, "of:
>> add a basic memory driver".
>>
>> I believe the two first patches should go into -rcN, although I have not
>> noticed any issues so far coming from the bugs themselves.
>>
>> The third patch should be a no-op for now, and I'd like to have it
>> merged before these clocks actually appear on the driver; in this way
>> they will never be gated accidentally, and it remains bisectable. I will
>> be sending PLL5/6 support patches in short order.
>>
>> Cheers,
>>
>> Emilio
>>
>> Emilio L?pez (3):
>>    clk: sunxi: factors: fix off-by-one masks
>>    clk: sunxi: factors: clear variables before using them
>>    clk: sunxi: protect core clocks from accidental shutdown
>>
>>   drivers/clk/sunxi/clk-factors.c |  4 ++--
>>   drivers/clk/sunxi/clk-sunxi.c   | 28 ++++++++++++++++++++++++++++
>>   2 files changed, 30 insertions(+), 2 deletions(-)
>>
>
> Can you please take a look at this series and pick the patches if you
> are ok with them? It would be nice to see the first two fixes on -rcN by
> the way.

$ ping Mike
