Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3806FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 05:16:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC47218DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 05:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tSgvilH/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g9d2Yiy8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC47218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kwg2x2s8Mq+8plnOKwzASjcSQR3USJp2yzJ3ISZYtgM=; b=tSgvilH/yGcbpy
	ELGxiZksuvaYFJtjNkm7d5BjFYGXZ7okSC98RGHztNERtP0NaCp+ch0GM0mVM/3Oy16I0AfDwfSwj
	WN7QW5fXX0nKAPPulV+JnugQ6578qSUTAs3W4wQ/Ak6FXPp+yiNMNmZPJwvNnGrv0h027JF7U00YG
	rH62zh5E6C8Y4nM4PKsmD5AAckUgIzJUwbA35RGYnVGv5otD59u5YLXDyoxq6s9VCQ/HBWLj9tw46
	6vcO45juDSMJmHqXZJFkkb6RYx+IvaW0oh9jiJGdJvFUh5Djmc3NEaNXtjCFihJPQEm/43gELrfWq
	C3CC9DsLiuYCUvsvv4Ig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvbI8-0001PN-5T; Mon, 18 Feb 2019 05:16:32 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvbHW-0000fI-JC
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 05:15:56 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1I5Fk2H083659;
 Sun, 17 Feb 2019 23:15:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550466946;
 bh=UlWnmsL1w1hS1UaqWrm66gIFeCg2lQPInjIbsAzZDcU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=g9d2Yiy8HeYySJzDwz97fva0q350kf2vpfx3EUnWGdIi70ofKYN3qPHbrLP7lkXW+
 3SV4UcSXA1AXtFOAw1ESl86FcHnGTN7G1O4N6waOEtvAYJLrsGVbr34X6e8nBTaxof
 DKkJA+vSAGC+htkUr6TLUx685TckyO/ZHcStStJk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1I5FkgO052355
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 17 Feb 2019 23:15:46 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sun, 17
 Feb 2019 23:15:45 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sun, 17 Feb 2019 23:15:45 -0600
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1I5FbKi029067;
 Sun, 17 Feb 2019 23:15:43 -0600
From: Lokesh Vutla <lokeshvutla@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Santosh
 Shilimkar <ssantosh@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/4] soc: ti: ti_sci_pm_domains: Add support for exclusive
 access
Date: Mon, 18 Feb 2019 10:45:15 +0530
Message-ID: <20190218051517.9218-3-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190218051517.9218-1-lokeshvutla@ti.com>
References: <20190218051517.9218-1-lokeshvutla@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_211554_708969_CC5B8D06 
X-CRM114-Status: GOOD (  21.71  )
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
 Sekhar Nori <nsekhar@ti.com>,
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
 .../bindings/soc/ti/sci-pm-domain.txt         |  7 ++++--
 drivers/soc/ti/ti_sci_pm_domains.c            | 22 +++++++++++++++++--
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
index f7b00a7c0f68..5fdda7475023 100644
--- a/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
+++ b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
@@ -19,8 +19,11 @@ child of the pmmc node.
 Required Properties:
 --------------------
 - compatible: should be "ti,sci-pm-domain"
-- #power-domain-cells: Must be 1 so that an id can be provided in each
-		       device node.
+- #power-domain-cells: Can be one of the following:
+			1: Containing the device id of each node
+			2: First entry should be device id
+			   Second entry should be 1 or 0. Use 1 for enabling
+			   the device with exclusive permissions set else 0.
 
 Example (K2G):
 -------------
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
