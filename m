From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 08 Jul 2014 16:10:47 +0200
Subject: [PATCH 18/19] ARM: SAMSUNG: Remove remaining legacy code
In-Reply-To: <4267278.JdVSGvRhtr@wuerfel>
References: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
 <1404496099-26708-19-git-send-email-t.figa@samsung.com>
 <4267278.JdVSGvRhtr@wuerfel>
Message-ID: <53BBFBE7.5080209@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.07.2014 22:23, Arnd Bergmann wrote:
> On Friday 04 July 2014 19:48:18 Tomasz Figa wrote:
>> After refactoring suspend/resume, which was last part with dependencies
>> on legacy code, all Kconfig symbols related to Samsung ATAGS support can
>> be deselected and more unused code removed. This includes most of s5p-*
>> code as well, as s5pv210 was their last user.
>>
>> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> 
> I actually found a few more, see patch below. Feel free to merge it
> into yours.

Will add your patch to this series, if sending v2. Otherwise I guess it
could be applied on top of it.

> 
> As discussed on IRC, I have also done an experimental patch to move
> the few contents of mach-s5pv210 into mach-exynos, which turned out
> very simple and should be uncontroversial but needs more testing.
> 
> Finally, there is some more cleanup potential in moving things out
> of plat-samsung into the individual platforms (s3c24xx, s3c64xx,
> exynos including s5pv210), as a lot of files are now only used
> on one of them.
> 
> I tried moving everything that the combined mach-exynos needs out
> of plat-samsung, but that resulted in about 500-600 lines of duplication
> between s3c and exynos for pm-common.c, pm-common.h, pmdebug.c
> and pm-check.c, so those four files should probably remain shared
> for now.

OK.

Best regards,
Tomasz
