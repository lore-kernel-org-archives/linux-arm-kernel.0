From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 25 Sep 2012 16:40:20 +1000
Subject: linux-next: manual merge of the arm-soc tree with the fbdev tree
Message-ID: <20120925164020.8c83339ae70d5eed5fc4b05c@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/video/msm/mdp_hw.h between commit 8abf0b31e161 ("video: msm:
Remove useless mach/* includes") from the fbdev tree and commit
1ef21f6343ff ("ARM: msm: move platform_data definitions") from the
arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120925/aaa21255/attachment.sig>
