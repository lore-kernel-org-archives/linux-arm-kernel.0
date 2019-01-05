Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B6DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:49:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE448218E2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U98ZXUIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE448218E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soulik.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8KCRxXkqoeNGt7l590Sj2n6aZeAa+ce5OlI9fTVdtSs=; b=U98ZXUIZ6MyOf+
	aOAQ30enyl3BxnAZJunJYVK/HChvL573xYzal+tcyW5JyAuMVWb8/UUurkcRq/v/wTndtNFf2YqTs
	pZDsOPojXkacFC1Rqo12ZiCJFcJCvI4biojZaUQdx6B/tQ0vdpfMXEmAyiA76Tde/0+0WFYmBDZI/
	By1lhZ0y2V62IDhxFcN/GpC4uFNkLlDCp7eDMqOfJA+RtH2eiRaL/UiRHe/teJdKit7bj8qh1CYyK
	5guPjLIOxVn2jHHu48NEHMknQRCNCKs18QNmYOc7sj+rBb6i2qBZUnrKZtTzf3Wmi/V+PNRq9fjCK
	1nwqSSN8mJXEhdc8dzxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfq4y-0007Dj-TY; Sat, 05 Jan 2019 17:49:48 +0000
Received: from kozue.soulik.info ([108.61.200.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfq4G-0006Re-VU; Sat, 05 Jan 2019 17:49:08 +0000
Received: from misaki.sumomo.pri (unknown
 [IPv6:2001:470:b30d:2:c604:15ff:0:a00])
 by kozue.soulik.info (Postfix) with ESMTPA id F0844101811;
 Sun,  6 Jan 2019 02:49:41 +0900 (JST)
From: Randy Li <ayaka@soulik.info>
To: linux-rockchip@lists.infradead.org
Subject: [PATCH 3/3] soc: rockchip: power-domain: export idle request
Date: Sun,  6 Jan 2019 01:48:37 +0800
Message-Id: <20190105174837.19378-4-ayaka@soulik.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190105174837.19378-1-ayaka@soulik.info>
References: <20190105174837.19378-1-ayaka@soulik.info>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190105_094905_523550_23177526 
X-CRM114-Status: UNSURE (   8.29  )
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
Cc: ulf.hansson@linaro.org, zhangqing@rock-chips.com, heiko@sntech.de,
 geert+renesas@glider.be, sboyd@kernel.org, mturquette@baylibre.com,
 Randy Li <ayaka@soulik.info>, linux-kernel@vger.kernel.org,
 Jeffy Chen <jeffy.chen@rock-chips.com>, linux-arm-kernel@lists.infradead.org,
 Caesar Wang <wxt@rock-chips.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

We need to put the power status of HEVC IP into IDLE unless
we can't reset that IP or the SoC would crash down.
rockchip_pmu_idle_request(dev, true)---> enter idle
rockchip_pmu_idle_request(dev, false)---> exit idle

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Randy Li <ayaka@soulik.info>
---
 drivers/soc/rockchip/pm_domains.c | 23 +++++++++++++++++++++++
 include/soc/rockchip/pm_domains.h | 18 ++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 include/soc/rockchip/pm_domains.h

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 847c7c482b26..3e2e252cb64b 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -199,6 +199,29 @@ static int rockchip_pmu_set_idle_request(struct rockchip_pm_domain *pd,
 	return 0;
 }
 
+int rockchip_pmu_idle_request(struct device *dev, bool idle)
+{
+	struct generic_pm_domain *genpd;
+	struct rockchip_pm_domain *pd;
+	int ret;
+
+	if (IS_ERR_OR_NULL(dev))
+		return -EINVAL;
+
+	if (IS_ERR_OR_NULL(dev->pm_domain))
+		return -EINVAL;
+
+	genpd = pd_to_genpd(dev->pm_domain);
+	pd = to_rockchip_pd(genpd);
+
+	mutex_lock(&pd->pmu->mutex);
+	ret = rockchip_pmu_set_idle_request(pd, idle);
+	mutex_unlock(&pd->pmu->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL(rockchip_pmu_idle_request);
+
 static int rockchip_pmu_save_qos(struct rockchip_pm_domain *pd)
 {
 	int i;
diff --git a/include/soc/rockchip/pm_domains.h b/include/soc/rockchip/pm_domains.h
new file mode 100644
index 000000000000..690db6118636
--- /dev/null
+++ b/include/soc/rockchip/pm_domains.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SOC_ROCKCHIP_PM_DOMAINS_H
+#define __SOC_ROCKCHIP_PM_DOMAINS_H
+
+#include <linux/errno.h>
+
+struct device;
+
+#ifdef CONFIG_ROCKCHIP_PM_DOMAINS
+int rockchip_pmu_idle_request(struct device *dev, bool idle);
+#else
+static inline int rockchip_pmu_idle_request(struct device *dev, bool idle)
+{
+	return -ENOTSUPP;
+}
+#endif
+
+#endif
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
