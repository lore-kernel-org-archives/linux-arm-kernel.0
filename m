From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 17 Oct 2016 18:56:15 -0700
Subject: [PATCH v5 02/23] of: device: Export of_device_{get_modalias,
 uvent_modalias} to modules
In-Reply-To: <20161018015636.11701-1-stephen.boyd@linaro.org>
References: <20161018015636.11701-1-stephen.boyd@linaro.org>
Message-ID: <20161018015636.11701-3-stephen.boyd@linaro.org>
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
index 8a22a253a830..6719ab35b62e 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -225,6 +225,7 @@ ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len)
 
 	return tsize;
 }
+EXPORT_SYMBOL_GPL(of_device_get_modalias);
 
 int of_device_request_module(struct device *dev)
 {
@@ -290,6 +291,7 @@ void of_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 	}
 	mutex_unlock(&of_mutex);
 }
+EXPORT_SYMBOL_GPL(of_device_uevent_modalias);
 
 int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env)
 {
-- 
2.10.0.297.gf6727b0
