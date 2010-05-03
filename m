From: saaguirre@ti.com (Sergio Aguirre)
Date: Mon,  3 May 2010 14:51:25 -0500
Subject: [PATCH v3] arm: Fix .gitignore for boot/compressed folder
Message-ID: <1272916286-7315-1-git-send-email-saaguirre@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This should complement changes done in:

  commit e7db7b4270ed2a606b8c0b5f944a5f92ade0e84c
  Author: Albin Tonnerre <albin.tonnerre@free-electrons.com>
  Date:   Fri Jan 8 14:42:43 2010 -0800

      arm: add support for LZO-compressed kernels

It missed to do the respective changes in '.gitignore' file.

Also, add vmlinux to the list, which is generated also during
the build.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/compressed/.gitignore |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/compressed/.gitignore b/arch/arm/boot/compressed/.gitignore
index ab204db..3e728a6 100644
--- a/arch/arm/boot/compressed/.gitignore
+++ b/arch/arm/boot/compressed/.gitignore
@@ -1,3 +1,6 @@
 font.c
-piggy.gz
+piggy.gzip
+piggy.lzo
+lib1funcs.S
 vmlinux.lds
+vmlinux
-- 
1.6.3.3
