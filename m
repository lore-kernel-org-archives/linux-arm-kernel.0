From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 4 Oct 2012 14:29:44 +1000
Subject: linux-next: manual merge of the arm-soc tree with the modules tree
Message-ID: <20121004142944.70f5ebb6dbc197322b04bfea@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got conflicts in
arch/cris/include/asm/Kbuild, arch/h8300/include/asm/Kbuild and
arch/m32r/include/asm/Kbuild between commit 786d35d45cc4 ("Make most arch
asm/module.h files use asm-generic/module.h") from the modules tree and
commit e7a570ff7dff ("asm-generic: Add default clkdev.h") from the
arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/cris/include/asm/Kbuild
index 28b690d,a8eab26..0000000
--- a/arch/cris/include/asm/Kbuild
+++ b/arch/cris/include/asm/Kbuild
@@@ -8,4 -8,4 +8,5 @@@ header-y += etraxgpio.
  header-y += rs485.h
  header-y += sync_serial.h
  
 +generic-y += module.h
+ generic-y += clkdev.h
diff --cc arch/h8300/include/asm/Kbuild
index 871382d,0e152a9..0000000
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@@ -1,3 -1,3 +1,4 @@@
  include include/asm-generic/Kbuild.asm
  
 +generic-y	+= module.h
+ generic-y	+= clkdev.h
diff --cc arch/m32r/include/asm/Kbuild
index 871382d,0e152a9..0000000
--- a/arch/m32r/include/asm/Kbuild
+++ b/arch/m32r/include/asm/Kbuild
@@@ -1,3 -1,3 +1,4 @@@
  include include/asm-generic/Kbuild.asm
  
 +generic-y	+= module.h
+ generic-y	+= clkdev.h
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121004/dcfb7b18/attachment.sig>
