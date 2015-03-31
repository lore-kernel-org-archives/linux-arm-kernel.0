From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 31 Mar 2015 11:26:03 +0200
Subject: [PATCH] ARM: fix exynos randconfig build error
In-Reply-To: <20150330213742.GO24899@n2100.arm.linux.org.uk>
References: <E1YQa78-0000O0-A4@rmk-PC.arm.linux.org.uk>
 <14257250.yOR9pFcIkO@amdc1032> <20150330213742.GO24899@n2100.arm.linux.org.uk>
Message-ID: <9274849.uVSoggUUTC@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Monday, March 30, 2015 10:37:42 PM Russell King - ARM Linux wrote:
> On Tue, Mar 03, 2015 at 01:44:34PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > 
> > Hi,
> > 
> > On Tuesday, March 03, 2015 04:40:02 AM Kukjin Kim wrote:
> > > On 02/27/15 06:30, Kukjin Kim wrote:
> > > > On 02/25/15 20:46, Krzysztof Kozlowski wrote:
> > > >> 2015-02-25 12:26 GMT+01:00 Russell King <rmk+kernel@arm.linux.org.uk>:
> > > >>> The following error was observed with SMP=n in v4.0-rc1:
> > > >>>
> > > >>> arch/arm/mach-exynos/pm.c: In function 'exynos_cpu0_enter_aftr':
> > > >>> arch/arm/mach-exynos/pm.c:246:4: error: implicit declaration of function 'arch_send_wakeup_ipi_mask' [-Werror=implicit-function-declaration]
> > > >>>
> > > >>> As the code unconditionally calls a function only available with SMP=y,
> > > >>> make the Exynos PM support depend on SMP.
> > > >>>
> > > >>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > > >>
> > > >> Hi,
> > > >>
> > > >> Thanks for the patch but this already waits for Kukjin top be picked
> > > >> up. The first patch was similar to yours (adds dependency on SMP),
> > > >> sent on 4th of February:
> > > >> https://patchwork.ozlabs.org/patch/436231/
> > > >>
> > > >> But later Bartlomiej fixed this in other way (allowing to use cpuidle
> > > >> on non-SMP):
> > > >> https://patchwork.ozlabs.org/patch/436445/
> > > >>
> > > >> Unfortunately none of them were picked up.
> > > >>
> > > > I've missed the fix, sorry.
> > > > 
> > > > BTW, as you know, all of exynos SoCs are based on SMP so generally (in
> > > > normal case) there is no reason to use non-SMP on exynos
> > > > platforms...even though I understand the build error should be fixed...
> > > > 
> > > > Anyway, I'll have a look Bart's patch and Russell's fix in this weekend.
> > > > 
> > > 
> > > Firstly, let me take rmk's patch for the randconfig build error...BTW
> > 
> > What is wrong with picking my patch instead?  It is non-invasive and fixes
> > cpuidle support on UP (which is a regression from previous kernels)?
> > 
> > https://lkml.org/lkml/2015/2/4/521
> > 
> > > I'm still wondering exynos stuff needs to support non-SMP and need to
> > > think more about its usefulness?...
> > 
> > Currently UP is supported and at least I find it useful for testing/debug
> > purposes.  If you want to to make Exynos SMP only thats OK but it should
> > be done globally for Exynos arch support not just for cpuidle support.
> 
> Has either of these happened yet?  I don't see either in arm-soc.
> 
> (lkml.org seems to be - as seems typical - having problems.  The above
> URL now returns a blank message.)

My fix has been in Kukjin's tree (and thus linux-next) for the last two weeks:
http://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/commit/?h=v4.0-samsung-fixes-2&id=cfdda3535f87e752780ca18a57d13db58f6a6913

Unfortunately it seems that Samsung fixes branch has not been pushed to
arm-soc tree yet.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
