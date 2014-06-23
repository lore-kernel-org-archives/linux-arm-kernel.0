From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:28:22 +0900
Subject: [PATCH 13/29] ARM: shmobile: Lager memory map update
In-Reply-To: <cover.1403487225.git.horms+renesas@verge.net.au>
References: <cover.1403487225.git.horms+renesas@verge.net.au>
Message-ID: <7b16c61a86ce41edd5c42a87f22a0a146968b62f.1403487225.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Update the Lager DTS to make use of the new unified legacy
memory map where the legacy window on Lager and Koelsch
have the same size.

With this change in place the code gets aligned with the
documentation.

After update the Lager board has the following map:
Bank0: 1GiB RAM (Legacy 32-bit: 0x40000000->0x7fffffff)
Bank1: 3GiB RAM (LPAE area: 0x140000000->0x1ffffffff)

Before the update the old map looked like this:
Bank0: 2GiB RAM (Legacy 32-bit: 0x40000000->0xbfffffff)
Bank1: 2GiB RAM (LPAE area: 0x180000000->0x1ffffffff)

Tested with and without LPAE on r8a7790 Lager.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index b68ff56..b04d257 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -29,12 +29,12 @@
 
 	memory at 40000000 {
 		device_type = "memory";
-		reg = <0 0x40000000 0 0x80000000>;
+		reg = <0 0x40000000 0 0x40000000>;
 	};
 
 	memory at 180000000 {
 		device_type = "memory";
-		reg = <1 0x80000000 0 0x80000000>;
+		reg = <1 0x40000000 0 0xc0000000>;
 	};
 
 	lbsc {
-- 
2.0.0.rc2
