Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC34C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:53:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B65142146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BKsyAa5J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="agX8ypkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65142146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:
	In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	References:List-Owner; bh=Kav+LpQ6GHyehjIhykrk8UR/ep9/a6b/y96gedU5RC0=; b=BKs
	yAa5JPYuBkWsmJuUmimzpgK/6ds1mT8UICqszzt3MwLxtZQGXaod+Zogii1HdRSTphyf/03nM+1D+
	RTBfVlLfSH+Bh+UZhLeCC1G3biv5IQf8bQozwMGcvvI/lyp0imFVGpwduWpoIdPfj6q9GnPYDz4QS
	jkzLdEZHbAhoVIr931BtXUTgH3gPJT5jGmGASL2tC6uSoTZ0xKwMXqLPg33hZ+hc8ycUYqNM5x/aJ
	QWnNZdOaIgskB3MtoFoCkQ+3LrS+nuKNIA+9/Ln/VngCogvq+VITgffxt+HpXONYQxD4nmKN4CdHL
	CPeAdEagv4SLyBKE5hbyLRb1cPAAbRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwW3c-0002Tf-Cz; Wed, 20 Feb 2019 17:53:20 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwW3Y-0002TI-SD
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 17:53:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=Sw9DGCDrtpLs6KGdDyXVairVrd0d5AlkmKpqpplvKlk=; b=agX8ypkd9IMR
 qNWlBPHWVDIKL7EsRqt4JPCF1avWlTdXA9VCP5+zGq0SN+/gGjp5RH/5P9V6iMXtjiKfGmbOX0hZ/
 6DP9UXAlrCxjanZm+oVte0Z4Ld/CloWT3gASTVeOfcv8Qq8zXsutlvr7X4+l54DNlUxX1snrWB65c
 Sssf0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gwW3R-0005St-Rk; Wed, 20 Feb 2019 17:53:09 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 5FE75112882C; Wed, 20 Feb 2019 17:53:09 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Applied "spi: pxa2xx: Setup maximum supported DMA transfer length" to
 the spi tree
In-Reply-To: <20190219202128.24993-1-andriy.shevchenko@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190220175309.5FE75112882C@debutante.sirena.org.uk>
Date: Wed, 20 Feb 2019 17:53:09 +0000 (GMT)
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_095317_058870_B2E62893 
X-CRM114-Status: GOOD (  13.86  )
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
Cc: linux-arm-kernel@lists.infradead.org,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 stable@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>,
 Daniel Mack <daniel@zonque.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The patch

   spi: pxa2xx: Setup maximum supported DMA transfer length

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

From ef070b4e4aa25bb5f8632ad196644026c11903bf Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 19 Feb 2019 23:21:28 +0300
Subject: [PATCH] spi: pxa2xx: Setup maximum supported DMA transfer length

When the commit b6ced294fb61

   ("spi: pxa2xx: Switch to SPI core DMA mapping functionality")

switches to SPI core provided DMA helpers, it missed to setup maximum
supported DMA transfer length for the controller and thus users
mistakenly try to send more data than supported with the following
warning:

  ili9341 spi-PRP0001:01: DMA disabled for transfer length 153600 greater than 65536

Setup maximum supported DMA transfer length in order to make users know
the limit.

Fixes: b6ced294fb61 ("spi: pxa2xx: Switch to SPI core DMA mapping functionality")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi-pxa2xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index d84b893a64d7..3e82eaad0f2d 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1696,6 +1696,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 			platform_info->enable_dma = false;
 		} else {
 			master->can_dma = pxa2xx_spi_can_dma;
+			master->max_dma_len = MAX_DMA_LEN;
 		}
 	}
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
