From: gang.chen@asianux.com (Chen Gang)
Date: Fri, 02 Aug 2013 15:39:02 +0800
Subject: [PATCH trivial] include: uapi: standard all files' macro prefix and
 suffix, excluding "linux/" sub-directory
Message-ID: <51FB6216.6010008@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For "include/uapi/*", excluding "linux/" sub-directory, let all files'
macro prefix match the standard format, and give related stand comments
for their macro suffix.

The related standard format is:

  "_SUBDIRNAME_SUBDIRNAME[_SUBDIRNAME]_FILENAME" (1st _SUBDIRNAME is _UAPI), and use '_' instead of '.' and '-'.


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 include/uapi/asm-generic/auxvec.h      |    6 +++---
 include/uapi/asm-generic/bitsperlong.h |    6 +++---
 include/uapi/asm-generic/errno-base.h  |    6 +++---
 include/uapi/asm-generic/errno.h       |    6 +++---
 include/uapi/asm-generic/fcntl.h       |    6 +++---
 include/uapi/asm-generic/ioctls.h      |    6 +++---
 include/uapi/asm-generic/ipcbuf.h      |    6 +++---
 include/uapi/asm-generic/kvm_para.h    |    5 +++++
 include/uapi/asm-generic/mman-common.h |    6 +++---
 include/uapi/asm-generic/mman.h        |    6 +++---
 include/uapi/asm-generic/msgbuf.h      |    6 +++---
 include/uapi/asm-generic/param.h       |    6 +++---
 include/uapi/asm-generic/poll.h        |    6 +++---
 include/uapi/asm-generic/posix_types.h |    6 +++---
 include/uapi/asm-generic/sembuf.h      |    6 +++---
 include/uapi/asm-generic/setup.h       |    6 +++---
 include/uapi/asm-generic/shmbuf.h      |    6 +++---
 include/uapi/asm-generic/shmparam.h    |    6 +++---
 include/uapi/asm-generic/signal-defs.h |    6 +++---
 include/uapi/asm-generic/signal.h      |    6 +++---
 include/uapi/asm-generic/socket.h      |    6 +++---
 include/uapi/asm-generic/sockios.h     |    6 +++---
 include/uapi/asm-generic/stat.h        |    6 +++---
 include/uapi/asm-generic/statfs.h      |    6 +++---
 include/uapi/asm-generic/swab.h        |    6 +++---
 include/uapi/asm-generic/termbits.h    |    6 +++---
 include/uapi/asm-generic/types.h       |    6 +++---
 include/uapi/asm-generic/ucontext.h    |    6 +++---
 include/uapi/asm-generic/unistd.h      |    5 +++++
 include/uapi/drm/drm.h                 |    6 +++---
 include/uapi/drm/drm_fourcc.h          |    6 +++---
 include/uapi/drm/drm_mode.h            |    6 +++---
 include/uapi/drm/drm_sarea.h           |    6 +++---
 include/uapi/drm/exynos_drm.h          |    6 +++---
 include/uapi/drm/i810_drm.h            |    6 +++---
 include/uapi/drm/i915_drm.h            |    6 +++---
 include/uapi/drm/mga_drm.h             |    6 +++---
 include/uapi/drm/nouveau_drm.h         |    6 +++---
 include/uapi/drm/omap_drm.h            |    6 +++---
 include/uapi/drm/qxl_drm.h             |    6 +++---
 include/uapi/drm/r128_drm.h            |    6 +++---
 include/uapi/drm/radeon_drm.h          |    6 +++---
 include/uapi/drm/savage_drm.h          |    6 +++---
 include/uapi/drm/sis_drm.h             |    6 +++---
 include/uapi/drm/tegra_drm.h           |    6 +++---
 include/uapi/drm/via_drm.h             |    6 +++---
 include/uapi/drm/vmwgfx_drm.h          |    6 +++---
 include/uapi/mtd/inftl-user.h          |    6 +++---
 include/uapi/mtd/mtd-abi.h             |    6 +++---
 include/uapi/mtd/mtd-user.h            |    6 +++---
 include/uapi/mtd/nftl-user.h           |    6 +++---
 include/uapi/mtd/ubi-user.h            |    6 +++---
 include/uapi/rdma/ib_user_cm.h         |    6 +++---
 include/uapi/rdma/ib_user_mad.h        |    6 +++---
 include/uapi/rdma/ib_user_sa.h         |    6 +++---
 include/uapi/rdma/ib_user_verbs.h      |    6 +++---
 include/uapi/rdma/rdma_netlink.h       |    6 +++---
 include/uapi/rdma/rdma_user_cm.h       |    6 +++---
 include/uapi/scsi/fc/fc_els.h          |    6 +++---
 include/uapi/scsi/fc/fc_fs.h           |    6 +++---
 include/uapi/scsi/fc/fc_gs.h           |    6 +++---
 include/uapi/scsi/fc/fc_ns.h           |    6 +++---
 include/uapi/scsi/scsi_bsg_fc.h        |    7 +++----
 include/uapi/scsi/scsi_netlink.h       |    7 +++----
 include/uapi/scsi/scsi_netlink_fc.h    |    7 +++----
 include/uapi/sound/asequencer.h        |    6 +++---
 include/uapi/sound/asound.h            |    6 +++---
 include/uapi/sound/asound_fm.h         |    6 +++---
 include/uapi/sound/compress_offload.h  |    6 +++---
 include/uapi/sound/compress_params.h   |    6 +++---
 include/uapi/sound/emu10k1.h           |    6 +++---
 include/uapi/sound/hdsp.h              |    6 +++---
 include/uapi/sound/hdspm.h             |    6 +++---
 include/uapi/sound/sb16_csp.h          |    6 +++---
 include/uapi/sound/sfnt_info.h         |    6 +++---
 include/uapi/video/edid.h              |    6 +++---
 include/uapi/video/sisfb.h             |    6 +++---
 include/uapi/video/uvesafb.h           |    6 +++---
 include/uapi/xen/evtchn.h              |    6 +++---
 include/uapi/xen/privcmd.h             |    6 +++---
 80 files changed, 244 insertions(+), 237 deletions(-)

diff --git a/include/uapi/asm-generic/auxvec.h b/include/uapi/asm-generic/auxvec.h
index b99573b..c4b445a 100644
--- a/include/uapi/asm-generic/auxvec.h
+++ b/include/uapi/asm-generic/auxvec.h
@@ -1,8 +1,8 @@
-#ifndef __ASM_GENERIC_AUXVEC_H
-#define __ASM_GENERIC_AUXVEC_H
+#ifndef _UAPI_ASM_GENERIC_AUXVEC_H
+#define _UAPI_ASM_GENERIC_AUXVEC_H
 /*
  * Not all architectures need their own auxvec.h, the most
  * common definitions are already in linux/auxvec.h.
  */
 
-#endif /* __ASM_GENERIC_AUXVEC_H */
+#endif /* _UAPI_ASM_GENERIC_AUXVEC_H */
diff --git a/include/uapi/asm-generic/bitsperlong.h b/include/uapi/asm-generic/bitsperlong.h
index 23e6c41..2a6e4e2 100644
--- a/include/uapi/asm-generic/bitsperlong.h
+++ b/include/uapi/asm-generic/bitsperlong.h
@@ -1,5 +1,5 @@
-#ifndef _UAPI__ASM_GENERIC_BITS_PER_LONG
-#define _UAPI__ASM_GENERIC_BITS_PER_LONG
+#ifndef _UAPI_ASM_GENERIC_BITS_PER_LONG
+#define _UAPI_ASM_GENERIC_BITS_PER_LONG
 
 /*
  * There seems to be no way of detecting this automatically from user
@@ -12,4 +12,4 @@
 #define __BITS_PER_LONG 32
 #endif
 
-#endif /* _UAPI__ASM_GENERIC_BITS_PER_LONG */
+#endif /* _UAPI_ASM_GENERIC_BITS_PER_LONG */
diff --git a/include/uapi/asm-generic/errno-base.h b/include/uapi/asm-generic/errno-base.h
index 6511597..08e447b 100644
--- a/include/uapi/asm-generic/errno-base.h
+++ b/include/uapi/asm-generic/errno-base.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_GENERIC_ERRNO_BASE_H
-#define _ASM_GENERIC_ERRNO_BASE_H
+#ifndef _UAPI_ASM_GENERIC_ERRNO_BASE_H
+#define _UAPI_ASM_GENERIC_ERRNO_BASE_H
 
 #define	EPERM		 1	/* Operation not permitted */
 #define	ENOENT		 2	/* No such file or directory */
@@ -36,4 +36,4 @@
 #define	EDOM		33	/* Math argument out of domain of func */
 #define	ERANGE		34	/* Math result not representable */
 
-#endif
+#endif /* _UAPI_ASM_GENERIC_ERRNO_BASE_H */
diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
index a1331ce..a47d9b5 100644
--- a/include/uapi/asm-generic/errno.h
+++ b/include/uapi/asm-generic/errno.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_GENERIC_ERRNO_H
-#define _ASM_GENERIC_ERRNO_H
+#ifndef _UAPI_ASM_GENERIC_ERRNO_H
+#define _UAPI_ASM_GENERIC_ERRNO_H
 
 #include <asm-generic/errno-base.h>
 
@@ -110,4 +110,4 @@
 
 #define EHWPOISON	133	/* Memory page has hardware error */
 
-#endif
+#endif /* _UAPI_ASM_GENERIC_ERRNO_H */
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 95e46c8..20e5c94 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_GENERIC_FCNTL_H
-#define _ASM_GENERIC_FCNTL_H
+#ifndef _UAPI_ASM_GENERIC_FCNTL_H
+#define _UAPI_ASM_GENERIC_FCNTL_H
 
 #include <linux/types.h>
 
@@ -204,4 +204,4 @@ struct flock64 {
 #endif
 #endif /* !CONFIG_64BIT */
 
-#endif /* _ASM_GENERIC_FCNTL_H */
+#endif /* _UAPI_ASM_GENERIC_FCNTL_H */
diff --git a/include/uapi/asm-generic/ioctls.h b/include/uapi/asm-generic/ioctls.h
index 143dacb..ed09d14 100644
--- a/include/uapi/asm-generic/ioctls.h
+++ b/include/uapi/asm-generic/ioctls.h
@@ -1,5 +1,5 @@
-#ifndef __ASM_GENERIC_IOCTLS_H
-#define __ASM_GENERIC_IOCTLS_H
+#ifndef _UAPI_ASM_GENERIC_IOCTLS_H
+#define _UAPI_ASM_GENERIC_IOCTLS_H
 
 #include <linux/ioctl.h>
 
@@ -114,4 +114,4 @@
 
 #define TIOCSER_TEMT	0x01	/* Transmitter physically empty */
 
-#endif /* __ASM_GENERIC_IOCTLS_H */
+#endif /* _UAPI_ASM_GENERIC_IOCTLS_H */
diff --git a/include/uapi/asm-generic/ipcbuf.h b/include/uapi/asm-generic/ipcbuf.h
index 76982b2..3d0ab11 100644
--- a/include/uapi/asm-generic/ipcbuf.h
+++ b/include/uapi/asm-generic/ipcbuf.h
@@ -1,5 +1,5 @@
-#ifndef __ASM_GENERIC_IPCBUF_H
-#define __ASM_GENERIC_IPCBUF_H
+#ifndef _UAPI_ASM_GENERIC_IPCBUF_H
+#define _UAPI_ASM_GENERIC_IPCBUF_H
 
 /*
  * The generic ipc64_perm structure:
@@ -31,4 +31,4 @@ struct ipc64_perm {
 	unsigned long		__unused2;
 };
 
-#endif /* __ASM_GENERIC_IPCBUF_H */
+#endif /* _UAPI_ASM_GENERIC_IPCBUF_H */
diff --git a/include/uapi/asm-generic/kvm_para.h b/include/uapi/asm-generic/kvm_para.h
index 486f0af..a2cc788 100644
--- a/include/uapi/asm-generic/kvm_para.h
+++ b/include/uapi/asm-generic/kvm_para.h
@@ -1,4 +1,9 @@
+#ifndef _UAPI_ASM_GENERIC_KVM_PARA_H
+#define _UAPI_ASM_GENERIC_KVM_PARA_H
+
 /*
  * There isn't anything here, but the file must not be empty or patch
  * will delete it.
  */
+
+#endif /* _UAPI_ASM_GENERIC_KVM_PARA_H */
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 4164529..191cee2 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -1,5 +1,5 @@
-#ifndef __ASM_GENERIC_MMAN_COMMON_H
-#define __ASM_GENERIC_MMAN_COMMON_H
+#ifndef _UAPI_ASM_GENERIC_MMAN_COMMON_H
+#define _UAPI_ASM_GENERIC_MMAN_COMMON_H
 
 /*
  Author: Michael S. Tsirkin <mst@mellanox.co.il>, Mellanox Technologies Ltd.
@@ -66,4 +66,4 @@
 #define MAP_HUGE_SHIFT	26
 #define MAP_HUGE_MASK	0x3f
 
-#endif /* __ASM_GENERIC_MMAN_COMMON_H */
+#endif /* _UAPI_ASM_GENERIC_MMAN_COMMON_H */
diff --git a/include/uapi/asm-generic/mman.h b/include/uapi/asm-generic/mman.h
index e9fe6fd..2b52204 100644
--- a/include/uapi/asm-generic/mman.h
+++ b/include/uapi/asm-generic/mman.h
@@ -1,5 +1,5 @@
-#ifndef __ASM_GENERIC_MMAN_H
-#define __ASM_GENERIC_MMAN_H
+#ifndef _UAPI_ASM_GENERIC_MMAN_H
+#define _UAPI_ASM_GENERIC_MMAN_H
 
 #include <asm-generic/mman-common.h>
 
@@ -18,4 +18,4 @@
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
 
-#endif /* __ASM_GENERIC_MMAN_H */
+#endif /* _UAPI_ASM_GENERIC_MMAN_H */
diff --git a/include/uapi/asm-generic/msgbuf.h b/include/uapi/asm-generic/msgbuf.h
index aec850d..d65c865 100644
--- a/include/uapi/asm-generic/msgbuf.h
+++ b/include/uapi/asm-generic/msgbuf.h
@@ -1,5 +1,5 @@
-#ifndef __ASM_GENERIC_MSGBUF_H
-#define __ASM_GENERIC_MSGBUF_H
+#ifndef _UAPI_ASM_GENERIC_MSGBUF_H
+#define _UAPI_ASM_GENERIC_MSGBUF_H
 
 #include <asm/bitsperlong.h>
 /*
@@ -44,4 +44,4 @@ struct msqid64_ds {
 	unsigned long  __unused5;
 };
 
-#endif /* __ASM_GENERIC_MSGBUF_H */
+#endif /* _UAPI_ASM_GENERIC_MSGBUF_H */
diff --git a/include/uapi/asm-generic/param.h b/include/uapi/asm-generic/param.h
index 5becc84..2032540 100644
--- a/include/uapi/asm-generic/param.h
+++ b/include/uapi/asm-generic/param.h
@@ -1,5 +1,5 @@
-#ifndef _UAPI__ASM_GENERIC_PARAM_H
-#define _UAPI__ASM_GENERIC_PARAM_H
+#ifndef _UAPI_ASM_GENERIC_PARAM_H
+#define _UAPI_ASM_GENERIC_PARAM_H
 
 #ifndef HZ
 #define HZ 100
@@ -16,4 +16,4 @@
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
 
 
-#endif /* _UAPI__ASM_GENERIC_PARAM_H */
+#endif /* _UAPI_ASM_GENERIC_PARAM_H */
diff --git a/include/uapi/asm-generic/poll.h b/include/uapi/asm-generic/poll.h
index a969498..f8ca661 100644
--- a/include/uapi/asm-generic/poll.h
+++ b/include/uapi/asm-generic/poll.h
@@ -1,5 +1,5 @@
-#ifndef __ASM_GENERIC_POLL_H
-#define __ASM_GENERIC_POLL_H
+#ifndef _UAPI_ASM_GENERIC_POLL_H
+#define _UAPI_ASM_GENERIC_POLL_H
 
 /* These are specified by iBCS2 */
 #define POLLIN		0x0001
@@ -38,4 +38,4 @@ struct pollfd {
 	short revents;
 };
 
-#endif	/* __ASM_GENERIC_POLL_H */
+#endif	/* _UAPI_ASM_GENERIC_POLL_H */
diff --git a/include/uapi/asm-generic/posix_types.h b/include/uapi/asm-generic/posix_types.h
index fe74fcc..25128f8 100644
--- a/include/uapi/asm-generic/posix_types.h
+++ b/include/uapi/asm-generic/posix_types.h
@@ -1,5 +1,5 @@
-#ifndef __ASM_GENERIC_POSIX_TYPES_H
-#define __ASM_GENERIC_POSIX_TYPES_H
+#ifndef _UAPI_ASM_GENERIC_POSIX_TYPES_H
+#define _UAPI_ASM_GENERIC_POSIX_TYPES_H
 
 #include <asm/bitsperlong.h>
 /*
@@ -93,4 +93,4 @@ typedef char *		__kernel_caddr_t;
 typedef unsigned short	__kernel_uid16_t;
 typedef unsigned short	__kernel_gid16_t;
 
-#endif /* __ASM_GENERIC_POSIX_TYPES_H */
+#endif /* _UAPI_ASM_GENERIC_POSIX_TYPES_H */
diff --git a/include/uapi/asm-generic/sembuf.h b/include/uapi/asm-generic/sembuf.h
index 4cb2c13..93409df 100644
--- a/include/uapi/asm-generic/sembuf.h
+++ b/include/uapi/asm-generic/sembuf.h
@@ -1,5 +1,5 @@
-#ifndef __ASM_GENERIC_SEMBUF_H
-#define __ASM_GENERIC_SEMBUF_H
+#ifndef _UAPI_ASM_GENERIC_SEMBUF_H
+#define _UAPI_ASM_GENERIC_SEMBUF_H
 
 #include <asm/bitsperlong.h>
 
@@ -35,4 +35,4 @@ struct semid64_ds {
 	unsigned long	__unused4;
 };
 
-#endif /* __ASM_GENERIC_SEMBUF_H */
+#endif /* _UAPI_ASM_GENERIC_SEMBUF_H */
diff --git a/include/uapi/asm-generic/setup.h b/include/uapi/asm-generic/setup.h
index 6fc26a5..4ff1c83 100644
--- a/include/uapi/asm-generic/setup.h
+++ b/include/uapi/asm-generic/setup.h
@@ -1,6 +1,6 @@
-#ifndef __ASM_GENERIC_SETUP_H
-#define __ASM_GENERIC_SETUP_H
+#ifndef _UAPI_ASM_GENERIC_SETUP_H
+#define _UAPI_ASM_GENERIC_SETUP_H
 
 #define COMMAND_LINE_SIZE	512
 
-#endif	/* __ASM_GENERIC_SETUP_H */
+#endif	/* _UAPI_ASM_GENERIC_SETUP_H */
diff --git a/include/uapi/asm-generic/shmbuf.h b/include/uapi/asm-generic/shmbuf.h
index 5768fa6..3cc3f46 100644
--- a/include/uapi/asm-generic/shmbuf.h
+++ b/include/uapi/asm-generic/shmbuf.h
@@ -1,5 +1,5 @@
-#ifndef __ASM_GENERIC_SHMBUF_H
-#define __ASM_GENERIC_SHMBUF_H
+#ifndef _UAPI_ASM_GENERIC_SHMBUF_H
+#define _UAPI_ASM_GENERIC_SHMBUF_H
 
 #include <asm/bitsperlong.h>
 
@@ -56,4 +56,4 @@ struct shminfo64 {
 	unsigned long	__unused4;
 };
 
-#endif /* __ASM_GENERIC_SHMBUF_H */
+#endif /* _UAPI_ASM_GENERIC_SHMBUF_H */
diff --git a/include/uapi/asm-generic/shmparam.h b/include/uapi/asm-generic/shmparam.h
index 51a3852..78df3d8 100644
--- a/include/uapi/asm-generic/shmparam.h
+++ b/include/uapi/asm-generic/shmparam.h
@@ -1,6 +1,6 @@
-#ifndef __ASM_GENERIC_SHMPARAM_H
-#define __ASM_GENERIC_SHMPARAM_H
+#ifndef _UAPI_ASM_GENERIC_SHMPARAM_H
+#define _UAPI_ASM_GENERIC_SHMPARAM_H
 
 #define SHMLBA PAGE_SIZE	 /* attach addr a multiple of this */
 
-#endif /* _ASM_GENERIC_SHMPARAM_H */
+#endif /* _UAPI_ASM_GENERIC_SHMPARAM_H */
diff --git a/include/uapi/asm-generic/signal-defs.h b/include/uapi/asm-generic/signal-defs.h
index 00f95df..69157b0 100644
--- a/include/uapi/asm-generic/signal-defs.h
+++ b/include/uapi/asm-generic/signal-defs.h
@@ -1,5 +1,5 @@
-#ifndef __ASM_GENERIC_SIGNAL_DEFS_H
-#define __ASM_GENERIC_SIGNAL_DEFS_H
+#ifndef _UAPI_ASM_GENERIC_SIGNAL_DEFS_H
+#define _UAPI_ASM_GENERIC_SIGNAL_DEFS_H
 
 #include <linux/compiler.h>
 
@@ -25,4 +25,4 @@ typedef __restorefn_t __user *__sigrestore_t;
 #define SIG_ERR	((__force __sighandler_t)-1)	/* error return from signal */
 #endif
 
-#endif /* __ASM_GENERIC_SIGNAL_DEFS_H */
+#endif /* _UAPI_ASM_GENERIC_SIGNAL_DEFS_H */
diff --git a/include/uapi/asm-generic/signal.h b/include/uapi/asm-generic/signal.h
index 9df61f1..06107b4 100644
--- a/include/uapi/asm-generic/signal.h
+++ b/include/uapi/asm-generic/signal.h
@@ -1,5 +1,5 @@
-#ifndef _UAPI__ASM_GENERIC_SIGNAL_H
-#define _UAPI__ASM_GENERIC_SIGNAL_H
+#ifndef _UAPI_ASM_GENERIC_SIGNAL_H
+#define _UAPI_ASM_GENERIC_SIGNAL_H
 
 #include <linux/types.h>
 
@@ -116,4 +116,4 @@ typedef struct sigaltstack {
 
 #endif /* __ASSEMBLY__ */
 
-#endif /* _UAPI__ASM_GENERIC_SIGNAL_H */
+#endif /* _UAPI_ASM_GENERIC_SIGNAL_H */
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index f04b69b..49568ab 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -1,5 +1,5 @@
-#ifndef __ASM_GENERIC_SOCKET_H
-#define __ASM_GENERIC_SOCKET_H
+#ifndef _UAPI_ASM_GENERIC_SOCKET_H
+#define _UAPI_ASM_GENERIC_SOCKET_H
 
 #include <asm/sockios.h>
 
@@ -78,4 +78,4 @@
 
 #define SO_BUSY_POLL		46
 
-#endif /* __ASM_GENERIC_SOCKET_H */
+#endif /* _UAPI_ASM_GENERIC_SOCKET_H */
diff --git a/include/uapi/asm-generic/sockios.h b/include/uapi/asm-generic/sockios.h
index 9a61a36..dab5a3b 100644
--- a/include/uapi/asm-generic/sockios.h
+++ b/include/uapi/asm-generic/sockios.h
@@ -1,5 +1,5 @@
-#ifndef __ASM_GENERIC_SOCKIOS_H
-#define __ASM_GENERIC_SOCKIOS_H
+#ifndef _UAPI_ASM_GENERIC_SOCKIOS_H
+#define _UAPI_ASM_GENERIC_SOCKIOS_H
 
 /* Socket-level I/O control calls. */
 #define FIOSETOWN	0x8901
@@ -10,4 +10,4 @@
 #define SIOCGSTAMP	0x8906		/* Get stamp (timeval) */
 #define SIOCGSTAMPNS	0x8907		/* Get stamp (timespec) */
 
-#endif /* __ASM_GENERIC_SOCKIOS_H */
+#endif /* _UAPI_ASM_GENERIC_SOCKIOS_H */
diff --git a/include/uapi/asm-generic/stat.h b/include/uapi/asm-generic/stat.h
index bd8cad2..7b4f080 100644
--- a/include/uapi/asm-generic/stat.h
+++ b/include/uapi/asm-generic/stat.h
@@ -1,5 +1,5 @@
-#ifndef __ASM_GENERIC_STAT_H
-#define __ASM_GENERIC_STAT_H
+#ifndef _UAPI_ASM_GENERIC_STAT_H
+#define _UAPI_ASM_GENERIC_STAT_H
 
 /*
  * Everybody gets this wrong and has to stick with it for all
@@ -69,4 +69,4 @@ struct stat64 {
 };
 #endif
 
-#endif /* __ASM_GENERIC_STAT_H */
+#endif /* _UAPI_ASM_GENERIC_STAT_H */
diff --git a/include/uapi/asm-generic/statfs.h b/include/uapi/asm-generic/statfs.h
index 0999647..8de03a1 100644
--- a/include/uapi/asm-generic/statfs.h
+++ b/include/uapi/asm-generic/statfs.h
@@ -1,5 +1,5 @@
-#ifndef _UAPI_GENERIC_STATFS_H
-#define _UAPI_GENERIC_STATFS_H
+#ifndef _UAPI_ASM_GENERIC_STATFS_H
+#define _UAPI_ASM_GENERIC_STATFS_H
 
 #include <linux/types.h>
 
@@ -80,4 +80,4 @@ struct compat_statfs64 {
 	__u32 f_spare[4];
 } ARCH_PACK_COMPAT_STATFS64;
 
-#endif /* _UAPI_GENERIC_STATFS_H */
+#endif /* _UAPI_ASM_GENERIC_STATFS_H */
diff --git a/include/uapi/asm-generic/swab.h b/include/uapi/asm-generic/swab.h
index a8e9029..6850417 100644
--- a/include/uapi/asm-generic/swab.h
+++ b/include/uapi/asm-generic/swab.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_GENERIC_SWAB_H
-#define _ASM_GENERIC_SWAB_H
+#ifndef _UAPI_ASM_GENERIC_SWAB_H
+#define _UAPI_ASM_GENERIC_SWAB_H
 
 #include <asm/bitsperlong.h>
 
@@ -15,4 +15,4 @@
 #endif
 #endif
 
-#endif /* _ASM_GENERIC_SWAB_H */
+#endif /* _UAPI_ASM_GENERIC_SWAB_H */
diff --git a/include/uapi/asm-generic/termbits.h b/include/uapi/asm-generic/termbits.h
index 232b478..ceee144 100644
--- a/include/uapi/asm-generic/termbits.h
+++ b/include/uapi/asm-generic/termbits.h
@@ -1,5 +1,5 @@
-#ifndef __ASM_GENERIC_TERMBITS_H
-#define __ASM_GENERIC_TERMBITS_H
+#ifndef _UAPI_ASM_GENERIC_TERMBITS_H
+#define _UAPI_ASM_GENERIC_TERMBITS_H
 
 #include <linux/posix_types.h>
 
@@ -196,4 +196,4 @@ struct ktermios {
 #define	TCSADRAIN	1
 #define	TCSAFLUSH	2
 
-#endif /* __ASM_GENERIC_TERMBITS_H */
+#endif /* _UAPI_ASM_GENERIC_TERMBITS_H */
diff --git a/include/uapi/asm-generic/types.h b/include/uapi/asm-generic/types.h
index bd39806..e11d0a3 100644
--- a/include/uapi/asm-generic/types.h
+++ b/include/uapi/asm-generic/types.h
@@ -1,9 +1,9 @@
-#ifndef _ASM_GENERIC_TYPES_H
-#define _ASM_GENERIC_TYPES_H
+#ifndef _UAPI_ASM_GENERIC_TYPES_H
+#define _UAPI_ASM_GENERIC_TYPES_H
 /*
  * int-ll64 is used practically everywhere now,
  * so use it as a reasonable default.
  */
 #include <asm-generic/int-ll64.h>
 
-#endif /* _ASM_GENERIC_TYPES_H */
+#endif /* _UAPI_ASM_GENERIC_TYPES_H */
diff --git a/include/uapi/asm-generic/ucontext.h b/include/uapi/asm-generic/ucontext.h
index ad77343..111a869 100644
--- a/include/uapi/asm-generic/ucontext.h
+++ b/include/uapi/asm-generic/ucontext.h
@@ -1,5 +1,5 @@
-#ifndef __ASM_GENERIC_UCONTEXT_H
-#define __ASM_GENERIC_UCONTEXT_H
+#ifndef _UAPI_ASM_GENERIC_UCONTEXT_H
+#define _UAPI_ASM_GENERIC_UCONTEXT_H
 
 struct ucontext {
 	unsigned long	  uc_flags;
@@ -9,4 +9,4 @@ struct ucontext {
 	sigset_t	  uc_sigmask;	/* mask last for extensibility */
 };
 
-#endif /* __ASM_GENERIC_UCONTEXT_H */
+#endif /* _UAPI_ASM_GENERIC_UCONTEXT_H */
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a20a9b4..6e26d0a 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -1,3 +1,6 @@
+#ifndef _UAPI_ASM_GENERIC_UNISTD_H
+#define _UAPI_ASM_GENERIC_UNISTD_H
+
 #include <asm/bitsperlong.h>
 
 /*
@@ -902,3 +905,5 @@ __SYSCALL(__NR_fork, sys_ni_syscall)
 #define __NR_lstat64 __NR3264_lstat
 #endif
 #endif
+
+#endif /* _UAPI_ASM_GENERIC_UNISTD_H */
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index 272580c..1bbf3ec 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -33,8 +33,8 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#ifndef _DRM_H_
-#define _DRM_H_
+#ifndef _UAPI_DRM_DRM_H
+#define _UAPI_DRM_DRM_H
 
 #if defined(__KERNEL__) || defined(__linux__)
 
@@ -829,4 +829,4 @@ typedef struct drm_scatter_gather drm_scatter_gather_t;
 typedef struct drm_set_version drm_set_version_t;
 #endif
 
-#endif
+#endif /* _UAPI_DRM_DRM_H */
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 646ae5f..1efc52a 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -21,8 +21,8 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#ifndef DRM_FOURCC_H
-#define DRM_FOURCC_H
+#ifndef _UAPI_DRM_DRM_FOURCC_H
+#define _UAPI_DRM_DRM_FOURCC_H
 
 #include <linux/types.h>
 
@@ -132,4 +132,4 @@
 #define DRM_FORMAT_YUV444	fourcc_code('Y', 'U', '2', '4') /* non-subsampled Cb (1) and Cr (2) planes */
 #define DRM_FORMAT_YVU444	fourcc_code('Y', 'V', '2', '4') /* non-subsampled Cr (1) and Cb (2) planes */
 
-#endif /* DRM_FOURCC_H */
+#endif /* _UAPI_DRM_DRM_FOURCC_H */
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 53db7ce..712a52c 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -24,8 +24,8 @@
  * IN THE SOFTWARE.
  */
 
-#ifndef _DRM_MODE_H
-#define _DRM_MODE_H
+#ifndef _UAPI_DRM_DRM_MODE_H
+#define _UAPI_DRM_DRM_MODE_H
 
 #include <linux/types.h>
 
@@ -473,4 +473,4 @@ struct drm_mode_destroy_dumb {
 	uint32_t handle;
 };
 
-#endif
+#endif /* _UAPI_DRM_DRM_MODE_H */
diff --git a/include/uapi/drm/drm_sarea.h b/include/uapi/drm/drm_sarea.h
index 413a564..cfbdd45 100644
--- a/include/uapi/drm/drm_sarea.h
+++ b/include/uapi/drm/drm_sarea.h
@@ -29,8 +29,8 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#ifndef _DRM_SAREA_H_
-#define _DRM_SAREA_H_
+#ifndef _UAPI_DRM_DRM_SAREA_H
+#define _UAPI_DRM_DRM_SAREA_H
 
 #include <drm/drm.h>
 
@@ -83,4 +83,4 @@ typedef struct drm_sarea_frame drm_sarea_frame_t;
 typedef struct drm_sarea drm_sarea_t;
 #endif
 
-#endif				/* _DRM_SAREA_H_ */
+#endif /* _UAPI_DRM_DRM_SAREA_H */
diff --git a/include/uapi/drm/exynos_drm.h b/include/uapi/drm/exynos_drm.h
index d584412..b7c9c84 100644
--- a/include/uapi/drm/exynos_drm.h
+++ b/include/uapi/drm/exynos_drm.h
@@ -12,8 +12,8 @@
  * option) any later version.
  */
 
-#ifndef _UAPI_EXYNOS_DRM_H_
-#define _UAPI_EXYNOS_DRM_H_
+#ifndef _UAPI_DRM_EXYNOS_DRM_H
+#define _UAPI_DRM_EXYNOS_DRM_H
 
 #include <drm/drm.h>
 
@@ -387,4 +387,4 @@ struct drm_exynos_ipp_event {
 	__u32			buf_id[EXYNOS_DRM_OPS_MAX];
 };
 
-#endif /* _UAPI_EXYNOS_DRM_H_ */
+#endif /* _UAPI_DRM_EXYNOS_DRM_H */
diff --git a/include/uapi/drm/i810_drm.h b/include/uapi/drm/i810_drm.h
index 7a10bb6..20a6e30 100644
--- a/include/uapi/drm/i810_drm.h
+++ b/include/uapi/drm/i810_drm.h
@@ -1,5 +1,5 @@
-#ifndef _I810_DRM_H_
-#define _I810_DRM_H_
+#ifndef _UAPI_DRM_I810_DRM_H
+#define _UAPI_DRM_I810_DRM_H
 
 /* WARNING: These defines must be the same as what the Xserver uses.
  * if you change them, you must change the defines in the Xserver.
@@ -278,4 +278,4 @@ typedef struct _drm_i810_mc {
 	unsigned int last_render;	/* Last Render Request */
 } drm_i810_mc_t;
 
-#endif				/* _I810_DRM_H_ */
+#endif /* _UAPI_DRM_I810_DRM_H */
diff --git a/include/uapi/drm/i915_drm.h b/include/uapi/drm/i915_drm.h
index a1a7b6b..38a2493 100644
--- a/include/uapi/drm/i915_drm.h
+++ b/include/uapi/drm/i915_drm.h
@@ -24,8 +24,8 @@
  *
  */
 
-#ifndef _UAPI_I915_DRM_H_
-#define _UAPI_I915_DRM_H_
+#ifndef _UAPI_DRM_I915_DRM_H
+#define _UAPI_DRM_I915_DRM_H
 
 #include <drm/drm.h>
 
@@ -1005,4 +1005,4 @@ struct drm_i915_reg_read {
 	__u64 offset;
 	__u64 val; /* Return value */
 };
-#endif /* _UAPI_I915_DRM_H_ */
+#endif /* _UAPI_DRM_I915_DRM_H */
diff --git a/include/uapi/drm/mga_drm.h b/include/uapi/drm/mga_drm.h
index 2375bfd..6410569 100644
--- a/include/uapi/drm/mga_drm.h
+++ b/include/uapi/drm/mga_drm.h
@@ -32,8 +32,8 @@
  *    Gareth Hughes <gareth@valinux.com>
  */
 
-#ifndef __MGA_DRM_H__
-#define __MGA_DRM_H__
+#ifndef _UAPI_DRM_MGA_DRM_H
+#define _UAPI_DRM_MGA_DRM_H
 
 #include <drm/drm.h>
 
@@ -416,4 +416,4 @@ typedef struct drm_mga_getparam {
 	void __user *value;
 } drm_mga_getparam_t;
 
-#endif
+#endif /* _UAPI_DRM_MGA_DRM_H */
diff --git a/include/uapi/drm/nouveau_drm.h b/include/uapi/drm/nouveau_drm.h
index 2a5769f..de1db59 100644
--- a/include/uapi/drm/nouveau_drm.h
+++ b/include/uapi/drm/nouveau_drm.h
@@ -22,8 +22,8 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#ifndef __NOUVEAU_DRM_H__
-#define __NOUVEAU_DRM_H__
+#ifndef _UAPI_DRM_NOUVEAU_DRM_H
+#define _UAPI_DRM_NOUVEAU_DRM_H
 
 #define NOUVEAU_GEM_DOMAIN_CPU       (1 << 0)
 #define NOUVEAU_GEM_DOMAIN_VRAM      (1 << 1)
@@ -135,4 +135,4 @@ struct drm_nouveau_gem_cpu_fini {
 #define DRM_IOCTL_NOUVEAU_GEM_CPU_FINI       DRM_IOW (DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_CPU_FINI, struct drm_nouveau_gem_cpu_fini)
 #define DRM_IOCTL_NOUVEAU_GEM_INFO           DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_INFO, struct drm_nouveau_gem_info)
 
-#endif /* __NOUVEAU_DRM_H__ */
+#endif /* _UAPI_DRM_NOUVEAU_DRM_H */
diff --git a/include/uapi/drm/omap_drm.h b/include/uapi/drm/omap_drm.h
index 1d0b117..beb7d14 100644
--- a/include/uapi/drm/omap_drm.h
+++ b/include/uapi/drm/omap_drm.h
@@ -17,8 +17,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef __OMAP_DRM_H__
-#define __OMAP_DRM_H__
+#ifndef _UAPI_DRM_OMAP_DRM_H
+#define _UAPI_DRM_OMAP_DRM_H
 
 #include <drm/drm.h>
 
@@ -120,4 +120,4 @@ struct drm_omap_gem_info {
 #define DRM_IOCTL_OMAP_GEM_CPU_FINI	DRM_IOW (DRM_COMMAND_BASE + DRM_OMAP_GEM_CPU_FINI, struct drm_omap_gem_cpu_fini)
 #define DRM_IOCTL_OMAP_GEM_INFO		DRM_IOWR(DRM_COMMAND_BASE + DRM_OMAP_GEM_INFO, struct drm_omap_gem_info)
 
-#endif /* __OMAP_DRM_H__ */
+#endif /* _UAPI_DRM_OMAP_DRM_H */
diff --git a/include/uapi/drm/qxl_drm.h b/include/uapi/drm/qxl_drm.h
index ebebd36..17fa3ec 100644
--- a/include/uapi/drm/qxl_drm.h
+++ b/include/uapi/drm/qxl_drm.h
@@ -21,8 +21,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  */
-#ifndef QXL_DRM_H
-#define QXL_DRM_H
+#ifndef _UAPI_DRM_QXL_DRM_H
+#define _UAPI_DRM_QXL_DRM_H
 
 #include <stddef.h>
 #include "drm/drm.h"
@@ -149,4 +149,4 @@ struct drm_qxl_alloc_surf {
 	DRM_IOWR(DRM_COMMAND_BASE + DRM_QXL_ALLOC_SURF,\
 		struct drm_qxl_alloc_surf)
 
-#endif
+#endif /* _UAPI_DRM_QXL_DRM_H */
diff --git a/include/uapi/drm/r128_drm.h b/include/uapi/drm/r128_drm.h
index 8d8878b..ede7f8e 100644
--- a/include/uapi/drm/r128_drm.h
+++ b/include/uapi/drm/r128_drm.h
@@ -30,8 +30,8 @@
  *    Kevin E. Martin <martin@valinux.com>
  */
 
-#ifndef __R128_DRM_H__
-#define __R128_DRM_H__
+#ifndef _UAPI_DRM_R128_DRM_H
+#define _UAPI_DRM_R128_DRM_H
 
 /* WARNING: If you change any of these defines, make sure to change the
  * defines in the X server file (r128_sarea.h)
@@ -323,4 +323,4 @@ typedef struct drm_r128_getparam {
 	void __user *value;
 } drm_r128_getparam_t;
 
-#endif
+#endif /* _UAPI_DRM_R128_DRM_H */
diff --git a/include/uapi/drm/radeon_drm.h b/include/uapi/drm/radeon_drm.h
index 321d4ac..089abd3 100644
--- a/include/uapi/drm/radeon_drm.h
+++ b/include/uapi/drm/radeon_drm.h
@@ -30,8 +30,8 @@
  *    Keith Whitwell <keith@tungstengraphics.com>
  */
 
-#ifndef __RADEON_DRM_H__
-#define __RADEON_DRM_H__
+#ifndef _UAPI_DRM_RADEON_DRM_H
+#define _UAPI_DRM_RADEON_DRM_H
 
 #include <drm/drm.h>
 
@@ -1005,4 +1005,4 @@ struct drm_radeon_info {
 #define SI_TILE_MODE_DEPTH_STENCIL_2D_4AA	3
 #define SI_TILE_MODE_DEPTH_STENCIL_2D_8AA	2
 
-#endif
+#endif /* _UAPI_DRM_RADEON_DRM_H */
diff --git a/include/uapi/drm/savage_drm.h b/include/uapi/drm/savage_drm.h
index 818d49b..d505252 100644
--- a/include/uapi/drm/savage_drm.h
+++ b/include/uapi/drm/savage_drm.h
@@ -23,8 +23,8 @@
  * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#ifndef __SAVAGE_DRM_H__
-#define __SAVAGE_DRM_H__
+#ifndef _UAPI_DRM_SAVAGE_DRM_H
+#define _UAPI_DRM_SAVAGE_DRM_H
 
 #ifndef __SAVAGE_SAREA_DEFINES__
 #define __SAVAGE_SAREA_DEFINES__
@@ -207,4 +207,4 @@ union drm_savage_cmd_header {
 	} clear1;		/* SAVAGE_CMD_CLEAR data */
 };
 
-#endif
+#endif /* _UAPI_DRM_SAVAGE_DRM_H */
diff --git a/include/uapi/drm/sis_drm.h b/include/uapi/drm/sis_drm.h
index df37632..570f019 100644
--- a/include/uapi/drm/sis_drm.h
+++ b/include/uapi/drm/sis_drm.h
@@ -24,8 +24,8 @@
  *
  */
 
-#ifndef __SIS_DRM_H__
-#define __SIS_DRM_H__
+#ifndef _UAPI_DRM_SIS_DRM_H
+#define _UAPI_DRM_SIS_DRM_H
 
 /* SiS specific ioctls */
 #define NOT_USED_0_3
@@ -68,4 +68,4 @@ struct sis_file_private {
 	struct list_head obj_list;
 };
 
-#endif				/* __SIS_DRM_H__ */
+#endif /* _UAPI_DRM_SIS_DRM_H */
diff --git a/include/uapi/drm/tegra_drm.h b/include/uapi/drm/tegra_drm.h
index 73bde4e..70d79b4 100644
--- a/include/uapi/drm/tegra_drm.h
+++ b/include/uapi/drm/tegra_drm.h
@@ -14,8 +14,8 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef _UAPI_TEGRA_DRM_H_
-#define _UAPI_TEGRA_DRM_H_
+#ifndef _UAPI_DRM_TEGRA_DRM_H
+#define _UAPI_DRM_TEGRA_DRM_H
 
 #include <drm/drm.h>
 
@@ -135,4 +135,4 @@ struct drm_tegra_submit {
 #define DRM_IOCTL_TEGRA_GET_SYNCPT DRM_IOWR(DRM_COMMAND_BASE + DRM_TEGRA_GET_SYNCPT, struct drm_tegra_get_syncpt)
 #define DRM_IOCTL_TEGRA_SUBMIT DRM_IOWR(DRM_COMMAND_BASE + DRM_TEGRA_SUBMIT, struct drm_tegra_submit)
 
-#endif
+#endif /* _UAPI_DRM_TEGRA_DRM_H */
diff --git a/include/uapi/drm/via_drm.h b/include/uapi/drm/via_drm.h
index 8b0533c..c070906 100644
--- a/include/uapi/drm/via_drm.h
+++ b/include/uapi/drm/via_drm.h
@@ -21,8 +21,8 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  * DEALINGS IN THE SOFTWARE.
  */
-#ifndef _VIA_DRM_H_
-#define _VIA_DRM_H_
+#ifndef _UAPI_DRM_VIA_DRM_H
+#define _UAPI_DRM_VIA_DRM_H
 
 #include <drm/drm.h>
 
@@ -278,4 +278,4 @@ struct via_file_private {
 	struct list_head obj_list;
 };
 
-#endif				/* _VIA_DRM_H_ */
+#endif /* _UAPI_DRM_VIA_DRM_H */
diff --git a/include/uapi/drm/vmwgfx_drm.h b/include/uapi/drm/vmwgfx_drm.h
index bcb0912..95a2188 100644
--- a/include/uapi/drm/vmwgfx_drm.h
+++ b/include/uapi/drm/vmwgfx_drm.h
@@ -25,8 +25,8 @@
  *
  **************************************************************************/
 
-#ifndef __VMWGFX_DRM_H__
-#define __VMWGFX_DRM_H__
+#ifndef _UAPI_DRM_VMWGFX_DRM_H
+#define _UAPI_DRM_VMWGFX_DRM_H
 
 #define DRM_VMW_MAX_SURFACE_FACES 6
 #define DRM_VMW_MAX_MIP_LEVELS 24
@@ -787,4 +787,4 @@ struct drm_vmw_update_layout_arg {
 	uint64_t rects;
 };
 
-#endif
+#endif /* _UAPI_DRM_VMWGFX_DRM_H */
diff --git a/include/uapi/mtd/inftl-user.h b/include/uapi/mtd/inftl-user.h
index 8376bd1..6a63bb9 100644
--- a/include/uapi/mtd/inftl-user.h
+++ b/include/uapi/mtd/inftl-user.h
@@ -3,8 +3,8 @@
  *
  */
 
-#ifndef __MTD_INFTL_USER_H__
-#define __MTD_INFTL_USER_H__
+#ifndef _UAPI_MTD_INFTL_USER_H
+#define _UAPI_MTD_INFTL_USER_H
 
 #include <linux/types.h>
 
@@ -86,6 +86,6 @@ struct INFTLMediaHeader {
 #define	INFTL_BDTL	0x40000000
 #define	INFTL_LAST	0x80000000
 
-#endif /* __MTD_INFTL_USER_H__ */
+#endif /* _UAPI_MTD_INFTL_USER_H */
 
 
diff --git a/include/uapi/mtd/mtd-abi.h b/include/uapi/mtd/mtd-abi.h
index 36eace0..3f20420 100644
--- a/include/uapi/mtd/mtd-abi.h
+++ b/include/uapi/mtd/mtd-abi.h
@@ -17,8 +17,8 @@
  *
  */
 
-#ifndef __MTD_ABI_H__
-#define __MTD_ABI_H__
+#ifndef _UAPI_MTD_MTD_ABI_H
+#define _UAPI_MTD_MTD_ABI_H
 
 #include <linux/types.h>
 
@@ -275,4 +275,4 @@ enum mtd_file_modes {
 	MTD_FILE_MODE_RAW,
 };
 
-#endif /* __MTD_ABI_H__ */
+#endif /* _UAPI_MTD_MTD_ABI_H */
diff --git a/include/uapi/mtd/mtd-user.h b/include/uapi/mtd/mtd-user.h
index 83327c8..1bc2f45 100644
--- a/include/uapi/mtd/mtd-user.h
+++ b/include/uapi/mtd/mtd-user.h
@@ -17,8 +17,8 @@
  *
  */
 
-#ifndef __MTD_USER_H__
-#define __MTD_USER_H__
+#ifndef _UAPI_MTD_MTD_USER_H
+#define _UAPI_MTD_MTD_USER_H
 
 #include <stdint.h>
 
@@ -31,4 +31,4 @@ typedef struct region_info_user region_info_t;
 typedef struct nand_oobinfo nand_oobinfo_t;
 typedef struct nand_ecclayout_user nand_ecclayout_t;
 
-#endif /* __MTD_USER_H__ */
+#endif /* _UAPI_MTD_MTD_USER_H */
diff --git a/include/uapi/mtd/nftl-user.h b/include/uapi/mtd/nftl-user.h
index bdeabd8..9a03a73 100644
--- a/include/uapi/mtd/nftl-user.h
+++ b/include/uapi/mtd/nftl-user.h
@@ -17,8 +17,8 @@
  *
  */
 
-#ifndef __MTD_NFTL_USER_H__
-#define __MTD_NFTL_USER_H__
+#ifndef _UAPI_MTD_NFTL_USER_H
+#define _UAPI_MTD_NFTL_USER_H
 
 #include <linux/types.h>
 
@@ -87,4 +87,4 @@ struct NFTLMediaHeader {
 #define ZONE_BAD_MARKED 7
 
 
-#endif /* __MTD_NFTL_USER_H__ */
+#endif /* _UAPI_MTD_NFTL_USER_H */
diff --git a/include/uapi/mtd/ubi-user.h b/include/uapi/mtd/ubi-user.h
index 723c324..64f55b0 100644
--- a/include/uapi/mtd/ubi-user.h
+++ b/include/uapi/mtd/ubi-user.h
@@ -18,8 +18,8 @@
  * Author: Artem Bityutskiy (???????? ?????)
  */
 
-#ifndef __UBI_USER_H__
-#define __UBI_USER_H__
+#ifndef _UAPI_MTD_UBI_USER_H
+#define _UAPI_MTD_UBI_USER_H
 
 #include <linux/types.h>
 
@@ -420,4 +420,4 @@ struct ubi_set_vol_prop_req {
 	__u64 value;
 }  __packed;
 
-#endif /* __UBI_USER_H__ */
+#endif /* _UAPI_MTD_UBI_USER_H */
diff --git a/include/uapi/rdma/ib_user_cm.h b/include/uapi/rdma/ib_user_cm.h
index f79014a..31bdfd9 100644
--- a/include/uapi/rdma/ib_user_cm.h
+++ b/include/uapi/rdma/ib_user_cm.h
@@ -31,8 +31,8 @@
  * SOFTWARE.
  */
 
-#ifndef IB_USER_CM_H
-#define IB_USER_CM_H
+#ifndef _UAPI_RDMA_IB_USER_CM_H
+#define _UAPI_RDMA_IB_USER_CM_H
 
 #include <linux/types.h>
 #include <rdma/ib_user_sa.h>
@@ -322,4 +322,4 @@ struct ib_ucm_event_resp {
 	} u;
 };
 
-#endif /* IB_USER_CM_H */
+#endif /* _UAPI_RDMA_IB_USER_CM_H */
diff --git a/include/uapi/rdma/ib_user_mad.h b/include/uapi/rdma/ib_user_mad.h
index d6fce1c..5f2c288 100644
--- a/include/uapi/rdma/ib_user_mad.h
+++ b/include/uapi/rdma/ib_user_mad.h
@@ -31,8 +31,8 @@
  * SOFTWARE.
  */
 
-#ifndef IB_USER_MAD_H
-#define IB_USER_MAD_H
+#ifndef _UAPI_RDMA_IB_USER_MAD_H
+#define _UAPI_RDMA_IB_USER_MAD_H
 
 #include <linux/types.h>
 #include <linux/ioctl.h>
@@ -200,4 +200,4 @@ struct ib_user_mad_reg_req {
 
 #define IB_USER_MAD_ENABLE_PKEY		_IO(IB_IOCTL_MAGIC, 3)
 
-#endif /* IB_USER_MAD_H */
+#endif /* _UAPI_RDMA_IB_USER_MAD_H */
diff --git a/include/uapi/rdma/ib_user_sa.h b/include/uapi/rdma/ib_user_sa.h
index cfc7c9b..a58438e8 100644
--- a/include/uapi/rdma/ib_user_sa.h
+++ b/include/uapi/rdma/ib_user_sa.h
@@ -30,8 +30,8 @@
  * SOFTWARE.
  */
 
-#ifndef IB_USER_SA_H
-#define IB_USER_SA_H
+#ifndef _UAPI_RDMA_IB_USER_SA_H
+#define _UAPI_RDMA_IB_USER_SA_H
 
 #include <linux/types.h>
 
@@ -73,4 +73,4 @@ struct ib_user_path_rec {
 	__u8	preference;
 };
 
-#endif /* IB_USER_SA_H */
+#endif /* _UAPI_RDMA_IB_USER_SA_H */
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 805711e..17c9572 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -33,8 +33,8 @@
  * SOFTWARE.
  */
 
-#ifndef IB_USER_VERBS_H
-#define IB_USER_VERBS_H
+#ifndef _UAPI_RDMA_IB_USER_VERBS_H
+#define _UAPI_RDMA_IB_USER_VERBS_H
 
 #include <linux/types.h>
 
@@ -747,4 +747,4 @@ struct ib_uverbs_destroy_srq_resp {
 	__u32 events_reported;
 };
 
-#endif /* IB_USER_VERBS_H */
+#endif /* _UAPI_RDMA_IB_USER_VERBS_H */
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 8297285..099b1e5 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -1,5 +1,5 @@
-#ifndef _UAPI_RDMA_NETLINK_H
-#define _UAPI_RDMA_NETLINK_H
+#ifndef _UAPI_RDMA_RDMA_NETLINK_H
+#define _UAPI_RDMA_RDMA_NETLINK_H
 
 #include <linux/types.h>
 
@@ -34,4 +34,4 @@ struct rdma_cm_id_stats {
 };
 
 
-#endif /* _UAPI_RDMA_NETLINK_H */
+#endif /* _UAPI_RDMA_RDMA_NETLINK_H */
diff --git a/include/uapi/rdma/rdma_user_cm.h b/include/uapi/rdma/rdma_user_cm.h
index 99b80ab..6d321f5 100644
--- a/include/uapi/rdma/rdma_user_cm.h
+++ b/include/uapi/rdma/rdma_user_cm.h
@@ -30,8 +30,8 @@
  * SOFTWARE.
  */
 
-#ifndef RDMA_USER_CM_H
-#define RDMA_USER_CM_H
+#ifndef _UAPI_RDMA_RDMA_USER_CM_H
+#define _UAPI_RDMA_RDMA_USER_CM_H
 
 #include <linux/types.h>
 #include <linux/in6.h>
@@ -299,4 +299,4 @@ struct rdma_ucm_migrate_resp {
 	__u32 events_reported;
 };
 
-#endif /* RDMA_USER_CM_H */
+#endif /* _UAPI_RDMA_RDMA_USER_CM_H */
diff --git a/include/uapi/scsi/fc/fc_els.h b/include/uapi/scsi/fc/fc_els.h
index 481abbd..a4bf009 100644
--- a/include/uapi/scsi/fc/fc_els.h
+++ b/include/uapi/scsi/fc/fc_els.h
@@ -17,8 +17,8 @@
  * Maintained at www.Open-FCoE.org
  */
 
-#ifndef _FC_ELS_H_
-#define	_FC_ELS_H_
+#ifndef _UAPI_SCSI_FC_FC_ELS_H
+#define	_UAPI_SCSI_FC_FC_ELS_H
 
 #include <linux/types.h>
 
@@ -828,4 +828,4 @@ enum fc_els_clid_ic {
 	ELS_CLID_IC_LIP =	8,	/* receiving LIP */
 };
 
-#endif /* _FC_ELS_H_ */
+#endif /* _UAPI_SCSI_FC_FC_ELS_H */
diff --git a/include/uapi/scsi/fc/fc_fs.h b/include/uapi/scsi/fc/fc_fs.h
index 50f28b1..0d94610 100644
--- a/include/uapi/scsi/fc/fc_fs.h
+++ b/include/uapi/scsi/fc/fc_fs.h
@@ -17,8 +17,8 @@
  * Maintained at www.Open-FCoE.org
  */
 
-#ifndef _FC_FS_H_
-#define _FC_FS_H_
+#ifndef _UAPI_SCSI_FC_FC_FS_H
+#define _UAPI_SCSI_FC_FC_FS_H
 
 #include <linux/types.h>
 
@@ -345,4 +345,4 @@ enum fc_pf_rjt_reason {
 #define FC_DEF_E_D_TOV	2000UL
 #define FC_DEF_R_A_TOV	10000UL
 
-#endif /* _FC_FS_H_ */
+#endif /* _UAPI_SCSI_FC_FC_FS_H */
diff --git a/include/uapi/scsi/fc/fc_gs.h b/include/uapi/scsi/fc/fc_gs.h
index a37346d..763655e 100644
--- a/include/uapi/scsi/fc/fc_gs.h
+++ b/include/uapi/scsi/fc/fc_gs.h
@@ -17,8 +17,8 @@
  * Maintained at www.Open-FCoE.org
  */
 
-#ifndef _FC_GS_H_
-#define	_FC_GS_H_
+#ifndef _UAPI_SCSI_FC_FC_GS_H
+#define	_UAPI_SCSI_FC_FC_GS_H
 
 #include <linux/types.h>
 
@@ -93,4 +93,4 @@ enum fc_ct_explan {
 	/* definitions not complete */
 };
 
-#endif /* _FC_GS_H_ */
+#endif /* _UAPI_SCSI_FC_FC_GS_H */
diff --git a/include/uapi/scsi/fc/fc_ns.h b/include/uapi/scsi/fc/fc_ns.h
index f7751d5..6fdeac7 100644
--- a/include/uapi/scsi/fc/fc_ns.h
+++ b/include/uapi/scsi/fc/fc_ns.h
@@ -17,8 +17,8 @@
  * Maintained at www.Open-FCoE.org
  */
 
-#ifndef _FC_NS_H_
-#define	_FC_NS_H_
+#ifndef _UAPI_SCSI_FC_FC_NS_H
+#define	_UAPI_SCSI_FC_FC_NS_H
 
 #include <linux/types.h>
 
@@ -205,4 +205,4 @@ struct fc_ns_rff_id {
 	__u8		fr_type;	/* FC-4 type */
 } __attribute__((__packed__));
 
-#endif /* _FC_NS_H_ */
+#endif /* _UAPI_SCSI_FC_FC_NS_H */
diff --git a/include/uapi/scsi/scsi_bsg_fc.h b/include/uapi/scsi/scsi_bsg_fc.h
index 3031b90..dad5f46 100644
--- a/include/uapi/scsi/scsi_bsg_fc.h
+++ b/include/uapi/scsi/scsi_bsg_fc.h
@@ -19,8 +19,8 @@
  *
  */
 
-#ifndef SCSI_BSG_FC_H
-#define SCSI_BSG_FC_H
+#ifndef _UAPI_SCSI_SCSI_BSG_FC_H
+#define _UAPI_SCSI_SCSI_BSG_FC_H
 
 /*
  * This file intended to be included by both kernel and user space
@@ -316,5 +316,4 @@ struct fc_bsg_reply {
 };
 
 
-#endif /* SCSI_BSG_FC_H */
-
+#endif /* _UAPI_SCSI_SCSI_BSG_FC_H */
diff --git a/include/uapi/scsi/scsi_netlink.h b/include/uapi/scsi/scsi_netlink.h
index 62b4eda..b21e18d 100644
--- a/include/uapi/scsi/scsi_netlink.h
+++ b/include/uapi/scsi/scsi_netlink.h
@@ -19,8 +19,8 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  *
  */
-#ifndef SCSI_NETLINK_H
-#define SCSI_NETLINK_H
+#ifndef _UAPI_SCSI_SCSI_NETLINK_H
+#define _UAPI_SCSI_SCSI_NETLINK_H
 
 #include <linux/netlink.h>
 #include <linux/types.h>
@@ -119,5 +119,4 @@ struct scsi_nl_host_vendor_msg {
 	(hdr)->msglen = mlen;					\
 	}
 
-#endif /* SCSI_NETLINK_H */
-
+#endif /* _UAPI_SCSI_SCSI_NETLINK_H */
diff --git a/include/uapi/scsi/scsi_netlink_fc.h b/include/uapi/scsi/scsi_netlink_fc.h
index cbf76e4..6ba885a 100644
--- a/include/uapi/scsi/scsi_netlink_fc.h
+++ b/include/uapi/scsi/scsi_netlink_fc.h
@@ -18,8 +18,8 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  *
  */
-#ifndef SCSI_NETLINK_FC_H
-#define SCSI_NETLINK_FC_H
+#ifndef _UAPI_SCSI_SCSI_NETLINK_FC_H
+#define _UAPI_SCSI_SCSI_NETLINK_FC_H
 
 #include <scsi/scsi_netlink.h>
 
@@ -67,5 +67,4 @@ struct fc_nl_event {
 } __attribute__((aligned(sizeof(uint64_t))));
 
 
-#endif /* SCSI_NETLINK_FC_H */
-
+#endif /* _UAPI_SCSI_SCSI_NETLINK_FC_H */
diff --git a/include/uapi/sound/asequencer.h b/include/uapi/sound/asequencer.h
index 09c8a00..1cf6a6b 100644
--- a/include/uapi/sound/asequencer.h
+++ b/include/uapi/sound/asequencer.h
@@ -19,8 +19,8 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
  */
-#ifndef _UAPI__SOUND_ASEQUENCER_H
-#define _UAPI__SOUND_ASEQUENCER_H
+#ifndef _UAPI_SOUND_ASEQUENCER_H
+#define _UAPI_SOUND_ASEQUENCER_H
 
 
 /** version of the sequencer */
@@ -611,4 +611,4 @@ struct snd_seq_query_subs {
 #define SNDRV_SEQ_IOCTL_QUERY_NEXT_CLIENT	_IOWR('S', 0x51, struct snd_seq_client_info)
 #define SNDRV_SEQ_IOCTL_QUERY_NEXT_PORT	_IOWR('S', 0x52, struct snd_seq_port_info)
 
-#endif /* _UAPI__SOUND_ASEQUENCER_H */
+#endif /* _UAPI_SOUND_ASEQUENCER_H */
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 041203f..ffc28ce 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -20,8 +20,8 @@
  *
  */
 
-#ifndef _UAPI__SOUND_ASOUND_H
-#define _UAPI__SOUND_ASOUND_H
+#ifndef _UAPI_SOUND_ASOUND_H
+#define _UAPI_SOUND_ASOUND_H
 
 #include <linux/types.h>
 
@@ -972,4 +972,4 @@ struct snd_ctl_event {
 #define SNDRV_CTL_NAME_IEC958_PCM_STREAM		"PCM Stream"
 #define SNDRV_CTL_NAME_IEC958(expl,direction,what)	"IEC958 " expl SNDRV_CTL_NAME_##direction SNDRV_CTL_NAME_IEC958_##what
 
-#endif /* _UAPI__SOUND_ASOUND_H */
+#endif /* _UAPI_SOUND_ASOUND_H */
diff --git a/include/uapi/sound/asound_fm.h b/include/uapi/sound/asound_fm.h
index c2a4b96..eca7aab 100644
--- a/include/uapi/sound/asound_fm.h
+++ b/include/uapi/sound/asound_fm.h
@@ -1,5 +1,5 @@
-#ifndef __SOUND_ASOUND_FM_H
-#define __SOUND_ASOUND_FM_H
+#ifndef _UAPI_SOUND_ASOUND_FM_H
+#define _UAPI_SOUND_ASOUND_FM_H
 
 /*
  *  Advanced Linux Sound Architecture - ALSA
@@ -131,4 +131,4 @@ struct sbi_patch {
 	unsigned char data[32];
 };
 
-#endif /* __SOUND_ASOUND_FM_H */
+#endif /* _UAPI_SOUND_ASOUND_FM_H */
diff --git a/include/uapi/sound/compress_offload.h b/include/uapi/sound/compress_offload.h
index d630163..dce9292 100644
--- a/include/uapi/sound/compress_offload.h
+++ b/include/uapi/sound/compress_offload.h
@@ -22,8 +22,8 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
  */
-#ifndef __COMPRESS_OFFLOAD_H
-#define __COMPRESS_OFFLOAD_H
+#ifndef _UAPI_SOUND_COMPRESS_OFFLOAD_H
+#define _UAPI_SOUND_COMPRESS_OFFLOAD_H
 
 #include <linux/types.h>
 #include <sound/asound.h>
@@ -187,4 +187,4 @@ struct snd_compr_metadata {
 #define SND_COMPR_TRIGGER_DRAIN 7 /*FIXME move this to pcm.h */
 #define SND_COMPR_TRIGGER_NEXT_TRACK 8
 #define SND_COMPR_TRIGGER_PARTIAL_DRAIN 9
-#endif
+#endif /* _UAPI_SOUND_COMPRESS_OFFLOAD_H */
diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
index 602dc6c..b9c42c3 100644
--- a/include/uapi/sound/compress_params.h
+++ b/include/uapi/sound/compress_params.h
@@ -48,8 +48,8 @@
  * MATERIALS OR THE USE OR OTHER DEALINGS IN THE MATERIALS.
  *
  */
-#ifndef __SND_COMPRESS_PARAMS_H
-#define __SND_COMPRESS_PARAMS_H
+#ifndef _UAPI_SOUND_COMPRESS_PARAMS_H
+#define _UAPI_SOUND_COMPRESS_PARAMS_H
 
 #include <linux/types.h>
 
@@ -397,4 +397,4 @@ struct snd_codec {
 	__u32 reserved[3];
 };
 
-#endif
+#endif /* _UAPI_SOUND_COMPRESS_PARAMS_H */
diff --git a/include/uapi/sound/emu10k1.h b/include/uapi/sound/emu10k1.h
index d1bbaf7..849654f 100644
--- a/include/uapi/sound/emu10k1.h
+++ b/include/uapi/sound/emu10k1.h
@@ -19,8 +19,8 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
  */
-#ifndef _UAPI__SOUND_EMU10K1_H
-#define _UAPI__SOUND_EMU10K1_H
+#ifndef _UAPI_SOUND_EMU10K1_H
+#define _UAPI_SOUND_EMU10K1_H
 
 #include <linux/types.h>
 
@@ -370,4 +370,4 @@ typedef struct snd_emu10k1_fx8010_code emu10k1_fx8010_code_t;
 typedef struct snd_emu10k1_fx8010_tram emu10k1_fx8010_tram_t;
 typedef struct snd_emu10k1_fx8010_pcm_rec emu10k1_fx8010_pcm_t;
 
-#endif /* _UAPI__SOUND_EMU10K1_H */
+#endif /* _UAPI_SOUND_EMU10K1_H */
diff --git a/include/uapi/sound/hdsp.h b/include/uapi/sound/hdsp.h
index 0909a38..b5cacac 100644
--- a/include/uapi/sound/hdsp.h
+++ b/include/uapi/sound/hdsp.h
@@ -1,5 +1,5 @@
-#ifndef __SOUND_HDSP_H
-#define __SOUND_HDSP_H
+#ifndef _UAPI_SOUND_HDSP_H
+#define _UAPI_SOUND_HDSP_H
 
 /*
  *   Copyright (C) 2003 Thomas Charbonnel (thomas at undata.org)
@@ -107,4 +107,4 @@ typedef struct hdsp_version hdsp_version_t;
 typedef struct hdsp_mixer hdsp_mixer_t;
 typedef struct hdsp_9632_aeb hdsp_9632_aeb_t;
 
-#endif /* __SOUND_HDSP_H */
+#endif /* _UAPI_SOUND_HDSP_H */
diff --git a/include/uapi/sound/hdspm.h b/include/uapi/sound/hdspm.h
index 1f59ea2..c1f1b5d 100644
--- a/include/uapi/sound/hdspm.h
+++ b/include/uapi/sound/hdspm.h
@@ -1,5 +1,5 @@
-#ifndef __SOUND_HDSPM_H
-#define __SOUND_HDSPM_H
+#ifndef _UAPI_SOUND_HDSPM_H
+#define _UAPI_SOUND_HDSPM_H
 /*
  *   Copyright (C) 2003 Winfried Ritsch (IEM)
  *   based on hdsp.h from Thomas Charbonnel (thomas at undata.org)
@@ -226,4 +226,4 @@ typedef struct hdspm_channelfader snd_hdspm_channelfader_t;
 typedef struct hdspm_mixer hdspm_mixer_t;
 
 
-#endif
+#endif /* _UAPI_SOUND_HDSPM_H */
diff --git a/include/uapi/sound/sb16_csp.h b/include/uapi/sound/sb16_csp.h
index 3b96907..a13dc02 100644
--- a/include/uapi/sound/sb16_csp.h
+++ b/include/uapi/sound/sb16_csp.h
@@ -19,8 +19,8 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
  */
-#ifndef _UAPI__SOUND_SB16_CSP_H
-#define _UAPI__SOUND_SB16_CSP_H
+#ifndef _UAPI_SOUND_SB16_CSP_H
+#define _UAPI_SOUND_SB16_CSP_H
 
 
 /* CSP modes */
@@ -119,4 +119,4 @@ struct snd_sb_csp_info {
 #define SNDRV_SB_CSP_IOCTL_RESTART	_IO('H', 0x16)
 
 
-#endif /* _UAPI__SOUND_SB16_CSP_H */
+#endif /* _UAPI_SOUND_SB16_CSP_H */
diff --git a/include/uapi/sound/sfnt_info.h b/include/uapi/sound/sfnt_info.h
index 1bce7fd..7435465 100644
--- a/include/uapi/sound/sfnt_info.h
+++ b/include/uapi/sound/sfnt_info.h
@@ -1,5 +1,5 @@
-#ifndef __SOUND_SFNT_INFO_H
-#define __SOUND_SFNT_INFO_H
+#ifndef _UAPI_SOUND_SFNT_INFO_H
+#define _UAPI_SOUND_SFNT_INFO_H
 
 /*
  *  Patch record compatible with AWE driver on OSS
@@ -209,4 +209,4 @@ struct snd_emux_misc_mode {
 #define SNDRV_EMUX_IOCTL_MEM_AVAIL	_IOW('H', 0x84, int)
 #define SNDRV_EMUX_IOCTL_MISC_MODE	_IOWR('H', 0x84, struct snd_emux_misc_mode)
 
-#endif /* __SOUND_SFNT_INFO_H */
+#endif /* _UAPI_SOUND_SFNT_INFO_H */
diff --git a/include/uapi/video/edid.h b/include/uapi/video/edid.h
index 8c0f032..aa8d946 100644
--- a/include/uapi/video/edid.h
+++ b/include/uapi/video/edid.h
@@ -1,9 +1,9 @@
-#ifndef _UAPI__linux_video_edid_h__
-#define _UAPI__linux_video_edid_h__
+#ifndef _UAPI_VIDEO_EDID_H
+#define _UAPI_VIDEO_EDID_H
 
 struct edid_info {
 	unsigned char dummy[128];
 };
 
 
-#endif /* _UAPI__linux_video_edid_h__ */
+#endif /* _UAPI_VIDEO_EDID_H */
diff --git a/include/uapi/video/sisfb.h b/include/uapi/video/sisfb.h
index 9250b22..06de303 100644
--- a/include/uapi/video/sisfb.h
+++ b/include/uapi/video/sisfb.h
@@ -18,8 +18,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307, USA
  */
 
-#ifndef _UAPI_LINUX_SISFB_H_
-#define _UAPI_LINUX_SISFB_H_
+#ifndef _UAPI_VIDEO_SISFB_H_
+#define _UAPI_VIDEO_SISFB_H_
 
 #include <linux/types.h>
 #include <asm/ioctl.h>
@@ -206,4 +206,4 @@ struct sis_memreq {
 /**********************************************/
 
 
-#endif /* _UAPI_LINUX_SISFB_H_ */
+#endif /* _UAPI_VIDEO_SISFB_H_ */
diff --git a/include/uapi/video/uvesafb.h b/include/uapi/video/uvesafb.h
index cee063d..ce37b3c 100644
--- a/include/uapi/video/uvesafb.h
+++ b/include/uapi/video/uvesafb.h
@@ -1,5 +1,5 @@
-#ifndef _UAPI_UVESAFB_H
-#define _UAPI_UVESAFB_H
+#ifndef _UAPI_VIDEO_UVESAFB_H
+#define _UAPI_VIDEO_UVESAFB_H
 
 #include <linux/types.h>
 
@@ -57,4 +57,4 @@ struct vbe_ib {
 	char  misc_data[512];
 } __attribute__ ((packed));
 
-#endif /* _UAPI_UVESAFB_H */
+#endif /* _UAPI_VIDEO_UVESAFB_H */
diff --git a/include/uapi/xen/evtchn.h b/include/uapi/xen/evtchn.h
index 14e833e..c857acf 100644
--- a/include/uapi/xen/evtchn.h
+++ b/include/uapi/xen/evtchn.h
@@ -30,8 +30,8 @@
  * IN THE SOFTWARE.
  */
 
-#ifndef __LINUX_PUBLIC_EVTCHN_H__
-#define __LINUX_PUBLIC_EVTCHN_H__
+#ifndef _UAPI_XEN_EVTCHN_H
+#define _UAPI_XEN_EVTCHN_H
 
 /*
  * Bind a fresh port to VIRQ @virq.
@@ -85,4 +85,4 @@ struct ioctl_evtchn_notify {
 #define IOCTL_EVTCHN_RESET				\
 	_IOC(_IOC_NONE, 'E', 5, 0)
 
-#endif /* __LINUX_PUBLIC_EVTCHN_H__ */
+#endif /* _UAPI_XEN_EVTCHN_H */
diff --git a/include/uapi/xen/privcmd.h b/include/uapi/xen/privcmd.h
index a853168..4c59bdf 100644
--- a/include/uapi/xen/privcmd.h
+++ b/include/uapi/xen/privcmd.h
@@ -30,8 +30,8 @@
  * IN THE SOFTWARE.
  */
 
-#ifndef __LINUX_PUBLIC_PRIVCMD_H__
-#define __LINUX_PUBLIC_PRIVCMD_H__
+#ifndef _UAPI_XEN_PRIVCMD_H
+#define _UAPI_XEN_PRIVCMD_H
 
 #include <linux/types.h>
 #include <linux/compiler.h>
@@ -95,4 +95,4 @@ struct privcmd_mmapbatch_v2 {
 #define IOCTL_PRIVCMD_MMAPBATCH_V2				\
 	_IOC(_IOC_NONE, 'P', 4, sizeof(struct privcmd_mmapbatch_v2))
 
-#endif /* __LINUX_PUBLIC_PRIVCMD_H__ */
+#endif /* _UAPI_XEN_PRIVCMD_H */
-- 
1.7.7.6
