Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA060C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:43:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AEF8217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GCrGSrfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AEF8217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lky2qj4PiUnVZepFXi820V+drc9B6sCszE0yXvtLaxA=; b=GCrGSrfclxkJsl
	UsFq/K15gviGW6eBYsvqgSiFssOOP0o3LVHxx0GO5TaCpBd+/BKWBWnpvnBmbKN44Bv4A7rK0+k70
	mbyhUctu2sDzOmIIPh3A4kT5su6jEZbu4XHd7/2DoR4W3TsXXJKMUTtMdWanbHFTqMyBcSGa2UOqu
	muSTtCSUL3N1g3XTNuSo5tbl+2BaDqhFogDONUVNznBMnm1syzHFU+YbJOvHQEHs7dtXBy+objjSC
	dBLM7nepCNWznw+cxfrpomoWzYM1Ns0ptocgMfdEH+mG+gI40AZyrGwhFut4t76zYq/4IljdeF8ji
	ei50iGLvCOH5m47N8Gxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr2sK-0003gV-Iv; Tue, 05 Feb 2019 15:43:04 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr2rl-000383-0q
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 15:42:31 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 669BB5FB5E; Tue,  5 Feb 2019 23:42:26 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v2 1/3] mmc: sunxi: Disable HS-DDR mode for H5 eMMC controller
 by default
Date: Tue,  5 Feb 2019 23:42:23 +0800
Message-Id: <20190205154225.14264-2-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205154225.14264-1-wens@csie.org>
References: <20190205154225.14264-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_074229_263324_24FF5F26 
X-CRM114-Status: GOOD (  12.06  )
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
Cc: devicetree@vger.kernel.org, Chris Blake <chrisrblake93@gmail.com>,
 linux-mmc@vger.kernel.org, linux-sunxi@googlegroups.com,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Some H5 boards seem to not have proper trace lengths for eMMC to be able
to use the default setting for the delay chains under HS-DDR mode. These
include the Bananapi M2+ H5 and NanoPi NEO Core2. However the Libre
Computer ALL-H3-CC-H5 works just fine.

For the H5 (at least for now), default to not enabling HS-DDR modes in
the driver, and expect the device tree to signal HS-DDR capability on
boards that work.

Reported-by: Chris Blake <chrisrblake93@gmail.com>
Fixes: 07bafc1e3536 ("mmc: sunxi: Use new timing mode for A64 eMMC controller")
Cc: <stable@vger.kernel.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mmc/host/sunxi-mmc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 279e326e397e..7415af8c8ff6 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1399,7 +1399,16 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	mmc->caps	       |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 				  MMC_CAP_ERASE | MMC_CAP_SDIO_IRQ;
 
-	if (host->cfg->clk_delays || host->use_new_timings)
+	/*
+	 * Some H5 devices do not have signal traces precise enough to
+	 * use HS DDR mode for their eMMC chips.
+	 *
+	 * We still enable HS DDR modes for all the other controller
+	 * variants that support them.
+	 */
+	if ((host->cfg->clk_delays || host->use_new_timings) &&
+	    !of_device_is_compatible(pdev->dev.of_node,
+				     "allwinner,sun50i-h5-emmc"))
 		mmc->caps      |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
 
 	ret = mmc_of_parse(mmc);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
