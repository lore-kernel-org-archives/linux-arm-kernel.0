Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701B9C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:22:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EF5B21721
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c2tTf3JY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L3KhXxkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF5B21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=cHIu5xw14qHI6HdpMIR/2QnAmMt0qZcmxkX4gIwO3MU=; b=c2tTf3JYugYCxZOA22Q1/FZqMd
	Q1K5Lag+SC4UfsN64oxi92FTCvgWvquqOnPBrhGBCr1fBV1QA+jBGDDyoSNRa8yWq6c7bOWfZJZ5P
	3iPU/Hn38KBjqppK4m1OHNDy+gvtM0RHerZ7GEs4ekpFKvbuHnEnTAS4fyTB8jYgGGYGrcnqu1ny5
	MLDZxwT4/XnrEr9fKuqNprOW71ndbSMcgtU8A8kojUWpxO+I7TDoDqotAaZuk/3spxuzfgVzggDhP
	HSpdpmoLFe3xIgSz7G8MXEMuF44wVwsJGu7yFwnZvKb0hjawmI4i/gT1wOUV2oXg87pCyodomE7Ij
	nvdm8rQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glw0C-0003dj-Oj; Tue, 22 Jan 2019 13:22:04 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glvzw-0003Ns-AU
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 13:21:53 +0000
Received: by mail-pf1-x441.google.com with SMTP id i12so11762009pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 05:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :in-reply-to:references;
 bh=aThP/Y0UG/Bg6pZXhNtucLsiLRzzJRNdslnI1cWQFgk=;
 b=L3KhXxkKfjsH+L/BnnSqvkjQnyke/EFblv6Xj9LR5HpaDYCG2SW+L1rZPux21lQZOy
 6QlGOs3Fk+PCVOn136Z1R+D+jrRAPLWxAxVmDq5npItzATHgmUGDTEYJ19DG8oRODYc7
 elvbX1t+aPoMNLPjK3juuGj4wpVIYB0zb/f+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:in-reply-to:references;
 bh=aThP/Y0UG/Bg6pZXhNtucLsiLRzzJRNdslnI1cWQFgk=;
 b=UmPVno7ehj+0viF2CeQL7wf9UM8TCK/MBHPr9rmnU7npkUJsp25EbHhDMrVfNd8T0M
 pSMgbJ/RC1ImW9Ud306MubR8kZGv0kvqm7dTUkV7y0FMDQt1qhVZo4nRjvCqM6kbYkaY
 Emx31pAUAoLOaHOasxEsz6CjHmZ2Fo6sCFgy18Q0DeUWYAof36KewfJKpxxIv/HOldW5
 t9ymSNIxDyaBEvwu61dfmQLqxrZvNbE9c+dkrbsKSEQjD2fxC2ORgwb4x+Kq3oMbyNGR
 YwctgXteIoDWAg6WdYwf0x3Z4sJUyZTykt9VA8oWOXXnxRTPk6ihrIFMKhpU8pqQvlHh
 aASw==
X-Gm-Message-State: AJcUukfEDw3+nfQJGjHJ0d/gnauswsjweZQiVWYXElcEoFbYbZ0glfCC
 A2CflBfRUi0t7k/OEZr3i8eZQw==
X-Google-Smtp-Source: ALg8bN7IMe1xG7oWLmt59zeewvS276awFJgI0jA50yMh6opTTidFaX//dX+l9hYA9ckDUMNYQQUSgg==
X-Received: by 2002:a62:35c7:: with SMTP id c190mr34406112pfa.76.1548163307648; 
 Tue, 22 Jan 2019 05:21:47 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
 by smtp.gmail.com with ESMTPSA id l185sm21609574pfl.54.2019.01.22.05.21.42
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 22 Jan 2019 05:21:46 -0800 (PST)
From: Baolin Wang <baolin.wang@linaro.org>
To: vkoul@kernel.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com
Subject: [PATCH 2/3] dmaengine: sprd: Add new DMA engine translation function
Date: Tue, 22 Jan 2019 21:20:52 +0800
Message-Id: <529bc30b34a14bf7849fc852c7cbff34dee47aaa.1548158832.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
References: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
In-Reply-To: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
References: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_052148_981414_6D8E790A 
X-CRM114-Status: GOOD (  13.82  )
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
Cc: devicetree@vger.kernel.org, eric.long@unisoc.com, arnd@arndb.de,
 baolin.wang@linaro.org, zhang.lyra@gmail.com, broonie@kernel.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, arm@kernel.org,
 olof@lixom.net, orsonzhai@gmail.com, dan.j.williams@intel.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add new DMA engine translation function to get the hardware slave id
of the corresponding DMA engine channel. Meanwhile we do not need
to set default slave id in sprd_dma_alloc_chan_resources(), remove it.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |   49 ++++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index e2f0167..7d180bb 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -204,9 +204,9 @@ struct sprd_dma_dev {
 	struct sprd_dma_chn	channels[0];
 };
 
-static bool sprd_dma_filter_fn(struct dma_chan *chan, void *param);
-static struct of_dma_filter_info sprd_dma_info = {
-	.filter_fn = sprd_dma_filter_fn,
+struct sprd_dma_filter_param {
+	u32 chn_id;
+	u32 slave_id;
 };
 
 static inline struct sprd_dma_chn *to_sprd_dma_chan(struct dma_chan *c)
@@ -580,15 +580,7 @@ static irqreturn_t dma_irq_handle(int irq, void *dev_id)
 
 static int sprd_dma_alloc_chan_resources(struct dma_chan *chan)
 {
-	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
-	int ret;
-
-	ret = pm_runtime_get_sync(chan->device->dev);
-	if (ret < 0)
-		return ret;
-
-	schan->dev_id = SPRD_DMA_SOFTWARE_UID;
-	return 0;
+	return pm_runtime_get_sync(chan->device->dev);
 }
 
 static void sprd_dma_free_chan_resources(struct dma_chan *chan)
@@ -1022,12 +1014,31 @@ static bool sprd_dma_filter_fn(struct dma_chan *chan, void *param)
 {
 	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
 	struct sprd_dma_dev *sdev = to_sprd_dma_dev(&schan->vc.chan);
-	u32 req = *(u32 *)param;
+	struct sprd_dma_filter_param *sparam = param;
 
-	if (req < sdev->total_chns)
-		return req == schan->chn_num + 1;
-	else
-		return false;
+	if (sparam->chn_id < sdev->total_chns &&
+	    sparam->chn_id == schan->chn_num + 1) {
+		schan->dev_id = sparam->slave_id;
+		return true;
+	}
+
+	return false;
+}
+
+static struct dma_chan *sprd_dma_xlate(struct of_phandle_args *dma_spec,
+				       struct of_dma *ofdma)
+{
+	struct sprd_dma_dev *sdev = ofdma->of_dma_data;
+	dma_cap_mask_t mask = sdev->dma_dev.cap_mask;
+	struct sprd_dma_filter_param param;
+
+	if (dma_spec->args_count != 2)
+		return NULL;
+
+	param.chn_id = dma_spec->args[0];
+	param.slave_id = dma_spec->args[1];
+
+	return dma_request_channel(mask, sprd_dma_filter_fn, &param);
 }
 
 static int sprd_dma_probe(struct platform_device *pdev)
@@ -1133,9 +1144,7 @@ static int sprd_dma_probe(struct platform_device *pdev)
 		goto err_register;
 	}
 
-	sprd_dma_info.dma_cap = sdev->dma_dev.cap_mask;
-	ret = of_dma_controller_register(np, of_dma_simple_xlate,
-					 &sprd_dma_info);
+	ret = of_dma_controller_register(np, sprd_dma_xlate, sdev);
 	if (ret)
 		goto err_of_register;
 
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
