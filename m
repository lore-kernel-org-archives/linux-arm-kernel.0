From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 10 Jan 2017 07:55:27 +0100
Subject: [PATCH v2 1/4] dmaengine: pl330: remove pdata based initialization
In-Reply-To: <20170109181511.37da3mslzdiq4uhr@kozik-lap>
References: <1483970598-6191-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170109140325eucas1p2674704b2505517ee532284c58c8a64d1@eucas1p2.samsung.com>
 <1483970598-6191-2-git-send-email-m.szyprowski@samsung.com>
 <20170109181511.37da3mslzdiq4uhr@kozik-lap>
Message-ID: <c12cb9e0-ce2f-662a-2b3b-12b4a2209b74@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,


On 2017-01-09 19:15, Krzysztof Kozlowski wrote:
> On Mon, Jan 09, 2017 at 03:03:15PM +0100, Marek Szyprowski wrote:
>> This driver is now used only on platforms which support device tree, so
>> it is safe to remove legacy platform data based initialization code.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   drivers/dma/pl330.c        | 30 ++++++++----------------------
>>   include/linux/amba/pl330.h | 35 -----------------------------------
> Nope:
> $ git grep pl330.h
> arch/arm/plat-samsung/devs.c:#include <linux/amba/pl330.h>

Huh... This seems to be a leftover from a really old code, because pl330
devices have been removed from devs.c quite a long time ago. I will fix
this in v3.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
