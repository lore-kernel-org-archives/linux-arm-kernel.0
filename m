Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD47FC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:18:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 970272086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dkVAXIlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970272086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Ydnh9dApgknYSWO5IKY7fd2OM/WFjVMlCdVD2Zr0/6M=; b=dkVAXIlWNX+XA6
	o7nP5mPmZi0kn+o4xH44WSiYu8Olw4kJXvc2ItlUD4Q+dZGtVpTiSofT/cZbnwk0iwCebBaUmE8m/
	XUd+G9UeltXEZhVKP1gjsKHKz2fIOYWu62l/o9tLXkdJH1nTERRtNquCNxAEf/NV86n2UjHvyKJYl
	KxII+56gL5+cDb6M3Inda5vDPEzRYEzs9vhKJQOd8aoTMcXCKewnpcYAt2Vy+wmcCgzKUNUdi1B0V
	epFPyB2lWw6d3ij31qzbDkW6UgPUSZNW0b7ynpxQ7VASeFhColVIPfd/Bz93VYjfOJQmiAPWZ6FAb
	YoBNhWUQZrm5O5ReimYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXjc5-00057M-MN; Fri, 14 Dec 2018 09:18:29 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXjc1-00055l-BQ; Fri, 14 Dec 2018 09:18:27 +0000
X-UUID: e4c31ede5efa483cbe5fa465c901535a-20181214
X-UUID: e4c31ede5efa483cbe5fa465c901535a-20181214
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
 (envelope-from <nick.fan@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1641462383; Fri, 14 Dec 2018 17:18:06 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Dec 2018 17:18:05 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Fri, 14 Dec 2018 17:18:05 +0800
From: Nick Fan <Nick.Fan@mediatek.com>
To: Viresh Kumar <vireshk@kernel.org>
Subject: [RFC PATCH] [RESEND] opp: Add API for getting voltage from supplies
Date: Fri, 14 Dec 2018 17:17:42 +0800
Message-ID: <1544779062-8276-1-git-send-email-Nick.Fan@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_011825_528532_C378751F 
X-CRM114-Status: UNSURE (   9.97  )
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
Cc: Nishanth Menon <nm@ti.com>, Chiawen.Lee@mediatek.com,
 srv_heupstream@mediatek.com, linux-pm@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, erin.lo@mediatek.com, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, tfiga@chromium.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Nick Fan <Nick.Fan@mediatek.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[Resending because the previous attempt did not reach the mailing lists.]

This new API is needed for a downstream GPU driver, but posting it as an RFC to make sure that we implement it in a potentially upstreamable way or in case someone needs it for an upstream user later.

Add API to get voltage for multiple supplies from opp table

Signed-off-by: Nick Fan <Nick.Fan@mediatek.com>
---
 drivers/opp/core.c     | 28 ++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2c2df4e..ee73546 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -113,6 +113,34 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage);
 
 /**
+ * dev_pm_opp_get_voltage_supply() - Gets the voltage corresponding to an opp
+ * with index
+ * @opp:        opp for which voltage has to be returned for
+ * @index:      index to specify the returned supplies
+ *
+ * Return: voltage in micro volt corresponding to the opp with index, else
+ * return 0
+ *
+ * This is useful for devices with multiple power supplies.
+ */
+unsigned long dev_pm_opp_get_voltage_supply(struct dev_pm_opp *opp,
+					    unsigned int index)
+{
+	if (IS_ERR_OR_NULL(opp)) {
+		pr_err("%s: Invalid parameters\n", __func__);
+		return 0;
+	}
+
+	if (index >= opp->opp_table->regulator_count) {
+		pr_err("%s: Invalid supply index: %u\n", __func__, index);
+		return 0;
+	}
+
+	return opp->supplies[index].u_volt;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage_supply);
+
+/**
  * dev_pm_opp_get_freq() - Gets the frequency corresponding to an available opp
  * @opp:	opp for which frequency has to be returned for
  *
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 5d399eee..2f1c2a8 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -84,6 +84,9 @@ struct dev_pm_set_opp_data {
 
 unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
 
+unsigned long dev_pm_opp_get_voltage_supply(struct dev_pm_opp *opp,
+					    unsigned int index);
+
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
 
 bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp);
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
