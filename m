Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2926C282CF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:24:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 739A0214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XFzDAiib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739A0214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eDvZnn60bgzIFVdMmd+sft4OdXHMeeOZCG0cQdbf+NY=; b=XFzDAiibghB2Zh
	QjxIlFp0/NszEE1Cpk3QljulyWL7Kray93hANnAnAM7v76nDY1uPEOa40hemc+uGt+CsZD5OJ2Iwz
	9wWZlD1RQpUbtdsrm9J0XJQY4+EMz2B1TgtdJAggIBPj+y11eNHhuJF19Vlb0fw/KaPcJQuyTEblo
	B4VXdawF+sIIpZeiwoF2SRN9LKSzNtp2LlpByxaLc2oM94ioLo1TeRcvKlls0GEP5MoRJWzA2nMal
	/bb6ORW4NDkYAU1fQgaAeJAl6JuaPEpuZgm6blkDh4Whv18WEJx3UTgFtHxzAqimj1XuCKqL5wZlR
	b/V55ofSskuVZSFsNb1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go7pX-0005MB-4M; Mon, 28 Jan 2019 14:24:07 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go7p5-0004tx-IV
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 14:23:41 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0SEL00d025914; Mon, 28 Jan 2019 15:23:33 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2q8dw2vy0v-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Mon, 28 Jan 2019 15:23:33 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7F11E31;
 Mon, 28 Jan 2019 14:23:32 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4CC7F2D38;
 Mon, 28 Jan 2019 14:23:32 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 28 Jan
 2019 15:23:31 +0100
Received: from localhost (10.201.20.122) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 28 Jan 2019 15:23:31
 +0100
From: Benjamin Gaignard <benjamin.gaignard@st.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <arnd@arndb.de>,
 <shawnguo@kernel.org>, <s.hauer@pengutronix.de>, <fabio.estevam@nxp.com>
Subject: [RFC v2 3/7] base: Add calls to domains controller
Date: Mon, 28 Jan 2019 15:23:09 +0100
Message-ID: <20190128142313.17036-4-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190128142313.17036-1-benjamin.gaignard@st.com>
References: <20190128142313.17036-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-28_08:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_062339_910217_DA588F36 
X-CRM114-Status: GOOD (  11.19  )
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
Cc: benjamin.gaignard@linaro.org, loic.pallardy@st.com,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org,
 Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

To avoid modifying all the drivers call domainsctrl_set_default_config
before probe to apply the configuration define in device node (if any).

When unbinding the device try to apply configuration named "unbind".

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/base/dd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 8ac10af17c00..2880fe893096 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -20,6 +20,7 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/domainsctrl.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/kthread.h>
@@ -478,6 +479,10 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 re_probe:
 	dev->driver = drv;
 
+	ret = domainsctrl_set_default_config(dev);
+	if (ret)
+		goto domainctrl_failed;
+
 	/* If using pinctrl, bind pins now before probing */
 	ret = pinctrl_bind_pins(dev);
 	if (ret)
@@ -548,6 +553,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
 pinctrl_bind_failed:
+	domainsctrl_set_config_by_name(dev, "unbind");
+domainctrl_failed:
 	device_links_no_driver(dev);
 	devres_release_all(dev);
 	driver_sysfs_remove(dev);
@@ -970,6 +977,8 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 		device_links_driver_cleanup(dev);
 		arch_teardown_dma_ops(dev);
 
+		domainsctrl_set_config_by_name(dev, "unbind");
+
 		devres_release_all(dev);
 		dev->driver = NULL;
 		dev_set_drvdata(dev, NULL);
-- 
2.15.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
