From: gang.chen@asianux.com (Chen Gang)
Date: Mon, 20 May 2013 12:19:31 +0800
Subject: [PATCH] arm64: compiling issue for allmodconfig, need "asm/parport.h"
 by "drivers/parport/parport_pc.c"
In-Reply-To: <20130424110511.GK23397@arm.com>
References: <5177551D.8090007@asianux.com> <20130424082237.GA23397@arm.com>
 <5177B1F0.10106@asianux.com>
 <20130424102327.GF21850@mudshark.cambridge.arm.com>
 <5177BAD0.9000500@asianux.com> <20130424110511.GK23397@arm.com>
Message-ID: <5199A453.4080402@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Need add the default file in 'asm/Kbuild' just like arm has done.

The build command is:
  make EXTRA_CFLAGS=-W ARCH=arm64 allmodconfig
  make EXTRA_CFLAGS=-W ARCH=arm64 menuconfig
    set "aarch64-linux-gnu-" as cross compiling prefix.
  make EXTRA_CFLAGS=-W ARCH=arm64

The related error:
  drivers/parport/parport_pc.c:67:25: fatal error: asm/parport.h: No such file or directory


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm64/include/asm/Kbuild |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 79a642d..9005e81 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -25,6 +25,7 @@ generic-y += local64.h
 generic-y += mman.h
 generic-y += msgbuf.h
 generic-y += mutex.h
+generic-y += parport.h
 generic-y += pci.h
 generic-y += percpu.h
 generic-y += poll.h
-- 
1.7.7.6
