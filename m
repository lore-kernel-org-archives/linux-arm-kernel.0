From: borneo.antonio@gmail.com (Antonio Borneo)
Date: Mon, 20 Mar 2017 10:57:18 +0100
Subject: [PATCH 1/4] spi: pl022: remove nonexistent properties from DT binding
 example
Message-ID: <20170320095721.6724-1-borneo.antonio@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The properties "pl022,hierarchy" and "pl022,slave-tx-disable" were
initially proposed till patch V4 [1] but then discarded in V5 [2]
when the patch set was taken over by another developer, as
explained in patch history in [3].
The above properties never landed in mainline code but were then
listed in the binding example by a following commit dc715452e914
("spi: pl022: use generic DMA slave configuration if possible")
and later on they were copy-paste in some board's DT.

Remove the nonexistent properties from the example.
Also remove a spaces-only line at the end of the file.

[1] https://lkml.org/lkml/2012/7/9/421
[2] https://lkml.org/lkml/2012/8/21/427
[3] https://lkml.org/lkml/2012/8/21/436

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
---
To: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Brijesh Singh <brijeshkumar.singh@amd.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Jon Mason <jonmason@broadcom.com>
Cc: bcm-kernel-feedback-list at broadcom.com
Cc: linux-spi at vger.kernel.org
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 Documentation/devicetree/bindings/spi/spi_pl022.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi_pl022.txt b/Documentation/devicetree/bindings/spi/spi_pl022.txt
index 4d1673ca8cf8..2692a5726c3f 100644
--- a/Documentation/devicetree/bindings/spi/spi_pl022.txt
+++ b/Documentation/devicetree/bindings/spi/spi_pl022.txt
@@ -56,9 +56,7 @@ Example:
 			spi-max-frequency = <12000000>;
 			spi-cpol;
 			spi-cpha;
-			pl022,hierarchy = <0>;
 			pl022,interface = <0>;
-			pl022,slave-tx-disable;
 			pl022,com-mode = <0x2>;
 			pl022,rx-level-trig = <0>;
 			pl022,tx-level-trig = <0>;
@@ -67,4 +65,3 @@ Example:
 			pl022,duplex = <0>;
 		};
 	};
-	
-- 
2.12.0
