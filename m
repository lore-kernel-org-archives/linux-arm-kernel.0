From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 22 Jul 2012 15:18:56 +0200
Subject: [PATCH 1/7] stddev: make it selectable via Kconfig
In-Reply-To: <20120722130301.GI22657@game.jcrosoft.org>
References: <20120722130301.GI22657@game.jcrosoft.org>
Message-ID: <1342963142-30339-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable is by default for simple and hush
we do not need to NO_SHELL

this allow to save 1KiB

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 commands/Makefile |    2 +-
 common/Kconfig    |    5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/commands/Makefile b/commands/Makefile
index 54191b4..e9157bf 100644
--- a/commands/Makefile
+++ b/commands/Makefile
@@ -1,4 +1,4 @@
-obj-y				+= stddev.o
+obj-$(CONFIG_STDDEV)		+= stddev.o
 obj-$(CONFIG_CMD_BOOTM)		+= bootm.o
 obj-$(CONFIG_CMD_UIMAGE)	+= uimage.o
 obj-$(CONFIG_CMD_LINUX16)	+= linux16.o
diff --git a/common/Kconfig b/common/Kconfig
index 1c996aa..c6f1afa 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -50,6 +50,9 @@ config BINFMT
 config GLOBALVAR
 	bool
 
+config STDDEV
+	bool
+
 menu "General Settings              "
 
 config LOCALVERSION
@@ -295,6 +298,7 @@ choice
 		select COMMAND_SUPPORT
 		select PARAMETER
 		select BINFMT
+		select STDDEV
 		help
 		  Enable hush support. This is the most advanced shell available
 		  for barebox.
@@ -304,6 +308,7 @@ choice
 		select ENVIRONMENT_VARIABLES
 		select COMMAND_SUPPORT
 		select PARAMETER
+		select STDDEV
 		help
 		  simple shell. No if/then, no return values from commands, no loops
 
-- 
1.7.10
