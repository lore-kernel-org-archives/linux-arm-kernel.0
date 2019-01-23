Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B993C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:58:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0D45217D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TDcQPtaj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="v9xI2SBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D45217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:
	In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	References:List-Owner; bh=BuQSH7wnH6OaqUq/fJHjqwzRQyecGCkKrbSh/ksDyXc=; b=TDc
	QPtajkOQg5l9xa4mNGHesv94Rkw2/zxzM99GO+9LHyTge6HkND8IeXYR+aBbvpnbB0pBIjvaOOlud
	obRTGxFpLXxON4qWqxkxKypGKUQjDatTHZ6yRDzDBKKVJ/OWqkFgaulXJCwFsI1OXlCjit8VZA4/p
	adSb6aQ/M85aUAZ2ckSQf2jQICJI9Puw+xHSwHAMmXtHCJPX1XnYfmNPgp8hb6HzZ5MEQUpiedGz+
	LPbSDKBMlCAAIBIMq68/EpncYmYIsF4vR0gwheEtQXoIItcnlDD46F+S1JldXYaGHH2+IganHDZwU
	nuLEKOrGOSybMEBwHud5onaAgH7nnlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmMn1-0000dq-Un; Wed, 23 Jan 2019 17:58:15 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmMmz-0000d1-3b; Wed, 23 Jan 2019 17:58:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=FDVGUh97QlabIV1YIkxnB38rVPUOuVzxvF1p0Xb8kr8=; b=v9xI2SBLXKzb
 6V8rDf1e1/oqByQo+wjqcTGLBeuZWjMt0Uk8OjASAgzqSlgVykZ2+ypKJd2V5D2wvmT5F6+6KzuN4
 kCaazOlBRzzXJnuW3TU8OxgnZ8FXsOXHFgtzqXQGOFK2C2nHoIXQ9xMzq07WRrnt+Ok5YzeloXhRX
 xASAI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gmMmn-0006qq-FW; Wed, 23 Jan 2019 17:58:01 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 7DF351127ABA; Wed, 23 Jan 2019 17:58:00 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: YueHaibing <yuehaibing@huawei.com>
Subject: Applied "spi: bcm2835aux: remove unneeded NULL check of devm_clk_get"
 to the spi tree
In-Reply-To: <20190123070507.15404-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190123175800.7DF351127ABA@debutante.sirena.org.uk>
Date: Wed, 23 Jan 2019 17:58:00 +0000 (GMT)
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_095813_291872_99EDA55A 
X-CRM114-Status: GOOD (  12.90  )
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
Cc: stefan.wahren@i2se.com, f.fainelli@gmail.com, sbranden@broadcom.com,
 rjui@broadcom.com, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 eric@anholt.net, broonie@kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The patch

   spi: bcm2835aux: remove unneeded NULL check of devm_clk_get

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From bfc7af6d6df8d75b9c693b8eb98c21aa75c1e377 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 23 Jan 2019 15:05:07 +0800
Subject: [PATCH] spi: bcm2835aux: remove unneeded NULL check of devm_clk_get

Fix a static code checker warning:
drivers/spi/spi-bcm2835aux.c:460
 bcm2835aux_spi_probe() warn: passing zero to 'PTR_ERR'

In case of error, the function devm_clk_get() returns ERR_PTR()
and not returns NULL.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm2835aux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 671e374e1b01..f7e054848ca5 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -456,7 +456,7 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 	}
 
 	bs->clk = devm_clk_get(&pdev->dev, NULL);
-	if ((!bs->clk) || (IS_ERR(bs->clk))) {
+	if (IS_ERR(bs->clk)) {
 		err = PTR_ERR(bs->clk);
 		dev_err(&pdev->dev, "could not get clk: %d\n", err);
 		goto out_master_put;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
