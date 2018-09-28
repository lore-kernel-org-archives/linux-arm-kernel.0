From: joe@perches.com (Joe Perches)
Date: Fri, 28 Sep 2018 14:51:26 -0700
Subject: Bad MAINTAINERS pattern in section 'ARM/SAMSUNG S5P SERIES Multi
 Format Codec (MFC) SUPPORT'
Message-ID: <20180928215127.28790-1-joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	2009	ARM/SAMSUNG S5P SERIES Multi Format Codec (MFC) SUPPORT
	2010	M:	Kyungmin Park <kyungmin.park@samsung.com>
	2011	M:	Kamil Debski <kamil@wypas.org>
	2012	M:	Jeongtae Park <jtp.park@samsung.com>
	2013	M:	Andrzej Hajda <a.hajda@samsung.com>
	2014	L:	linux-arm-kernel at lists.infradead.org
	2015	L:	linux-media at vger.kernel.org
	2016	S:	Maintained
-->	2017	F:	arch/arm/plat-samsung/s5p-dev-mfc.c
	2018	F:	drivers/media/platform/s5p-mfc/

Commit that introduced this:

commit 7683e9e529258d01ce99216ad3be21f59eff83ec
 Author: Linus Torvalds <torvalds@linux-foundation.org>
 Date:   Sun Jul 23 16:06:21 2017 -0700
 
     Properly alphabetize MAINTAINERS file
     
     This adds a perl script to actually parse the MAINTAINERS file, clean up
     some whitespace in it, warn about errors in it, and then properly sort
     the end result.
     
     My perl-fu is atrocious, so the script has basically been created by
     randomly putting various characters in a pile, mixing them around, and
     then looking it the end result does anything interesting when used as a
     perl script.
     
     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
 
  MAINTAINERS                  | 3585 +++++++++++++++++++++---------------------
  scripts/parse-maintainers.pl |   77 +
  2 files changed, 1868 insertions(+), 1794 deletions(-)

Last commit with arch/arm/plat-samsung/s5p-dev-mfc.c

commit b93b315d444faa1505b6a5e001c30f3024849e46
Author: Kukjin Kim <kgene@kernel.org>
Date:   Thu Jul 30 01:48:17 2015 +0900

    ARM: SAMSUNG: make local s5p-dev-mfc in mach-exynos
    
    This patch moves s5p-dev-mfc from plat-samsung into mach-exynos
    because it is used for only exynos no other platforms.
    
    Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
    Signed-off-by: Kukjin Kim <kgene@kernel.org>

 arch/arm/mach-exynos/Kconfig                         | 5 +++++
 arch/arm/mach-exynos/Makefile                        | 2 ++
 arch/arm/{plat-samsung => mach-exynos}/s5p-dev-mfc.c | 0
 arch/arm/plat-samsung/Kconfig                        | 5 -----
 arch/arm/plat-samsung/Makefile                       | 1 -
 5 files changed, 7 insertions(+), 6 deletions(-)
