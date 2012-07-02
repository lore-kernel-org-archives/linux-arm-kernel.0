From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 02 Jul 2012 10:57:21 +0100
Subject: [PATCH 03/15] mfd: Make MFD core code Device Tree and IRQ domain
 aware
In-Reply-To: <20120629184927.GX22806@sortiz-mobl>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
 <1340197011-5435-4-git-send-email-lee.jones@linaro.org>
 <20120629145503.GF22806@sortiz-mobl> <4FEDC141.8090000@linaro.org>
 <20120629184927.GX22806@sortiz-mobl>
Message-ID: <4FF17081.9000005@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sam,

Something like this what you were after?

From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 2 Jul 2012 10:50:19 +0100
Subject: [PATCH] MFD: Attaching a node to new 'struct mfd_cell' of_compatible
 variable

Applying a succinct description to the of_compatible variable recently
added to the mfd_cell struct. Also link to the documentation page where
more information can be found about compatible properties.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/mfd/core.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index 99b7eb1..3a8435a 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -36,6 +36,10 @@ struct mfd_cell {
 	/* platform data passed to the sub devices drivers */
 	void			*platform_data;
 	size_t			pdata_size;
+	/*
+	 * Device Tree compatible string
+	 * See: Documentation/devicetree/usage-model.txt Chapter 2.2 for details
+	 */
 	const char		*of_compatible;
 
 	/*
-- 
1.7.9.5
