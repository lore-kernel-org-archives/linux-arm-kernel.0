From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed, 28 Dec 2016 14:56:48 -0800
Subject: [PATCH v6 02/25] of: device: Export of_device_{get_modalias,
 uvent_modalias} to modules
In-Reply-To: <20161228225711.698-1-stephen.boyd@linaro.org>
References: <20161228225711.698-1-stephen.boyd@linaro.org>
Message-ID: <20161228225711.698-3-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ULPI bus can be built as a module, and it will soon be
calling these functions when it supports probing devices from DT.
Export them so they can be used by the ULPI module.

Acked-by: Rob Herring <robh@kernel.org>
Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/of/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 8a22a253a830..b1e6bebda3f3 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -225,6 +225,7 @@ ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len)
 
 	return tsize;
 }
+EXPORT_SYMBOL_GPL(of_device_get_modalias);
 
 int of_device_request_module(struct device *dev)
 {
@@ -310,3 +311,4 @@ int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(of_device_uevent_modalias);
-- 
2.10.0.297.gf6727b0
