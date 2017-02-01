From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  1 Feb 2017 14:31:40 +0000
Subject: [PATCH v2 05/10] serial: st-asc: Use generic DT binding for
 announcing RTS/CTS lines
In-Reply-To: <20170201143145.31962-1-lee.jones@linaro.org>
References: <20170201143145.31962-1-lee.jones@linaro.org>
Message-ID: <20170201143145.31962-6-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The initial binding 'st,hw-flow-control' isn't used anywhere, in neither
in upstream nor downstream kernels.  It isn't even documented in
dt-bindings, so we can safely assume it's safe to swap to the generic
one.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/st-asc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index e521078..bcf1d33 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -794,7 +794,7 @@ static struct asc_port *asc_of_get_asc_port(struct platform_device *pdev)
 		return NULL;
 
 	asc_ports[id].hw_flow_control = of_property_read_bool(np,
-							"st,hw-flow-control");
+							"uart-has-rtscts");
 	asc_ports[id].force_m1 =  of_property_read_bool(np, "st,force_m1");
 	asc_ports[id].port.line = id;
 	asc_ports[id].rts = NULL;
-- 
2.9.3
