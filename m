From: jason.wessel@windriver.com (Jason Wessel)
Date: Thu, 20 Sep 2012 08:57:26 -0500
Subject: [PATCH 07/11] tty/serial: Add kgdb_nmi driver
In-Reply-To: <1348098122-11041-7-git-send-email-anton.vorontsov@linaro.org>
References: <20120919234003.GA24143@lizard>
 <1348098122-11041-7-git-send-email-anton.vorontsov@linaro.org>
Message-ID: <505B20C6.5090308@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2012 06:41 PM, Anton Vorontsov wrote:
> This special driver makes it possible to temporary use NMI debugger port
> as a normal console by issuing 'nmi_console' command (assuming that the
> port is attached to KGDB).
> 


The kgdb regression compiler also does checkpatch, so the "check patch
police" don't come chasing us let's get rid of this warning.  This
comes with the disclaimer that I believe checkpatch is a bit overly
agressive in the first place. :-)

WARNING: quoted string split across lines
#133: FILE: drivers/tty/serial/kgdb_nmi.c:36:
+MODULE_PARM_DESC(knock, "if set to 1 (default), the special '$3#33' command "
+                       "must be used to enter the debugger; when set to 0, "

---
 drivers/tty/serial/kgdb_nmi.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/tty/serial/kgdb_nmi.c
+++ b/drivers/tty/serial/kgdb_nmi.c
@@ -32,10 +32,10 @@
 
 static int kgdb_nmi_knock = 1;
 module_param_named(knock, kgdb_nmi_knock, int, 0600);
-MODULE_PARM_DESC(knock, "if set to 1 (default), the special '$3#33' command "
-			"must be used to enter the debugger; when set to 0, "
-			"hitting return key is enough to enter the debugger; "
-			"when set to -1, the debugger is entered immediately "
+MODULE_PARM_DESC(knock, "if set to 1 (default), the special '$3#33' command " \
+			"must be used to enter the debugger; when set to 0, " \
+			"hitting return key is enough to enter the debugger; " \
+			"when set to -1, the debugger is entered immediately " \
 			"upon NMI");
 
 static char *kgdb_nmi_magic = "$3#33";
