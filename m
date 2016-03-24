From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 24 Mar 2016 11:23:49 +0000
Subject: [PATCH 0/3] [media] c8sectpfe: Various driver fixups
Message-ID: <1458818632-25552-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro,

This series includes a few fixes for the c8sectpfe Linux dvb demux driver.

The first fixes a bug introduced in the review process to the circular 
buffer WP management. The second re-works the firmware loading code to not
rely on the CONFIG_FW_LOADER_USER_HELPER_FALLBACK which was removed in
a previous patch. The third patch simly demotes a print statement to
dev_dbg.

regards,

Peter.

Peter Griffin (3):
  [media] c8sectpfe: Fix broken circular buffer wp management
  [media] c8sectpfe: Demote print to dev_dbg
  [media] c8sectpfe: Rework firmware loading mechanism

 .../media/platform/sti/c8sectpfe/c8sectpfe-core.c  | 69 ++++++++--------------
 1 file changed, 24 insertions(+), 45 deletions(-)

-- 
1.9.1
