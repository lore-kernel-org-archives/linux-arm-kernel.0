From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 May 2015 10:52:59 +0200
Subject: [PATCH] cgroup: add seq_file forward declaration for struct cftype
Message-ID: <8289624.GnpfIU6Era@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: b4a04ab7a37b ("cgroup: separate out include/linux/cgroup-defs.h")

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 7d83d7f73420..ab9dd741ab99 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -302,6 +302,8 @@ struct cgroup_root {
 	char name[MAX_CGROUP_ROOT_NAMELEN];
 };
 
+struct seq_file;
+
 /*
  * struct cftype: handler definitions for cgroup control files
  *
