From: huawei.libin@huawei.com (Li Bin)
Date: Fri, 30 Oct 2015 16:31:03 +0800
Subject: [PATCH 2/3] recordmcount: x86: assign a meaningful value to
 rel_type_nop
In-Reply-To: <1446193864-24593-1-git-send-email-huawei.libin@huawei.com>
References: <1446193864-24593-1-git-send-email-huawei.libin@huawei.com>
Message-ID: <1446193864-24593-3-git-send-email-huawei.libin@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Although, the default value of rel_type_nop is zero, and the value
of R_386_NONE/R_X86_64_NONE is zero too, but it should be assigned
a meaningful value explicitly, otherwise it looks confused.

Assign R_386_NONE to rel_type_nop for 386, assign R_X86_64_NONE
to rel_type_nop for x86_64.

Signed-off-by: Li Bin <huawei.libin@huawei.com>
---
 scripts/recordmcount.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 3d1984e..8cc020b 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -345,6 +345,7 @@ do_file(char const *const fname)
 		break;
 	case EM_386:
 		reltype = R_386_32;
+		rel_type_nop = R_386_NONE;
 		make_nop = make_nop_x86;
 		ideal_nop = ideal_nop5_x86_32;
 		mcount_adjust_32 = -1;
@@ -371,6 +372,7 @@ do_file(char const *const fname)
 		make_nop = make_nop_x86;
 		ideal_nop = ideal_nop5_x86_64;
 		reltype = R_X86_64_64;
+		rel_type_nop = R_X86_64_NONE;
 		mcount_adjust_64 = -1;
 		break;
 	}  /* end switch */
-- 
1.7.12.4
