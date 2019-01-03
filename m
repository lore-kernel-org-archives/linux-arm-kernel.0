Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F118C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:17:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A1020815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NW8LwZGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A1020815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a2T5Ivcc5Q9bLo6Z+BNGHQuaElG3RPsEPykla3T8nxQ=; b=NW8LwZGRPnX17C
	+GyqpGqMy0YpTx5uPl+TgGvGCixm231W2C4MIpmvATwxsbDpj8OV6fsxxZhOmMHnA5Q/BOSVuiezQ
	q4SBxosAi8pzyZSAkNkAQkjuWsG4v/X7Wvz5329sX65RmgQzjMWJCHj4JPFvHRnptYlBJ6NhftYkc
	EMNaDrbK99+ilN5oDEoFcbg+DSTE4H6X5H9BRuscaxsE123ym9jvxklS+YyM1P2cU1IRSyNNY1UiF
	zSVItqG5ugowTtm5GmvnxDrYuk8D8AI6PeQMvWij2pwqzPhnZuASGMDd82jnqs0c3vl6JhtLyHDUU
	8ByaXIi0BozfSnG/JAcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf04V-0006VS-L8; Thu, 03 Jan 2019 10:17:51 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf043-00060z-53
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 10:17:25 +0000
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x03AC9K6023336; Thu, 3 Jan 2019 11:17:15 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2pnxxbtsk8-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 03 Jan 2019 11:17:15 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7C3DD31;
 Thu,  3 Jan 2019 10:17:14 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 479222A85;
 Thu,  3 Jan 2019 10:17:14 +0000 (GMT)
Received: from localhost (10.75.127.46) by SFHDAG5NODE2.st.com (10.75.127.14)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2;
 Thu, 3 Jan 2019 11:17:13 +0100
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@st.com>, <dmaengine@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v1 2/3] dmaengine: stm32-dmamux: Add PM Runtime support
Date: Thu, 3 Jan 2019 11:17:09 +0100
Message-ID: <1546510630-16555-3-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546510630-16555-1-git-send-email-pierre-yves.mordret@st.com>
References: <1546510630-16555-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-03_04:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_021723_472129_9F17AF8D 
X-CRM114-Status: GOOD (  16.24  )
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
Cc: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use pm_runtime engine for clock management purpose.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 drivers/dma/stm32-dmamux.c | 58 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
index b922db9..a671191 100644
--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -28,6 +28,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -79,8 +80,7 @@ static void stm32_dmamux_free(struct device *dev, void *route_data)
 	stm32_dmamux_write(dmamux->iomem, STM32_DMAMUX_CCR(mux->chan_id), 0);
 	clear_bit(mux->chan_id, dmamux->dma_inuse);
 
-	if (!IS_ERR(dmamux->clk))
-		clk_disable(dmamux->clk);
+	pm_runtime_put_sync(dev);
 
 	spin_unlock_irqrestore(&dmamux->lock, flags);
 
@@ -146,13 +146,10 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 
 	/* Set dma request */
 	spin_lock_irqsave(&dmamux->lock, flags);
-	if (!IS_ERR(dmamux->clk)) {
-		ret = clk_enable(dmamux->clk);
-		if (ret < 0) {
-			spin_unlock_irqrestore(&dmamux->lock, flags);
-			dev_err(&pdev->dev, "clk_prep_enable issue: %d\n", ret);
-			goto error;
-		}
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0) {
+		spin_unlock_irqrestore(&dmamux->lock, flags);
+		goto error;
 	}
 	spin_unlock_irqrestore(&dmamux->lock, flags);
 
@@ -254,6 +251,7 @@ static int stm32_dmamux_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "DMAMUX defaulting on %u requests\n",
 			 stm32_dmamux->dmamux_requests);
 	}
+	pm_runtime_get_noresume(&pdev->dev);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	iomem = devm_ioremap_resource(&pdev->dev, res);
@@ -282,6 +280,8 @@ static int stm32_dmamux_probe(struct platform_device *pdev)
 	stm32_dmamux->dmarouter.route_free = stm32_dmamux_free;
 
 	platform_set_drvdata(pdev, stm32_dmamux);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
 
 	if (!IS_ERR(stm32_dmamux->clk)) {
 		ret = clk_prepare_enable(stm32_dmamux->clk);
@@ -291,17 +291,52 @@ static int stm32_dmamux_probe(struct platform_device *pdev)
 		}
 	}
 
+	pm_runtime_get_noresume(&pdev->dev);
+
 	/* Reset the dmamux */
 	for (i = 0; i < stm32_dmamux->dma_requests; i++)
 		stm32_dmamux_write(stm32_dmamux->iomem, STM32_DMAMUX_CCR(i), 0);
 
-	if (!IS_ERR(stm32_dmamux->clk))
-		clk_disable(stm32_dmamux->clk);
+	pm_runtime_put(&pdev->dev);
 
 	return of_dma_router_register(node, stm32_dmamux_route_allocate,
 				     &stm32_dmamux->dmarouter);
 }
 
+#ifdef CONFIG_PM
+static int stm32_dmamux_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev =
+		container_of(dev, struct platform_device, dev);
+	struct stm32_dmamux_data *stm32_dmamux = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(stm32_dmamux->clk);
+
+	return 0;
+}
+
+static int stm32_dmamux_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev =
+		container_of(dev, struct platform_device, dev);
+	struct stm32_dmamux_data *stm32_dmamux = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = clk_prepare_enable(stm32_dmamux->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to prepare_enable clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops stm32_dmamux_pm_ops = {
+	SET_RUNTIME_PM_OPS(stm32_dmamux_runtime_suspend,
+			   stm32_dmamux_runtime_resume, NULL)
+};
+
 static const struct of_device_id stm32_dmamux_match[] = {
 	{ .compatible = "st,stm32h7-dmamux" },
 	{},
@@ -312,6 +347,7 @@ static struct platform_driver stm32_dmamux_driver = {
 	.driver = {
 		.name = "stm32-dmamux",
 		.of_match_table = stm32_dmamux_match,
+		.pm = &stm32_dmamux_pm_ops,
 	},
 };
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
