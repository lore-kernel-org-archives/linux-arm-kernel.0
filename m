Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42624C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:33:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF3F920684
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ld0IzK8b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mg9FW6tg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3F920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lwsDWx+bOOP0KQuvCkSrYDwrFQV6Yx/Wzj2ku/4xjHU=; b=ld0IzK8beDsw+6
	ec304D7beZtD8i7AFJeDXt06ri1SRrzMlJZsCjQH4Cnw2Rbxj2ZNUslp7R/KkWl+vw6D0zy39GSom
	PWuGjmNbx+7qBfN5hoB6NsRpceqDAcW1l1ocu9QtVRiGNMHghKnS/LPlAthpB9rPwwSPGBKOyDZOy
	An+ll+4U7Ci8Hh7A+SlUAHjo0BrrmmfxlPs6VBMzhCG71BKzxuTUhPeoBTcFMNDK2sN6iGvXvNwpO
	xIoG4/5jQWD6RUwJ2eVrVk3tInx12TIL1MH/zYJXTZTexQ0LTuifshULGAtaRZnSa+PQ+Ewq6D3k6
	tAE9EwNS8q2auJYNohcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxTgf-0006my-EW; Sat, 23 Feb 2019 09:33:37 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxTgA-000689-39
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 09:33:09 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1N9X4Ya039621;
 Sat, 23 Feb 2019 03:33:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550914384;
 bh=md0RHlA8ewcfC3T++bx/etT33UOAlB+p1f8NwcGbYzo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=mg9FW6tg4LPQjxiNYbtzCO5smv310IMM7XK12IOBPYqDf8pRfIf3eFZwV9laNPcNV
 ra+XIfTP3sVnixyajGcuoX8S9teMSuj3EJRSSq8MxSoiURvSz4QYvPLXJh9RtbvU61
 2SZ+TmOjc2TFLy4Y2bRPl+ZssiC6nEibYpoeE7IM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1N9X4Iw031387
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 23 Feb 2019 03:33:04 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sat, 23
 Feb 2019 03:33:04 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sat, 23 Feb 2019 03:33:04 -0600
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1N9WrQk028361;
 Sat, 23 Feb 2019 03:33:02 -0600
From: Lokesh Vutla <lokeshvutla@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Santosh
 Shilimkar <ssantosh@kernel.org>
Subject: [PATCH v2 3/5] soc: ti: ti_sci_pm_domains: Add support for exclusive
 access
Date: Sat, 23 Feb 2019 15:02:30 +0530
Message-ID: <20190223093232.29003-4-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190223093232.29003-1-lokeshvutla@ti.com>
References: <20190223093232.29003-1-lokeshvutla@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_013306_471369_4EE55240 
X-CRM114-Status: GOOD (  19.31  )
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
Cc: Lokesh Vutla <lokeshvutla@ti.com>,
 Device Tree Mailing List <devicetree@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

TISCI protocol supports for enabling the device with exclusive
permissions. Certain remoteproc devices or some shared devices
across VM doesn't wants to request devices with this flag set.
So add support for getting this information from DT. With this
power-domain-cells are increased to 2.

For keeping the DT backward compatibility intact, defaulting the
device permissions to set the exclusive flag set. In this case the
power-domain-cells is 1.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/soc/ti/ti_sci_pm_domains.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/ti_sci_pm_domains.c b/drivers/soc/ti/ti_sci_pm_domains.c
index de31b9389e2e..4dae42651212 100644
--- a/drivers/soc/ti/ti_sci_pm_domains.c
+++ b/drivers/soc/ti/ti_sci_pm_domains.c
@@ -24,6 +24,8 @@
 #include <linux/slab.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
 
+#define PD_REQUEST_EXCLUSIVE BIT(0)
+
 /**
  * struct ti_sci_genpd_dev_data: holds data needed for every device attached
  *				 to this genpd
@@ -32,6 +34,7 @@
  */
 struct ti_sci_genpd_dev_data {
 	int idx;
+	u8 exclusive;
 };
 
 /**
@@ -63,6 +66,14 @@ static int ti_sci_dev_id(struct device *dev)
 	return sci_dev_data->idx;
 }
 
+static u8 is_ti_sci_dev_exclusive(struct device *dev)
+{
+	struct generic_pm_domain_data *genpd_data = dev_gpd_data(dev);
+	struct ti_sci_genpd_dev_data *sci_dev_data = genpd_data->data;
+
+	return sci_dev_data->exclusive & PD_REQUEST_EXCLUSIVE;
+}
+
 /**
  * ti_sci_dev_to_sci_handle(): get pointer to ti_sci_handle
  * @dev: pointer to device associated with this genpd
@@ -87,7 +98,10 @@ static int ti_sci_dev_start(struct device *dev)
 	const struct ti_sci_handle *ti_sci = ti_sci_dev_to_sci_handle(dev);
 	int idx = ti_sci_dev_id(dev);
 
-	return ti_sci->ops.dev_ops.get_device(ti_sci, idx);
+	if (is_ti_sci_dev_exclusive(dev))
+		return ti_sci->ops.dev_ops.get_device_exclusive(ti_sci, idx);
+	else
+		return ti_sci->ops.dev_ops.get_device(ti_sci, idx);
 }
 
 /**
@@ -118,7 +132,7 @@ static int ti_sci_pd_attach_dev(struct generic_pm_domain *domain,
 	if (ret < 0)
 		return ret;
 
-	if (pd_args.args_count != 1)
+	if (pd_args.args_count != 1 && pd_args.args_count != 2)
 		return -EINVAL;
 
 	idx = pd_args.args[0];
@@ -136,6 +150,10 @@ static int ti_sci_pd_attach_dev(struct generic_pm_domain *domain,
 		return -ENOMEM;
 
 	sci_dev_data->idx = idx;
+	/* Enable the exclusive permissions by default */
+	sci_dev_data->exclusive = PD_REQUEST_EXCLUSIVE;
+	if (pd_args.args_count == 2)
+		sci_dev_data->exclusive = pd_args.args[1];
 
 	genpd_data = dev_gpd_data(dev);
 	genpd_data->data = sci_dev_data;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
