From: linux@roeck-us.net (Guenter Roeck)
Date: Mon,  6 Oct 2014 22:28:09 -0700
Subject: [PATCH 07/44] qnap-poweroff: Drop reference to pm_power_off from
 devicetree bindings
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
Message-ID: <1412659726-29957-8-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace reference to pm_power_off (which is an implementation detail)
and replace it with a more generic description of the driver's functionality.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt b/Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt
index af25e77..1e2260a 100644
--- a/Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt
+++ b/Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt
@@ -3,8 +3,8 @@
 QNAP NAS devices have a microcontroller controlling the main power
 supply. This microcontroller is connected to UART1 of the Kirkwood and
 Orion5x SoCs. Sending the character 'A', at 19200 baud, tells the
-microcontroller to turn the power off. This driver adds a handler to
-pm_power_off which is called to turn the power off.
+microcontroller to turn the power off. This driver installs a handler
+to power off the system.
 
 Synology NAS devices use a similar scheme, but a different baud rate,
 9600, and a different character, '1'.
-- 
1.9.1
