From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 24 Aug 2016 17:38:19 +0900
Subject: [PATCH 1/2] clk: samsung: exynos5260: Move struct samsung_cmu_info
 to init section
In-Reply-To: <20160824044346.GR6502@codeaurora.org>
References: <1471834185-20249-1-git-send-email-cw00.choi@samsung.com>
 <1471834185-20249-2-git-send-email-cw00.choi@samsung.com>
 <CGME20160823005523epcas1p3993794ba487bb055cbf8a0b247fcb280@epcas1p3.samsung.com>
 <20160823005512.GP6502@codeaurora.org> <57BBB66E.2060807@samsung.com>
 <84e40b9b-1e08-24e0-f1ef-60b38b760ae6@samsung.com>
 <20160824044346.GR6502@codeaurora.org>
Message-ID: <57BD5CFB.5050500@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016? 08? 24? 13:43, Stephen Boyd wrote:
> On 08/23, Sylwester Nawrocki wrote:
>> On 08/23/2016 04:35 AM, Chanwoo Choi wrote:
>> I checked stripped object files and it seems with the patch there
>> is some saving of the kernel image size. Exactly 784 bytes, which
>> makes zImage smaller by 480 bytes.
>>
>> The patch increases .init.rodata section size by 780 bytes but 
>> decreases .init.text section size by 1564 bytes.  Looks like 
>> a static initializer is cheaper.
>>
>> $ ls -l  drivers/clk/samsung/clk-exynos5260.o
>>
>> < -rw-rw-r-- 1 snawrocki snawrocki 29100 Aug 23 11:35 drivers/clk/samsung/clk-exynos5260.o
>> ---
>>> -rw-rw-r-- 1 snawrocki snawrocki 28316 Aug 23 11:32 drivers/clk/samsung/clk-exynos5260.o
>>
>>
>> The section size differences are as below:
>> 15c15
>> <   3 .init.text    000006b8  00000000  00000000  00000034  2**2
>> ---
>>>   3 .init.text    0000009c  00000000  00000000  00000034  2**2
>> 25c25
>> <   8 .init.rodata  00003f6c  00000000  00000000  00002f20  2**2
>> ---
>>>   8 .init.rodata  00004278  00000000  00000000  00002904  2**2
>>
>> So the saving is rather insignificant but the patch doesn't make
>> things worse and I'd say it might be worth applying.
>>
> 
> Sounds good. This sort of information should be in the commit
> text though. Talking about const doesn't make any sense to me.

Do you mean that 'const' is initconst secion?
If possible, could you explain the anything
why you don't make sense about 'const'?

-- 
Best Regards,
Chanwoo Choi
