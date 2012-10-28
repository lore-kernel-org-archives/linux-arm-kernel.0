From: jm@lentin.co.uk (Jamie Lentin)
Date: Sun, 28 Oct 2012 20:47:42 +0000
Subject: [PATCH] ARM: kirkwood: Increase NAND chip-delay for DNS-320
Message-ID: <1351457262-11506-1-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The default chip-delay of 25ns is a bit too tight for some DNS-320's,
increase to 35ns.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
I now own 2 DNS-320's, the first of which is happy with a mainline
kernel, the second fills the console with "Bad eraseblock xxx at
0x00000xxxxxxx" for every eraseblock and refuses to access the NAND.
Beyond this they appear identical, and report the same NAND chip
(I haven't physically checked that it's the same, however).

The patch below fixes it, however:-
* Is there something else I should be trying, rather than potentially
masking the problem?
* Is chip-delay too low for kirkwood generally?

Cheers,

 arch/arm/boot/dts/kirkwood-dns320.dts |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-dns320.dts b/arch/arm/boot/dts/kirkwood-dns320.dts
index 5bb0bf3..abe17a4 100644
--- a/arch/arm/boot/dts/kirkwood-dns320.dts
+++ b/arch/arm/boot/dts/kirkwood-dns320.dts
@@ -50,5 +50,9 @@
 			clock-frequency = <166666667>;
 			status = "okay";
 		};
+
+		nand at 3000000 {
+			chip-delay = <35>;
+		};
 	};
 };
-- 
1.7.10.4
