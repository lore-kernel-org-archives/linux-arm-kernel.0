From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Mon, 15 May 2017 15:48:56 +0800
Subject: [PATCH V2 3/6] dt-bindings: serial: fsl-lpuart: add i.MX7ULP support
In-Reply-To: <1494834539-17523-1-git-send-email-aisheng.dong@nxp.com>
References: <1494834539-17523-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1494834539-17523-4-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The lpuart of imx7ulp is basically the same as ls1021a. It's also
32 bit width register, but unlike ls1021a, it's little endian.
Besides that, imx7ulp lpuart has a minor different register layout
from ls1021a.

Cc: devicetree at vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Mingkai Hu <Mingkai.Hu@nxp.com>
Cc: Yangbo Lu <yangbo.lu@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 Documentation/devicetree/bindings/serial/fsl-lpuart.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
index c95005e..a1252a0 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
@@ -6,6 +6,8 @@ Required properties:
     on Vybrid vf610 SoC with 8-bit register organization
   - "fsl,ls1021a-lpuart" for lpuart compatible with the one integrated
     on LS1021A SoC with 32-bit big-endian register organization
+  - "fsl,imx7ulp-lpuart" for lpuart compatible with the one integrated
+    on i.MX7ULP SoC with 32-bit little-endian register organization
 - reg : Address and length of the register set for the device
 - interrupts : Should contain uart interrupt
 - clocks : phandle + clock specifier pairs, one for each entry in clock-names
-- 
2.7.4
