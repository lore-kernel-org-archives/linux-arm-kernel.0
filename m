From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 13 Aug 2014 12:28:52 +0200
Subject: [PATCH v4 2/8] serial: sunzilog: Remove unnecessary volatile keyword
In-Reply-To: <1407925738-26170-1-git-send-email-thierry.reding@gmail.com>
References: <1407925738-26170-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1407925738-26170-3-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The field annotated with volatile are all accessed through I/O accessors
so they don't need to be explicitly marked. The accessors will take care
of it.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v4:
- new patch

 drivers/tty/serial/sunzilog.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sunzilog.h b/drivers/tty/serial/sunzilog.h
index 5dec7b47cc38..de2850c1ab57 100644
--- a/drivers/tty/serial/sunzilog.h
+++ b/drivers/tty/serial/sunzilog.h
@@ -2,10 +2,10 @@
 #define _SUNZILOG_H
 
 struct zilog_channel {
-	volatile unsigned char control;
-	volatile unsigned char __pad1;
-	volatile unsigned char data;
-	volatile unsigned char __pad2;
+	unsigned char control;
+	unsigned char __pad1;
+	unsigned char data;
+	unsigned char __pad2;
 };
 
 struct zilog_layout {
-- 
2.0.4
