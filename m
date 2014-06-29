From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 29 Jun 2014 16:10:58 +0200
Subject: [PATCH v3 0/4] pinctrl: sunxi: Properly handle level triggered gpio
 irqs
Message-ID: <1404051062-24079-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here is v3 of my sunxi-pinctrl gpio irq patches, mainly aimed at get level
triggered irqs to work properly for use with oob sdio irqs.

Changes since v1:
-Post these patches as a separate series, rather then as part of a larger
 patchset touching multiple subsystems
-"pinctrl: sunxi: Add IRQCHIP_SKIP_SET_WAKE flag for pinctrl irq chip"
 Dropped the setting of the irq_chip name
-"pinctrl: sunxi: Move setting of mux to irq type from unmask to request_resourc
 -Use irq_request_resources callback
 -Added a check for func == NULL
-"pinctrl: sunxi: Define enable / disable irq callbacks for level triggered irqs
 -Use sunxi_pinctrl_irq_ack() and sunxi_pinctrl_irq_unmask()

Changes since v2:
-"pinctrl: sunxi: Move setting of mux to irq type from unmask to request_resourc
 Added Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
-"pinctrl: sunxi: Properly handle level triggered gpio interrupts"
 Use tentative declaration of the irq_chip structs to avoid the need for moving
 their real declaration around

Regards,

Hans 
