From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 4 Apr 2016 10:57:56 +0900
Subject: [RFC PATCH 0/9] ARM: start to move arch/arm/mach-* to
 arch/arm/platforms/*
In-Reply-To: <20160403182543.GQ19428@n2100.arm.linux.org.uk>
References: <1459694367-18635-1-git-send-email-yamada.masahiro@socionext.com>
 <20160403182543.GQ19428@n2100.arm.linux.org.uk>
Message-ID: <CAK7LNAR4sNgUwGskvNZcs84aDsmUjifff7V8xUjCjdjCETbtLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

2016-04-04 3:25 GMT+09:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Sun, Apr 03, 2016 at 11:39:18PM +0900, Masahiro Yamada wrote:
>> We have growing number of mach-* directories in arch/arm, and I guess
>> it might be a good time to discuss moving them into a sub-directory.
>
> What does it buy us?  Let me summarise the actual change:
>
> - Move up to 71 arch/arm/mach-* directories to arch/arm/platforms/*,
>   which just means another level of directory structure.  We still
>   end up with up to 71 directories in arch/arm/platforms/

True, but we can separate non-SoC directories (kernel/, mm/, configs/, etc.)
from mach- directories, at least.


> - The ability to use obj-y rather than machine-y, where both already
>   work in the same way.

Yes, but Kbuild standard Makefiles might provide more flexible
directory structures
to tidy up similar SoC families from the same vendor.

For example,

arch/arm/platforms/samsung/
arch/arm/platforms/samsung/exynos/
arch/arm/platforms/samsung/s3c64xx/

instead of

arch/arm/plat-samsung/
arch/arm/mach-exynos/
arch/arm/mach-s3c64xx/

I am missing something, though.



> Is there anything I missed?
>
> If that is all, then I really do not like this change - it's seems
> to be churn for no benefit, and that's something we really should be
> minimising.  Linus Torvalds has historically moaned at the ARM
> architecture for stuff like this.

OK.


-- 
Best Regards
Masahiro Yamada
