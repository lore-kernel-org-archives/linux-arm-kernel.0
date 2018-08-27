From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Mon, 27 Aug 2018 09:11:06 -0600
Subject: [PATCH 3/9] drm/msm/a6xx: Rename gmu phandle to qcom,gmu
In-Reply-To: <20180827151112.25211-1-jcrouse@codeaurora.org>
References: <20180827151112.25211-1-jcrouse@codeaurora.org>
Message-ID: <20180827151112.25211-4-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From the review for the DT bindings for the GPU/GMU it
was suggested that the phandle for the GMU be
'qcom,gmu' instead of just 'gmu' but that never actually
got changed in the code.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index c629f742a1d1..9a14cb3d5027 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -799,7 +799,7 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	}
 
 	/* Check if there is a GMU phandle and set it up */
-	node = of_parse_phandle(pdev->dev.of_node, "gmu", 0);
+	node = of_parse_phandle(pdev->dev.of_node, "qcom,gmu", 0);
 
 	/* FIXME: How do we gracefully handle this? */
 	BUG_ON(!node);
-- 
2.18.0
