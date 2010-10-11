From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 11 Oct 2010 02:20:32 +0200
Subject: [PATCH 14/14 RESEND] Remove __devinitdata from tc6393xb_mmc_resources
In-Reply-To: <1286756432-5873-1-git-send-email-marek.vasut@gmail.com>
References: <1286756432-5873-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1286756432-5873-14-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This static struct resource tc6393xb_mmc_resources[] is used in resume function,
therefore the data can not be wiped.

Also, this causes a section mismatch.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/mfd/tc6393xb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/tc6393xb.c b/drivers/mfd/tc6393xb.c
index ef6c42c..1ea80d8 100644
--- a/drivers/mfd/tc6393xb.c
+++ b/drivers/mfd/tc6393xb.c
@@ -155,7 +155,7 @@ static struct resource __devinitdata tc6393xb_nand_resources[] = {
 	},
 };
 
-static struct resource __devinitdata tc6393xb_mmc_resources[] = {
+static struct resource tc6393xb_mmc_resources[] = {
 	{
 		.start	= 0x800,
 		.end	= 0x9ff,
-- 
1.7.1
