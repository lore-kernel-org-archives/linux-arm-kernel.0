Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46428C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:02:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EE712085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HdjTDFVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE712085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZhjLp2Iqz8zlGjeJdiRM121hn3uTqH7DqcJL6oxkz6A=; b=HdjTDFVbPCK9N8
	tOW90jEugSPpxEIvSawd4MQQ8T1If2jN5ZP+HdUJTZjfg7k7aJWfSbvrVT6C25bYuOVoVVOQeQCVg
	NonsnO06VWwbpQQvCGReAgSzpCCisQUjbPIN2G1Dby5Np4qJn+cpXIN9i+smAcc/mG6PDXs95PVJW
	XfLLmXHysZf2ksD3CsVrzJMKFAY3mVl9A/F9ubJmt5nJQ2YrsQfkZ1bp+uvLHLdqXWuFisW2z1Xj4
	q5/AbyrG3lL23bM4KUk/9CRD/xA+HbpWZDRPP2jFpI++n4HbAv2t+3KLz0JGEb9kvNOfs5nVSV4Uz
	SEpu3xsdg2VznMBe0uxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggNzQ-00065b-OA; Mon, 07 Jan 2019 06:02:20 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggNzN-00064T-Ck
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 06:02:18 +0000
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 4B2012A8CA6177CF9BB8;
 Mon,  7 Jan 2019 14:02:06 +0800 (CST)
Received: from SZX1000457887.localdomain (10.21.56.152) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Mon, 7 Jan 2019 13:53:42 +0800
From: yuqi jin <jinyuqi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] net:hns3:add xps init support
Date: Mon, 7 Jan 2019 13:50:59 +0800
Message-ID: <1546840259-111361-1-git-send-email-jinyuqi@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.21.56.152]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190106_220217_587781_5725898E 
X-CRM114-Status: GOOD (  11.10  )
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
Cc: yuqi jin <jinyuqi@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

XPS settings based on CPU(s) map . we can use __netdev_pick_tx
to select the transmit queue,then we can improve performance

Cc: Yisen Zhuang <yisen.zhuang@huawei.com>
Cc: Salil Mehta <salil.mehta@huawei.com>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: yuqi jin <jinyuqi@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index d3b9aaf..29e2225 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -377,6 +377,30 @@ static int hns3_nic_net_up(struct net_device *netdev)
 	return ret;
 }
 
+static int hns3_config_xps(struct hns3_nic_priv *priv)
+{
+	struct hnae3_handle *h = priv->ae_handle;
+	struct hnae3_knic_private_info *kinfo = &h->kinfo;
+	unsigned int queue_size = kinfo->rss_size * kinfo->num_tc;
+	struct hns3_enet_tqp_vector *tqp_vector;
+	struct hns3_nic_ring_data ring_data;
+	int ret = 0, i;
+
+	for (i = 0; i < queue_size; i++) {
+		ring_data = priv->ring_data[i];
+		tqp_vector = ring_data.ring->tqp_vector;
+		ret = netif_set_xps_queue(kinfo->netdev,
+					  &tqp_vector->affinity_mask,
+					  ring_data.queue_index);
+		if (ret) {
+			netdev_err(kinfo->netdev, "ret %d xps %d\n", ret,
+				   tqp_vector->idx);
+			return ret;
+		}
+	}
+	return ret;
+}
+
 static int hns3_nic_net_open(struct net_device *netdev)
 {
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
@@ -409,6 +433,12 @@ static int hns3_nic_net_open(struct net_device *netdev)
 	if (h->ae_algo->ops->set_timer_task)
 		h->ae_algo->ops->set_timer_task(priv->ae_handle, true);
 
+	ret = hns3_config_xps(priv);
+	if (ret) {
+		netdev_err(netdev,
+			   "hns xps init fail, ret=%d!\n", ret);
+		return ret;
+	}
 	return 0;
 }
 
-- 
1.8.3.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
