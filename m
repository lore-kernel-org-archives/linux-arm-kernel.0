From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 29 Sep 2009 14:19:48 +0200
Subject: [PATCH] correct TCM documentation
Message-ID: <1254226788-23348-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It turns out that the TCM memory can be remap:ed by the MMU just
like any other memory.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 Documentation/arm/tcm.txt |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/arm/tcm.txt b/Documentation/arm/tcm.txt
index 074f4be..77fd937 100644
--- a/Documentation/arm/tcm.txt
+++ b/Documentation/arm/tcm.txt
@@ -29,11 +29,13 @@ TCM location and size. Notice that this is not a MMU table: you
 actually move the physical location of the TCM around. At the
 place you put it, it will mask any underlying RAM from the
 CPU so it is usually wise not to overlap any physical RAM with
-the TCM. The TCM memory exists totally outside the MMU and will
-override any MMU mappings.
+the TCM.
 
-Code executing inside the ITCM does not "see" any MMU mappings
-and e.g. register accesses must be made to physical addresses.
+The TCM memory can then be remapped to another address again using
+the MMU, but notice that the TCM if often used in situations where
+the MMU is turned off. To avoid confusion the current Linux
+implementation will map the TCM 1 to 1 from physical to virtual
+memory in the location specified by the machine.
 
 TCM is used for a few things:
 
-- 
1.6.2.1
