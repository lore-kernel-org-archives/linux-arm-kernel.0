Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85131C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:13:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 418492087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IztWqpFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418492087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rIq9WNcoiu7ghe2ORFEJ/v0D8sFyT/N0Nky0zcAvYxw=; b=IztWqpFSYGjxHC
	XL5ApOg4z6s7FGbs+triaSyDR3uF/UlPmcJs8+E+s8kUO6I4fW1lAJ+1qqMgt3t4cCtqFPgg2WHJY
	F6G4gUJR7Nli33UmRwrsnDsQyL+xktSsPV04aBu1RBDrfLceJaIN6ksE84GHMTzavaRqo2vf/22Xc
	qIHZuY3njbmRIZPc2Wt6euDiHVWYLJtp+cQG0aMtLb/Vy9RBpNggHYRzkBUm5rxV8ANK83RRmIgpg
	lclYlaygXB/Rgz9nYW2/DsQwBU4rxBKBaJZXI4u7Rb/NmKHLTb65jl6kP8qcB5Jk3052UJG0twfLq
	eF7asrljX0ZUN764gpXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyy5B-0006Ic-UQ; Wed, 27 Feb 2019 12:13:05 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyy50-00067m-4K
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 12:12:56 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1RC8jFI019399; Wed, 27 Feb 2019 13:12:47 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qtvh3pd76-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 27 Feb 2019 13:12:47 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B9B6E34;
 Wed, 27 Feb 2019 12:12:46 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9633F5266;
 Wed, 27 Feb 2019 12:12:46 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 27 Feb
 2019 13:12:46 +0100
Received: from localhost (10.201.20.122) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 27 Feb 2019 13:12:46
 +0100
From: Benjamin Gaignard <benjamin.gaignard@st.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <arnd@arndb.de>,
 <shawnguo@kernel.org>, <s.hauer@pengutronix.de>, <fabio.estevam@nxp.com>
Subject: [PATCH 3/7] base: Add calls to domains controller
Date: Wed, 27 Feb 2019 13:12:28 +0100
Message-ID: <20190227121232.24873-4-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190227121232.24873-1-benjamin.gaignard@st.com>
References: <20190227121232.24873-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-27_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_041254_478168_B7BAE659 
X-CRM114-Status: GOOD (  11.41  )
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
Reviewed-by: Mark Brown <broonie@kernel.org>
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
