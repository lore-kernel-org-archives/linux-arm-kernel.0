From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 24 Oct 2011 05:50:00 -0400
Subject: [PATCH 11/12] ARM: mach-w90x900: properly disable CPU idle call
In-Reply-To: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
References: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
Message-ID: <1319449801-12367-12-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-w90x900/dev.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-w90x900/dev.c b/arch/arm/mach-w90x900/dev.c
index 7a1fa6adb7..34301545e3 100644
--- a/arch/arm/mach-w90x900/dev.c
+++ b/arch/arm/mach-w90x900/dev.c
@@ -534,5 +534,6 @@ void __init nuc900_board_init(struct platform_device **device, int size)
 	platform_add_devices(nuc900_public_dev, ARRAY_SIZE(nuc900_public_dev));
 	spi_register_board_info(nuc900_spi_board_info,
 					ARRAY_SIZE(nuc900_spi_board_info));
+	disable_hlt();
 }
 
-- 
1.7.7.1.431.g10b2a
