From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jun 2016 17:45:51 +0200
Subject: [PATCH v2 09/11] net: skfb: remove obsolete -I cflag
In-Reply-To: <20160615154553.3177021-1-arnd@arndb.de>
References: <20160615154553.3177021-1-arnd@arndb.de>
Message-ID: <20160615154553.3177021-10-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The skfp driver has been moved to drivers/net/fddi/skfp a long time
ago, but we still attempt to include headers from the old location,
which causes a warning when building with W=1:

cc1: error: /git/arm-soc/drivers/net/skfp: No such file or directory [-Werror=missing-include-dirs]
cc1: error: drivers/net/skfp: No such file or directory [-Werror=missing-include-dirs]

Clearly this include directive is not needed any more, so we can
just remove it now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/fddi/skfp/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/fddi/skfp/Makefile b/drivers/net/fddi/skfp/Makefile
index b0be0234abf6..a957a1c7e5ba 100644
--- a/drivers/net/fddi/skfp/Makefile
+++ b/drivers/net/fddi/skfp/Makefile
@@ -17,4 +17,4 @@ skfp-objs :=  skfddi.o    hwmtm.o    fplustm.o  smt.o      cfm.o     \
 #   projects. To keep the source common for all those drivers (and
 #   thus simplify fixes to it), please do not clean it up!
 
-ccflags-y := -Idrivers/net/skfp -DPCI -DMEM_MAPPED_IO -Wno-strict-prototypes
+ccflags-y := -DPCI -DMEM_MAPPED_IO -Wno-strict-prototypes
-- 
2.9.0
