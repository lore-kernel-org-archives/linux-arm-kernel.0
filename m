From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 14 Apr 2016 15:28:17 +0900
Subject: [PATCH 5/7] clk: samsung: exynos542x: Add the clock id for ACLK
In-Reply-To: <CA+Ln22EFdspBdHwWar65UZ-uFxq4c9+RPhNCJjgKp9idvDvM5A@mail.gmail.com>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
 <1460091646-28701-6-git-send-email-cw00.choi@samsung.com>
 <570CDB16.2050001@samsung.com>
 <CA+Ln22EFdspBdHwWar65UZ-uFxq4c9+RPhNCJjgKp9idvDvM5A@mail.gmail.com>
Message-ID: <570F3881.9000100@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz and Krzysztof,

On 2016? 04? 13? 15:20, Tomasz Figa wrote:
> 2016-04-12 14:25 GMT+03:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
>> On 04/08/2016 07:00 AM, Chanwoo Choi wrote:
>>> This patch adds the clock id for ACLK clock which is source clock of AMBA AXI
>>> Bus. This clock should be handled in Bus frequency scaling driver.
>>>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> ---
>>>  drivers/clk/samsung/clk-exynos5420.c | 85 +++++++++++++++++++++++-------------
>>>  1 file changed, 55 insertions(+), 30 deletions(-)
>>
>> The IDs itself look good but you are not adding only clock ID. You are
>> changing all of them from NULL-flags to CLK_SET_RATE_PARENT. This should
>> be explained in the commit message why you need it. Probably it should
>> be also in separate commit.
> 
> +1. And CLK_SET_RATE_PARENT for a clock which has a mux as its parent
> is a bit suspicious, so I'd like to know the rationale for each single
> clock with CLK_SET_RATE_PARENT being added.

This patch don't need the CLK_SET_RATE_PARENT flag. As Tomasz's comment,
the mux of divider's parent don't need this flag. Sorry for confusion.

I'll drop the CLK_SET_RATE_PARENT flag.

Best Regards,
Chanwoo Choi
