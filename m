From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 10 Mar 2011 11:11:20 +0000
Subject: [PATCH 1/2] at91: provide pclk and hclk for macb ethernet devices
Message-ID: <mailman.167.1299757305.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AT91 has a "macb_pclk" which is used to control the clock to the
Ethernet controller, but this is a different name to the AVR32
devices that use "pclk".  Associate the clock with the names "pclk"
and "hclk" and the macb driver doesn't need to handle the two
architectures differently.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-at91/at572d940hf_devices.c |    3 +++
 arch/arm/mach-at91/at91cap9_devices.c    |    3 +++
 arch/arm/mach-at91/at91rm9200_devices.c  |    3 +++
 arch/arm/mach-at91/at91sam9260_devices.c |    3 +++
 arch/arm/mach-at91/at91sam9263_devices.c |    3 +++
 arch/arm/mach-at91/at91sam9g45_devices.c |    3 +++
 6 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/at572d940hf_devices.c b/arch/arm/mach-at91/at572d940hf_devices.c
index 6e1b9a3..9234b4e 100644
--- a/arch/arm/mach-at91/at572d940hf_devices.c
+++ b/arch/arm/mach-at91/at572d940hf_devices.c
@@ -192,6 +192,9 @@ void __init at91_add_device_eth(struct eth_platform_data *data)
 	at91_set_A_periph(AT91_PIN_PA13, 0);	/* EMDIO */
 	at91_set_A_periph(AT91_PIN_PA14, 0);	/* EMDC */
 
+	at91_clock_associate("macb_clk", &at572d940hf_eth_device.dev, "pclk");
+	at91_clock_associate("macb_clk", &at572d940hf_eth_device.dev, "hclk");
+
 	eth_data = *data;
 	platform_device_register(&at572d940hf_eth_device);
 }
diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index e041743..5c57885 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -258,6 +258,9 @@ void __init at91_add_device_eth(struct eth_platform_data *data)
 		at91_set_B_periph(AT91_PIN_PC24, 0);	/* ETXER */
 	}
 
+	at91_clock_associate("macb_clk", &at91cap9_eth_device.dev, "pclk");
+	at91_clock_associate("macb_clk", &at91cap9_eth_device.dev, "hclk");
+
 	eth_data = *data;
 	platform_device_register(&at91cap9_eth_device);
 }
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 5f873d5..e7b8ec3 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -187,6 +187,9 @@ void __init at91_add_device_eth(struct eth_platform_data *data)
 		at91_set_B_periph(AT91_PIN_PB12, 0);	/* ETX2 */
 	}
 
+	at91_clock_associate("macb_clk", &at91rm9200_eth_device.dev, "pclk");
+	at91_clock_associate("macb_clk", &at91rm9200_eth_device.dev, "hclk");
+
 	eth_data = *data;
 	platform_device_register(&at91rm9200_eth_device);
 }
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index e172b46..9ff8592 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -188,6 +188,9 @@ void __init at91_add_device_eth(struct eth_platform_data *data)
 		at91_set_B_periph(AT91_PIN_PA22, 0);	/* ETXER */
 	}
 
+	at91_clock_associate("macb_clk", &at91sam9260_eth_device.dev, "pclk");
+	at91_clock_associate("macb_clk", &at91sam9260_eth_device.dev, "hclk");
+
 	eth_data = *data;
 	platform_device_register(&at91sam9260_eth_device);
 }
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 416613c..46560e9 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -198,6 +198,9 @@ void __init at91_add_device_eth(struct eth_platform_data *data)
 		at91_set_B_periph(AT91_PIN_PC24, 0);	/* ETXER */
 	}
 
+	at91_clock_associate("macb_clk", &at91sam9263_eth_device.dev, "pclk");
+	at91_clock_associate("macb_clk", &at91sam9263_eth_device.dev, "hclk");
+
 	eth_data = *data;
 	platform_device_register(&at91sam9263_eth_device);
 }
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 0867343..ab46ae7 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -343,6 +343,9 @@ void __init at91_add_device_eth(struct eth_platform_data *data)
 		at91_set_B_periph(AT91_PIN_PA27, 0);	/* ETXER */
 	}
 
+	at91_clock_associate("macb_clk", &at91sam9g45_eth_device.dev, "pclk");
+	at91_clock_associate("macb_clk", &at91sam9g45_eth_device.dev, "hclk");
+
 	eth_data = *data;
 	platform_device_register(&at91sam9g45_eth_device);
 }
-- 
1.7.4
