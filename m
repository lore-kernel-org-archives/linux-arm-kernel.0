Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDCFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:51:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A7C7217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XDFpWTo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7C7217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wJrH5HQVPmGmizbENNxJncC1nWQu1db3qiZZO9NHp40=; b=XDFpWTo4Aw3eLf
	u0lVUYrW+mfSM/1PJCDyJe7nUZkzaE7y7qDoMRcFUuw3UTN4P3/mhjOB+NXN7qGEDZLnol5QxtXPZ
	jjrNh9fYxDn1ky4zCWbbRzj3UAmXFYh8OKZVuR4VE2yqcwl19XIfJ8AITsn05HEhZK9XWdn3W7G3K
	CB92GEUCnQ5ZjpNxjXlmGEObYGXUwjiy95KhGZ9M2Hxqpv6RrpIr8Kaf0So8um5QlMU5RliN3WXOJ
	bF0Lky+Z7gkJbf4xrypRhDFDSkvjcd3j78hwjmG7l0bhJQphXtXEmCkKrA69f8HQPpApTrqmvVCES
	QWMoaKAls2QsFE4jDo2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvMqq-000475-Nv; Sun, 17 Feb 2019 13:51:24 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvMqe-0003te-4S; Sun, 17 Feb 2019 13:51:13 +0000
X-UUID: cfab4d0ac0784ac88afbc68b3fb05217-20190217
X-UUID: cfab4d0ac0784ac88afbc68b3fb05217-20190217
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <ryder.lee@kernel.org>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1719824355; Sun, 17 Feb 2019 05:51:07 -0800
Received: from MTKMBS01N2.mediatek.inc (172.21.101.79) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 17 Feb 2019 05:51:06 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 17 Feb 2019 21:50:52 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Sun, 17 Feb 2019 21:50:52 +0800
From: Ryder Lee <ryder.lee@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 3/3] dt-bindings: timer: mediatek: update bindings for MT7629
 SoC
Date: Sun, 17 Feb 2019 21:50:32 +0800
Message-ID: <b145be98c1bfa71d0b9609b80c20c37177f45d6a.1550233614.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <56a2c38c9efa41be940858e19501fe07fbd5120e.1550233614.git.ryder.lee@mediatek.com>
References: <56a2c38c9efa41be940858e19501fe07fbd5120e.1550233614.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 6C65F80851D20DB026668A1521030E6F68102B7026BA75ABE6D6326EE67303692000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_055112_187249_F93C1868 
X-CRM114-Status: UNSURE (   9.45  )
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
Cc: devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Sean Wang <sean.wang@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Ryder Lee <ryder.lee@mediatek.com>

Update the binding for MT7629 SoC, which uses fallback compatible to
MT6765 SYST, so add more descriptions to distinguish it from the other
SoCs that use GPT.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../devicetree/bindings/timer/mediatek,mtk-timer.txt          | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
index 18d4d01..ff7c567 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
@@ -1,7 +1,7 @@
-Mediatek Timers
+MediaTek Timers
 ---------------
 
-Mediatek SoCs have two different timers on different platforms,
+MediaTek SoCs have two different timers on different platforms,
 - GPT (General Purpose Timer)
 - SYST (System Timer)
 
@@ -9,6 +9,7 @@ The proper timer will be selected automatically by driver.
 
 Required properties:
 - compatible should contain:
+	For those SoCs that use GPT
 	* "mediatek,mt2701-timer" for MT2701 compatible timers (GPT)
 	* "mediatek,mt6580-timer" for MT6580 compatible timers (GPT)
 	* "mediatek,mt6589-timer" for MT6589 compatible timers (GPT)
@@ -17,7 +18,11 @@ Required properties:
 	* "mediatek,mt8135-timer" for MT8135 compatible timers (GPT)
 	* "mediatek,mt8173-timer" for MT8173 compatible timers (GPT)
 	* "mediatek,mt6577-timer" for MT6577 and all above compatible timers (GPT)
-	* "mediatek,mt6765-timer" for MT6765 compatible timers (SYST)
+
+	For those SoCs that use SYST
+	* "mediatek,mt7629-timer" for MT7629 compatible timers (SYST)
+	* "mediatek,mt6765-timer" for MT6765 and all above compatible timers (SYST)
+
 - reg: Should contain location and length for timer register.
 - clocks: Should contain system clock.
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
