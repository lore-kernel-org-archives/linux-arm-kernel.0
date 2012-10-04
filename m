From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 4 Oct 2012 14:52:41 +1000
Subject: linux-next: manual merge of the signal tree with the modules and
 arm-soc trees
Message-ID: <20121004145241.fac039e78a15bb614cbd6da0@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Al,

Today's linux-next merge of the signal tree got conflicts in
arch/avr32/include/asm/Kbuild, arch/cris/include/asm/Kbuild,
arch/frv/include/asm/Kbuild, arch/h8300/include/asm/Kbuild,
arch/ia64/include/asm/Kbuild, arch/m32r/include/asm/Kbuild,
arch/microblaze/include/asm/Kbuild, arch/mn10300/include/asm/Kbuild and
arch/xtensa/include/asm/Kbuild between commit e7a570ff7dff ("asm-generic:
Add default clkdev.h") from the arm-soc tree, commit 786d35d45cc4 ("Make
most arch asm/module.h files use asm-generic/module.h") from the modules
tree and commit ddd03a1f7591 ("get rid of generic instances of
asm/exec.h") from the signal tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/avr32/include/asm/Kbuild
index e3ba7bc,aa47fff..0000000
--- a/arch/avr32/include/asm/Kbuild
+++ b/arch/avr32/include/asm/Kbuild
@@@ -1,5 -1,4 +1,6 @@@
  include include/asm-generic/Kbuild.asm
  
 +generic-y	+= clkdev.h
+ generic-y	+= exec.h
 +
  header-y	+= cachectl.h
diff --cc arch/cris/include/asm/Kbuild
index 6900bbf,b68ad4b..0000000
--- a/arch/cris/include/asm/Kbuild
+++ b/arch/cris/include/asm/Kbuild
@@@ -8,5 -8,4 +8,6 @@@ header-y += etraxgpio.
  header-y += rs485.h
  header-y += sync_serial.h
  
 +generic-y += module.h
 +generic-y += clkdev.h
+ generic-y += exec.h
diff --cc arch/frv/include/asm/Kbuild
index 13cd044,32c1646..0000000
--- a/arch/frv/include/asm/Kbuild
+++ b/arch/frv/include/asm/Kbuild
@@@ -2,4 -2,4 +2,6 @@@ include include/asm-generic/Kbuild.as
  
  header-y += registers.h
  header-y += termios.h
++
 +generic-y += clkdev.h
+ generic-y += exec.h
diff --cc arch/h8300/include/asm/Kbuild
index 98477e9,3a2af1a..0000000
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@@ -1,4 -1,2 +1,5 @@@
  include include/asm-generic/Kbuild.asm
 +
 +generic-y	+= module.h
 +generic-y	+= clkdev.h
+ generic-y += exec.h
diff --cc arch/ia64/include/asm/Kbuild
index 58f3d14,98efd48..0000000
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@@ -13,4 -13,4 +13,6 @@@ header-y += ptrace_offsets.
  header-y += rse.h
  header-y += ucontext.h
  header-y += ustack.h
++
 +generic-y += clkdev.h
+ generic-y += exec.h
diff --cc arch/m32r/include/asm/Kbuild
index 98477e9,7083403..0000000
--- a/arch/m32r/include/asm/Kbuild
+++ b/arch/m32r/include/asm/Kbuild
@@@ -1,4 -1,3 +1,5 @@@
  include include/asm-generic/Kbuild.asm
  
 +generic-y	+= module.h
 +generic-y	+= clkdev.h
+ generic-y += exec.h
diff --cc arch/microblaze/include/asm/Kbuild
index 48510f6,5a0e72b..0000000
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@@ -1,4 -1,4 +1,6 @@@
  include include/asm-generic/Kbuild.asm
  
  header-y  += elf.h
++
 +generic-y += clkdev.h
+ generic-y += exec.h
diff --cc arch/mn10300/include/asm/Kbuild
index 0d20f55,7083403..0000000
--- a/arch/mn10300/include/asm/Kbuild
+++ b/arch/mn10300/include/asm/Kbuild
@@@ -1,3 -1,3 +1,4 @@@
  include include/asm-generic/Kbuild.asm
  
 +generic-y += clkdev.h
+ generic-y += exec.h
diff --cc arch/xtensa/include/asm/Kbuild
index 0d20f55,7083403..0000000
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@@ -1,3 -1,3 +1,4 @@@
  include include/asm-generic/Kbuild.asm
  
 +generic-y += clkdev.h
+ generic-y += exec.h
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121004/c14c4154/attachment.sig>
