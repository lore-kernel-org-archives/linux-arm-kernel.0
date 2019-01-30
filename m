Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA881C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:09:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA0AC2184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OF4NLcZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0AC2184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=emdPOuO1LNlWF5FbMbYrY2tLGNHb8HatpnHkAMVv8TY=; b=OF4NLcZYw1VsjA
	ar8zRf3xErQDc+2ZiLPghW5quafOtLXyror3SGB14t8LCGvWdWfib17uWc53BMXGPsQhUvcDVIL9/
	arsQXWRS0L8aoKKMdLWKFTHIHrqM23ALDIICE0ScmkCsQmOLuyXDscYlwuydHetlfIosD9BNJnROn
	wBuG+v3h++3hothhyolVistrxxggS8MPghARJpmSubFQQhGtjo3XCqA4dZdwYqALUPiVhKHAFg/Jz
	GVBiIBtvW/fRoD9ou0YQTFheHd0P7fZDmPq/hEkn+V91LmSE2VHPURBK/vNuX+nIVl7b4CFFML9I3
	HUobRvnH0wPTGJa2PV3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomoH-0003qg-LP; Wed, 30 Jan 2019 10:09:33 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomoE-0003ps-4x; Wed, 30 Jan 2019 10:09:31 +0000
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 2203825444CC2BD98C69;
 Wed, 30 Jan 2019 18:09:25 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Wed, 30 Jan 2019
 18:09:15 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <bbrezillon@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
 <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
 <marek.vasut@gmail.com>, <mcoquelin.stm32@gmail.com>,
 <alexandre.torgue@st.com>, <christophe.kerello@st.com>
Subject: [PATCH -next] mtd: rawnand: stm32_fmc2: Make some functions static
Date: Wed, 30 Jan 2019 18:09:08 +0800
Message-ID: <20190130100908.19532-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_020930_358409_8C4CCF05 
X-CRM114-Status: UNSURE (   8.90  )
X-CRM114-Notice: Please train this message.
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
Cc: YueHaibing <yuehaibing@huawei.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Fixes the following sparse warning:
drivers/mtd/nand/raw/stm32_fmc2_nand.c:1228:6: warning: symbol 'stm32_fmc2_read_data' was not declared. Should it be static?
drivers/mtd/nand/raw/stm32_fmc2_nand.c:1275:6: warning: symbol 'stm32_fmc2_write_data' was not declared. Should it be static?
drivers/mtd/nand/raw/stm32_fmc2_nand.c:1707:32: warning: symbol 'stm32_fmc2_nand_ooblayout_ops' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index e057282..999ca6a 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -1225,8 +1225,8 @@ static irqreturn_t stm32_fmc2_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-void stm32_fmc2_read_data(struct nand_chip *chip, void *buf,
-			  unsigned int len, bool force_8bit)
+static void stm32_fmc2_read_data(struct nand_chip *chip, void *buf,
+				 unsigned int len, bool force_8bit)
 {
 	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
 	void __iomem *io_addr_r = fmc2->data_base[fmc2->cs_sel];
@@ -1272,8 +1272,8 @@ void stm32_fmc2_read_data(struct nand_chip *chip, void *buf,
 		stm32_fmc2_set_buswidth_16(fmc2, true);
 }
 
-void stm32_fmc2_write_data(struct nand_chip *chip, const void *buf,
-			   unsigned int len, bool force_8bit)
+static void stm32_fmc2_write_data(struct nand_chip *chip, const void *buf,
+				  unsigned int len, bool force_8bit)
 {
 	struct stm32_fmc2_nfc *fmc2 = to_stm32_nfc(chip->controller);
 	void __iomem *io_addr_w = fmc2->data_base[fmc2->cs_sel];
@@ -1704,7 +1704,7 @@ static int stm32_fmc2_nand_ooblayout_free(struct mtd_info *mtd, int section,
 	return 0;
 }
 
-const struct mtd_ooblayout_ops stm32_fmc2_nand_ooblayout_ops = {
+static const struct mtd_ooblayout_ops stm32_fmc2_nand_ooblayout_ops = {
 	.ecc = stm32_fmc2_nand_ooblayout_ecc,
 	.free = stm32_fmc2_nand_ooblayout_free,
 };
-- 
2.7.0



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
