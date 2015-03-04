From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Mar 2015 22:14:01 +0100
Subject: [PATCH 8/9] ARM: EXYNOS: suspend requires regulator access
In-Reply-To: <CAJKOXPf6eY4oZZe3tG51QnRhsvFuOVRmYsEpc4g0bwyAfip0EQ@mail.gmail.com>
References: <1423769746-582629-1-git-send-email-arnd@arndb.de>
 <2062492.pEav958W9c@wuerfel>
 <CAJKOXPf6eY4oZZe3tG51QnRhsvFuOVRmYsEpc4g0bwyAfip0EQ@mail.gmail.com>
Message-ID: <4263601.lmZODAZr9H@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 March 2015 20:44:07 Krzysztof Koz?owski wrote:
> W dniu poniedzia?ek, 2 marca 2015 Arnd Bergmann <arnd@arndb.de> napisa?(a):
> >
> > Building an exynos kernel without regulators but with suspend enabled results
> > in a link error:
> >
> > arch/arm/mach-exynos/built-in.o: In function `exynos_suspend_finish':
> > arch/arm/mach-exynos/suspend.c:532: undefined reference to `regulator_suspend_finish'
> > arch/arm/mach-exynos/built-in.o: In function `exynos_suspend_prepare':
> > arch/arm/mach-exynos/suspend.c:515: undefined reference to `regulator_suspend_prepare'
> >
> > This adds an appropriate 'select' statement in Kconfig to ensure the symbols
> > are available.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> 
> Isn't this fixed already by: https://lkml.org/lkml/2015/2/4/119
> (applied by Mark Brown)?
> 
> I can't test it now (I am out of office) but issue looks quite similar.
> 
> 

Yes, that is probably right.

Thanks,

	Arnd
