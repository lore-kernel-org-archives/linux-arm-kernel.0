From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 17 Apr 2012 16:45:23 +0100
Subject: [PATCH 10/16 v2] drivers/gpio: represent gpio-nomadik as an IRQ
 controller in DT documentation
In-Reply-To: <201204171438.33051.arnd@arndb.de>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
 <1334659448-11521-11-git-send-email-lee.jones@linaro.org>
 <201204171438.33051.arnd@arndb.de>
Message-ID: <4F8D9013.3070901@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>
Date: Fri, 13 Apr 2012 16:05:26 +0100
Subject: [PATCH 10/16] drivers/gpio: represent gpio-nomadik as an IRQ
  controller in DT documentation

Now gpio-nomadik has proper bindings devices initialised by Device Tree
entries are able to use the chained GPIO IRQ lines it provides. This
patch aims to reflect that in the gpio-nmk documentation.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
  .../devicetree/bindings/gpio/gpio-nmk.txt          |    2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-nmk.txt 
b/Documentation/devicetree/bindings/gpio/gpio-nmk.txt
index 3856789..ee87467 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-nmk.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-nmk.txt
@@ -13,6 +13,7 @@ Required properties:
                                    4 = active high level-sensitive.
                                    8 = active low level-sensitive.
  - gpio-controller       : Marks the device node as a GPIO controller.
+- interrupt-controller  : Marks the device node as an interrupt controller.
  - gpio-bank             : Specifies which bank a controller owns.
  - st,supports-sleepmode : Specifies whether controller can sleep or not

@@ -24,6 +25,7 @@ Example:
                          interrupts = <0 120 0x4>;
                          #gpio-cells = <2>;
                          gpio-controller;
+                        interrupt-controller;
                          supports-sleepmode;
                          gpio-bank = <1>;
                  };
-- 
1.7.9.1

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
