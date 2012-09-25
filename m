From: stigge@antcom.de (Roland Stigge)
Date: Tue, 25 Sep 2012 09:56:14 +0200
Subject: [PATCH 2/2] gpio: Document device_node's det_debounce
In-Reply-To: <1348559774-15484-1-git-send-email-stigge@antcom.de>
References: <1348559774-15484-1-git-send-email-stigge@antcom.de>
Message-ID: <1348559774-15484-2-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation for set_debounce in struct device_node.

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
 include/asm-generic/gpio.h |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.orig/include/asm-generic/gpio.h
+++ linux-2.6/include/asm-generic/gpio.h
@@ -60,6 +60,8 @@ struct device_node;
  * @get: returns value for signal "offset"; for output signals this
  *	returns either the value actually sensed, or zero
  * @direction_output: configures signal "offset" as output, or returns error
+ * @set_debounce: optional hook for setting debounce time for specified gpio in
+ *      interrupt triggered gpio chips
  * @set: assigns output value for signal "offset"
  * @to_irq: optional hook supporting non-static gpio_to_irq() mappings;
  *	implementation may not sleep
