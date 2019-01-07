Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D84C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:01:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE20A206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kPs7UFIb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="VO9Tw2yK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE20A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:
	In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	References:List-Owner; bh=8x72Ynl78xgVzc3ORyI1P/lQTJ5b3mQ8NApHJ00lv6c=; b=kPs
	7UFIbDwHPUdo3LtyRvQQ6kpg0g7PsFU31q3oBguzPC3VUWdu2TNamiIVhtJsIVTicsuGeoLBTeSgC
	BOlmgMyyFREKwQQfs7D/DjIKh7/xeUennxCk+n7gQYDOTm9ZK5kHkNkxQe7ZQCJW9D9f+cR+tqc69
	xfHIFeYDqgpCTOj3eVr6E81TwG+iDaVqTVp9v30BbaTQzxQ+G5gUAeXucPt0f8PmY6c7dJ4oTBUHu
	l2EDcsR9DnzOttbilguQzhvm+r57vAY/MmNb04cSOkwMy+GlXL+8WCHqpYepKFHtZS4HcBAP7KHyW
	/QI5goqGywLMELbHL9uLfzqmJYGUWMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gga9W-000625-6F; Mon, 07 Jan 2019 19:01:34 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gga7L-0002fH-PV
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 18:59:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=u8W1sekMwJLEm6EyPy+JcHJsSu5ENjswD94T4/osl8A=; b=VO9Tw2yK8C7G
 aTzdrzzPShXG3uVkEHYgOeBTbXhWIljddoqH9b6uK0ot1d8iuJ8sAkwVuTovFZGTncN9PggO6YTmW
 iUlwlVDEWSMNDUtcIKBzqT+JEu5pjw0D6ItB98b7kPhUDnu16GMiQt5cixW2MppVjp3OZd4JWvHtv
 V5S34=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gga7J-0007rY-2v; Mon, 07 Jan 2019 18:59:17 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id A15151127491; Mon,  7 Jan 2019 18:59:16 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Cezary Gapinski <cezary.gapinski@gmail.com>
Subject: Applied "spi: stm32: use NULL pointer instead of plain integer" to
 the spi tree
In-Reply-To: <1545688840-23992-3-git-send-email-cezary.gapinski@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185916.A15151127491@debutante.sirena.org.uk>
Date: Mon,  7 Jan 2019 18:59:16 +0000 (GMT)
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_105919_984852_03B25481 
X-CRM114-Status: GOOD (  13.95  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Amelie Delaunay <amelie.delaunay@st.com>,
 Alexandre Torgue <alexandre.torgue@st.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The patch

   spi: stm32: use NULL pointer instead of plain integer

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

From d4c9134a6c2c85d18b0d58accdf0e9be447f77a3 Mon Sep 17 00:00:00 2001
From: Cezary Gapinski <cezary.gapinski@gmail.com>
Date: Mon, 24 Dec 2018 23:00:28 +0100
Subject: [PATCH] spi: stm32: use NULL pointer instead of plain integer

Patch fixes sparse warning: Using plain integer as NULL pointer. Replaces
second argument of function devm_clk_get from 0 to NULL.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 5f30578a4224..51d7f720127b 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1100,7 +1100,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 		goto err_master_put;
 	}
 
-	spi->clk = devm_clk_get(&pdev->dev, 0);
+	spi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(spi->clk)) {
 		ret = PTR_ERR(spi->clk);
 		dev_err(&pdev->dev, "clk get failed: %d\n", ret);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
