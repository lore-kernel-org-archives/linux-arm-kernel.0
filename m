Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC48AC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:10:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EBC9218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MuMvRAm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBC9218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k03KSHADyO4rd0ngL5cHVPDP4yf1uyvSLFan6y/mmjM=; b=MuMvRAm+pRgGtM
	HEtBeEhgJYetA3NOB3ZWKOXcwvSQxkCaM6pD+NniRIOh1MxOveYvsK0vS5uVU5/7h9nQn6cWcv6E4
	inN7v0Fg8nwbFL997qB1pezq1jTWOXwsdNNXxxZnmNIMREcxKxLrJCcSYbw4eD2zPa3HERsgdvtOB
	l6z2xefob/hhiTM+QW3Qji7SbUwQ3b7U2diuDeOKZOdK2RD6mZjrIY23SlfPpFtlRVM+DMVEEoLxQ
	ANvz5ver+9HJnO3Nauf0lji5AZBVb3kZWqX1xUmVMw+JZ4MwtTCVOwsAj4VNnCdjL/TZvEsLTGBDN
	yyi0GzOdtbiPrlLu8qyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gehE9-00062p-Qa; Wed, 02 Jan 2019 14:10:33 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gehE5-0005qs-Pe; Wed, 02 Jan 2019 14:10:31 +0000
X-UUID: 1a4ee7767611403c97f3b65c52a2538e-20190102
X-UUID: 1a4ee7767611403c97f3b65c52a2538e-20190102
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by
 mailgw01.mediatek.com (envelope-from <henryc.chen@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1324295749; Wed, 02 Jan 2019 22:10:27 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 2 Jan 2019 22:10:26 +0800
Received: from mtkslt205.mediatek.inc (10.21.15.75) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 2 Jan 2019 22:10:27 +0800
From: Henry Chen <henryc.chen@mediatek.com>
To: Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Ulf
 Hansson <ulf.hansson@linaro.org>
Subject: [RFC RESEND PATCH 5/7] soc: mediatek: add header for mediatek SIP
 interface
Date: Wed, 2 Jan 2019 22:09:56 +0800
Message-ID: <1546438198-1677-6-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_061030_016901_B856A482 
X-CRM114-Status: GOOD (  12.06  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>,
 Kees Cook <keescook@chromium.org>, Weiyi Lu <weiyi.lu@mediatek.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Henry Chen <henryc.chen@mediatek.com>, Fan Chen <fan.chen@mediatek.com>,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a header to collect SIPs and add one SIP call to initialize power
management hardware for the SIP interface defined to access the SPM
handling vcore voltage and ddr rate changes on mt8183 (and most likely
later socs).

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 include/soc/mediatek/mtk_sip.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 include/soc/mediatek/mtk_sip.h

diff --git a/include/soc/mediatek/mtk_sip.h b/include/soc/mediatek/mtk_sip.h
new file mode 100644
index 0000000..5394ff4
--- /dev/null
+++ b/include/soc/mediatek/mtk_sip.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2018 MediaTek Inc.
+ */
+#ifndef __SOC_MTK_SIP_H
+#define __SOC_MTK_SIP_H
+
+#ifdef CONFIG_ARM64
+#define MTK_SIP_SMC_AARCH_BIT		0x40000000
+#else
+#define MTK_SIP_SMC_AARCH_BIT		0x00000000
+#endif
+
+#define MTK_SIP_SPM			(0x82000220 | MTK_SIP_SMC_AARCH_BIT)
+#define MTK_SIP_SPM_DVFSRC_INIT		0x00
+
+#endif
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
