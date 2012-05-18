From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 18 May 2012 10:21:13 +0200
Subject: [PATCH 2/2] gpio/exynos: Add support for Exynos4x12 SoC
In-Reply-To: <4FB5B9CA.6060705@samsung.com>
References: <1337307497-15777-1-git-send-email-jy0922.shim@samsung.com>
 <1337307497-15777-2-git-send-email-jy0922.shim@samsung.com>
 <4FB5B9CA.6060705@samsung.com>
Message-ID: <4FB60679.8050008@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2012 04:54 AM, Joonyoung Shim wrote:
> Add to cc Grant Likely and Linus Walleij
> 
> On 05/18/2012 11:18 AM, Joonyoung Shim wrote:
>> Exynos4x12 GPIO part1 and part2 layouts are different with that of
>> Exynos4210. So, it needs to support gpios for Exynos4x12 SoC. This
>> doesn't support GPVx Exynos4x12 GPIO part4 yet.
>>
>> In the Exynos4x12 GPIO part1 and part2, the interval of base register
>> offset is 0x20 but GPF0, GPJ0, GPK0 and GPM0 ignore the 0x20 interval
>> and have new value. The interrupt reg offset also is about GPF0 and GPK0
>> too. Refer the below layout.
>>
>> - Exynos4x12 GPIO Part1
>> GPIO    Base offset     Interrupt reg offset
>> GPA0    0x000           0x00
>> GPA1    0x020           0x04
>> GPB     0x040           0x08
>> GPC0    0x060           0x0C
>> GPC1    0x080           0x10
>> GPD0    0x0A0           0x14
>> GPD1    0x0C0           0x18
>>          ...
>> GPF0    0x180           0x30
>> GPF1    0x1A0           0x34
>> GPF2    0x1C0           0x38
>> GPF3    0x1E0           0x3C
>>          ...
>> GPJ0    0x240           0x40
>> GPJ1    0x260           0x44
>>
>> - Exynos4x12 GPIO Part2
>>          ...
>> GPK0    0x040           0x08
>> GPK1    0x060           0x0C
>> GPK2    0x080           0x10
>> GPK3    0x0A0           0x14
>> GPL0    0x0C0           0x18
>> GPL1    0x0E0           0x1C
>> GPL2    0x100           0x20
>> GPY0    0x120           x
>> GPY1    0x140           x
>> GPY2    0x160           x
>> GPY3    0x180           x
>> GPY4    0x1A0           x
>> GPY5    0x1C0           x
>> GPY6    0x1E0           x
>>          ...
>> GPM0    0x260           0x24
>> GPM1    0x280           0x28
>> GPM2    0x2A0           0x2C
>> GPM3    0x2C0           0x30
>> GPM4    0x2E0           0x34
>> GPX0    0xC00           x
>> GPX1    0xC20           x
>> GPX2    0xC40           x
>> GPX3    0xC60           x
>>
>> Signed-off-by: Joonyoung Shim<jy0922.shim@samsung.com>
>> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
