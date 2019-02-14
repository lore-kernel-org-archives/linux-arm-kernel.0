Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5249C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:25:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70FB5222D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uFWAOnLM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FB5222D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wZDUAv1YPdfJeAZMbzOvFn4AxZTz4rLKwYSCj/xc6EU=; b=uFWAOnLMjxA9d2
	MkD7lZFAZN3LiJ6HHmBRbM/ViwNstSSRuZqYfytbOyHxgqV5ppVWlM5eW/lXXFlYNnqP3R01PORyY
	jOFmhHmOnfq5aqvCmazgB9SvkGtANKp/Xydv7ARDNbC9b6G4XjQwBs7y6G3paa9sQhB+txH2m0p9I
	XvPxvLkqvl/ak4WT0z5WGpPAnioqyuau2/6vn7UJqETnEMF1vkZSJHuSY2iFH4W654cVWCfzIh9ME
	HRZ6sH3OAXO0Oh/f2mORVY5NXIBr9mQupxTmV8gyoBwUMtZoA6mx19rbc3vlli6Zq5Uz5ProAcZ9g
	4NhDfd/S4kEmxwW1oYkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu6iL-0007sM-80; Thu, 14 Feb 2019 02:25:25 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu6i3-0006Ys-Vm; Thu, 14 Feb 2019 02:25:09 +0000
X-UUID: a56d1543931843acbb0d3bf03e834cc1-20190213
X-UUID: a56d1543931843acbb0d3bf03e834cc1-20190213
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <yunfei.dong@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1643038233; Wed, 13 Feb 2019 18:25:00 -0800
Received: from mtkmbs08n1.mediatek.inc (172.21.101.55) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 13 Feb 2019 18:24:58 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 14 Feb 2019 10:24:57 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 14 Feb 2019 10:24:56 +0800
From: Yunfei Dong <yunfei.dong@mediatek.com>
To: Hans Verkuil <hverkuil@xs4all.nl>, Tiffany Lin <tiffany.lin@mediatek.com>, 
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>, Rob Herring
 <robh+dt@kernel.org>
Subject: [RESEND PATCH v4,
 3/3] media: mtk-vcodec: Using common interface to manage vdec/venc
 clock
Date: Thu, 14 Feb 2019 10:24:53 +0800
Message-ID: <1550111093-7057-3-git-send-email-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1550111093-7057-1-git-send-email-yunfei.dong@mediatek.com>
References: <1550111093-7057-1-git-send-email-yunfei.dong@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_182508_048262_62EF6B4B 
X-CRM114-Status: GOOD (  15.40  )
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
 Yunfei Dong <yunfei.dong@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Qianqian Yan <qianqian.yan@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Vdec: Using standard CCF interface to set parent clock and
clock rate in dtsi and using common interface to open/close
video decoder clock.
Venc: Using standard CCF interface to set parent clock in dtsi
and using common interface to open/close video encoder clock.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Signed-off-by: Qianqian Yan <qianqian.yan@mediatek.com>
---
 .../media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c  |  163 +++++++-------------
 drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h |   31 ++--
 .../media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c  |  104 +++++++------
 3 files changed, 132 insertions(+), 166 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
index 79ca03a..7884465 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
@@ -27,11 +27,14 @@ int mtk_vcodec_init_dec_pm(struct mtk_vcodec_dev *mtkdev)
 	struct device_node *node;
 	struct platform_device *pdev;
 	struct mtk_vcodec_pm *pm;
-	int ret = 0;
+	struct mtk_vcodec_clk *dec_clk;
+	struct mtk_vcodec_clk_info *clk_info;
+	int i = 0, ret = 0;
 
 	pdev = mtkdev->plat_dev;
 	pm = &mtkdev->pm;
 	pm->mtkdev = mtkdev;
+	dec_clk = &pm->vdec_clk;
 	node = of_parse_phandle(pdev->dev.of_node, "mediatek,larb", 0);
 	if (!node) {
 		mtk_v4l2_err("of_parse_phandle mediatek,larb fail!");
@@ -47,52 +50,34 @@ int mtk_vcodec_init_dec_pm(struct mtk_vcodec_dev *mtkdev)
 	pdev = mtkdev->plat_dev;
 	pm->dev = &pdev->dev;
 
-	pm->vcodecpll = devm_clk_get(&pdev->dev, "vcodecpll");
-	if (IS_ERR(pm->vcodecpll)) {
-		mtk_v4l2_err("devm_clk_get vcodecpll fail");
-		ret = PTR_ERR(pm->vcodecpll);
+	dec_clk->clk_num =
+		of_property_count_strings(pdev->dev.of_node, "clock-names");
+	if (dec_clk->clk_num > 0) {
+		dec_clk->clk_info = devm_kcalloc(&pdev->dev,
+			dec_clk->clk_num, sizeof(*clk_info),
+			GFP_KERNEL);
+		if (!dec_clk->clk_info)
+			return -ENOMEM;
+	} else {
+		mtk_v4l2_err("Failed to get vdec clock count");
+		return -EINVAL;
 	}
 
-	pm->univpll_d2 = devm_clk_get(&pdev->dev, "univpll_d2");
-	if (IS_ERR(pm->univpll_d2)) {
-		mtk_v4l2_err("devm_clk_get univpll_d2 fail");
-		ret = PTR_ERR(pm->univpll_d2);
-	}
-
-	pm->clk_cci400_sel = devm_clk_get(&pdev->dev, "clk_cci400_sel");
-	if (IS_ERR(pm->clk_cci400_sel)) {
-		mtk_v4l2_err("devm_clk_get clk_cci400_sel fail");
-		ret = PTR_ERR(pm->clk_cci400_sel);
-	}
-
-	pm->vdec_sel = devm_clk_get(&pdev->dev, "vdec_sel");
-	if (IS_ERR(pm->vdec_sel)) {
-		mtk_v4l2_err("devm_clk_get vdec_sel fail");
-		ret = PTR_ERR(pm->vdec_sel);
-	}
-
-	pm->vdecpll = devm_clk_get(&pdev->dev, "vdecpll");
-	if (IS_ERR(pm->vdecpll)) {
-		mtk_v4l2_err("devm_clk_get vdecpll fail");
-		ret = PTR_ERR(pm->vdecpll);
-	}
-
-	pm->vencpll = devm_clk_get(&pdev->dev, "vencpll");
-	if (IS_ERR(pm->vencpll)) {
-		mtk_v4l2_err("devm_clk_get vencpll fail");
-		ret = PTR_ERR(pm->vencpll);
-	}
-
-	pm->venc_lt_sel = devm_clk_get(&pdev->dev, "venc_lt_sel");
-	if (IS_ERR(pm->venc_lt_sel)) {
-		mtk_v4l2_err("devm_clk_get venc_lt_sel fail");
-		ret = PTR_ERR(pm->venc_lt_sel);
-	}
-
-	pm->vdec_bus_clk_src = devm_clk_get(&pdev->dev, "vdec_bus_clk_src");
-	if (IS_ERR(pm->vdec_bus_clk_src)) {
-		mtk_v4l2_err("devm_clk_get vdec_bus_clk_src");
-		ret = PTR_ERR(pm->vdec_bus_clk_src);
+	for (i = 0; i < dec_clk->clk_num; i++) {
+		clk_info = &dec_clk->clk_info[i];
+		ret = of_property_read_string_index(pdev->dev.of_node,
+			"clock-names", i, &clk_info->clk_name);
+		if (ret) {
+			mtk_v4l2_err("Failed to get clock name id = %d", i);
+			return ret;
+		}
+		clk_info->vcodec_clk = devm_clk_get(&pdev->dev,
+			clk_info->clk_name);
+		if (IS_ERR(clk_info->vcodec_clk)) {
+			mtk_v4l2_err("devm_clk_get (%d)%s fail", i,
+				clk_info->clk_name);
+			return PTR_ERR(clk_info->vcodec_clk);
+		}
 	}
 
 	pm_runtime_enable(&pdev->dev);
@@ -125,78 +110,36 @@ void mtk_vcodec_dec_pw_off(struct mtk_vcodec_pm *pm)
 
 void mtk_vcodec_dec_clock_on(struct mtk_vcodec_pm *pm)
 {
-	int ret;
-
-	ret = clk_set_rate(pm->vcodecpll, 1482 * 1000000);
-	if (ret)
-		mtk_v4l2_err("clk_set_rate vcodecpll fail %d", ret);
-
-	ret = clk_set_rate(pm->vencpll, 800 * 1000000);
-	if (ret)
-		mtk_v4l2_err("clk_set_rate vencpll fail %d", ret);
-
-	ret = clk_prepare_enable(pm->vcodecpll);
-	if (ret)
-		mtk_v4l2_err("clk_prepare_enable vcodecpll fail %d", ret);
-
-	ret = clk_prepare_enable(pm->vencpll);
-	if (ret)
-		mtk_v4l2_err("clk_prepare_enable vencpll fail %d", ret);
-
-	ret = clk_prepare_enable(pm->vdec_bus_clk_src);
-	if (ret)
-		mtk_v4l2_err("clk_prepare_enable vdec_bus_clk_src fail %d",
-				ret);
-
-	ret = clk_prepare_enable(pm->venc_lt_sel);
-	if (ret)
-		mtk_v4l2_err("clk_prepare_enable venc_lt_sel fail %d", ret);
-
-	ret = clk_set_parent(pm->venc_lt_sel, pm->vdec_bus_clk_src);
-	if (ret)
-		mtk_v4l2_err("clk_set_parent venc_lt_sel vdec_bus_clk_src fail %d",
-				ret);
-
-	ret = clk_prepare_enable(pm->univpll_d2);
-	if (ret)
-		mtk_v4l2_err("clk_prepare_enable univpll_d2 fail %d", ret);
-
-	ret = clk_prepare_enable(pm->clk_cci400_sel);
-	if (ret)
-		mtk_v4l2_err("clk_prepare_enable clk_cci400_sel fail %d", ret);
-
-	ret = clk_set_parent(pm->clk_cci400_sel, pm->univpll_d2);
-	if (ret)
-		mtk_v4l2_err("clk_set_parent clk_cci400_sel univpll_d2 fail %d",
-				ret);
-
-	ret = clk_prepare_enable(pm->vdecpll);
-	if (ret)
-		mtk_v4l2_err("clk_prepare_enable vdecpll fail %d", ret);
-
-	ret = clk_prepare_enable(pm->vdec_sel);
-	if (ret)
-		mtk_v4l2_err("clk_prepare_enable vdec_sel fail %d", ret);
-
-	ret = clk_set_parent(pm->vdec_sel, pm->vdecpll);
-	if (ret)
-		mtk_v4l2_err("clk_set_parent vdec_sel vdecpll fail %d", ret);
+	struct mtk_vcodec_clk *dec_clk = &pm->vdec_clk;
+	int ret, i = 0;
+
+	for (i = 0; i < dec_clk->clk_num; i++) {
+		ret = clk_prepare_enable(dec_clk->clk_info[i].vcodec_clk);
+		if (ret) {
+			mtk_v4l2_err("clk_prepare_enable %d %s fail %d", i,
+				dec_clk->clk_info[i].clk_name, ret);
+			goto error;
+		}
+	}
 
 	ret = mtk_smi_larb_get(pm->larbvdec);
-	if (ret)
+	if (ret) {
 		mtk_v4l2_err("mtk_smi_larb_get larbvdec fail %d", ret);
+		goto error;
+	}
+	return;
 
+error:
+	for (i -= 1; i >= 0; i--)
+		clk_disable_unprepare(dec_clk->clk_info[i].vcodec_clk);
 }
 
 void mtk_vcodec_dec_clock_off(struct mtk_vcodec_pm *pm)
 {
+	struct mtk_vcodec_clk *dec_clk = &pm->vdec_clk;
+	int i = 0;
+
 	mtk_smi_larb_put(pm->larbvdec);
-	clk_disable_unprepare(pm->vdec_sel);
-	clk_disable_unprepare(pm->vdecpll);
-	clk_disable_unprepare(pm->univpll_d2);
-	clk_disable_unprepare(pm->clk_cci400_sel);
-	clk_disable_unprepare(pm->venc_lt_sel);
-	clk_disable_unprepare(pm->vdec_bus_clk_src);
-	clk_disable_unprepare(pm->vencpll);
-	clk_disable_unprepare(pm->vcodecpll);
+	for (i = dec_clk->clk_num - 1; i >= 0; i--)
+		clk_disable_unprepare(dec_clk->clk_info[i].vcodec_clk);
 }
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
index 3cffb38..8aba695 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
@@ -176,22 +176,29 @@ struct mtk_enc_params {
 };
 
 /**
+ * struct mtk_vcodec_clk_info - Structure used to store clock name
+ */
+struct mtk_vcodec_clk_info {
+	const char	*clk_name;
+	struct clk	*vcodec_clk;
+};
+
+/**
+ * struct mtk_vcodec_clk - Structure used to store vcodec clock information
+ */
+struct mtk_vcodec_clk {
+	struct mtk_vcodec_clk_info	*clk_info;
+	int	clk_num;
+};
+
+/**
  * struct mtk_vcodec_pm - Power management data structure
  */
 struct mtk_vcodec_pm {
-	struct clk	*vdec_bus_clk_src;
-	struct clk	*vencpll;
-
-	struct clk	*vcodecpll;
-	struct clk	*univpll_d2;
-	struct clk	*clk_cci400_sel;
-	struct clk	*vdecpll;
-	struct clk	*vdec_sel;
-	struct clk	*vencpll_d2;
-	struct clk	*venc_sel;
-	struct clk	*univpll1_d2;
-	struct clk	*venc_lt_sel;
+	struct mtk_vcodec_clk	vdec_clk;
 	struct device	*larbvdec;
+
+	struct mtk_vcodec_clk	venc_clk;
 	struct device	*larbvenc;
 	struct device	*larbvenclt;
 	struct device	*dev;
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
index 7c02504..39375b8 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
@@ -27,9 +27,11 @@ int mtk_vcodec_init_enc_pm(struct mtk_vcodec_dev *mtkdev)
 {
 	struct device_node *node;
 	struct platform_device *pdev;
-	struct device *dev;
 	struct mtk_vcodec_pm *pm;
-	int ret = 0;
+	struct mtk_vcodec_clk *enc_clk;
+	struct mtk_vcodec_clk_info *clk_info;
+	int ret = 0, i = 0;
+	struct device *dev;
 
 	pdev = mtkdev->plat_dev;
 	pm = &mtkdev->pm;
@@ -37,6 +39,7 @@ int mtk_vcodec_init_enc_pm(struct mtk_vcodec_dev *mtkdev)
 	pm->mtkdev = mtkdev;
 	pm->dev = &pdev->dev;
 	dev = &pdev->dev;
+	enc_clk = &pm->venc_clk;
 
 	node = of_parse_phandle(dev->of_node, "mediatek,larb", 0);
 	if (!node) {
@@ -68,28 +71,34 @@ int mtk_vcodec_init_enc_pm(struct mtk_vcodec_dev *mtkdev)
 	pdev = mtkdev->plat_dev;
 	pm->dev = &pdev->dev;
 
-	pm->vencpll_d2 = devm_clk_get(&pdev->dev, "venc_sel_src");
-	if (IS_ERR(pm->vencpll_d2)) {
-		mtk_v4l2_err("devm_clk_get vencpll_d2 fail");
-		ret = PTR_ERR(pm->vencpll_d2);
-	}
-
-	pm->venc_sel = devm_clk_get(&pdev->dev, "venc_sel");
-	if (IS_ERR(pm->venc_sel)) {
-		mtk_v4l2_err("devm_clk_get venc_sel fail");
-		ret = PTR_ERR(pm->venc_sel);
+	enc_clk->clk_num = of_property_count_strings(pdev->dev.of_node,
+		"clock-names");
+	if (enc_clk->clk_num > 0) {
+		enc_clk->clk_info = devm_kcalloc(&pdev->dev,
+			enc_clk->clk_num, sizeof(*clk_info),
+			GFP_KERNEL);
+		if (!enc_clk->clk_info)
+			return -ENOMEM;
+	} else {
+		mtk_v4l2_err("Failed to get venc clock count");
+		return -EINVAL;
 	}
 
-	pm->univpll1_d2 = devm_clk_get(&pdev->dev, "venc_lt_sel_src");
-	if (IS_ERR(pm->univpll1_d2)) {
-		mtk_v4l2_err("devm_clk_get univpll1_d2 fail");
-		ret = PTR_ERR(pm->univpll1_d2);
-	}
-
-	pm->venc_lt_sel = devm_clk_get(&pdev->dev, "venc_lt_sel");
-	if (IS_ERR(pm->venc_lt_sel)) {
-		mtk_v4l2_err("devm_clk_get venc_lt_sel fail");
-		ret = PTR_ERR(pm->venc_lt_sel);
+	for (i = 0; i < enc_clk->clk_num; i++) {
+		clk_info = &enc_clk->clk_info[i];
+		ret = of_property_read_string_index(pdev->dev.of_node,
+			"clock-names", i, &clk_info->clk_name);
+		if (ret) {
+			mtk_v4l2_err("venc failed to get clk name %d", i);
+			return ret;
+		}
+		clk_info->vcodec_clk = devm_clk_get(&pdev->dev,
+			clk_info->clk_name);
+		if (IS_ERR(clk_info->vcodec_clk)) {
+			mtk_v4l2_err("venc devm_clk_get (%d)%s fail", i,
+				clk_info->clk_name);
+			return PTR_ERR(clk_info->vcodec_clk);
+		}
 	}
 
 	return ret;
@@ -102,38 +111,45 @@ void mtk_vcodec_release_enc_pm(struct mtk_vcodec_dev *mtkdev)
 
 void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm)
 {
-	int ret;
-
-	ret = clk_prepare_enable(pm->venc_sel);
-	if (ret)
-		mtk_v4l2_err("clk_prepare_enable fail %d", ret);
-
-	ret = clk_set_parent(pm->venc_sel, pm->vencpll_d2);
-	if (ret)
-		mtk_v4l2_err("clk_set_parent fail %d", ret);
-
-	ret = clk_prepare_enable(pm->venc_lt_sel);
-	if (ret)
-		mtk_v4l2_err("clk_prepare_enable fail %d", ret);
-
-	ret = clk_set_parent(pm->venc_lt_sel, pm->univpll1_d2);
-	if (ret)
-		mtk_v4l2_err("clk_set_parent fail %d", ret);
+	struct mtk_vcodec_clk *enc_clk = &pm->venc_clk;
+	int ret, i = 0;
+
+	for (i = 0; i < enc_clk->clk_num; i++) {
+		ret = clk_prepare_enable(enc_clk->clk_info[i].vcodec_clk);
+		if (ret) {
+			mtk_v4l2_err("venc clk_prepare_enable %d %s fail %d", i,
+				enc_clk->clk_info[i].clk_name, ret);
+			goto clkerr;
+		}
+	}
 
 	ret = mtk_smi_larb_get(pm->larbvenc);
-	if (ret)
+	if (ret) {
 		mtk_v4l2_err("mtk_smi_larb_get larb3 fail %d", ret);
-
+		goto larbvencerr;
+	}
 	ret = mtk_smi_larb_get(pm->larbvenclt);
-	if (ret)
+	if (ret) {
 		mtk_v4l2_err("mtk_smi_larb_get larb4 fail %d", ret);
+		goto larbvenclterr;
+	}
+	return;
 
+larbvenclterr:
+	mtk_smi_larb_put(pm->larbvenc);
+larbvencerr:
+clkerr:
+	for (i -= 1; i >= 0; i--)
+		clk_disable_unprepare(enc_clk->clk_info[i].vcodec_clk);
 }
 
 void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm)
 {
+	struct mtk_vcodec_clk *enc_clk = &pm->venc_clk;
+	int i = 0;
+
 	mtk_smi_larb_put(pm->larbvenc);
 	mtk_smi_larb_put(pm->larbvenclt);
-	clk_disable_unprepare(pm->venc_lt_sel);
-	clk_disable_unprepare(pm->venc_sel);
+	for (i = enc_clk->clk_num - 1; i >= 0; i--)
+		clk_disable_unprepare(enc_clk->clk_info[i].vcodec_clk);
 }
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
