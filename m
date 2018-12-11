Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E468DC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:32:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1E1E2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OLm5Nrfa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E1E2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=VnGj2yxNqwhzvMwbHIgTX4c+uGeYePKUAp2R3YpTfBQ=; b=OLm5NrfaK5Zs/L
	ZBbvrlzR9lJ47mVO0J9QymhLJNa29xForGDGk1lwGSIsU/ebZZYlvWsstqmXwxUyNOZ2EXyjbVarZ
	7KQbYufvRY83BZndfWjl036KCPAjvm69VrMsbdaErDNEducDciuhZYWHgc1nwI5XBgrR85pyo47p6
	B//nveTLH7s4bucqvtxmjms9R178oROPt8XqAbbfshtlAGwBN6jqNDi70LO3ndAnVbZ823r0bKEfv
	EupAjZnbw9BkP1DpoOVjMgF2VYgpAPiP+7IyQuJjzmxS/802sjWVIl9BLsSihbFGrdcOBoL60T7sW
	PZ69++Ja+7SD9NlxHoKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWeP8-0004Uc-O4; Tue, 11 Dec 2018 09:32:38 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWeP5-0004Sr-EN; Tue, 11 Dec 2018 09:32:37 +0000
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id E879EACDEF66;
 Tue, 11 Dec 2018 17:32:14 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Tue, 11 Dec 2018
 17:32:05 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <dmitry.torokhov@gmail.com>, <matthias.bgg@gmail.com>,
 <lee.jones@linaro.org>, <chen.zhong@mediatek.com>
Subject: [PATCH v2 -next] input: keyboard: remove duplicated include from
 mtk-pmic-keys.c
Date: Tue, 11 Dec 2018 17:32:00 +0800
Message-ID: <20181211093200.18140-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_013235_669483_CE392878 
X-CRM114-Status: UNSURE (   6.71  )
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
Cc: YueHaibing <yuehaibing@huawei.com>, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-input@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

alphabetise the header files and remove duplicated include
file linux/kernel.h

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: alphabetise the header files
---
 drivers/input/keyboard/mtk-pmic-keys.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index 02c67a1..8e6ebab 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -14,18 +14,17 @@
  *
  */
 
-#include <linux/module.h>
-#include <linux/kernel.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
-#include <linux/platform_device.h>
 #include <linux/kernel.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/regmap.h>
 #include <linux/mfd/mt6323/registers.h>
-#include <linux/mfd/mt6397/registers.h>
 #include <linux/mfd/mt6397/core.h>
+#include <linux/mfd/mt6397/registers.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
 
 #define MTK_PMIC_PWRKEY_RST_EN_MASK	0x1
 #define MTK_PMIC_PWRKEY_RST_EN_SHIFT	6
-- 
2.7.4



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
