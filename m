From: panand@redhat.com (Pratyush Anand)
Date: Mon, 14 Nov 2016 19:32:42 +0530
Subject: [PATCH V3 1/5] hw_breakpoint: Allow watchpoint of length 3,5,6 and 7
In-Reply-To: <cover.1479130617.git.panand@redhat.com>
References: <cover.1479130617.git.panand@redhat.com>
Message-ID: <f5f2020a89b79b502219e12898f45a6834c44ddc.1479130617.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We only support breakpoint/watchpoint of length 1, 2, 4 and 8. If we can
support other length as well, then user may watch more data with less
number of watchpoints (provided hardware supports it). For example: if we
have to watch only 4th, 5th and 6th byte from a 64 bit aligned address, we
will have to use two slots to implement it currently. One slot will watch a
half word at offset 4 and other a byte at offset 6. If we can have a
watchpoint of length 3 then we can watch it with single slot as well.

ARM64 hardware does support such functionality, therefore adding these new
definitions in generic layer.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 include/uapi/linux/hw_breakpoint.h       | 4 ++++
 tools/include/uapi/linux/hw_breakpoint.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/uapi/linux/hw_breakpoint.h b/include/uapi/linux/hw_breakpoint.h
index b04000a2296a..2b65efd19a46 100644
--- a/include/uapi/linux/hw_breakpoint.h
+++ b/include/uapi/linux/hw_breakpoint.h
@@ -4,7 +4,11 @@
 enum {
 	HW_BREAKPOINT_LEN_1 = 1,
 	HW_BREAKPOINT_LEN_2 = 2,
+	HW_BREAKPOINT_LEN_3 = 3,
 	HW_BREAKPOINT_LEN_4 = 4,
+	HW_BREAKPOINT_LEN_5 = 5,
+	HW_BREAKPOINT_LEN_6 = 6,
+	HW_BREAKPOINT_LEN_7 = 7,
 	HW_BREAKPOINT_LEN_8 = 8,
 };
 
diff --git a/tools/include/uapi/linux/hw_breakpoint.h b/tools/include/uapi/linux/hw_breakpoint.h
index b04000a2296a..2b65efd19a46 100644
--- a/tools/include/uapi/linux/hw_breakpoint.h
+++ b/tools/include/uapi/linux/hw_breakpoint.h
@@ -4,7 +4,11 @@
 enum {
 	HW_BREAKPOINT_LEN_1 = 1,
 	HW_BREAKPOINT_LEN_2 = 2,
+	HW_BREAKPOINT_LEN_3 = 3,
 	HW_BREAKPOINT_LEN_4 = 4,
+	HW_BREAKPOINT_LEN_5 = 5,
+	HW_BREAKPOINT_LEN_6 = 6,
+	HW_BREAKPOINT_LEN_7 = 7,
 	HW_BREAKPOINT_LEN_8 = 8,
 };
 
-- 
2.7.4
