From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 May 2015 16:46:38 +0200
Subject: [PATCH] ARM: zx: fix building with CONFIG_THUMB2_KERNEL
In-Reply-To: <CABymUCP=unny8rORcm4ki-izCsaoWysUQ2gUtro0-T1RV3Ad-g@mail.gmail.com>
References: <2771121.xOQTA4CzPC@wuerfel>
 <CABymUCP=unny8rORcm4ki-izCsaoWysUQ2gUtro0-T1RV3Ad-g@mail.gmail.com>
Message-ID: <29857847.dJSqWUUsqW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 May 2015 21:04:34 Jun Nie wrote:
> 2015-05-21 16:36 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> > The newly added zx platform causes a build error when
> > CONFIG_THUMB2_KERNEL is enabled:
> >
> > arch/arm/mach-zx/headsmp.S:16: Error: invalid immediate for address calculation (value = 0x00000004)
> >
> > I'm assuming that the ROM code that is calling these entry
> > points runs in ARM mode, so there would be another problem
> > in the same file, and we can solve both problems at once
> > by adding a '.arm' statement that will make zx_resume_jump
> > and zx_secondary_startup both be built as ARM code.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > Hi Jun,
> >
> > This patch fixes a build error with mach-zx, but I don't know if it's
> > actually correct. Can you check if the machine correctly boots
> > with this patch enabled and CONFIG_THUMB2_KERNEL=y set in the .config?
> >
> Arnd,
> 
> I add CONFIG_THUMB2_KERNEL=y in defconfig and reproduce the build
> error. Your change does fix the bug and boot/cpu_hotplug works well.
> Thanks for your work!
> 

Ok, thanks for testing, I've applied the patch to next/soc now.

	Arnd
