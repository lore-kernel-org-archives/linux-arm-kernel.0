Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16E9C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:30:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F38821473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kW0a6YTp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ihNwYvrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F38821473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+s/YQAgRZ3e8kDNuuM6uXURAVWMMtFH33ggvIiI032Q=; b=kW0a6YTppvKSHY
	SgECqDj6czj4aT8uPnzYNOVgmqjwOTOwYBMkdAnqcoqM015z7GUD+f2RmfjZpc7s8z7ySLOVT7/Qb
	kc/efrD5AjM1prxhZTkGfBqa51CTI/62ojqTksO3N1EZ958Er7w72TGidqj5uoNIS/2WSzaUdmHd6
	uMDgoLl8jXu5Q6Vg0Go411pKalEUafEbb+qoe59qe2cg1SKbssoanlk15L9ChfFEWXqZatbWwxbaT
	pMzg0jzB14MF2QADj4e8avkmh/Zo3P9xVa1ieUAEC41pn1F5CtkgXiRAaXVRNzoB9lcAMORVdsq3E
	F+SMji0wIwiT1o/DJNFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goTTZ-00083i-RE; Tue, 29 Jan 2019 13:30:53 +0000
Received: from mail-eopbgr20075.outbound.protection.outlook.com ([40.107.2.75]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goTTU-000835-EC
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 13:30:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90X4MwzwubFSUdcE3ZhdSYbyc2gzgpQJHCtoYzBwsso=;
 b=ihNwYvrOp0tzC23vD3zTcC9DBYQyzuCIsyvx9gVR7zFD99luWzzpGnzC4kPnO2h5AWY0njWkFN40mhuJptwPuXvoO0L46zl54LHeIS4nbCB5AGEa8bPk4Q2B+OevRPj/27nuCioWEfKgeTFI9FrqHtV/E/njyonVvBtrZIvC1hU=
Received: from VI1PR04MB5008.eurprd04.prod.outlook.com (20.177.49.225) by
 VI1PR04MB4271.eurprd04.prod.outlook.com (52.134.31.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Tue, 29 Jan 2019 13:30:41 +0000
Received: from VI1PR04MB5008.eurprd04.prod.outlook.com
 ([fe80::2d2c:455a:16e9:cd4f]) by VI1PR04MB5008.eurprd04.prod.outlook.com
 ([fe80::2d2c:455a:16e9:cd4f%2]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 13:30:41 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Anson Huang <anson.huang@nxp.com>, Rob Herring <robh@kernel.org>, Lucas Stach
 <l.stach@pengutronix.de>, Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH] soc: imx: Add psci gpc support for i.MX8MQ
Thread-Topic: [PATCH] soc: imx: Add psci gpc support for i.MX8MQ
Thread-Index: AQHUt9bU+/jArCh7A0qIut8V+yy3WQ==
Date: Tue, 29 Jan 2019 13:30:41 +0000
Message-ID: <1548768630-2416-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0601CA0029.eurprd06.prod.outlook.com
 (2603:10a6:203:68::15) To VI1PR04MB5008.eurprd04.prod.outlook.com
 (2603:10a6:803:57::33)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB4271;
 6:54buLjOPouEPWD1pkVufF4sS7vpNb6KaoVhwrJhuTel7xX+5lDIiOBpMtWwqxYWT9KEqZslgqwB4fKCHcc1syoXAEe4rX3FNyPzXnxR/jLpwYKKcrFuMzEIDuoAZ3hL3UgJNlfUqZBkdFtR02At1xFsHDfj8nxXQcwb5WHl2FYVcTFb4RA3OaE5x5cnoAzW4pSHz6dtjB18iREX84XrnpzN45cXEEh6TNd6FWgU4u7ZWvvstzhE/kxr1x2gWCxyVb27Vwm3Pk6dJxI39WG11WuZQFYwnFMvEU/f4RlxHSJHO+XEsg5v8J7O0GdgXWtAO2rXf0ILN65OJWSRWDFNV4yEwNyvXAuL7sd402LbVkzGDYYlfJnydT33pKLdRYkm04nU10dPVYorGAktSwo4IzdHsO1cz9qDCsrU621dEKWQbye/Zc3JWa2RCl3ix7zjL9rjzGofdNTc7Meh5row37g==;
 5:PCFELKl/TgBVz1DKHvyTQ9PeSbnu+J+NoPZKqnzQOqvVgw4TVG0iehUh4uAsMDZGhltrtSX8IRxp7Z9HOthMONTDD1a/5yHQPkGzCEQgB5EJazqHv2ChtpnOS4cSUXDInnXDsSJjvqSItz3JlGk6f+/+/z+2YxMTkyT6lBVmztTRBYXhxshwzibFf7sPY3q8uh5UUtsTKTadqF2PwpyUBA==;
 7:nYKe31R4fun5qTiNNjluPF8KCg8ziY8o9nS1Lb4nDSLYo3u3d3hHtSoDVEdVz6P0MM6HdT0GzX6E1x9/YLaYdB4qeyQsGtFC7MTxvqYiU26hDIgk9Czo2smnIw341wFlP1r0LPl/7FGOX6eq8c0DdQ==
x-ms-office365-filtering-correlation-id: d2370c97-995e-450b-9ba8-08d685edf6be
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4271; 
x-ms-traffictypediagnostic: VI1PR04MB4271:
x-microsoft-antispam-prvs: <VI1PR04MB42718D23D8650A70389F1924F6970@VI1PR04MB4271.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(376002)(366004)(39860400002)(346002)(189003)(199004)(478600001)(39060400002)(36756003)(71190400001)(71200400001)(99286004)(25786009)(3846002)(8676002)(44832011)(2906002)(86362001)(2616005)(6512007)(6486002)(106356001)(105586002)(6436002)(6116002)(476003)(14454004)(53936002)(486006)(102836004)(97736004)(8936002)(110136005)(66066001)(54906003)(186003)(14444005)(4326008)(6506007)(386003)(30864003)(305945005)(81166006)(81156014)(7736002)(50226002)(316002)(52116002)(6636002)(68736007)(256004)(26005)(2004002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4271;
 H:VI1PR04MB5008.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: q40gfzG42HNxNdHkLjPT/X4DoPFFZLtMQXSeJdYDIeMsKsE1W++Gi5TuembSRkO3VXt9HX2gueqm3qH1cTAPLn3OIEmo+rafCw3HmwPuWnpLOyDeA3ZZIiXWR61R44MGFOf6kENYl4h8mIgHhGLR2UGPkLsXXh3LKz5UgMEaSyJuLCi0luFTnp4Nx9QRvV+AcX7dys/SH4a5/Y4aYjCC8GQaS3PDOy1FQ6T871fsfZ9Xf1bAwv91CJs2kUJaWUUQtXCHzeGYtVTcHXExnhjq6xPxw+OJ650WsS5MHz7epHQbobAr+AJxQvzt+/B7ch1Ffun21t3Uxcu+jqWe8mx/u9BfQQ8g4m003dLXt0IiNH7krXJhL7HTZcVc9Jy6ZuKibUZfoqgh64tyA8GtfO87ueCTj0Tj3xfotcnm5gGKISQ=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2370c97-995e-450b-9ba8-08d685edf6be
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 13:30:40.3090 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4271
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_053048_710598_209E32FD 
X-CRM114-Status: GOOD (  20.85  )
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
Cc: Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Abel Vesa <abelvesa@linux.com>, dl-linux-imx <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Anson Huang <Anson.Huang@nxp.com>

Add i.MX8MQ PSCI GPC virtual driver support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/soc/imx/Makefile   |   1 +
 drivers/soc/imx/gpc-psci.c | 423 +++++++++++++++++++++++++++++++++++++++++++++
 include/soc/imx/fsl_sip.h  |  31 ++++
 3 files changed, 455 insertions(+)
 create mode 100644 drivers/soc/imx/gpc-psci.c
 create mode 100644 include/soc/imx/fsl_sip.h

diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index 506a6f3..83a38ac 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
 obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
+obj-$(CONFIG_ARCH_MXC) += gpc-psci.o
diff --git a/drivers/soc/imx/gpc-psci.c b/drivers/soc/imx/gpc-psci.c
new file mode 100644
index 0000000..4f8fee9
--- /dev/null
+++ b/drivers/soc/imx/gpc-psci.c
@@ -0,0 +1,423 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2019 NXP.
+ *
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/clk.h>
+#include <linux/cpumask.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/arm-gic.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/pm_domain.h>
+#include <soc/imx/fsl_sip.h>
+
+#define GPC_MAX_IRQS		(4 * 32)
+
+struct imx_gpc_pm_domain {
+	const char name[30];
+	struct device *dev;
+	struct generic_pm_domain pd;
+	u32 gpc_domain_id;
+	struct clk **clks;
+	unsigned int num_clks;
+	struct regulator *reg;
+};
+
+enum imx_gpc_pm_domain_state {
+	GPC_PD_STATE_OFF,
+	GPC_PD_STATE_ON,
+};
+
+#define to_imx_gpc_pm_domain(_genpd) \
+	container_of(_genpd, struct imx_gpc_pm_domain, pd)
+
+static DEFINE_SPINLOCK(gpc_psci_lock);
+static DEFINE_MUTEX(gpc_pd_mutex);
+
+static void imx_gpc_psci_irq_unmask(struct irq_data *d)
+{
+	struct arm_smccc_res res;
+
+	spin_lock(&gpc_psci_lock);
+	arm_smccc_smc(FSL_SIP_GPC, FSL_SIP_CONFIG_GPC_UNMASK, d->hwirq,
+		      0, 0, 0, 0, 0, &res);
+	spin_unlock(&gpc_psci_lock);
+
+	irq_chip_unmask_parent(d);
+}
+
+static void imx_gpc_psci_irq_mask(struct irq_data *d)
+{
+	struct arm_smccc_res res;
+
+	spin_lock(&gpc_psci_lock);
+	arm_smccc_smc(FSL_SIP_GPC, FSL_SIP_CONFIG_GPC_MASK, d->hwirq,
+		      0, 0, 0, 0, 0, &res);
+	spin_unlock(&gpc_psci_lock);
+
+	irq_chip_mask_parent(d);
+}
+static int imx_gpc_psci_irq_set_wake(struct irq_data *d, unsigned int on)
+{
+	struct arm_smccc_res res;
+
+	spin_lock(&gpc_psci_lock);
+	arm_smccc_smc(FSL_SIP_GPC, FSL_SIP_CONFIG_GPC_SET_WAKE, d->hwirq,
+			on, 0, 0, 0, 0, &res);
+	spin_unlock(&gpc_psci_lock);
+
+	return 0;
+}
+
+static int imx_gpc_psci_irq_set_affinity(struct irq_data *d,
+					 const struct cpumask *dest,
+					 bool force)
+{
+	/* parse the cpu of irq affinity */
+	struct arm_smccc_res res;
+	int cpu = cpumask_any_and(dest, cpu_online_mask);
+
+	irq_chip_set_affinity_parent(d, dest, force);
+
+	spin_lock(&gpc_psci_lock);
+	arm_smccc_smc(FSL_SIP_GPC, 0x4, d->hwirq,
+		      cpu, 0, 0, 0, 0, &res);
+	spin_unlock(&gpc_psci_lock);
+
+	return 0;
+}
+
+static struct irq_chip imx_gpc_psci_chip = {
+	.name			= "GPC-PSCI",
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_mask		= imx_gpc_psci_irq_mask,
+	.irq_unmask		= imx_gpc_psci_irq_unmask,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_wake		= imx_gpc_psci_irq_set_wake,
+	.irq_set_affinity	= imx_gpc_psci_irq_set_affinity,
+};
+
+static int imx_gpc_psci_domain_translate(struct irq_domain *d,
+				    struct irq_fwspec *fwspec,
+				    unsigned long *hwirq,
+				    unsigned int *type)
+{
+	if (is_of_node(fwspec->fwnode)) {
+		if (fwspec->param_count != 3)
+			return -EINVAL;
+
+		/* No PPI should point to this domain */
+		if (fwspec->param[0] != 0)
+			return -EINVAL;
+
+		*hwirq = fwspec->param[1];
+		*type = fwspec->param[2];
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int imx_gpc_psci_domain_alloc(struct irq_domain *domain,
+				  unsigned int irq,
+				  unsigned int nr_irqs, void *data)
+{
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec parent_fwspec;
+	irq_hw_number_t hwirq;
+	int i;
+
+	if (fwspec->param_count != 3)
+		return -EINVAL;	/* Not GIC compliant */
+	if (fwspec->param[0] != 0)
+		return -EINVAL;	/* No PPI should point to this domain */
+
+	hwirq = fwspec->param[1];
+	if (hwirq >= GPC_MAX_IRQS)
+		return -EINVAL;	/* Can't deal with this */
+
+	for (i = 0; i < nr_irqs; i++)
+		irq_domain_set_hwirq_and_chip(domain, irq + i, hwirq + i,
+					      &imx_gpc_psci_chip, NULL);
+
+	parent_fwspec = *fwspec;
+	parent_fwspec.fwnode = domain->parent->fwnode;
+
+	return irq_domain_alloc_irqs_parent(domain, irq, nr_irqs,
+					    &parent_fwspec);
+}
+
+static const struct irq_domain_ops imx_gpc_psci_domain_ops = {
+	.translate = imx_gpc_psci_domain_translate,
+	.alloc	= imx_gpc_psci_domain_alloc,
+	.free	= irq_domain_free_irqs_common,
+};
+
+static int __init imx_gpc_psci_init(struct device_node *node,
+			       struct device_node *parent)
+{
+	struct irq_domain *parent_domain, *domain;
+
+	if (!parent) {
+		pr_err("%s: no parent, giving up\n", node->full_name);
+		return -ENODEV;
+	}
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("%s: unable to obtain parent domain\n",
+			node->full_name);
+		return -ENXIO;
+	}
+
+	domain = irq_domain_add_hierarchy(parent_domain, 0, GPC_MAX_IRQS,
+					  node, &imx_gpc_psci_domain_ops,
+					  NULL);
+	if (!domain)
+		return -ENOMEM;
+
+	return 0;
+}
+IRQCHIP_DECLARE(imx_gpc_psci, "fsl,imx8mq-gpc", imx_gpc_psci_init);
+
+static int imx_gpc_pd_power_on(struct generic_pm_domain *domain)
+{
+	struct imx_gpc_pm_domain *pd = to_imx_gpc_pm_domain(domain);
+	struct arm_smccc_res res;
+	int index, ret = 0;
+
+	/* power on the external supply */
+	if (pd->reg) {
+		ret = regulator_enable(pd->reg);
+		if (ret) {
+			dev_warn(pd->dev, "failed to power up the reg%d\n", ret);
+			return ret;
+		}
+	}
+
+	/* enable the necessary clks needed by the power domain */
+	if (pd->num_clks) {
+		for (index = 0; index < pd->num_clks; index++)
+			clk_prepare_enable(pd->clks[index]);
+	}
+
+	mutex_lock(&gpc_pd_mutex);
+	arm_smccc_smc(FSL_SIP_GPC, FSL_SIP_CONFIG_GPC_PM_DOMAIN,
+			pd->gpc_domain_id,
+			GPC_PD_STATE_ON, 0, 0, 0, 0, &res);
+	mutex_unlock(&gpc_pd_mutex);
+
+	return 0;
+}
+
+static int imx_gpc_pd_power_off(struct generic_pm_domain *domain)
+{
+	struct imx_gpc_pm_domain *pd = to_imx_gpc_pm_domain(domain);
+	struct arm_smccc_res res;
+	int index, ret = 0;
+
+	mutex_lock(&gpc_pd_mutex);
+	arm_smccc_smc(FSL_SIP_GPC, FSL_SIP_CONFIG_GPC_PM_DOMAIN,
+			pd->gpc_domain_id, GPC_PD_STATE_OFF,
+			0, 0, 0, 0, &res);
+	mutex_unlock(&gpc_pd_mutex);
+
+	/* power off the external supply */
+	if (pd->reg) {
+		ret = regulator_disable(pd->reg);
+		if (ret) {
+			dev_warn(pd->dev, "failed to power off the reg%d\n", ret);
+			return ret;
+		}
+	}
+
+	/* disable the necessary clks when power domain on finished */
+	if (pd->num_clks) {
+		for (index = 0; index < pd->num_clks; index++)
+			clk_disable_unprepare(pd->clks[index]);
+	}
+
+	return ret;
+};
+
+static int imx8m_pd_clk_init(struct device_node *np,
+			     struct imx_gpc_pm_domain *domain)
+{
+	struct property *pp;
+	struct clk **clks;
+	int index;
+
+	pp = of_find_property(np, "clocks", NULL);
+	if (pp)
+		domain->num_clks = pp->length / 8;
+	else
+		domain->num_clks = 0;
+
+	if (domain->num_clks) {
+		clks = kcalloc(domain->num_clks, sizeof(*clks), GFP_KERNEL);
+		if (!clks) {
+			domain->num_clks = 0;
+			domain->clks = NULL;
+			return -ENOMEM;
+		}
+
+		domain->clks = clks;
+	}
+
+	for (index = 0; index < domain->num_clks; index++) {
+		clks[index] = of_clk_get(np, index);
+		if (IS_ERR(clks[index])) {
+			for (index = 0; index < domain->num_clks; index++) {
+				if (!IS_ERR(clks[index]))
+					clk_put(clks[index]);
+			}
+
+			domain->num_clks = 0;
+			domain->clks = NULL;
+			kfree(clks);
+			pr_warn("imx8m domain clock init failed\n");
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+
+static int imx8m_add_subdomain(struct device_node *parent,
+			       struct generic_pm_domain *parent_pd)
+{
+	struct device_node *child_node;
+	struct imx_gpc_pm_domain *child_domain;
+	int ret = 0;
+
+	/* add each of the child domain of parent */
+	for_each_child_of_node(parent, child_node) {
+		if (!of_device_is_available(child_node))
+			continue;
+
+		child_domain = kzalloc(sizeof(*child_domain), GFP_KERNEL);
+		if (!child_domain)
+			return -ENOMEM;
+
+		ret = of_property_read_string(child_node, "domain-name",
+					      &child_domain->pd.name);
+		if (ret)
+			goto exit;
+
+		ret = of_property_read_u32(child_node, "domain-id",
+					   &child_domain->gpc_domain_id);
+		if (ret)
+			goto exit;
+
+		child_domain->pd.power_off = imx_gpc_pd_power_off;
+		child_domain->pd.power_on = imx_gpc_pd_power_on;
+		/* no reg for subdomains */
+		child_domain->reg = NULL;
+
+		imx8m_pd_clk_init(child_node, child_domain);
+
+		/* power domains as off at boot */
+		pm_genpd_init(&child_domain->pd, NULL, true);
+
+		/* add subdomain of parent power domain */
+		pm_genpd_add_subdomain(parent_pd, &child_domain->pd);
+
+		ret = of_genpd_add_provider_simple(child_node,
+						 &child_domain->pd);
+		if (ret)
+			pr_err("failed to add subdomain\n");
+	}
+
+	return 0;
+exit:
+	kfree(child_domain);
+	return ret;
+};
+
+static int imx_gpc_pm_domain_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct imx_gpc_pm_domain *imx_pm_domain;
+	int ret = 0;
+
+	if (!np) {
+		dev_err(dev, "power domain device tree node not found\n");
+		return -ENODEV;
+	}
+
+	imx_pm_domain = devm_kzalloc(dev, sizeof(*imx_pm_domain), GFP_KERNEL);
+	if (!imx_pm_domain)
+		return -ENOMEM;
+	imx_pm_domain->dev = dev;
+
+	ret = of_property_read_string(np, "domain-name",
+					&imx_pm_domain->pd.name);
+	if (ret) {
+		dev_err(dev, "get domain name failed\n");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32(np, "domain-id",
+					&imx_pm_domain->gpc_domain_id);
+	if (ret) {
+		dev_err(dev, "get domain id failed\n");
+		return -EINVAL;
+	}
+
+	imx_pm_domain->reg = devm_regulator_get_optional(dev, "power");
+	if (IS_ERR(imx_pm_domain->reg)) {
+		if (PTR_ERR(imx_pm_domain->reg) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		imx_pm_domain->reg = NULL;
+	}
+
+	imx8m_pd_clk_init(np, imx_pm_domain);
+
+	imx_pm_domain->pd.power_off = imx_gpc_pd_power_off;
+	imx_pm_domain->pd.power_on = imx_gpc_pd_power_on;
+	/* all power domains as off at boot */
+	pm_genpd_init(&imx_pm_domain->pd, NULL, true);
+
+	ret = of_genpd_add_provider_simple(np,
+				 &imx_pm_domain->pd);
+
+	/* add subdomain */
+	ret = imx8m_add_subdomain(np, &imx_pm_domain->pd);
+	if (ret)
+		dev_warn(dev, "please check the child power domain init\n");
+
+	return 0;
+}
+
+static const struct of_device_id imx_gpc_pm_domain_ids[] = {
+	{.compatible = "fsl,imx8mq-pm-domain"},
+	{.compatible = "fsl,imx8mm-pm-domain"},
+	{},
+};
+
+static struct platform_driver imx_gpc_pm_domain_driver = {
+	.driver = {
+		.name	= "imx8m_gpc_pm_domain",
+		.owner	= THIS_MODULE,
+		.of_match_table = imx_gpc_pm_domain_ids,
+	},
+	.probe = imx_gpc_pm_domain_probe,
+};
+
+module_platform_driver(imx_gpc_pm_domain_driver);
+
+MODULE_AUTHOR("NXP");
+MODULE_DESCRIPTION("NXP i.MX8M GPC power domain driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/soc/imx/fsl_sip.h b/include/soc/imx/fsl_sip.h
new file mode 100644
index 0000000..c3867a2
--- /dev/null
+++ b/include/soc/imx/fsl_sip.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017 NXP
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __SOC_FSL_SIP_H
+#define __SOC_FSL_SIP_H
+
+#define FSL_SIP_GPC			0xC2000000
+#define FSL_SIP_CONFIG_GPC_MASK		0x00
+#define FSL_SIP_CONFIG_GPC_UNMASK	0x01
+#define FSL_SIP_CONFIG_GPC_SET_WAKE	0x02
+#define FSL_SIP_CONFIG_GPC_PM_DOMAIN	0x03
+
+#define IMX8MQ_PD_MIPI		0
+#define IMX8MQ_PD_PCIE1		1
+#define IMX8MQ_PD_OTG1		2
+#define IMX8MQ_PD_OTG2		3
+#define IMX8MQ_PD_GPU		4
+#define IMX8MQ_PD_VPU		5
+#define IMX8MQ_PD_HDMI		6
+#define IMX8MQ_PD_DISP		7
+#define IMX8MQ_PD_MIPI_CSI1	8
+#define IMX8MQ_PD_MIPI_CSI2	9
+#define IMX8MQ_PD_PCIE2		10
+
+#endif
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
