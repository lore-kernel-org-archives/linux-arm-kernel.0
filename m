From: tj@kernel.org (Tejun Heo)
Date: Fri, 29 May 2015 09:16:30 -0400
Subject: [PATCH] cgroup: add seq_file forward declaration for struct cftype
In-Reply-To: <8289624.GnpfIU6Era@wuerfel>
References: <8289624.GnpfIU6Era@wuerfel>
Message-ID: <20150529131630.GI27479@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Arnd.

Applied to cgroup/for-4.2 with the declaration moved so that it's
where others are.  Sorry that I missed that.

Thanks.

----- 8< -----
>From c80ef9e0c021ff86771fdd72583c75d8f7b6a720 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 29 May 2015 10:52:59 +0200
Subject: [PATCH] cgroup: add seq_file forward declaration for struct cftype

Recent header file changes for cgroup caused lots of warnings
about a missing struct seq_file form declaration for every
inclusion of include/linux/cgroup-defs.h.

As some files are built with -Werror, this leads to build
failure like:

                 from /git/arm-soc/drivers/gpu/drm/tilcdc/tilcdc_crtc.c:18:
/git/arm-soc/include/linux/cgroup-defs.h:354:25: error: 'struct seq_file' declared inside parameter list [-Werror]
cc1: all warnings being treated as errors
make[6]: *** [drivers/gpu/drm/tilcdc/tilcdc_crtc.o] Error 1

This patch adds the declaration, which resolves both the
warnings and the drm failure.

tj: Moved it where other type declarations are.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: b4a04ab7a37b ("cgroup: separate out include/linux/cgroup-defs.h")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/cgroup-defs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 7d83d7f..26d1cea 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -26,6 +26,7 @@ struct cgroup_taskset;
 struct kernfs_node;
 struct kernfs_ops;
 struct kernfs_open_file;
+struct seq_file;
 
 #define MAX_CGROUP_TYPE_NAMELEN 32
 #define MAX_CGROUP_ROOT_NAMELEN 64
-- 
2.4.0
