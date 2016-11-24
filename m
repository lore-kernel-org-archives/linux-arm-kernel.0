From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Thu, 24 Nov 2016 16:10:28 +0000
Subject: [kvm-unit-tests PATCH v7 06/11] arm/Makefile.common: force -fno-pic
In-Reply-To: <20161124161033.11456-1-alex.bennee@linaro.org>
References: <20161124161033.11456-1-alex.bennee@linaro.org>
Message-ID: <20161124161033.11456-7-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As distro compilers move towards defaults for build hardening for things
like ASLR we need to force -fno-pic. Failure to do can lead to weird
relocation problems when we build our "lat" binaries.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
---
 arm/Makefile.common | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arm/Makefile.common b/arm/Makefile.common
index 52f7440..cca0d9c 100644
--- a/arm/Makefile.common
+++ b/arm/Makefile.common
@@ -21,6 +21,7 @@ phys_base = $(LOADADDR)
 
 CFLAGS += -std=gnu99
 CFLAGS += -ffreestanding
+CFLAGS += -fno-pic
 CFLAGS += -Wextra
 CFLAGS += -O2
 CFLAGS += -I lib -I lib/libfdt
-- 
2.10.1
