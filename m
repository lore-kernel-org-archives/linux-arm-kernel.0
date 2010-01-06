From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:32:15 -0800
Subject: [PATCH 33/35] davinci: da830/omapl137: Specify reserved channels/slots
In-Reply-To: <1262802737-6601-33-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-3-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-4-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-5-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-6-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-7-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-8-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-9-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-10-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-11-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-12-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-13-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-14-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-15-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-16-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-17-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-18-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-19-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-20-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-21-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-22-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-23-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-24-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-25-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-26-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-27-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-28-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-29-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-30-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-31-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-32-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-33-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-34-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudhakar Rajashekhara <sudhakar.raj@ti.com>

Pass reserved EDMA channel/slots as platform data for da830/omap-l137.

Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/devices-da8xx.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 63c330c..9a5342b 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -111,6 +111,29 @@ static const s8 da850_queue_priority_mapping[][2] = {
 	{-1, -1}
 };
 
+/*
+ * The following EDMA channels/slots are not being used by drivers (for
+ * example: Timer, GPIO, UART events etc) on da830/omap-l137, hence they
+ * are being reserved for codecs on the DSP side.
+ */
+static const s16 da830_dma_rsv_chans[][2] = {
+	/* (offset, number) */
+	{ 8,  2},
+	{12,  2},
+	{24,  4},
+	{30,  2},
+	{-1, -1}
+};
+
+static const s16 da830_dma_rsv_slots[][2] = {
+	/* (offset, number) */
+	{ 8,  2},
+	{12,  2},
+	{24,  4},
+	{30, 26},
+	{-1, -1}
+};
+
 static struct edma_soc_info da830_edma_info[] = {
 	{
 		.n_channel		= 32,
@@ -118,6 +141,8 @@ static struct edma_soc_info da830_edma_info[] = {
 		.n_slot			= 128,
 		.n_tc			= 2,
 		.n_cc			= 1,
+		.rsv_chans		= da830_dma_rsv_chans,
+		.rsv_slots		= da830_dma_rsv_slots,
 		.queue_tc_mapping	= da8xx_queue_tc_mapping,
 		.queue_priority_mapping	= da8xx_queue_priority_mapping,
 	},
-- 
1.6.6.rc2.1.g42108
