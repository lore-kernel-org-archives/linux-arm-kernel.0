From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 8 Dec 2015 23:19:30 -0300
Subject: [PATCH v4 7/8] ARM: dts: Exynos5422: fix OPP tables
In-Reply-To: <56677701.10809@samsung.com>
References: <1449512300-17230-1-git-send-email-b.zolnierkie@samsung.com>
 <1449512300-17230-8-git-send-email-b.zolnierkie@samsung.com>
 <56669126.7050803@samsung.com> <5666DE25.7090708@osg.samsung.com>
 <56677701.10809@samsung.com>
Message-ID: <56678FB2.1080205@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 12/08/2015 09:34 PM, Krzysztof Kozlowski wrote:
> On 08.12.2015 22:41, Javier Martinez Canillas wrote:
>> On 12/08/2015 05:13 AM, Krzysztof Kozlowski wrote:
>>>
>>> This looks like a very-non-atomic way of handling a change. You added
>>> opp tables to exynos5420 before so at that time they will be applied to
>>> Odroid XU3 family which uses different CPU order. After that you are
>>> fixing the tables to proper CPU order. Direct bisectability probably
>>> won't be an issue because all of DTS would go to separate branch... but
>>> the logic behind confuses.
>>>
>>
>> Agreed.
>>
>>> I think this should be squashed into 3/8.
>>>
>>
>> I think the patch should be split in two changes, the CPUs device nodes
>> having the wrong clock for clusters is a bug and has to be fixed in a
>> patch before adding the OPP tables and the OPP tables changes should be
>> separated and merged with patch 3/8 as you suggest.
> 
> I don't get the point about wrong clock (bug). Where is the bug? Beside
> of course what was introduced in 3/8 and it is not valid for reversed
> cluster order.
>

You are absolutely correct, for some reason I thought that the CLK_ARM_CLK
and CLK_KFC_CLK clocks were already defined in the cpu0 and cpu4 nodes from
exynos5420.dtsi and commit df09df6f9ac3 ("ARM: dts: add exynos5422-cpus.dtsi
to correct cpu order") missed that when reversing the cores for Exynos5422.

But on a second look to patch 3/8, I see that the clocks are defined in that
patch so I agree that $SUBJECT should just be squashed with 3/8 without doing
any split. Sorry for the noise.

> Best regards,
> Krzysztof
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
