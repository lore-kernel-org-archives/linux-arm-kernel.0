Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3059DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 06:39:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7147208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 06:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TaQ54LZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7147208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LnBdiBCPEcrDBdn2M6TddodSZx/RWzDXOC0KOifQa3U=; b=TaQ54LZdKUf2hS
	lAo4FaAWxhWxiiUPjBFUvvSu3YtK9UYvFdaf7dTdzDqvRcYSqChsr8pd2NQZtOQEyl4ZIGJZVtDii
	6ns0waK0sLxGp1lEzDkZ019O8cWU8KSGNx1migsQeTdjOv5sdZaftBVSifKLqvjZX/Ie7HvnCNtWE
	x8anf3dMS9RNv4LgKe2bPyxqNMv/vputDkHWU6JmlnLF0e1wbGKtS33LNSW5/1Q3FtOpWeO2bgqhh
	deCFpCkpCy4hYMpI53eJivpbkxTwFXcpz4LbclUQgDzL/EF0kze6kFQ8ENIsGIT3JlW9fBQ6RMdyL
	2C++XiX9w5SKVTTg+loA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gclnc-000432-Bt; Fri, 28 Dec 2018 06:39:12 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gclnP-0003rw-RZ
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 06:39:01 +0000
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id B130931B40F1A;
 Fri, 28 Dec 2018 14:38:46 +0800 (CST)
Received: from SIA1000080854.huawei.com (10.180.101.187) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Fri, 28 Dec 2018 14:38:42 +0800
From: h00249924 <hutenghui@huawei.com>
To: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/3] dmaengine: Extend the k3dma driver binding
Date: Fri, 28 Dec 2018 14:36:22 +0800
Message-ID: <1545978983-124360-2-git-send-email-hutenghui@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545978983-124360-1-git-send-email-hutenghui@huawei.com>
References: <1545978983-124360-1-git-send-email-hutenghui@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.101.187]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_223900_062469_D2B34852 
X-CRM114-Status: GOOD (  10.68  )
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
 Youlin Wang <wwx575822@notesmail.huawei.com>, hanxiaolong3@hisilicon.com,
 suzhuangluan@hisilicon.com, hantanglei@huawei.com, kongfei@hisilicon.com,
 ninggaoyu@hisilicon.com, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, liyuequan@hisilicon.com,
 huangli295@hisilicon.com, wangyoulin1@hisilicon.com, cash.qianli@hisilicon.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Youlin Wang <wwx575822@notesmail.huawei.com>

Extend the k3dma driver binding to support hisi-asp hardware variants.

Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
Signed-off-by: Tanglei Han <hantanglei@huawei.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/devicetree/bindings/dma/k3dma.txt | 33 ++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/k3dma.txt b/Documentation/devicetree/bindings/dma/k3dma.txt
index 4945aea..cd21b82 100644
--- a/Documentation/devicetree/bindings/dma/k3dma.txt
+++ b/Documentation/devicetree/bindings/dma/k3dma.txt
@@ -3,7 +3,9 @@
 See dma.txt first
 
 Required properties:
-- compatible: Should be "hisilicon,k3-dma-1.0"
+- compatible: Must be one of
+-		"hisilicon,k3-dma-1.0"
+-		"hisilicon,hisi-pcm-asp-dma-1.0"
 - reg: Should contain DMA registers location and length.
 - interrupts: Should contain one interrupt shared by all channel
 - #dma-cells: see dma.txt, should be 1, para number
@@ -43,3 +45,32 @@ For example, i2c0 read channel request line is 18, while write channel use 19
 			dma-names = "rx", "tx";
 		};
 
+
+
+
+Controller:
+		asp_dmac: asp_dmac@E804B000 {
+			compatible = "hisilicon,hisi-pcm-asp-dma-1.0";
+			reg = <0x0 0xe804b000 0x0 0x1000>;
+			#dma-cells = <1>;
+			dma-channels = <16>;
+			dma-requests = <32>;
+			dma-min-chan = <0>;
+			dma-used-chans = <0xFFFE>;
+			dma-share;
+			interrupts = <0 216 4>;
+			interrupt-names = "asp_dma_irq";
+			status = "ok";
+		};
+
+Client:
+		i2s2: hisi_i2s {
+			compatible = "hisilicon,hisi-i2s";
+			reg = <0x0 0xe804f800 0x0 0x400>,
+				<0x0 0xe804e000 0x0 0x400>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2s2_pmx_func &i2s2_cfg_func>;
+			dmas = <&asp_dmac 18 &asp_dmac 19>;
+			dma-names = "rx", "tx";
+			#sound-dai-cells = <0>;
+		};
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
