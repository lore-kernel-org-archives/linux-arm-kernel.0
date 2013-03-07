From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu,  7 Mar 2013 22:26:31 +0100
Subject: [PATCH 6/9] meminfo: switch to pr_xxx
In-Reply-To: <1362691594-32286-1-git-send-email-plagnioj@jcrosoft.com>
References: <20130307212523.GK4401@game.jcrosoft.org>
 <1362691594-32286-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1362691594-32286-6-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 common/meminfo.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/meminfo.c b/common/meminfo.c
index 5e3ff71..45733da 100644
--- a/common/meminfo.c
+++ b/common/meminfo.c
@@ -10,9 +10,9 @@ static int display_meminfo(void)
 	ulong mend   = mem_malloc_end();
 	ulong msize  = mend - mstart + 1;
 
-	debug("barebox code: 0x%p -> 0x%p\n", _stext, _etext - 1);
-	debug("bss segment:  0x%p -> 0x%p\n", __bss_start, __bss_stop - 1);
-	printf("malloc space: 0x%08lx -> 0x%08lx (size %s)\n",
+	pr_debug("barebox code: 0x%p -> 0x%p\n", _stext, _etext - 1);
+	pr_debug("bss segment:  0x%p -> 0x%p\n", __bss_start, __bss_stop - 1);
+	pr_info("malloc space: 0x%08lx -> 0x%08lx (size %s)\n",
 		mstart, mend, size_human_readable(msize));
 	return 0;
 }
-- 
1.7.10.4
