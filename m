Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90F7C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:41:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9741D2146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uR2R8fhb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9741D2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vdlVdIyPFYJ7ORj4Qu/kjQwVfquqg5HG1DUzow8Vs9I=; b=uR2R8fhbs1mNwk
	unyh74StmkYNquFN3FU8HOsSqH6uEHFpY9dtVQZNWWyvlYawNELA55RcjFBii1GxRXO1Al/0nHSGi
	JsPH4Ud7cWwL14fFLPc7dK9BvbbKSlRXZOgVnwtyGwfNqqpsR3u7tXMKT5w/MgU18j9P9fLFDdFBA
	pRp6oKXGX8scL/QCyVholAdwzk3xO01qSQujyH8eX18V42ayYF/KCSoIEyURbCQqusWuRIlXoRV5v
	BdysJVygRwPmi39GEqT5/D3iT5DqLEfTmOd/rlMyrH09ppYP4WYoIcyesx2/oMAvkB5ea4Wu9QI1n
	wUtOw876onT50ftxU5GQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs7LA-00055i-4S; Fri, 08 Feb 2019 14:41:16 +0000
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs7L6-00054l-Q4
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 14:41:14 +0000
X-Originating-IP: 109.213.164.40
Received: from localhost (alyon-652-1-53-40.w109-213.abo.wanadoo.fr
 [109.213.164.40])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 7A210E0005;
 Fri,  8 Feb 2019 14:41:01 +0000 (UTC)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH] clk: at91: fix masterck name
Date: Fri,  8 Feb 2019 15:40:59 +0100
Message-Id: <20190208144059.29861-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_064112_992445_EDBC5F20 
X-CRM114-Status: GOOD (  10.74  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The master clock is actually named masterck earlier in the driver. Having
"mck" in the parent list means that it can never be selected.

Fixes: 1eabdc2f9dd8 ("clk: at91: add at91sam9x5 PMCs driver")
Fixes: a2038077de9a ("clk: at91: add sama5d2 PMC driver")
Fixes: 084b696bb509 ("clk: at91: add sama5d4 pmc driver")

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/at91sam9x5.c | 2 +-
 drivers/clk/at91/sama5d2.c    | 4 ++--
 drivers/clk/at91/sama5d4.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 2fe225a697df..d55a151cb7f5 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -210,7 +210,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 	parent_names[1] = "mainck";
 	parent_names[2] = "plladivck";
 	parent_names[3] = "utmick";
-	parent_names[4] = "mck";
+	parent_names[4] = "masterck";
 	for (i = 0; i < 2; i++) {
 		char name[6];
 
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index d69ad96fe988..cd0ef7274fdb 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -240,7 +240,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 	parent_names[1] = "mainck";
 	parent_names[2] = "plladivck";
 	parent_names[3] = "utmick";
-	parent_names[4] = "mck";
+	parent_names[4] = "masterck";
 	for (i = 0; i < 3; i++) {
 		char name[6];
 
@@ -291,7 +291,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 	parent_names[1] = "mainck";
 	parent_names[2] = "plladivck";
 	parent_names[3] = "utmick";
-	parent_names[4] = "mck";
+	parent_names[4] = "masterck";
 	parent_names[5] = "audiopll_pmcck";
 	for (i = 0; i < ARRAY_SIZE(sama5d2_gck); i++) {
 		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock,
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index e358be7f6c8d..b645a9d59cdb 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -207,7 +207,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 	parent_names[1] = "mainck";
 	parent_names[2] = "plladivck";
 	parent_names[3] = "utmick";
-	parent_names[4] = "mck";
+	parent_names[4] = "masterck";
 	for (i = 0; i < 3; i++) {
 		char name[6];
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
