From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed,  8 Nov 2017 01:31:45 +0900
Subject: [PATCH 0/2] kbuild: remove all "obj- := dummy.o" tricks
Message-ID: <1510072307-16819-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This clean-up was prompted by Sam
when I refactored DT building:
https://patchwork.kernel.org/patch/10041881/

If you want to test this series,
apply the following 3 patches:
https://patchwork.kernel.org/patch/10037891/
https://patchwork.kernel.org/patch/10041877/
https://patchwork.kernel.org/patch/10041881/

I CCed DT forks to informs them of conflicts
with those patches Rob Herring offered to apply.
I doubt if he wants to review this series...



Masahiro Yamada (2):
  kbuild: create built-in.o automatically if parent directory wants it
  kbuild: remove all dummy assignments to obj-

 Makefile                                  | 2 +-
 arch/arm/mach-uniphier/Makefile           | 1 -
 arch/mips/boot/dts/brcm/Makefile          | 3 ---
 arch/mips/boot/dts/cavium-octeon/Makefile | 3 ---
 arch/mips/boot/dts/img/Makefile           | 3 ---
 arch/mips/boot/dts/ingenic/Makefile       | 3 ---
 arch/mips/boot/dts/lantiq/Makefile        | 3 ---
 arch/mips/boot/dts/mti/Makefile           | 3 ---
 arch/mips/boot/dts/netlogic/Makefile      | 3 ---
 arch/mips/boot/dts/ni/Makefile            | 3 ---
 arch/mips/boot/dts/pic32/Makefile         | 3 ---
 arch/mips/boot/dts/qca/Makefile           | 3 ---
 arch/mips/boot/dts/ralink/Makefile        | 3 ---
 arch/mips/boot/dts/xilfpga/Makefile       | 3 ---
 firmware/Makefile                         | 3 ---
 samples/bpf/Makefile                      | 3 ---
 samples/hidraw/Makefile                   | 3 ---
 samples/seccomp/Makefile                  | 3 ---
 samples/sockmap/Makefile                  | 3 ---
 samples/statx/Makefile                    | 3 ---
 samples/uhid/Makefile                     | 3 ---
 scripts/Makefile.build                    | 4 ++--
 22 files changed, 3 insertions(+), 61 deletions(-)

-- 
2.7.4
