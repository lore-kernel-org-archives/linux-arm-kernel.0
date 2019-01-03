Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7E4C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:17:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8CE520815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nhf73Jut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CE520815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wVf1NdO0IQ7kDPXoH+8GSNL/gLMiFrjhxhW/MhOC27M=; b=Nhf73JutkGGr+u
	5F4itAn7qd6xGJc2x76AZsmfW46gAqhQ044lkz6sucnS100oyuhWKSYwh7s0xJVM8873LOyiTlfVM
	24/p7/FBVRFMSK+Bvh19KQHDDi2qQH1m9KJT9WJIMjlXA4+OWWkimYgyIJwrPVoO/kDmoi2IJwMcG
	5ZDokp0INxoV6hkbAm+2cK+WsmBhfQkXHtOKg8qoxKniQhPT1Ou4aGY0WEyW6QRlGtxAQqz6EUHBz
	9ZdcYvL8fWtWWV0mHO9Dx0U7q0Pnov+rSdOw7al3KU4mf8KzYtN8WmQvvD/W69sUE6Ewm/QbKS5ZO
	ZcD1SMVI7p2iebd8FEmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf04G-0006Bz-5o; Thu, 03 Jan 2019 10:17:36 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf042-00060q-Az
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 10:17:24 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x03ABWhQ030372; Thu, 3 Jan 2019 11:17:14 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2pp0pm2hjg-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 03 Jan 2019 11:17:14 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 59DAA3A;
 Thu,  3 Jan 2019 10:17:13 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 33E892484;
 Thu,  3 Jan 2019 10:17:13 +0000 (GMT)
Received: from localhost (10.75.127.46) by SFHDAG5NODE2.st.com (10.75.127.14)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2;
 Thu, 3 Jan 2019 11:17:12 +0100
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@st.com>, <dmaengine@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v1 1/3] dmaengine: stm32-dma: Add PM Runtime support
Date: Thu, 3 Jan 2019 11:17:08 +0100
Message-ID: <1546510630-16555-2-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546510630-16555-1-git-send-email-pierre-yves.mordret@st.com>
References: <1546510630-16555-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-03_04:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_021722_663328_D671DC8E 
X-CRM114-Status: GOOD (  15.58  )
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
 drivers/dma/stm32-dma.c | 58 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 48f7c0f..ba239b5 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -23,6 +23,7 @@
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -1115,15 +1116,14 @@ static int stm32_dma_alloc_chan_resources(struct dma_chan *c)
 	int ret;
 
 	chan->config_init = false;
-	ret = clk_prepare_enable(dmadev->clk);
-	if (ret < 0) {
-		dev_err(chan2dev(chan), "clk_prepare_enable failed: %d\n", ret);
+
+	ret = pm_runtime_get_sync(dmadev->ddev.dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = stm32_dma_disable_chan(chan);
 	if (ret < 0)
-		clk_disable_unprepare(dmadev->clk);
+		pm_runtime_put(dmadev->ddev.dev);
 
 	return ret;
 }
@@ -1143,7 +1143,7 @@ static void stm32_dma_free_chan_resources(struct dma_chan *c)
 		spin_unlock_irqrestore(&chan->vchan.lock, flags);
 	}
 
-	clk_disable_unprepare(dmadev->clk);
+	pm_runtime_put(dmadev->ddev.dev);
 
 	vchan_free_chan_resources(to_virt_chan(c));
 }
@@ -1243,6 +1243,12 @@ static int stm32_dma_probe(struct platform_device *pdev)
 		return PTR_ERR(dmadev->clk);
 	}
 
+	ret = clk_prepare_enable(dmadev->clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "clk_prep_enable error: %d\n", ret);
+		return ret;
+	}
+
 	dmadev->mem2mem = of_property_read_bool(pdev->dev.of_node,
 						"st,mem2mem");
 
@@ -1292,7 +1298,7 @@ static int stm32_dma_probe(struct platform_device *pdev)
 
 	ret = dma_async_device_register(dd);
 	if (ret)
-		return ret;
+		goto clk_free;
 
 	for (i = 0; i < STM32_DMA_MAX_CHANNELS; i++) {
 		chan = &dmadev->chan[i];
@@ -1324,20 +1330,58 @@ static int stm32_dma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dmadev);
 
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_put(&pdev->dev);
+
 	dev_info(&pdev->dev, "STM32 DMA driver registered\n");
 
 	return 0;
 
 err_unregister:
 	dma_async_device_unregister(dd);
+clk_free:
+	clk_disable_unprepare(dmadev->clk);
 
 	return ret;
 }
 
+#ifdef CONFIG_PM
+static int stm32_dma_runtime_suspend(struct device *dev)
+{
+	struct stm32_dma_device *dmadev = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(dmadev->clk);
+
+	return 0;
+}
+
+static int stm32_dma_runtime_resume(struct device *dev)
+{
+	struct stm32_dma_device *dmadev = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(dmadev->clk);
+	if (ret) {
+		dev_err(dev, "failed to prepare_enable clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops stm32_dma_pm_ops = {
+	SET_RUNTIME_PM_OPS(stm32_dma_runtime_suspend,
+			   stm32_dma_runtime_resume, NULL)
+};
+
 static struct platform_driver stm32_dma_driver = {
 	.driver = {
 		.name = "stm32-dma",
 		.of_match_table = stm32_dma_of_match,
+		.pm = &stm32_dma_pm_ops,
 	},
 };
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
