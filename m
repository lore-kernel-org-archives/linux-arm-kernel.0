Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E45FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:02:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1BDC2083E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cmVmUDYv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="acaSCdYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1BDC2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:MIME-Version:Subject:To
	:From:References:In-Reply-To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/TQKvdCcx1SpvXTKVGrrYOvuILXDcPJiOKs8zYxYbLs=; b=cmVmUDYvJicG8r
	jBvsGIxioDXnWRbVdDwB32cRHUbX34Y9L60V5i2B7G0WulGZ3809rWovy2/h7H2SafxTmdlqbMfV/
	ql6AG4b9nxoxOtqMtbISNvcZcpYzFocJeOOJgmWPJQflo2rvjkxb7YJSA+wY/P3pi090NqfOMBFkJ
	5dGOSNIMvJGpB+FAv3h/8jgT+A26TgadOs3PgB6y/fLnBn5Cb2TJscQkMKTJdGVwWww4jEpviJvmM
	rpV0gPZG1uwOkyzN0YqrJIx+aiMqVb7KNCKG2ugF5Or0/BBJNMdrFMr1RwaupRcVvrWGq/MYr5iWm
	DBGMQjNe8GwjeFQRLTaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqnj-0000e9-Ab; Thu, 21 Feb 2019 16:02:19 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqnb-00070G-06
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 16:02:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
 In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zPD78fCYTtci38h67MfWuvO01OttSR+7Tm/Kh8ZQyrI=; b=acaSCdYWUq7Dp7fXuFkqTIYEas
 0yBVYnJpB2s6YjIK0HUUACCBGVFI64kbgOQR4EqSJaNUoPfI6sTbZKa/uBjpUQ7+tHj/ORb14WkHh
 QsZsSRDpTKRmpXpddodjZ7OWlZxbrcJHNNd9RLGS49haYlyno59XbPv8TyjzYrC2dxWv1m4DBKmR0
 kD7gs9SIc3IIav+nLpSqRmGq/41KrFN6OnC/zhha3EfoJ+d9uTbtDrH1pKTnVOJymG2f573DD6KS+
 2s1i5uahu0LZSQcvNyWf3Y4Ofj3VJSl1anNH5BXal9e2m0pTPGq87zW376ZeLWhwpQcaMbEqvqgpt
 w6/w55Ig==;
Received: from e0022681537dd.dyn.armlinux.org.uk
 ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:46824 helo=rmk-PC.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <rmk@armlinux.org.uk>)
 id 1gwqlT-0003hr-IP; Thu, 21 Feb 2019 15:59:59 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim
 4.82_1-5b7a7c0-XX) (envelope-from <rmk@armlinux.org.uk>)
 id 1gwqlS-00053l-QU; Thu, 21 Feb 2019 15:59:58 +0000
In-Reply-To: <20190221152459.axrjce7yqkjmedgl@shell.armlinux.org.uk>
References: <20190221152459.axrjce7yqkjmedgl@shell.armlinux.org.uk>
From: Russell King <rmk+kernel@armlinux.org.uk>
To: Mark Brown <broonie@kernel.org>,
 Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: [PATCH] spi: spi-gpio: fix SPI_CS_HIGH capability
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1gwqlS-00053l-QU@rmk-PC.armlinux.org.uk>
Date: Thu, 21 Feb 2019 15:59:58 +0000
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_080211_051249_66158DF7 
X-CRM114-Status: GOOD (  11.49  )
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
Cc: linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

spi-gpio is capable of dealing with active-high chip-selects.
Unfortunately, commit 4b859db2c606 ("spi: spi-gpio: add SPI_3WIRE
support") broke this by setting master->mode_bits, which overrides
the setting in the spi-bitbang code.  Fix this.

Fixes: 4b859db2c606 ("spi: spi-gpio: add SPI_3WIRE support")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
Patch against 4.20

 drivers/spi/spi-gpio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 45973ee3ae11..2d7cfe3c7732 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -410,7 +410,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 		return status;
 
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
-	master->mode_bits = SPI_3WIRE | SPI_CPHA | SPI_CPOL;
+	master->mode_bits = SPI_3WIRE | SPI_CPHA | SPI_CPOL | SPI_CS_HIGH;
 	master->flags = master_flags;
 	master->bus_num = pdev->id;
 	/* The master needs to think there is a chipselect even if not connected */
@@ -437,7 +437,6 @@ static int spi_gpio_probe(struct platform_device *pdev)
 		spi_gpio->bitbang.txrx_word[SPI_MODE_3] = spi_gpio_spec_txrx_word_mode3;
 	}
 	spi_gpio->bitbang.setup_transfer = spi_bitbang_setup_transfer;
-	spi_gpio->bitbang.flags = SPI_CS_HIGH;
 
 	status = spi_bitbang_start(&spi_gpio->bitbang);
 	if (status)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
