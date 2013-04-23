From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 24 Apr 2013 00:02:29 +0900
Subject: [PATCH v2 2/3] ARM: EXYNOS: Fix support of Exynos4210 rev0 SoC
In-Reply-To: <1696892.zdvbYPFFr0@amdc1227>
References: <1366036922-4103-1-git-send-email-t.figa@samsung.com>
 <201304222310.34775.arnd@arndb.de> <517692FD.9080005@samsung.com>
 <1696892.zdvbYPFFr0@amdc1227>
Message-ID: <5176A285.9030009@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/13 23:26, Tomasz Figa wrote:
> Hi Kukjin,

[...]

>>> Acked-by: Arnd Bergmann<arnd@arndb.de>
>>>
>>> Note that it would be helpful to mention here that this is required for
>>> the calling samsung_timer_init from the exynos4-dt.c file.
>>
>> I did 'amend' as per your suggestion and added your ack on this series.
>>
>> Thanks.
>>
>> - Kukjin
>
> Since the samsung-time rework patches were replaced with a non-invasive subset
> with different semantics (going to send them in a while), this patch should be
> replaced with new version I'm going to send (in a while as well).
>
Oh, OK. You want to replace with new patches you will send. I dropped 
this series in my late dt branch.

BTW, the series should depend on your samsung-time patches, right?

One more note, this makes following build error.

arch/arm/mach-exynos/built-in.o: In function `exynos_init_time':
arch/arm/mach-exynos/common.c:424: undefined reference to 
`samsung_timer_init'
make: *** [vmlinux] Error 1

Thanks.

- Kukjin
