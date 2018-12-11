Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4569AC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:42:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14FD220849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tMPd3vZt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PuZD42Z0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FD220849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:MIME-Version:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ADo2Uc3ewVBfgFUXIGDRijbH/bVZO+lE9fWsU6KAogU=; b=tMPd3vZtawCqgH
	2ex59yfWFwqGvaegTnm5h8n31G50hg/Bp8NZ1DHH5kGJIwEfHZX7AkrBKefRZkK6GgSChmhC8ijce
	saxggLqLWlmn24GYbCPvSpslZdMMP5rlqcrrrMyzo4Bl7ryMm4N5xYwhh2/LxEMzxEDxCPvWf1q7I
	lDBsP7IsrIWc/AK4ppwC5XZAmVAWZUNcoBnDFse0goYfSCgneACjfSlMvz/rbnsCX5pARtf45WxtL
	Z9HtPsNTsszB1RZRuYoEAJBMSm0RM1E0zm3t/Hr3PXoIQQgPkFg478bkcBk/b/MJGocOgCyMx5ELr
	BsSQHprH6Pqi0FXjt5zA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWjES-0002WD-RK; Tue, 11 Dec 2018 14:41:56 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWjEN-0002TD-WD
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 14:41:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Date:Sender:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=whP8yl6ecyEd1NBKKYalROXIZ8YTHQnoPObi7i0x8LI=; b=PuZD42Z0wUE5uakWjY9XDPMsWp
 Mr0Dxe8tT7gC1Bj508mKhciLXCqa96RO1S1OwViJtzVUTfJx8bxlcxYYKCX+jn9TpnQFxJQviGh6h
 3n+hI21t4M+8i58A//aPDvFBmNofLPd4eZ1U1n5ND6fTYOKKL70kdG/PCeDKiWyHoJWA=;
Received: from e0022681537dd.dyn.armlinux.org.uk
 ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:40392 helo=rmk-PC.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <rmk@armlinux.org.uk>)
 id 1gWjE3-00077Y-Pb; Tue, 11 Dec 2018 14:41:31 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim
 4.82_1-5b7a7c0-XX) (envelope-from <rmk@armlinux.org.uk>)
 id 1gWjE3-0006mG-2S; Tue, 11 Dec 2018 14:41:31 +0000
From: Russell King <rmk+kernel@armlinux.org.uk>
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>
Subject: [PATCH] mmc: omap_hsmmc: fix DMA API warning
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1gWjE3-0006mG-2S@rmk-PC.armlinux.org.uk>
Date: Tue, 11 Dec 2018 14:41:31 +0000
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_064152_032262_BE082F69 
X-CRM114-Status: GOOD (  12.73  )
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
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

While booting with rootfs on MMC, the following warning is encountered
on OMAP4430:

omap-dma-engine 4a056000.dma-controller: DMA-API: mapping sg segment longer than device claims to support [len=69632] [max=65536]

This is because the DMA engine has a default maximum segment size of 64K
but HSMMC sets:

        mmc->max_blk_size = 512;       /* Block Length at max can be 1024 */
        mmc->max_blk_count = 0xFFFF;    /* No. of Blocks is 16 bits */
        mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
        mmc->max_seg_size = mmc->max_req_size;

which ends up telling the block layer that we support a maximum segment
size of 65535*512, which exceeds the advertised DMA engine capabilities.

Fix this by clamping the maximum segment size to the lower of the
maximum request size and of the DMA engine device used for either DMA
channel.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/mmc/host/omap_hsmmc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 467d889a1638..55100974fb95 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1909,7 +1909,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	mmc->max_blk_size = 512;       /* Block Length at max can be 1024 */
 	mmc->max_blk_count = 0xFFFF;    /* No. of Blocks is 16 bits */
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
-	mmc->max_seg_size = mmc->max_req_size;
 
 	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 		     MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_ERASE | MMC_CAP_CMD23;
@@ -1939,6 +1938,17 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
+	/*
+	 * Limit the maximum segment size to the lower of the request size
+	 * and the DMA engine device segment size limits.  In reality, with
+	 * 32-bit transfers, the DMA engine can do longer segments than this
+	 * but there is no way to represent that in the DMA model - if we
+	 * increase this figure here, we get warnings from the DMA API debug.
+	 */
+	mmc->max_seg_size = min(mmc->max_req_size,
+				min(dma_get_max_seg_size(host->rx_chan->device->dev),
+				    dma_get_max_seg_size(host->tx_chan->device->dev)));
+
 	/* Request IRQ for MMC operations */
 	ret = devm_request_irq(&pdev->dev, host->irq, omap_hsmmc_irq, 0,
 			mmc_hostname(mmc), host);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
