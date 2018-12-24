Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DB9C64E75
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:02:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28F7E21850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LY0A16GS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpPOawWk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F7E21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=S0iVlQE5g7emltAlmiu+fuSGyS+ERrn5bVZa4h/NHVg=; b=LY0A16GSwKj95C7qfm2Uc4mX78
	Vkk7AtHNOBOLLxCHx/oWqQj0mZG7sUWRWK8/ceyVmjyCCBPyB8dhvRVul+Lncjyt/ftQmLYWnwbb/
	8116v4x+bGhKUoPhA/lrBsKkpIYXeI1z6tT8g4zv4oxhvF5zBLVRh9C/NwPPwhEUiUTNeRiybKvQo
	ZF1N5npgC1DQQUIWvB5/W1GAirNAsU68fkgNAKFWg3Q62I0t0NhRe9qIjk1keIgilOSRoY+5HY1M1
	BYZii5J510sizzWFXO44Ht/Uok6sQwgF9Ott8SwrqETK0GngYzk4WkcKlDcuxint24hcQOoFAna5q
	BU9/RMwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbYIc-0005Hk-CZ; Mon, 24 Dec 2018 22:02:10 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbYHe-0004IF-1m
 for linux-arm-kernel@lists.infradead.org; Mon, 24 Dec 2018 22:01:19 +0000
Received: by mail-wr1-x442.google.com with SMTP id v13so12541191wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 24 Dec 2018 14:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=yuQXdVUQ9R0GH2pEbqaSUK1RsDR3ktcKH1dkIwIBJFk=;
 b=OpPOawWkEWM1Cr2jMu4bxnJQ0drzy3p/rtF9teIe8kKzD04Z7l5Fun8XizxK/+Y/a8
 LIrCZpzlfIp9tPawqE2C8HfxxMemJOpd56zQeA+ressjU/kQ/LNddlHctQpvuT+yHPuP
 AU43U+lMYjcxQFhLux2ItNi2P8oZ/0IGQdqq112Yxvjy/XbpCO1Z7zMzwLOq+tmIvzKA
 er2F+b4F7D0rXu+chMQ8iP5Zb21E68LshPdiRuITFB0su3P5W4s/excYbHJZTPTDWVas
 26cuZO/5oStfeyMlWBpa0XYFeyTx8i5DlgQ7I9XBRk1HdhcGkVxnrxZ9qR4ZXmn3C0Vy
 qYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=yuQXdVUQ9R0GH2pEbqaSUK1RsDR3ktcKH1dkIwIBJFk=;
 b=Unli9czUfJmS19bklaiMnsGBGgt4MV5gUqNqQH5S3XiIGOoNA9KGAfQ6jb/7P0wwnm
 PjmSVWNfCEKIyfybpwpaLNP0Z6ItTKF7+5R3GqVzi0GRTvRxojuvu/u3z1E4RI5m/j27
 +KkVWGwmXzzyIpPCsw/wkzKmzJehLu9dokbeeJ7vFQMYw3/jlVkg734jGQrjYbU8P5mH
 mLBxOTk6FXVhkULl5zNyb0VnZwmB+Gcn9CMC5OTIpbFaqi1GxJuisgrK5+XCOlcQSEU4
 98eBNX7odSoM3jNmGJfuIUl9YMXpAzdukGnRqKHJAFZuHl8XH73uq2QW3OOsdlujUZt4
 138g==
X-Gm-Message-State: AJcUukdwxKTflJYzUi5JRoloVT1mqIQKXw+RjDcyaAhjZ8JWqE50Y1xd
 JRFQ66j4WmDYkTRVfxmCEq41rX76gbE=
X-Google-Smtp-Source: ALg8bN54HhVK5DC6H4W/r8G3ntxk8eOT6geZZ6jMgRZ4vjY3EzMiL8Ts3gl03YWZX2ys+X4yjjtJDw==
X-Received: by 2002:adf:d089:: with SMTP id y9mr13310723wrh.22.1545688865727; 
 Mon, 24 Dec 2018 14:01:05 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (daw20.neoplus.adsl.tpnet.pl.
 [83.23.22.20])
 by smtp.gmail.com with ESMTPSA id d4sm23970153wrp.89.2018.12.24.14.01.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 24 Dec 2018 14:01:05 -0800 (PST)
From: cezary.gapinski@gmail.com
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
 Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v2 08/14] spi: stm32: rename interrupt function
Date: Mon, 24 Dec 2018 23:00:34 +0100
Message-Id: <1545688840-23992-9-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_140110_416758_DD02D443 
X-CRM114-Status: GOOD (  13.83  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Cezary Gapinski <cezary.gapinski@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

Interrupt function is used as a thread so rename it to express
meaning directly by more clear function name.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 drivers/spi/spi-stm32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 2ece69a..9cb7d33 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -466,11 +466,11 @@ static bool stm32_spi_can_dma(struct spi_master *master,
 }
 
 /**
- * stm32_spi_irq - Interrupt handler for SPI controller events
+ * stm32_spi_irq_thread - Thread of interrupt handler for SPI controller
  * @irq: interrupt line
  * @dev_id: SPI controller master interface
  */
-static irqreturn_t stm32_spi_irq(int irq, void *dev_id)
+static irqreturn_t stm32_spi_irq_thread(int irq, void *dev_id)
 {
 	struct spi_master *master = dev_id;
 	struct stm32_spi *spi = spi_master_get_devdata(master);
@@ -1113,7 +1113,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 		goto err_master_put;
 	}
 	ret = devm_request_threaded_irq(&pdev->dev, spi->irq, NULL,
-					stm32_spi_irq, IRQF_ONESHOT,
+					stm32_spi_irq_thread, IRQF_ONESHOT,
 					pdev->name, master);
 	if (ret) {
 		dev_err(&pdev->dev, "irq%d request failed: %d\n", spi->irq,
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
