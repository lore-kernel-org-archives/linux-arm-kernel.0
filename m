From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Thu, 15 Sep 2016 18:42:37 +0200
Subject: [PATCH 05/11] serial: stm32: correct flow control property spelling
In-Reply-To: <1473957763-30629-1-git-send-email-alexandre.torgue@st.com>
References: <1473957763-30629-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1473957763-30629-6-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"st,hw-flow-ctrl" property is documented in device tree
binding whereas "auto-flow-control" was used in the code.
The driver is now aligned with the binding name
"st,hw-flow-ctrl".

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 184b018..ab294b9 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -508,7 +508,7 @@ static struct stm32_port *stm32_of_get_stm32_port(struct platform_device *pdev)
 		return NULL;
 
 	stm32_ports[id].hw_flow_control = of_property_read_bool(np,
-							"auto-flow-control");
+							"st,hw-flow-ctrl");
 	stm32_ports[id].port.line = id;
 	return &stm32_ports[id];
 }
-- 
1.9.1
