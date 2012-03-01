From: jason@lakedaemon.net (Jason Cooper)
Date: Thu,  1 Mar 2012 18:20:52 +0000
Subject: [PATCH 1/4] ARM: kirkwood: move var setting to correct location.
In-Reply-To: <cover.1330625877.git.jason@lakedaemon.net>
References: <cover.1330625877.git.jason@lakedaemon.net>
Message-ID: <dd039cd4cb126bd4c64903f6208500ae93d674b1.1330625877.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This variable should be set within the driver init function that uses
it's struct, not in the generic init function.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/mach-kirkwood/common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 357fcde..d9e4d99 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -382,6 +382,7 @@ static struct platform_device kirkwood_pcm_device = {
 void __init kirkwood_audio_init(void)
 {
 	kirkwood_clk_ctrl |= CGC_AUDIO;
+	kirkwood_i2s_data.tclk = kirkwood_tclk;
 	platform_device_register(&kirkwood_i2s_device);
 	platform_device_register(&kirkwood_pcm_device);
 }
@@ -450,7 +451,6 @@ void __init kirkwood_init(void)
 {
 	printk(KERN_INFO "Kirkwood: %s, TCLK=%d.\n",
 		kirkwood_id(), kirkwood_tclk);
-	kirkwood_i2s_data.tclk = kirkwood_tclk;
 
 	/*
 	 * Disable propagation of mbus errors to the CPU local bus,
-- 
1.7.3.4
