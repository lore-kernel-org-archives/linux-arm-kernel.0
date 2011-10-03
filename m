From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 03 Oct 2011 21:40:36 +0900
Subject: [PATCH] ARM: EXYNOS: Add ARCH_EXYNOS and reorganize
	arch/arm/mach-exynos
In-Reply-To: <5785830.Sj7W4aL3qy@wuerfel>
References: <001f01cc80e5$3abd1c80$b0375580$%kim@samsung.com>
	<CAH9JG2UNwZxDTPnwjohxhCumKZx_mWcPUn2rROjmjmROoxF07w@mail.gmail.com>
	<5785830.Sj7W4aL3qy@wuerfel>
Message-ID: <4E89AD44.80609@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/11 18:33, Arnd Bergmann wrote:
> On Monday 03 October 2011 13:02:16 Kyungmin Park wrote:
>> I'm afraid to change machine directory name again. mach-s5pv310 ->
>> mach-exynos4 ->  mach-exynos.
>> As I remember linus blamed the renaming the file names are happened
>> frequently at ARM
>
> I tend to agree with this. While the new name does make more sense,
> I would first like to see the bigger plan. If you are eventually
> planning to consolidate all of mach-s5p64x0, mach-s5pc100, mach-s5pv210,
> mach-exynos4 and plat-s5p into one common mach-s5p or mach-exynos
> directory, I'm all for that because it reduces code duplication
> and work required for the overall cross-subarchitecture single zimage
> work.
>
Yes, absolutely. As I said, the 'mach-exynos' can support upcoming 
Samsung EXYNOS SoCs and the way is better than making mach-exynos5.

My bigger plan is finally to make current directories to 3 mach- dir. 
(mach-s3c, mach-s5p, and mach-exynos) and 1 plat-samsung directory. Of 
course, the mach- directories can be reduced later.

Firstly, as you can see, I'm merging plat-s3c24xx and plat-s5p into one 
plat-samsung directory and actually the <plat/*.h> files and dev-*.c 
files have been moved into plat-samsung. Maybe I can finish it during 
3.2-rc.

Secondary, upcoming Samsung EXYNOS SoCs will be supported in mach-exynos 
directory and this patch is required to that. For example, the EXYNOS5 
SoCs (Cortex A15) will be supported in that with other EXYNOS4 SoCs soon 
and of course it reduces code duplication :)

And then current mach-s5pxxxx stuff will be merged into mach-s5p. As I 
talked to Ben Dooks, he also have a plan to merging mach-s3cxxxx stuff.

> Simply renaming something because the name does not quite fit entirely
> should be done very carefully.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
