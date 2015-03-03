From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 3 Mar 2015 08:29:49 +0100
Subject: [PATCH 8/9] ARM: EXYNOS: suspend requires regulator access
In-Reply-To: <2062492.pEav958W9c@wuerfel>
References: <1423769746-582629-1-git-send-email-arnd@arndb.de>
 <2062492.pEav958W9c@wuerfel>
Message-ID: <CABxcv=kMCiLui82eC6MNbH80qzdyzkJfUPgD3oWWfgL4voRTWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On Mon, Mar 2, 2015 at 10:28 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Building an exynos kernel without regulators but with suspend enabled results
> in a link error:
>
> arch/arm/mach-exynos/built-in.o: In function `exynos_suspend_finish':
> arch/arm/mach-exynos/suspend.c:532: undefined reference to `regulator_suspend_finish'
> arch/arm/mach-exynos/built-in.o: In function `exynos_suspend_prepare':
> arch/arm/mach-exynos/suspend.c:515: undefined reference to `regulator_suspend_prepare'
>
> This adds an appropriate 'select' statement in Kconfig to ensure the symbols
> are available.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

The patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
