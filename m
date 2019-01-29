Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB873C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:33:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACF6E217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iYQrWyeQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF6E217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4yLz6TLcTf1OIAlAboaJbJL9h0w15H0N36mU6YEUIhI=; b=iYQrWyeQB7jBdu
	zT+LWwbelyhd6a7IF2rHHgagep69oH2wJaQtCG5oP5HYFTfr0o9IMYX5L8Fx7ZnDsnRVvFb5SJsI6
	KpQ6JWILIggQK8fHxitj7TGfO3eaAW6WmfzA/+ynxGksCKTRElJVpykwZMP9a1m4K5m70z8YulF3V
	p5i6KislgMv/dhuup8+Al9nb/GJ+t1VNpXtNpNk233AT1VwK4SOAwIZeS9WNm0L/gBceRDFFZY2zv
	Fpli/qxbWyF1WGwJNTJONmlMo2iMFT/X/t7oZvxKqofqI2KhFKzjRw/NJqBAqNpiRkEB7ImrC4t9x
	WyBUoMXyH+Ny1y6F91zg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goNtf-0005VM-M7; Tue, 29 Jan 2019 07:33:27 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goNse-0004NM-1A; Tue, 29 Jan 2019 07:32:29 +0000
X-UUID: 765382441042406581a29751ae01569a-20190128
X-UUID: 765382441042406581a29751ae01569a-20190128
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <bibby.hsieh@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1345206750; Mon, 28 Jan 2019 23:32:15 -0800
Received: from mtkmbs08n2.mediatek.inc (172.21.101.56) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 28 Jan 2019 23:32:14 -0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 29 Jan 2019 15:32:12 +0800
Received: from mtkslt302.mediatek.inc (10.21.14.115) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Tue, 29 Jan 2019 15:32:12 +0800
From: Bibby Hsieh <bibby.hsieh@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, CK HU
 <ck.hu@mediatek.com>
Subject: [PATCH 07/10] soc: mediatek: add cmdq_dev_get_event function
Date: Tue, 29 Jan 2019 15:32:04 +0800
Message-ID: <1548747128-60136-8-git-send-email-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548747128-60136-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1548747128-60136-1-git-send-email-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 4CE45F2FC5B550B8AC8860B88ABAAB76010FFFB65353564D761C9F06C5D9EEAB2000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_233224_567328_71E8D443 
X-CRM114-Status: GOOD (  10.55  )
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
Cc: devicetree@vger.kernel.org, Nicolas Boichat <drinkcat@chromium.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, srv_heupstream@mediatek.com,
 Daoyuan Huang <daoyuan.huang@mediatek.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 Daniel Kurtz <djkurtz@chromium.org>,
 Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>, kendrick.hsu@mediatek.com,
 linux-mediatek@lists.infradead.org, Houlong Wei <houlong.wei@mediatek.com>,
 Sascha
 Hauer <kernel@pengutronix.de>, Frederic Chen <Frederic.Chen@mediatek.com>,
 YT Shen <yt.shen@mediatek.com>, Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
 Bibby Hsieh <bibby.hsieh@mediatek.com>, linux-arm-kernel@lists.infradead.org,
 ginny.chen@mediatek.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When client ask gce to clear or wait for event,
client need to pass event number to the API.
We suggest client store the event information in device node,
so we provide an API for client parse the event property.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 29 +++++++++++++++++++++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h  |  1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 6ad997f..16c0393 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -56,6 +56,35 @@ struct cmdq_base *cmdq_register_device(struct device *dev)
 }
 EXPORT_SYMBOL(cmdq_register_device);
 
+s32 cmdq_dev_get_event(struct device *dev, const char *name)
+{
+	s32 index = 0;
+	struct of_phandle_args spec;
+	s32 result;
+
+	if (!dev)
+		return -EINVAL;
+
+	index = of_property_match_string(dev->of_node, "gce-event-names", name);
+	if (index < 0) {
+		dev_err(dev, "no gce-event-names property or no such event:%s",
+			name);
+		return index;
+	}
+
+	if (of_parse_phandle_with_args(dev->of_node, "gce-events",
+	    "#gce-event-cells", index, &spec)) {
+		dev_err(dev, "can't parse gce-events property");
+		return -ENODEV;
+	}
+
+	result = spec.args[0];
+	of_node_put(spec.np);
+
+	return result;
+}
+EXPORT_SYMBOL(cmdq_dev_get_event);
+
 static void cmdq_client_timeout(struct timer_list *t)
 {
 	struct cmdq_client *client = from_timer(client, t, timer);
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index a1f5eb6..e5b0a98 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -139,5 +139,6 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
 
 u8 cmdq_subsys_base_to_id(struct cmdq_base *clt_base, u32 base);
 struct cmdq_base *cmdq_register_device(struct device *dev);
+s32 cmdq_dev_get_event(struct device *dev, const char *name);
 
 #endif	/* __MTK_CMDQ_H__ */
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
