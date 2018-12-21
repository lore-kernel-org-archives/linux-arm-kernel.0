Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_ADSP_DISCARD,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49285C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:57:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16F7421906
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tckN7akC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=megous.com header.i=@megous.com header.b="fDLaDDeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F7421906
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=megous.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=lKRLq89BTEGSN8+KuziXKwlYo5tBHr/3hgPvP9JgmLg=; b=tckN7akCyBOrA8
	IlVAgBeaya7a80WFg0PZkxT5bB7PvohBmom3X3ZU6GQFY3YiLArFdUYZUAGfT9xy+4S/oNRsa2J4d
	jwb+J1kHdw2UHh5Fvu06A4/oSHMFalmSzHIE9JiVQ0ZLqHcd2dn2YiXrGI3LfSWQE6Xh52gfyRcMz
	s/MsCfpG5CuO7wp9w6XyEgumMOHdiuh2pKhyjC7MfiwSW8YyNvhQ5nhL2RvUMPw8sPQupUEaSVely
	HeG4vla3ZVDStSPOPnff/dTRW1xcG9rAGe519+TzWwOD4Qpb/XQf/wnLthM+d3nHtEwTc2EN3VcGz
	KocrJ9d6tfeCfzMLho4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaO6r-0003Iw-5F; Fri, 21 Dec 2018 16:57:13 +0000
Received: from vps.xff.cz ([195.181.215.36])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaO6o-0003I4-4f
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 16:57:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
 t=1545411416; bh=gyy90YjTZtqrSOOiV5GFYEb87e0T/+Q/+2syiV6jq0E=;
 h=From:To:Cc:Subject:Date:From;
 b=fDLaDDeMEHt172NdlEwyk80ZqrsmA+nw4cNTvY4efjX7HpXLzOmEHLTWDJtwublUx
 lDc7D/DPLVpRQRMl34FxGgE3d78m7mEVK6Md9GkS0+KVFNyVWhJfX2FqzAgshXCY9e
 eE0DWl1I2moumvrw3aGXkZBb9BdU2nyUloVuxZZs=
From: megous@megous.com
To: dev@linux-sunxi.org
Subject: [PATCH] media: sunxi: cedrus: Fix missing error message context
Date: Fri, 21 Dec 2018 17:56:41 +0100
Message-Id: <20181221165641.16207-1-megous@megous.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_085710_493241_FA918691 
X-CRM114-Status: UNSURE (   7.68  )
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
Cc: Ondrej Jirman <megous@megous.com>,
 "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 open list <linux-kernel@vger.kernel.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 "moderated list:ARM/Allwinner sunXi SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:ALLWINNER VPU DRIVER" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Ondrej Jirman <megous@megous.com>

When cedrus_hw_probe is called, v4l2_dev is not yet initialized.
Use dev_err instead.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 .../staging/media/sunxi/cedrus/cedrus_hw.c    | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
index 300339fee1bc..0acf219a8c91 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
@@ -157,14 +157,14 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
 
 	irq_dec = platform_get_irq(dev->pdev, 0);
 	if (irq_dec <= 0) {
-		v4l2_err(&dev->v4l2_dev, "Failed to get IRQ\n");
+		dev_err(dev->dev, "Failed to get IRQ\n");
 
 		return irq_dec;
 	}
 	ret = devm_request_irq(dev->dev, irq_dec, cedrus_irq,
 			       0, dev_name(dev->dev), dev);
 	if (ret) {
-		v4l2_err(&dev->v4l2_dev, "Failed to request IRQ\n");
+		dev_err(dev->dev, "Failed to request IRQ\n");
 
 		return ret;
 	}
@@ -182,21 +182,21 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
 
 	ret = of_reserved_mem_device_init(dev->dev);
 	if (ret && ret != -ENODEV) {
-		v4l2_err(&dev->v4l2_dev, "Failed to reserve memory\n");
+		dev_err(dev->dev, "Failed to reserve memory\n");
 
 		return ret;
 	}
 
 	ret = sunxi_sram_claim(dev->dev);
 	if (ret) {
-		v4l2_err(&dev->v4l2_dev, "Failed to claim SRAM\n");
+		dev_err(dev->dev, "Failed to claim SRAM\n");
 
 		goto err_mem;
 	}
 
 	dev->ahb_clk = devm_clk_get(dev->dev, "ahb");
 	if (IS_ERR(dev->ahb_clk)) {
-		v4l2_err(&dev->v4l2_dev, "Failed to get AHB clock\n");
+		dev_err(dev->dev, "Failed to get AHB clock\n");
 
 		ret = PTR_ERR(dev->ahb_clk);
 		goto err_sram;
@@ -204,7 +204,7 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
 
 	dev->mod_clk = devm_clk_get(dev->dev, "mod");
 	if (IS_ERR(dev->mod_clk)) {
-		v4l2_err(&dev->v4l2_dev, "Failed to get MOD clock\n");
+		dev_err(dev->dev, "Failed to get MOD clock\n");
 
 		ret = PTR_ERR(dev->mod_clk);
 		goto err_sram;
@@ -212,7 +212,7 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
 
 	dev->ram_clk = devm_clk_get(dev->dev, "ram");
 	if (IS_ERR(dev->ram_clk)) {
-		v4l2_err(&dev->v4l2_dev, "Failed to get RAM clock\n");
+		dev_err(dev->dev, "Failed to get RAM clock\n");
 
 		ret = PTR_ERR(dev->ram_clk);
 		goto err_sram;
@@ -220,7 +220,7 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
 
 	dev->rstc = devm_reset_control_get(dev->dev, NULL);
 	if (IS_ERR(dev->rstc)) {
-		v4l2_err(&dev->v4l2_dev, "Failed to get reset control\n");
+		dev_err(dev->dev, "Failed to get reset control\n");
 
 		ret = PTR_ERR(dev->rstc);
 		goto err_sram;
@@ -229,7 +229,7 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
 	res = platform_get_resource(dev->pdev, IORESOURCE_MEM, 0);
 	dev->base = devm_ioremap_resource(dev->dev, res);
 	if (IS_ERR(dev->base)) {
-		v4l2_err(&dev->v4l2_dev, "Failed to map registers\n");
+		dev_err(dev->dev, "Failed to map registers\n");
 
 		ret = PTR_ERR(dev->base);
 		goto err_sram;
@@ -237,35 +237,35 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
 
 	ret = clk_set_rate(dev->mod_clk, CEDRUS_CLOCK_RATE_DEFAULT);
 	if (ret) {
-		v4l2_err(&dev->v4l2_dev, "Failed to set clock rate\n");
+		dev_err(dev->dev, "Failed to set clock rate\n");
 
 		goto err_sram;
 	}
 
 	ret = clk_prepare_enable(dev->ahb_clk);
 	if (ret) {
-		v4l2_err(&dev->v4l2_dev, "Failed to enable AHB clock\n");
+		dev_err(dev->dev, "Failed to enable AHB clock\n");
 
 		goto err_sram;
 	}
 
 	ret = clk_prepare_enable(dev->mod_clk);
 	if (ret) {
-		v4l2_err(&dev->v4l2_dev, "Failed to enable MOD clock\n");
+		dev_err(dev->dev, "Failed to enable MOD clock\n");
 
 		goto err_ahb_clk;
 	}
 
 	ret = clk_prepare_enable(dev->ram_clk);
 	if (ret) {
-		v4l2_err(&dev->v4l2_dev, "Failed to enable RAM clock\n");
+		dev_err(dev->dev, "Failed to enable RAM clock\n");
 
 		goto err_mod_clk;
 	}
 
 	ret = reset_control_reset(dev->rstc);
 	if (ret) {
-		v4l2_err(&dev->v4l2_dev, "Failed to apply reset\n");
+		dev_err(dev->dev, "Failed to apply reset\n");
 
 		goto err_ram_clk;
 	}
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
