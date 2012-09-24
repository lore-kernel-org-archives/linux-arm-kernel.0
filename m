From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 24 Sep 2012 19:49:21 +1000
Subject: linux-next: manual merge of the arm-soc tree with the fbdev tree
Message-ID: <20120924194921.9c277f5048627c74708ba1ce@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got conflicts in
drivers/video/msm/mddi.c, drivers/video/msm/mdp.c and
drivers/video/msm/mdp_hw.h between commit 8abf0b31e161 ("video: msm:
Remove useless mach/* includes") from the fbdev tree and commit
1ef21f6343ff ("ARM: msm: move platform_data definitions") from the
arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/video/msm/mddi.c
index d43e178,bf73f04..0000000
--- a/drivers/video/msm/mddi.c
+++ b/drivers/video/msm/mddi.c
@@@ -26,7 -26,10 +26,7 @@@
  #include <linux/clk.h>
  #include <linux/io.h>
  #include <linux/sched.h>
- #include <mach/msm_fb.h>
 -#include <mach/msm_iomap.h>
 -#include <mach/irqs.h>
 -#include <mach/board.h>
+ #include <linux/platform_data/video-msm_fb.h>
  #include "mddi_hw.h"
  
  #define FLAG_DISABLE_HIBERNATION 0x0001
diff --cc drivers/video/msm/mdp.c
index 7570908,d1f881e..0000000
--- a/drivers/video/msm/mdp.c
+++ b/drivers/video/msm/mdp.c
@@@ -25,7 -25,8 +25,7 @@@
  #include <linux/major.h>
  #include <linux/slab.h>
  
- #include <mach/msm_fb.h>
 -#include <mach/msm_iomap.h>
+ #include <linux/platform_data/video-msm_fb.h>
  #include <linux/platform_device.h>
  #include <linux/export.h>
  
diff --cc drivers/video/msm/mdp_hw.h
index 2a84137,a0bacf5..0000000
--- a/drivers/video/msm/mdp_hw.h
+++ b/drivers/video/msm/mdp_hw.h
@@@ -15,7 -15,8 +15,7 @@@
  #ifndef _MDP_HW_H_
  #define _MDP_HW_H_
  
- #include <mach/msm_fb.h>
 -#include <mach/msm_iomap.h>
+ #include <linux/platform_data/video-msm_fb.h>
  
  struct mdp_info {
  	struct mdp_device mdp_dev;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120924/e3c58b8f/attachment.sig>
