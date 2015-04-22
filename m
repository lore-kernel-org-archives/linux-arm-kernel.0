From: timo.kokkonen@offcode.fi (Timo Kokkonen)
Date: Wed, 22 Apr 2015 14:11:38 +0300
Subject: [PATCHv7 4/8] Documentation/watchdog: watchdog-test.c: Add support
 for changing timeout
In-Reply-To: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi>
References: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi>
Message-ID: <1429701102-22320-5-git-send-email-timo.kokkonen@offcode.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It might be useful for the random watchdog developer to also test
changing the watchdog timeout. Therefore, change the test application
to also support changing timeout.

Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
---
 Documentation/watchdog/src/watchdog-test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/watchdog/src/watchdog-test.c b/Documentation/watchdog/src/watchdog-test.c
index 3da8229..fb20d70 100644
--- a/Documentation/watchdog/src/watchdog-test.c
+++ b/Documentation/watchdog/src/watchdog-test.c
@@ -63,6 +63,12 @@ int main(int argc, char *argv[])
 	    fprintf(stderr, "Watchdog card enabled.\n");
 	    fflush(stderr);
 	    goto end;
+	} else if (!strncasecmp(argv[1], "-t", 2)) {
+	    flags = atoi(argv[2]);
+	    ioctl(fd, WDIOC_SETTIMEOUT, &flags);
+	    fprintf(stderr, "Watchdog timeout set to %d seconds.\n", flags);
+	    fflush(stderr);
+	    goto end;
 	} else {
 	    fprintf(stderr, "-d to disable, -e to enable.\n");
 	    fprintf(stderr, "run by itself to tick the card.\n");
-- 
2.1.0
