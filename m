From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 09 Dec 2015 09:34:09 +0900
Subject: [PATCH v4 7/8] ARM: dts: Exynos5422: fix OPP tables
In-Reply-To: <5666DE25.7090708@osg.samsung.com>
References: <1449512300-17230-1-git-send-email-b.zolnierkie@samsung.com>
 <1449512300-17230-8-git-send-email-b.zolnierkie@samsung.com>
 <56669126.7050803@samsung.com> <5666DE25.7090708@osg.samsung.com>
Message-ID: <56677701.10809@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.12.2015 22:41, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 12/08/2015 05:13 AM, Krzysztof Kozlowski wrote:
>> On 08.12.2015 03:18, Bartlomiej Zolnierkiewicz wrote:
>>> From: Ben Gamari <ben@smart-cactus.org>
>>>
>>> The Exynos 5422 is identical to the 5800 except for the fact that it
>>> boots from the A7 cores. Consequently, the core numbering is different:
>>> cores 0-3 are A7s whereas 4-7 are A15s.
>>>
>>> We can reuse the device tree of the 5800 for the 5422 but we must take
>>> care to override the OPP tables and CPU clocks.  These are otherwise
>>> inherited from the exynos5800 devicetree, which has the CPU clusters
>>> reversed compared to the 5422. This results in the A15 cores only
>>> reaching 1.4GHz, the maximum rate of the KFC clock.
>>>
>>> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
>>> Signed-off-by: Ben Gamari <ben@smart-cactus.org>
>>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>> ---
>>>  arch/arm/boot/dts/exynos5422-cpus.dtsi | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>
>> This looks like a very-non-atomic way of handling a change. You added
>> opp tables to exynos5420 before so at that time they will be applied to
>> Odroid XU3 family which uses different CPU order. After that you are
>> fixing the tables to proper CPU order. Direct bisectability probably
>> won't be an issue because all of DTS would go to separate branch... but
>> the logic behind confuses.
>>
> 
> Agreed.
> 
>> I think this should be squashed into 3/8.
>>
> 
> I think the patch should be split in two changes, the CPUs device nodes
> having the wrong clock for clusters is a bug and has to be fixed in a
> patch before adding the OPP tables and the OPP tables changes should be
> separated and merged with patch 3/8 as you suggest.

I don't get the point about wrong clock (bug). Where is the bug? Beside
of course what was introduced in 3/8 and it is not valid for reversed
cluster order.

Best regards,
Krzysztof
