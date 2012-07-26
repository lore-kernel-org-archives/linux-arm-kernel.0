From: javier.martin@vista-silicon.com (Javier Martin)
Date: Thu, 26 Jul 2012 13:20:36 +0200
Subject: [PATCH 3/4] Schedule removal of i.MX25 support in mx2_camera.c
In-Reply-To: <1343301637-19676-1-git-send-email-javier.martin@vista-silicon.com>
References: <1343301637-19676-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <1343301637-19676-4-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support for i.MX25 in mx2_camera.c has been broken
for a year. Furthermore, i.MX25 video capture HW
doesn't have much in common with i.MX27. A separate
driver would be desirable.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 Documentation/feature-removal-schedule.txt |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 56000b3..6c50a17 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -6,6 +6,15 @@ be removed from this file.  The suggested deprecation period is 3 releases.
 
 ---------------------------
 
+What:	support for i.mx25 in mx2_camera.c
+When:	v3.8
+Why:	it's been broken for a year. Furthermore, i.MX25 video capture
+	HW doesn't have much in common with i.MX27. A separate driver
+	will be needed for it.
+Who:	Javier Martin<javier.martin@vista-silicon.com>
+
+---------------------------
+
 What:	ddebug_query="query" boot cmdline param
 When:	v3.8
 Why:	obsoleted by dyndbg="query" and module.dyndbg="query"
-- 
1.7.9.5
