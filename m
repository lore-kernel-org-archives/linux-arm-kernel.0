From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 17 Aug 2016 13:31:53 +0200
Subject: [PATCH/RTF 4/7] mmc: sh_mobile_sdhi: Add r8a7796 support
In-Reply-To: <1471433516-4478-1-git-send-email-horms+renesas@verge.net.au>
References: <1471433516-4478-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1471433516-4478-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ai Kyuse <ai.kyuse.uw@renesas.com>

Add support for r8a7796 SoC.

Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 1 +
 drivers/mmc/host/sh_mobile_sdhi.c                  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
index 0f610d4b5b00..13df9c2399c3 100644
--- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -23,6 +23,7 @@ Required properties:
 		"renesas,sdhi-r8a7793" - SDHI IP on R8A7793 SoC
 		"renesas,sdhi-r8a7794" - SDHI IP on R8A7794 SoC
 		"renesas,sdhi-r8a7795" - SDHI IP on R8A7795 SoC
+		"renesas,sdhi-r8a7796" - SDHI IP on R8A7796 SoC
 
 Optional properties:
 - toshiba,mmc-wrprotect-disable: write-protect detection is unavailable
diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index dd176c0ce6ec..25e8e2fdaa2c 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -129,6 +129,7 @@ static const struct of_device_id sh_mobile_sdhi_of_match[] = {
 	{ .compatible = "renesas,sdhi-r8a7793", .data = &of_rcar_gen2_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7794", .data = &of_rcar_gen2_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7795", .data = &of_rcar_gen3_compatible, },
+	{ .compatible = "renesas,sdhi-r8a7796", .data = &of_rcar_gen3_compatible, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sh_mobile_sdhi_of_match);
-- 
2.7.0.rc3.207.g0ac5344
