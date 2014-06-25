From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 25 Jun 2014 13:32:31 +0100
Subject: [PATCH] arm/arm64: DT: Fix GICv2 CPU interface size
In-Reply-To: <CAL_Jsq+rS3FE8_F-4qdUUTaJ6X9XNFP2d2h7CdU9hDRG0KG9uA@mail.gmail.com>
 (Rob Herring's message of "Wed, 25 Jun 2014 13:21:17 +0100")
References: <1403692675-26503-1-git-send-email-marc.zyngier@arm.com>
 <CAL_Jsq+rS3FE8_F-4qdUUTaJ6X9XNFP2d2h7CdU9hDRG0KG9uA@mail.gmail.com>
Message-ID: <86simtjhk0.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25 2014 at 01:21:17 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Wed, Jun 25, 2014 at 5:37 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> All the Cortex-{A7,A15} implementations are using a GICv2. Same for
>> the current arm64 platforms.
>>
>> Turns out that most of these platforms have described their GIC CPU
>> interface size as being 4kB. while it is actually 8kB (the GICC_DIR
>> register lives at offset 0x1000).
>>
>> This was found when converting the GIC driver to use EOImode==1 on
>> GICv2-based systems. It uses the GICC_DIR register, and the result
>> is a very early firework...
>
> What's your plan for making the kernel change? Updating the dts files
> is good, but that doesn't immediately help you if you have old dtbs.

See at the end of https://lkml.org/lkml/2014/6/25/243

Basically, we stay with a GICv1 behaviour if we detect the mess.

>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/boot/dts/axm55xx.dtsi              | 2 +-
>>  arch/arm/boot/dts/dra7.dtsi                 | 2 +-
>>  arch/arm/boot/dts/ecx-2000.dts              | 2 +-
>
> Acked-by: Rob Herring <robh@kernel.org>

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
