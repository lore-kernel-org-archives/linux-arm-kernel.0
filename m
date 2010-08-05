From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 5 Aug 2010 14:51:11 +0900
Subject: [PATCH] S5PC110: Add OneNAND interrupt number
In-Reply-To: <1280982776.4363.18.camel@localhost.localdomain>
References: <20100727103937.GA1247@july>
	<1280982776.4363.18.camel@localhost.localdomain>
Message-ID: <AANLkTikV8ypbpainB7toPPeq7n6Q1P7ZDwL4Uf89q9dP@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 5, 2010 at 1:32 PM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> On Tue, 2010-07-27 at 19:39 +0900, Kyungmin Park wrote:
>> To use OneNAND interrupt at drivers, also extend DMA address to cover fully.
>>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> diff --git a/arch/arm/mach-s5pv210/dev-onenand.c b/arch/arm/mach-s5pv210/dev-onenand.c
>> index 34997b7..f8ede33 100644
>> --- a/arch/arm/mach-s5pv210/dev-onenand.c
>> +++ b/arch/arm/mach-s5pv210/dev-onenand.c
>> @@ -27,9 +27,14 @@ static struct resource s5pc110_onenand_resources[] = {
>> ? ? ? },
>> ? ? ? [1] = {
>> ? ? ? ? ? ? ? .start ?= S5PC110_PA_ONENAND_DMA,
>> - ? ? ? ? ? ? .end ? ?= S5PC110_PA_ONENAND_DMA + SZ_2K - 1,
>> + ? ? ? ? ? ? .end ? ?= S5PC110_PA_ONENAND_DMA + SZ_8K - 1,
>> ? ? ? ? ? ? ? .flags ?= IORESOURCE_MEM,
>> ? ? ? },
>> + ? ? [2] = {
>> + ? ? ? ? ? ? .start ?= IRQ_ONENAND_AUDI,
>> + ? ? ? ? ? ? .end ? ?= IRQ_ONENAND_AUDI,
>> + ? ? ? ? ? ? .flags ?= IORESOURCE_IRQ,
>> + ? ? },
>> ?};
>
> You do not expect this to go through the MTD tree, right?

After this patch, I did a lot of works but failed to persuade the Kukjin.
At this time. it's okay only this patch to mtd tree.

Kukjin, are you okay?
Since It's only affect the c110.

Thank you,
Kyungmin Park
