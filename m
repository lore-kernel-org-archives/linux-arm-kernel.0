From: andreyknvl@google.com (Andrey Konovalov)
Date: Fri, 12 Jan 2018 17:49:57 +0100
Subject: [PATCH 2/2] kasan: clean up KASAN_SHADOW_SCALE_SHIFT usage
In-Reply-To: <c8f1d954-64fe-1e9c-d8ba-94e880de2501@virtuozzo.com>
References: <cover.1515684162.git.andreyknvl@google.com>
 <ff221eca3db7a1f208c30c625b7d209fba33abb9.1515684162.git.andreyknvl@google.com>
 <c8f1d954-64fe-1e9c-d8ba-94e880de2501@virtuozzo.com>
Message-ID: <CAAeHK+y=1YedHu=+1pjau=2cYh822vGuNLK_6Q4gYh9eGZBeMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 11, 2018 at 10:59 PM, Andrey Ryabinin
<aryabinin@virtuozzo.com> wrote:
>
>
> On 01/11/2018 06:29 PM, Andrey Konovalov wrote:
>
>> diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasan.h
>> index e266f80e45b7..811643fe7640 100644
>> --- a/arch/arm64/include/asm/kasan.h
>> +++ b/arch/arm64/include/asm/kasan.h
>> @@ -27,7 +27,8 @@
>>   * should satisfy the following equation:
>>   *      KASAN_SHADOW_OFFSET = KASAN_SHADOW_END - (1ULL << 61)
>
> Care to update comments as well?

Sure, done in v2.

>
>>   */
>> -#define KASAN_SHADOW_OFFSET     (KASAN_SHADOW_END - (1ULL << (64 - 3)))
>> +#define KASAN_SHADOW_OFFSET     (KASAN_SHADOW_END - (1ULL << \
>> +                                     (64 - KASAN_SHADOW_SCALE_SHIFT)))
>>
>>  void kasan_init(void);
>>  void kasan_copy_shadow(pgd_t *pgdir);
