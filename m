From: joe@perches.com (Joe Perches)
Date: Fri, 28 Sep 2018 14:51:32 -0700
Subject: Bad MAINTAINERS pattern in section 'ARM/Synaptics Berlin SoC support'
Message-ID: <20180928215132.28867-1-joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	2111	ARM/Synaptics Berlin SoC support
	2112	M:	Jisheng Zhang <Jisheng.Zhang@synaptics.com>
	2113	M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
	2114	L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
	2115	S:	Maintained
	2116	F:	arch/arm/mach-berlin/
	2117	F:	arch/arm/boot/dts/berlin*
-->	2118	F:	arch/arm64/boot/dts/marvell/berlin*

Commit that introduced this:

commit bc52497a595d2246923749177d99e4216703b0f4
 Author: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
 Date:   Fri Mar 30 11:02:11 2018 +0800
 
     MAINTAINERS: update entry for ARM/berlin
     
     Synaptics has acquired the Multimedia Solutions Business of Marvell[1].
     So change the berlin entry name and move it to its alphabetical
     location. We move to ARM/Synaptics instead of ARM/Marvell.
     
     This patch also updates my email address from marvell to synaptics.
     
     [1] https://www.synaptics.com/company/news/conexant-marvell
     
     Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
     Reviewed-by: Andrew Lunn <andrew@lunn.ch>
     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
 
  MAINTAINERS | 18 +++++++++---------
  1 file changed, 9 insertions(+), 9 deletions(-)

Last commit with arch/arm64/boot/dts/marvell/berlin*

commit 031106ce95a201f6dd4c5ebf35abb900cf34e2ba
Author: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Date:   Wed May 16 17:43:28 2018 +0800

    arm64: dts: move berlin SoC files from marvell dir to synaptics dir
    
    Move device tree files as part of transition from Marvell berlin to
    Synaptics berlin.
    
    Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

 arch/arm64/boot/dts/Makefile                                 | 1 +
 arch/arm64/boot/dts/marvell/Makefile                         | 4 ----
 arch/arm64/boot/dts/synaptics/Makefile                       | 4 ++++
 arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct-dmp.dts | 0
 arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct-stb.dts | 0
 arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct.dtsi    | 0
 6 files changed, 5 insertions(+), 4 deletions(-)
