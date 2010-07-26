From: mmarek@suse.cz (Michal Marek)
Date: Mon, 26 Jul 2010 15:28:40 +0200
Subject: [PATCH v2] arm: Build with -fno-dwarf2-cfi-asm
In-Reply-To: <20100726131122.GD23399@n2100.arm.linux.org.uk>
References: <20100726131122.GD23399@n2100.arm.linux.org.uk>
Message-ID: <1280150920-17122-1-git-send-email-mmarek@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit d0679c7 restricted this workaround to powerpc only, but it turns
out that ARM needs it as well. Fixes
https://bugzilla.kernel.org/show_bug.cgi?id=16310 .

Reported-and-Tested-by: Robert Nelson <robertcnelson@gmail.com>
Acked-by: Mikael Pettersson <mikpe@it.uu.se>
Signed-off-by: Michal Marek <mmarek@suse.cz>
---

v2: changed commend as suggested by Mikael

---
 arch/arm/Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 64ba313..730d40c 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -21,6 +21,9 @@ GZFLAGS		:=-9
 # Explicitly specifiy 32-bit ARM ISA since toolchain default can be -mthumb:
 KBUILD_CFLAGS	+=$(call cc-option,-marm,)
 
+# Never generate .eh_frame
+KBUILD_CFLAGS	+= $(call cc-option,-fno-dwarf2-cfi-asm)
+
 # Do not use arch/arm/defconfig - it's always outdated.
 # Select a platform tht is kept up-to-date
 KBUILD_DEFCONFIG := versatile_defconfig
-- 
1.7.1
