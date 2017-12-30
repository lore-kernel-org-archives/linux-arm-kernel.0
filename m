From: contact@paulk.fr (Paul Kocialkowski)
Date: Sat, 30 Dec 2017 16:08:59 +0100
Subject: [PATCH] arm64: Target aarch64elf emulation to allow bare-metal
 toolchains
Message-ID: <20171230150859.28471-1-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This sets the LDFLAGS variable to target the aarch64elf emulation
instead of aarch64linux, which is incompatible with bare-metal
toolchains.

This change allows the kernel to build with bare-metal toolchains again.

Fixes: 3d6a7b99e3fa ("arm64: ensure the kernel is compiled for LP64")

Cc: stable at vger.kernel.org
Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm64/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index b481b4a7c011..a249233edcd8 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -64,14 +64,14 @@ KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__AARCH64EB__
 AS		+= -EB
 LD		+= -EB
-LDFLAGS		+= -maarch64linuxb
+LDFLAGS		+= -maarch64elfb
 UTS_MACHINE	:= aarch64_be
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
 CHECKFLAGS	+= -D__AARCH64EL__
 AS		+= -EL
 LD		+= -EL
-LDFLAGS		+= -maarch64linux
+LDFLAGS		+= -maarch64elf
 UTS_MACHINE	:= aarch64
 endif
 
-- 
2.15.1
