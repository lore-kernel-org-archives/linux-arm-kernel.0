From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  9 Mar 2017 15:52:44 +0100
Subject: [PATCH 0/2] ARM64: dts: meson-gxbb-odroidc2: Add GPIO lines names
Message-ID: <1489071166-11476-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds the GPIO lines names to describe the /real/ GPIO usage on
the Odroid-C2 board. These names are useful to have a clear and human readable
decription of the line usage.

The second patch is not specifically tied to the names but was found using
these descriptions since they did not match.

Here is an extract of the GPIO debugfs output :

# cat /sys/kernel/debug/gpio 
gpiochip0: GPIOs 0-13, parent: platform/c8100000.aobus:pinctrl at 14, aobus-banks:
 gpio-0   (UART_TX_AO_A        )
 gpio-1   (UART_RX_AO_A        )
 gpio-2   (VCCK En             )
 gpio-3   (TF 3V3/1V8 En       |?                   ) out lo    
 gpio-4   (USB HUB nRESET      )
 gpio-5   (USB OTG Power En    |USB_OTG_PWR         ) out lo    
 gpio-6   (J7 Header Pin2      )
 gpio-7   (IR In               )
 gpio-8   (J7 Header Pin4      )
 gpio-9   (J7 Header Pin6      )
 gpio-10  (J7 Header Pin5    )
 gpio-11  (J7 Header Pin7      )
 gpio-12  (HDMI CEC            )
 gpio-13  (SYS LED             |c2:blue:alive       ) out hi    
gpiochip1: GPIOs 14-132, parent: platform/c8834000.periphs:pinctrl at 4b0, periphs-banks:
 gpio-14  (Eth MDIO            )
 gpio-15  (Eth MDC             )
 gpio-16  (Eth RGMII RX Clk    )
 gpio-17  (Eth RX DV           )
 gpio-18  (Eth RX D0           )
 gpio-19  (Eth RX D1           )
 gpio-20  (Eth RX D2           )
 gpio-21  (Eth RX D3           )
 gpio-22  (Eth RGMII TX Clk    )
[...]
 gpio-115 (J2 Header Pin15     )
 gpio-116 (J2 Header Pin12     )
 gpio-117 (J2 Header Pin13     )
 gpio-118 (J2 Header Pin8      )
 gpio-119 (J2 Header Pin10     )
 gpio-120 (                    )
 gpio-121 (                    )
 gpio-122 (                    )
 gpio-123 (                    )
 gpio-124 (                    )
 gpio-125 (J2 Header Pin11     )
 gpio-126 (                    )
 gpio-127 (J2 Header Pin7      )
 gpio-128 (                    )
 gpio-129 (                    )
 gpio-130 (                    )
 gpio-131 (                  )
 gpio-132 (                    )

And the 'lsgpio' tool using the new char interface for GPIO handling :
# lsgpio 
GPIO chip: gpiochip1, "periphs-banks", 119 GPIO lines
	line  0: "Eth MDIO" unused
	line  1: "Eth MDC" unused
	line  2: "Eth RGMII RX Clk" unused
	line  3: "Eth RX DV" unused
	line  4: "Eth RX D0" unused
	line  5: "Eth RX D1" unused
	line  6: "Eth RX D2" unused
	line  7: "Eth RX D3" unused
	line  8: "Eth RGMII TX Clk" unused
	line  9: "Eth TX En" unused
	line 10: "Eth TX D0" unused
	line 11: "Eth TX D1" unused
	line 12: "Eth TX D2" unused
	line 13: "Eth TX D3" unused
	line 14: "Eth PHY nRESET" unused
	line 15: "Eth PHY Intc" unused
	line 16: "HDMI HPD" unused
	line 17: "HDMI DDC SDA" unused
	line 18: "HDMI DDC SCL" unused
	line 19: unnamed unused
	line 20: "eMMC D0" unused
	line 21: "eMMC D1" unused
	line 22: "eMMC D2" unused
	line 23: "eMMC D3" unused
	line 24: "eMMC D4" unused
[...]
	line 115: unnamed unused
	line 116: unnamed unused
	line 117: unnamed unused
	line 118: unnamed unused
GPIO chip: gpiochip0, "aobus-banks", 14 GPIO lines
	line  0: "UART_TX_AO_A" unused
	line  1: "UART_RX_AO_A" unused
	line  2: "VCCK En" unused
	line  3: "TF 3V3/1V8 En" "?" [kernel output]
	line  4: "USB HUB nRESET" unused
	line  5: "USB OTG Power En" "USB_OTG_PWR" [kernel output]
	line  6: "J7 Header Pin2" unused
	line  7: "IR In" unused
	line  8: "J7 Header Pin4" unused
	line  9: "J7 Header Pin6" unused
	line 10: "J7 Header Pin5" unused
	line 11: "J7 Header Pin7" unused
	line 12: "HDMI CEC" unused
	line 13: "SYS LED" "c2:blue:alive" [kernel output active-low]

Neil Armstrong (2):
  ARM64: dts: meson-gxbb-odroidc2: Add GPIO lines names
  ARM64: dts: meson-gxbb-odroidc2: Fix TFLASH VDD regulator GPIO line

 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 53 +++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

-- 
1.9.1
