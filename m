From: lho@apm.com (Loc Ho)
Date: Thu,  8 May 2014 17:03:16 -0600
Subject: [PATCH 1/4] edac: Fix MC scrub mode comparsion bug for correctable
 error
In-Reply-To: <1399590199-12256-1-git-send-email-lho@apm.com>
References: <1399590199-12256-1-git-send-email-lho@apm.com>
Message-ID: <1399590199-12256-2-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the MC scrub mode comparsion bug by replacing
'&' with '=='. The MC structure field scrub_mode is integer
type - not bit field.

Signed-off-by: Loc Ho <lho@apm.com>
---
 drivers/edac/edac_mc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 33edd67..2c694b5 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1018,7 +1018,7 @@ static void edac_ce_error(struct mem_ctl_info *mci,
 	}
 	edac_inc_ce_error(mci, enable_per_layer_report, pos, error_count);
 
-	if (mci->scrub_mode & SCRUB_SW_SRC) {
+	if (mci->scrub_mode == SCRUB_SW_SRC) {
 		/*
 			* Some memory controllers (called MCs below) can remap
 			* memory so that it is still available at a different
-- 
1.5.5
