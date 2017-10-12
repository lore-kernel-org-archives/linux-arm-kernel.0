From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Thu, 12 Oct 2017 11:16:48 -0500
Subject: [PATCH 08/20] staging: vc04_services: vchiq_core: mark expected
 switch fall-through
In-Reply-To: <cover.1507781178.git.garsilva@embeddedor.com>
References: <cover.1507781178.git.garsilva@embeddedor.com>
Message-ID: <f7666b46f3a50ba58eac5454680bbba4d84fe6c2.1507781178.git.garsilva@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index c3bb8e0..ecff92b 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -2951,8 +2951,7 @@ vchiq_close_service_internal(VCHIQ_SERVICE_T *service, int close_recvd)
 
 	case VCHIQ_SRVSTATE_OPENSYNC:
 		mutex_lock(&state->sync_mutex);
-		/* Drop through */
-
+		/* fall through */
 	case VCHIQ_SRVSTATE_OPEN:
 		if (state->is_master || close_recvd) {
 			if (!do_abort_bulks(service))
-- 
2.7.4
