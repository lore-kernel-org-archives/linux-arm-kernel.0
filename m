From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu,  8 Dec 2016 10:54:47 -0800
Subject: [PATCH] ARM: Ignore compressed kernel build products
Message-ID: <20161208185449.7196-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we select a kernel compression scheme, we will end-up with e.g:
piggy.xzkern under arch/arm/boot/compressed/, let's ignore these files.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/compressed/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/compressed/.gitignore b/arch/arm/boot/compressed/.gitignore
index 86b2f5d28240..06686768610f 100644
--- a/arch/arm/boot/compressed/.gitignore
+++ b/arch/arm/boot/compressed/.gitignore
@@ -4,6 +4,7 @@ font.c
 lib1funcs.S
 hyp-stub.S
 piggy_data
+piggy.*
 vmlinux
 vmlinux.lds
 
-- 
2.9.3
