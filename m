Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5A4C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:26:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED112147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F1PhjM4J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="V9iGdGm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED112147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:
	In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	References:List-Owner; bh=JCB0AXLDlAYhm5au6uYHSPQkU7Zsiq9W/7mrrJ79eIk=; b=F1P
	hjM4JrrUB7svPNl65uWWykUIiXShv2vMeTHMmlQ/p0hi8JKJtaDO+3fKyDuNXlgj+wqaiMeuZZxcT
	nCZ6AeyJBG254g3nB2nQ+0GjhLlBNuWUv75Ey1dcDbU1pIPjaypLgppVd8j0mVUROxZgxjmPK8+5Y
	qQPy+XeatX9vb3njkEZAV28iU6MGg20O/XyngfwtDExasRECFtWiWmM0nFWzvKO16ptKRnN5Y9j07
	k+pxHMBukygtoidrr4cDaSqs9oo43lxEsRyZwxkc+MA3Vpp9Nlh8JO3FndoXbeqk/zuG/Y9/kNoNR
	g2NI+WsuOtUXycpDksn72tpI2ULSCbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBcD-0003Vo-Na; Mon, 28 Jan 2019 18:26:37 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBbf-0003En-ID
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:26:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=mfhnHH0x2E654fntPsAGavlrFArTu2BdabxZHTu/TvM=; b=V9iGdGm8ucFw
 FOntlS62UojUqPgesp06L5J9u4hMR4wJ5bHfYxghwAFrIPpCMlzqP4KgQSIpdq3xX/fDZWGxU+IEL
 KHslhE+BrHczLbb0XWn1dKzhkIEbQZozBgeUVjOw2deEuFU9VGdhlV/VJTAJSadriA2WnIalo645+
 7OH60=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1goBba-0003Cf-1l; Mon, 28 Jan 2019 18:25:58 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id A0AAA1127D29; Mon, 28 Jan 2019 18:25:57 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Jiwei Sun <jiwei.sun@windriver.com>
Subject: Applied "spi: pl022: add a message state STATE_TIMEOUT for timeout
 transfer" to the spi tree
In-Reply-To: <20190118033229.22553-1-jiwei.sun@windriver.com>
X-Patchwork-Hint: ignore
Message-Id: <20190128182557.A0AAA1127D29@debutante.sirena.org.uk>
Date: Mon, 28 Jan 2019 18:25:57 +0000 (GMT)
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_102604_019074_D361BABA 
X-CRM114-Status: GOOD (  13.67  )
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
Cc: linus.walleij@linaro.org, broonie@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The patch

   spi: pl022: add a message state STATE_TIMEOUT for timeout transfer

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

From 7aef2b646b24247d880a353e09d4e10614a61cd6 Mon Sep 17 00:00:00 2001
From: Jiwei Sun <jiwei.sun@windriver.com>
Date: Fri, 18 Jan 2019 11:32:29 +0800
Subject: [PATCH] spi: pl022: add a message state STATE_TIMEOUT for timeout
 transfer

When transfer timeout, give -EAGAIN to the message's status, and it can
make the spi device driver choose repeated transimation or not. And if
transfer timeout, output some useful information for tracing the issue.

Signed-off-by: Jiwei Sun <jiwei.sun@windriver.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pl022.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 0c793e31d60f..26684178786f 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -253,6 +253,7 @@
 #define STATE_RUNNING			((void *) 1)
 #define STATE_DONE			((void *) 2)
 #define STATE_ERROR			((void *) -1)
+#define STATE_TIMEOUT			((void *) -2)
 
 /*
  * SSP State - Whether Enabled or Disabled
@@ -1484,6 +1485,30 @@ static void do_interrupt_dma_transfer(struct pl022 *pl022)
 	writew(irqflags, SSP_IMSC(pl022->virtbase));
 }
 
+static void print_current_status(struct pl022 *pl022)
+{
+	u32 read_cr0;
+	u16 read_cr1, read_dmacr, read_sr;
+
+	if (pl022->vendor->extended_cr)
+		read_cr0 = readl(SSP_CR0(pl022->virtbase));
+	else
+		read_cr0 = readw(SSP_CR0(pl022->virtbase));
+	read_cr1 = readw(SSP_CR1(pl022->virtbase));
+	read_dmacr = readw(SSP_DMACR(pl022->virtbase));
+	read_sr = readw(SSP_SR(pl022->virtbase));
+
+	dev_warn(&pl022->adev->dev, "spi-pl022 CR0: %x\n", read_cr0);
+	dev_warn(&pl022->adev->dev, "spi-pl022 CR1: %x\n", read_cr1);
+	dev_warn(&pl022->adev->dev, "spi-pl022 DMACR: %x\n", read_dmacr);
+	dev_warn(&pl022->adev->dev, "spi-pl022 SR: %x\n", read_sr);
+	dev_warn(&pl022->adev->dev,
+			"spi-pl022 exp_fifo_level/fifodepth: %u/%d\n",
+			pl022->exp_fifo_level,
+			pl022->vendor->fifodepth);
+
+}
+
 static void do_polling_transfer(struct pl022 *pl022)
 {
 	struct spi_message *message = NULL;
@@ -1535,7 +1560,8 @@ static void do_polling_transfer(struct pl022 *pl022)
 			if (time_after(time, timeout)) {
 				dev_warn(&pl022->adev->dev,
 				"%s: timeout!\n", __func__);
-				message->state = STATE_ERROR;
+				message->state = STATE_TIMEOUT;
+				print_current_status(pl022);
 				goto out;
 			}
 			cpu_relax();
@@ -1553,6 +1579,8 @@ static void do_polling_transfer(struct pl022 *pl022)
 	/* Handle end of message */
 	if (message->state == STATE_DONE)
 		message->status = 0;
+	else if (message->state == STATE_TIMEOUT)
+		message->status = -EAGAIN;
 	else
 		message->status = -EIO;
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
