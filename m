From: nsaenzjulienne@suse.de (Nicolas Saenz Julienne)
Date: Fri, 26 Oct 2018 15:48:10 +0200
Subject: [PATCH RFC 15/18] stagning: vchiq_core: fix logic redundancy in
 parse_open
In-Reply-To: <20181026134813.7775-1-nsaenzjulienne@suse.de>
References: <20181026134813.7775-1-nsaenzjulienne@suse.de>
Message-ID: <20181026134813.7775-16-nsaenzjulienne@suse.de>
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
index 0c37b7032857..a5664a44258e 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1462,9 +1462,7 @@ parse_open(VCHIQ_STATE_T *state, VCHIQ_HEADER_T *header)
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
