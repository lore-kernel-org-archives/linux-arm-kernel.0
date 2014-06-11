From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 12 Jun 2014 00:42:28 +0900
Subject: [PATCH] ARM: dts: exynos4: Fix reg sizes of GIC
In-Reply-To: <5397242D.8040303@samsung.com>
References: <1400855960-22033-1-git-send-email-t.figa@samsung.com>
 <53886E53.70206@gmail.com> <5388CB76.2030806@samsung.com>
 <5397242D.8040303@samsung.com>
Message-ID: <539878E4.8040005@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/14 00:28, Tomasz Figa wrote:
> Hi Kukjin,
>
Hi Tomasz,

> On 30.05.2014 20:18, Kukjin Kim wrote:
>> On 05/30/14 20:41, Tomasz Figa wrote:
>>> Hi,
>>>
>>> On 23.05.2014 16:39, Tomasz Figa wrote:
>>>> This patch fixes reg entry sizes in GIC node that were not large enough
>>>> to cover whole regions.
>>>>
>>>> Signed-off-by: Tomasz Figa<t.figa@samsung.com>
>>>> ---
>>>>    arch/arm/boot/dts/exynos4.dtsi | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
>>>> index b8ece4b..fbaf426 100644
>>>> --- a/arch/arm/boot/dts/exynos4.dtsi
>>>> +++ b/arch/arm/boot/dts/exynos4.dtsi
>>>> @@ -113,7 +113,7 @@
>>>>    		compatible = "arm,cortex-a9-gic";
>>>>    		#interrupt-cells =<3>;
>>>>    		interrupt-controller;
>>>> -		reg =<0x10490000 0x1000>,<0x10480000 0x100>;
>>>> +		reg =<0x10490000 0x10000>,<0x10480000 0x10000>;
>>>>    	};
>>>>
>>>>    	combiner: interrupt-controller at 10440000 {
>>>>
>>>
>>> Ping.
>>>
>> Yeah, SZ_64K is used for GIC_CPU and GIC_DIST before moving on DT
>> support. Applied, but I need to check this is required for stable tree...
>
> Not sure if you already managed, but I think it might not be necessary
> in stable trees, as the (correct) static mapping is still there and it
> causes ioremap() to return correctly mapped area, ignoring the length
> specified in device tree.
>
Yes, agreed. this is not required for stable tree...

Thanks,
Kukjin
