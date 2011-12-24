From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 24 Dec 2011 10:10:26 +0900
Subject: [PATCH 09/12] ARM: EXYNOS: introduce
 arch/arm/mach-exynos/common.[ch]
In-Reply-To: <20111223191935.GS2577@n2100.arm.linux.org.uk>
References: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
 <1324385316-6052-10-git-send-email-kgene.kim@samsung.com>
 <20111223191935.GS2577@n2100.arm.linux.org.uk>
Message-ID: <088101ccc1d8$d2023b00$7606b100$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> On Tue, Dec 20, 2011 at 09:48:33PM +0900, Kukjin Kim wrote:
> > This patch introduces common.[ch] which are used only in the
> > arch/arm/mach-exynos/ directory. The common.c file merges
> > the cpu.c, init.c, irq-combiner.c and irq-eint.c files which
> > are used commonly on EXYNOS SoCs and the common.h file replaces
> > with plat/exynos4.h file.
> >
> > Cc: Ben Dooks <ben-linux@fluff.org>
> > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> 
Hi Russell,

Sorry for my late following up the restart work :(

> It looks like there's some changes made to exynos stuff between -rc1

Yes, some bug has been fixed after -rc1...

> (which my immutable restart-cleanup branch is based upon) and the base
> for this patch which makes it hard to apply:
> 
Oops, I created this based on your devel-stable as per your suggestion and I
couldn't look at 'restart-cleanup' and 'restart' branches in your git,
'http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-2.6-arm.git'
.

> Patching 7249/1...
> git apply --whitespace=fix -p1 --index --check > /tmp/pdb.2292 2>&1 exited
> with
> non-zero status: 256
> error: patch failed: arch/arm/mach-exynos/cpu.c:1
> error: arch/arm/mach-exynos/cpu.c: patch does not apply
> 
> Trying with GNU patch gives:
> 
> Patching 7249/1...
> patch -p1 -f -EF0 -N --dry-run > /tmp/pdb.2298 2>&1 exited with non-zero
> status: 256
> patching file arch/arm/mach-exynos/Makefile
> patching file arch/arm/mach-exynos/clock-exynos4210.c
> patching file arch/arm/mach-exynos/clock-exynos4212.c
> patching file arch/arm/mach-exynos/clock.c
> patching file arch/arm/mach-exynos/common.c
> patching file arch/arm/mach-exynos/common.h
> patching file arch/arm/mach-exynos/cpu.c
> Hunk #1 FAILED at 1.
> File arch/arm/mach-exynos/cpu.c is not empty after patch, as expected
> 1 out of 1 hunk FAILED -- saving rejects to file arch/arm/mach-
> exynos/cpu.c.rej
> patching file arch/arm/mach-exynos/include/mach/map.h
> patching file arch/arm/mach-exynos/init.c
> patching file arch/arm/mach-exynos/irq-combiner.c
> patching file arch/arm/mach-exynos/irq-eint.c
> patching file arch/arm/mach-exynos/mach-armlex4210.c
> Hunk #1 succeeded at 20 (offset -1 lines).
> Hunk #2 succeeded at 27 (offset -1 lines).
> Hunk #3 succeeded at 188 (offset -1 lines).
> patching file arch/arm/mach-exynos/mach-nuri.c
> Hunk #1 succeeded at 37 (offset -1 lines).
> Hunk #2 succeeded at 53 (offset -1 lines).
> Hunk #3 succeeded at 1284 (offset -1 lines).
> patching file arch/arm/mach-exynos/mach-origen.c
> Hunk #1 succeeded at 28 (offset -1 lines).
> Hunk #2 succeeded at 42 (offset -1 lines).
> Hunk #3 succeeded at 639 (offset -1 lines).
> patching file arch/arm/mach-exynos/mach-smdk4x12.c
> Hunk #1 succeeded at 27 (offset -1 lines).
> Hunk #2 succeeded at 35 (offset -1 lines).
> Hunk #3 succeeded at 250 (offset -1 lines).
> patching file arch/arm/mach-exynos/mach-smdkv310.c
> Hunk #1 succeeded at 27 (offset -1 lines).
> Hunk #2 succeeded at 42 (offset -1 lines).
> Hunk #3 succeeded at 333 (offset -1 lines).
> patching file arch/arm/mach-exynos/mach-universal_c210.c
> Hunk #1 succeeded at 27 (offset -1 lines).
> Hunk #2 succeeded at 46 (offset -1 lines).
> Hunk #3 succeeded at 993 (offset -1 lines).
> patching file arch/arm/plat-s5p/Makefile
> patching file arch/arm/plat-s5p/cpu.c
> patching file arch/arm/plat-samsung/include/plat/cpu.h
> patching file arch/arm/plat-samsung/include/plat/exynos4.h
> 
> So I can't apply this, and this in turn means I can't provide Nicolas with
> a tree this evening for his arch_idle changes.
> 
So, isn't there any required my effort for it?

> Given the proximity to Christmas, and I'm _not_ planning to work from this
> evening until after the new year, things will now have to just sit and
> wait
> until after the festive period.

Hmm...yeah...
Anyway, Russell, Merry Christmas to you and your family ;)

> 
> I'll push out what I have been able to merge later this evening, but it
> will not include the exynos patches.

How should I do for including exynos-restart? Please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
