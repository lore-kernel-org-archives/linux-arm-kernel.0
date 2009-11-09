From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 9 Nov 2009 11:41:19 +0900
Subject: [PATCH 01/17] ARM: MM: use 64bytes of L1 cache on plat S5PC1xx
In-Reply-To: <20091108235847.GE4808@trinity.fluff.org>
References: <1255421482-26455-1-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-2-git-send-email-m.szyprowski@samsung.com>
	<20091108235847.GE4808@trinity.fluff.org>
Message-ID: <9c9fda240911081841t978292ch52befaf0fd5e510f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

It's missing of "From".

Actually I don't care who send and from. I just want to merge the
s5pc1xx series patches to mainline ASAP .

Thank you,
Kyungmin Park

On Mon, Nov 9, 2009 at 8:58 AM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Tue, Oct 13, 2009 at 10:11:06AM +0200, Marek Szyprowski wrote:
>> Samsung S5PC1xx SoCs are Coretex8 based, so use 64 bytes of L1 cache
>> line instead of the default 32 bytes.
>>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> This worries me, either this patch was from 'Kyungmin Park' and thus
> should have either been sent by, or have an 'From:' line at the top
> of the description. If this has been appraised by Kyungmin then the
> signoff should either be after Marek's (as this is the sender) or be
> something other than a signed-off-by.
>
>> ---
>> ?arch/arm/mm/Kconfig | ? ?2 +-
>> ?1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
>> index e993140..9cf7706 100644
>> --- a/arch/arm/mm/Kconfig
>> +++ b/arch/arm/mm/Kconfig
>> @@ -777,5 +777,5 @@ config CACHE_XSC3L2
>>
>> ?config ARM_L1_CACHE_SHIFT
>> ? ? ? int
>> - ? ? default 6 if ARCH_OMAP3
>> + ? ? default 6 if ARCH_OMAP3 || ARCH_S5PC1XX
>> ? ? ? default 5
>> --
>> 1.6.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> --
> --
> Ben
>
> Q: ? ? ?What's a light-year?
> A: ? ? ?One-third less calories than a regular year.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
