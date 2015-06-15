From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 15 Jun 2015 12:52:25 +0900
Subject: [PATCHv6 2/4] ARM: dts: exynos5422-odroidxu3: Enable TMU at
 Exynos5422 base
In-Reply-To: <CANAwSgT+-KYDsYM6ZvcMabeW+JvYvEaGAht8Pfn64=kafBho=Q@mail.gmail.com>
References: <1434277445-5243-1-git-send-email-linux.amoon@gmail.com>
 <1434277445-5243-2-git-send-email-linux.amoon@gmail.com>
 <557E136E.7090409@samsung.com>
 <CANAwSgT+-KYDsYM6ZvcMabeW+JvYvEaGAht8Pfn64=kafBho=Q@mail.gmail.com>
Message-ID: <557E4BF9.7000808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.06.2015 11:13, Anand Moon wrote:
> hi Krzysztof
> 
> On 15 June 2015 at 05:21, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
>> On 14.06.2015 19:24, Anand Moon wrote:
>>> This changes enables TMU IP block on the Exynos5422 Odroid-XU3
>>> device.
>>>
>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
>>> Acked-by: Lukasz Majewski <l.majewski@samsung.com>
>>> ---
>>> Changes rebase on git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung branch for-next
>>> Changes from v5: Use LDO7 regulator instead of LD010.
>>>
>>> The output of LDO18 goes to VDD_EMMC_1V8. This is not regulator for TMU.
>>>
>>> I think the schematics are missing some of details but it can be deducted that:
>>> 1. TEMP SE is supplied by VDD18_TS power domain. It consists of 5
>>> pairs of pins (XTSTEST_OUT[0-4], XTSEXT_RES[0-4]).
>>> 2. The VDD18_TS01, VDD18_TS23 and VDD18_TS4 are wired to the LDO7 of
>>> S2MPS11 PMIC.
>>> 3. I confirmed with the Exynos5422 datasheet that these
>>> VDD18_TS{01,23,4} supply the XTSTEST pins (OUT and RES).
>>>
>>> So the LDO7 it is... but before using it there is a caveat. The LDO7
>>> is also connected to VDD of MIPI, HDMI and few more. So when you use
>>> this regulator in TMU it may be turned off by TMU driver (e.g. during
>>> unbind). In such case these other blocks also should be tested and
>>> checked whether they take this regulator and enable it.
>>
>> Why did you took my email and pasted it here?
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/343702.html
>>
>> It is written now in first person so it pretends that you wrote this.
>> You are actually doing this for second time - taking my
>> reply and putting into commit message or changelog. Why?
>>
>> And where is proper changelog?
>>
> 
> Sorry: My intention was never to take credit on what your guidance and
> your pointers.
> I value ever input of your and try not to repeat the mistakes I am repeating.
> I will send updated version soon.

If you want to quote me, then it's fine. But please indicate that this
is a quote.

Thanks for resending. Later I'll give the patchset a try on my XU3-Lite.

Best regards,
Krzysztof
