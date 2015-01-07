From: moon.linux@yahoo.com (Anand Moon)
Date: Wed, 7 Jan 2015 14:39:07 +0000 (UTC)
Subject: [PATCH v2] ARM: exynos_defconfig: Enable CONFIG_LOCKUP_DETECTOR
In-Reply-To: <1420640600.32552.7.camel@AMDC1943>
References: <1420635542-7202-1-git-send-email-moon.linux@yahoo.com>
 <1420637261.32552.4.camel@AMDC1943>
 <157605903.5809859.1420638996780.JavaMail.yahoo@jws10677.mail.bf1.yahoo.com>
 <1420640600.32552.7.camel@AMDC1943>
Message-ID: <1208619911.5855211.1420641548080.JavaMail.yahoo@jws106113.mail.bf1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Kszysztof KozlowskiHi,

Sorry for the noise. Drop it.


-Anand Moon



On Wednesday, January 7, 2015 7:53 PM, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
On ?ro, 2015-01-07 at 13:56 +0000, Anand Moon wrote:
> Hi Kszysztof Kozlowski,
> 
> I picked up the bellow line from 
> 
> 
> Documentation/locking/lockdep-design.txt  line no 18
> 
> I understand that by enabling this flag we could detect possible 
> 
> deadlock situation with the kernel. Sorry for the noise.

...and lockdep-design.txt describes LOCKDEP. Not LOCKUP. So why you are
enabling lockup?

Best regards,
Krzysztof


> 
> 
> -Anand Moon
> 
> 
> 
> On Wednesday, January 7, 2015 6:57 PM, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> On ?ro, 2015-01-07 at 18:29 +0530, Anand Moon wrote:
> > Enable CONFIG_LOCKUP_DETECTOR to validate kernel locks state for exynos SOC.
> > 
> > Enabling CONFIG_LOCKUP_DETECTOR help validator tracks the 'state' of lock-classes,
> > and it tracks dependencies between different lock-classes.
> > The validator maintains a rolling proof that the state and
> > the dependencies are correct.
> 
> Unfortunately this is not correct. Lockup detector does something else.
> Please read the help/manual for LOCKUP_DETECTOR. You can find in
> lib/Kconfig.debug (around line 667).
> 
> Best regards,
> Krzysztof
> 
> > 
> > Changes since v2:
> >  * Made commit message more clear
> >  * Corrected grammer in code comment
> > 
> > Tested on Exynos5422 ODROID XU3 board.
> > 
> > Signed-off-by: Anand Moon <moon.linux@yahoo.com>
> > Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > ---
> >  arch/arm/configs/exynos_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> > index 5ef14de..ecd9987 100644
> > --- a/arch/arm/configs/exynos_defconfig
> > +++ b/arch/arm/configs/exynos_defconfig
> > @@ -178,6 +178,7 @@ CONFIG_PRINTK_TIME=y
> >  CONFIG_DEBUG_FS=y
> >  CONFIG_MAGIC_SYSRQ=y
> >  CONFIG_DEBUG_KERNEL=y
> > +CONFIG_LOCKUP_DETECTOR=y
> >  CONFIG_DETECT_HUNG_TASK=y
> >  CONFIG_DEBUG_RT_MUTEXES=y
> >  CONFIG_DEBUG_SPINLOCK=y
