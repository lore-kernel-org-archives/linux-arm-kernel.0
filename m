From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 17 Oct 2016 21:45:32 +0200
Subject: [PATCH v3 4/4] net: smsc91x: add u16 workaround for pxa platforms
In-Reply-To: <1476733532-29716-1-git-send-email-robert.jarzmik@free.fr>
References: <1476733532-29716-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1476733532-29716-5-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a workaround for mainstone, idp and stargate2 boards, for u16 writes
which must be aligned on 32 bits addresses.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Jeremy Linton <jeremy.linton@arm.com>
---
Since v1: rename dt property to pxa-u16-align4
      	  change the binding documentation file
---
 Documentation/devicetree/bindings/net/smsc-lan91c111.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/smsc-lan91c111.txt b/Documentation/devicetree/bindings/net/smsc-lan91c111.txt
index e77e167593db..309e37eb7c7c 100644
--- a/Documentation/devicetree/bindings/net/smsc-lan91c111.txt
+++ b/Documentation/devicetree/bindings/net/smsc-lan91c111.txt
@@ -13,3 +13,5 @@ Optional properties:
   16-bit access only.
 - power-gpios: GPIO to control the PWRDWN pin
 - reset-gpios: GPIO to control the RESET pin
+- pxa-u16-align4 : Boolean, put in place the workaround the force all
+		   u16 writes to be 32 bits aligned
-- 
2.1.4
