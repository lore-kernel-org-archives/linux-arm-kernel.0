From: nsaenzjulienne@suse.de (Nicolas Saenz Julienne)
Date: Tue, 20 Nov 2018 15:53:48 +0100
Subject: [PATCH 13/16] staging: vchiq_core: fix logic redundancy in parse_open
In-Reply-To: <20181120145351.30390-1-nsaenzjulienne@suse.de>
References: <20181120145351.30390-1-nsaenzjulienne@suse.de>
Message-ID: <20181120145351.30390-14-nsaenzjulienne@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We update sync to reflect that the firmware version is compatible with
that option. We don't need to check both of them again further down the
code.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.c    | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index a45cdd08e209..5ee667d46eb5 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1461,9 +1461,7 @@ parse_open(VCHIQ_STATE_T *state, VCHIQ_HEADER_T *header)
 					service->sync = 0;
 
 				/* Acknowledge the OPEN */
-				if (service->sync &&
-				    (state->version_common >=
-				     VCHIQ_VERSION_SYNCHRONOUS_MODE)) {
+				if (service->sync) {
 					if (queue_message_sync(
 						state,
 						NULL,
-- 
2.19.1
