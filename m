From: joel@jms.id.au (Joel Stanley)
Date: Wed, 30 May 2018 15:47:40 +0930
Subject: [PATCH] ARM: dts: aspeed: Fix hwrng register address
Message-ID: <20180530061740.31547-1-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The register address should be the full address of the rng, not the
offset from the start of the SCU.

Fixes: 5daa8212c08e ("ARM: dts: aspeed: Describe random number device")
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
Hi ARM maintainers, this was found when testing next-20180529 after the
merge of the aspeed 4.18 pull request.  Can you please apply this one to
your -next tree?

I'll also send a PR with some defconfig updates so the rng driver is
enabled by default.
---

 arch/arm/boot/dts/aspeed-g4.dtsi | 4 ++--
 arch/arm/boot/dts/aspeed-g5.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 5e947ed496c2..75df1573380e 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -145,9 +145,9 @@
 
 			};
 
-			rng: hwrng at 78 {
+			rng: hwrng at 1e6e2078 {
 				compatible = "timeriomem_rng";
-				reg = <0x78 0x4>;
+				reg = <0x1e6e2078 0x4>;
 				period = <1>;
 				quality = <100>;
 			};
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 24eec00c4a95..17f2714d18a7 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -189,9 +189,9 @@
 				};
 			};
 
-			rng: hwrng at 78 {
+			rng: hwrng at 1e6e2078 {
 				compatible = "timeriomem_rng";
-				reg = <0x78 0x4>;
+				reg = <0x1e6e2078 0x4>;
 				period = <1>;
 				quality = <100>;
 			};
-- 
2.17.0
