From: skannan@codeaurora.org (Saravana Kannan)
Date: Thu,  9 May 2013 11:35:02 -0700
Subject: [PATCH 2/2] regulator: core: Disable unused regulators after deferred
 probing is done
In-Reply-To: <1368124502-18830-1-git-send-email-skannan@codeaurora.org>
References: <1368124502-18830-1-git-send-email-skannan@codeaurora.org>
Message-ID: <1368124502-18830-2-git-send-email-skannan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With deferred probing, late_initcall() is too soon to declare a regulator
as unused. Wait for deferred probing to finish before declaring a regulator
as unused. Since deferred probing is done in late_initcall(), do the unused
check to late_initcall_sync.

Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
---
 drivers/regulator/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e3661c2..0e85c2c 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3864,4 +3864,4 @@ unlock:
 
 	return 0;
 }
-late_initcall(regulator_init_complete);
+late_initcall_sync(regulator_init_complete);
-- 
1.7.8.3

The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
