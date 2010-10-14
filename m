From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 14 Oct 2010 14:29:33 +0900
Subject: [PATCH V2 1/2] ARM: S5P: Add initial map for GPIO2 and GPIO3
In-Reply-To: <006601cb6b60$0a0e4190$1e2ac4b0$%kim@samsung.com>
References: <1286868876-3748-1-git-send-email-sbkim73@samsung.com>
	<1286868876-3748-2-git-send-email-sbkim73@samsung.com>
	<006601cb6b60$0a0e4190$1e2ac4b0$%kim@samsung.com>
Message-ID: <AANLkTimKNBfDpz_3E4z6MHV7V1Ht9Yobf6qbGMxyWWAy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 14, 2010 at 2:24 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Sangbeom Kim wrote:
>>
>> From: Jongpill Lee <boyko.lee@samsung.com>
>>
>> This patch adds initial map for GPIO2 and GPIO3.
>> S5PV310/S5PC210 has separated GPIO1, GPIO2 and GPIO3.
>>
>> Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
>> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
>> ---
>> Changes since v1:
>> - Rebased on latest for-next from Kukjin Kim's git tree
>> - Added S5P_VA_GPIO1 according to S5PV310_PA_GPIO1
>>
>> ?arch/arm/mach-s5pv310/cpu.c ? ? ? ? ? ? ?| ? 12 +++++++++++-
>> ?arch/arm/plat-s5p/include/plat/map-s5p.h | ? ?3 +++
>> ?2 files changed, 14 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-s5pv310/cpu.c b/arch/arm/mach-s5pv310/cpu.c
>> index 3345cf6..ffed262 100644
>> --- a/arch/arm/mach-s5pv310/cpu.c
>> +++ b/arch/arm/mach-s5pv310/cpu.c
>> @@ -57,11 +57,21 @@ static struct map_desc s5pv310_iodesc[] __initdata = {
>> ? ? ? ? ? ? ? .length ? ? ? ? = SZ_4K,
>> ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE,
>> ? ? ? }, {
>> - ? ? ? ? ? ? .virtual ? ? ? ?= (unsigned long)S5P_VA_GPIO,
>> + ? ? ? ? ? ? .virtual ? ? ? ?= (unsigned long)S5P_VA_GPIO1,
>> ? ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(S5PV310_PA_GPIO1),
>> ? ? ? ? ? ? ? .length ? ? ? ? = SZ_4K,
>> ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE,
>> ? ? ? }, {
>> + ? ? ? ? ? ? .virtual ? ? ? ?= (unsigned long)S5P_VA_GPIO2,
>> + ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(S5PV310_PA_GPIO2),
>> + ? ? ? ? ? ? .length ? ? ? ? = SZ_4K,
>> + ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE,
>> + ? ? }, {
>> + ? ? ? ? ? ? .virtual ? ? ? ?= (unsigned long)S5P_VA_GPIO3,
>> + ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(S5PV310_PA_GPIO3),
>> + ? ? ? ? ? ? .length ? ? ? ? = SZ_256K,
Why 256K?
>> + ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE,
>> + ? ? }, {
>> ? ? ? ? ? ? ? .virtual ? ? ? ?= (unsigned long)S5P_VA_DMC0,
>> ? ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(S5PV310_PA_DMC0),
>> ? ? ? ? ? ? ? .length ? ? ? ? = SZ_4K,
>> diff --git a/arch/arm/plat-s5p/include/plat/map-s5p.h b/arch/arm/plat-
>> s5p/include/plat/map-s5p.h
>> index ec96a19..fef353d 100644
>> --- a/arch/arm/plat-s5p/include/plat/map-s5p.h
>> +++ b/arch/arm/plat-s5p/include/plat/map-s5p.h
>> @@ -16,6 +16,9 @@
>> ?#define S5P_VA_CHIPID ? ? ? ? ? ? ? ?S3C_ADDR(0x02000000)
>> ?#define S5P_VA_CMU ? ? ? ? ? S3C_ADDR(0x02100000)
>> ?#define S5P_VA_GPIO ? ? ? ? ?S3C_ADDR(0x02200000)
>> +#define S5P_VA_GPIO1 ? ? ? ? S5P_VA_GPIO
>> +#define S5P_VA_GPIO2 ? ? ? ? S3C_ADDR(0x02240000)
>> +#define S5P_VA_GPIO3 ? ? ? ? S3C_ADDR(0x02280000)
>>
>> ?#define S5P_VA_SYSRAM ? ? ? ? ? ? ? ?S3C_ADDR(0x02400000)
>> ?#define S5P_VA_DMC0 ? ? ? ? ?S3C_ADDR(0x02440000)
>> --
>
> Looks ok to me...will apply.
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
