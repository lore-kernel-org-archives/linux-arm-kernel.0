From: colin.king@canonical.com (Colin King)
Date: Wed,  1 Aug 2018 11:47:34 +0100
Subject: [PATCH 1/9] ALSA: asihpi: remove redundant variable max_streams
In-Reply-To: <20180801104742.4328-1-colin.king@canonical.com>
References: <20180801104742.4328-1-colin.king@canonical.com>
Message-ID: <20180801104742.4328-2-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Variable max_streams is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'max_streams' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/asihpi/hpi6205.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/pci/asihpi/hpi6205.c b/sound/pci/asihpi/hpi6205.c
index 8d5abfa4e24b..2864698436a5 100644
--- a/sound/pci/asihpi/hpi6205.c
+++ b/sound/pci/asihpi/hpi6205.c
@@ -635,7 +635,6 @@ static u16 create_adapter_obj(struct hpi_adapter_obj *pao,
 	{
 		struct hpi_message hm;
 		struct hpi_response hr;
-		u32 max_streams;
 
 		HPI_DEBUG_LOG(VERBOSE, "init ADAPTER_GET_INFO\n");
 		memset(&hm, 0, sizeof(hm));
@@ -660,10 +659,6 @@ static u16 create_adapter_obj(struct hpi_adapter_obj *pao,
 		pao->type = hr.u.ax.info.adapter_type;
 		pao->index = hr.u.ax.info.adapter_index;
 
-		max_streams =
-			hr.u.ax.info.num_outstreams +
-			hr.u.ax.info.num_instreams;
-
 		HPI_DEBUG_LOG(VERBOSE,
 			"got adapter info type %x index %d serial %d\n",
 			hr.u.ax.info.adapter_type, hr.u.ax.info.adapter_index,
-- 
2.17.1
