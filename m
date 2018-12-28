Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FC6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 06:39:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88EBE208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 06:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TKtinaRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EBE208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Siy+YWj+061bvFNJwcSBrgQm2HPwrqopFINrgtnPDLY=; b=TKtinaRgfA87bb
	UvYv7RLcPtadrfF2T9w0PCf6dW+cAv1sKzGD9AO2L/8/tQ9l0KX5XGjwDh5X/atzuEbefPoqJ/QGl
	E/OWDbFEihrm7fz87yKZnqVFYfzRwm7PIPnUnpP08+d9ET751EQLDVuM5kPTe+F2hKyVwcZfplAXi
	GT+niw0yFJZRSO+xJSuQZcKK0TCEITW5/dtVkNvPW58ZnnlL6jn03NjFFbQXvogWHnrxgoKgPkyCz
	mDrle3LjloPgo3k4laRmASC7rQcJEMyko7+nvrUKSntBt2eHiEwA81I4JkvOhfXwzrkj4t5TLCKKK
	01YPOZ/eCnbWMPO74KLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gclo2-0004OR-3y; Fri, 28 Dec 2018 06:39:38 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gclnZ-0003sm-2v
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 06:39:11 +0000
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 1A58232C6733B;
 Fri, 28 Dec 2018 14:38:52 +0800 (CST)
Received: from SIA1000080854.huawei.com (10.180.101.187) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Fri, 28 Dec 2018 14:38:43 +0800
From: h00249924 <hutenghui@huawei.com>
To: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 3/3] arm64: dts: hi3660: Add hisi asp dma device
Date: Fri, 28 Dec 2018 14:36:23 +0800
Message-ID: <1545978983-124360-3-git-send-email-hutenghui@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545978983-124360-1-git-send-email-hutenghui@huawei.com>
References: <1545978983-124360-1-git-send-email-hutenghui@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.101.187]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_223909_710345_B505B53B 
X-CRM114-Status: UNSURE (   9.02  )
X-CRM114-Notice: Please train this message.
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
 Wei Xu <xuwei5@hisilicon.com>, ninggaoyu@hisilicon.com, Rob
 Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>,
 liyuequan@hisilicon.com, huangli295@hisilicon.com, wangyoulin1@hisilicon.com,
 cash.qianli@hisilicon.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Youlin Wang <wwx575822@notesmail.huawei.com>

Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
Signed-off-by: Tanglei Han <hantanglei@huawei.com>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index f432b0a..5223e36 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -1122,5 +1122,19 @@
 				};
 			};
 		};
+
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
 	};
 };
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
