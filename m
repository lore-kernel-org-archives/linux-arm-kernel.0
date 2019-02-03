Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9A3C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 11:50:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD50217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 11:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SO2d7Geq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nb/MN9Na"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD50217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xxUmmZwHDYx1Bcta8W80UM7aZqLsnnYSf33ANrEqry8=; b=SO2d7GeqNT10aF
	XLsUVpHNggHZGhrV6pFoNZAhu/cOMUKITwbYVeAn4x0K7AUGqDsAQq1ySOKlYMVDw+ZQzZoczhLO9
	NnVjh5bFMVdI3SQ+R7fkBSgxW9S6y0dLS02awbJUcWV3ndCLTrdpweCMLjWcHX3wYFry5QhoB8l/9
	46sZh+RET5udMLAKV00BtIl+OjuO1lG4bdjE3cuyq5EEidLDbL4zlVT4hfmU5onn5A7C1O+oqARJF
	RSV+mU1Rc9WqkScZ/2Yj8N45rZuDaHhKyz0124cGb5YH2EYY2LBBITDVrs+V2m5PlpF4slGABm08N
	AdL4Y8aODS0hMy1XBS+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqGHp-00073h-Ev; Sun, 03 Feb 2019 11:50:09 +0000
Received: from mail-eopbgr20083.outbound.protection.outlook.com ([40.107.2.83]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqGHk-0005zQ-QU
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 11:50:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZirnjFQahFu6PBaO8vrX6qD2DtphXUoaf1c8tgEM58w=;
 b=nb/MN9Na7yGDNXiMsq9ulX6Xi/vRODeYeh3pjCQTXOMCSRUQe6b97aZjf8/8uQPEoiQTg4G+5ZnkI1K2rAttji7tdUGa9zefRwWQ2dzdJfyd7QSiURWhp6tRaLdWG1Olfjwg+yqED/b1/5nQqtHSiX0JJg3vt0gwQRrmNrVbFVs=
Received: from VI1PR04MB5008.eurprd04.prod.outlook.com (20.177.49.225) by
 VI1PR04MB5855.eurprd04.prod.outlook.com (20.178.204.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.20; Sun, 3 Feb 2019 11:49:57 +0000
Received: from VI1PR04MB5008.eurprd04.prod.outlook.com
 ([fe80::2d2c:455a:16e9:cd4f]) by VI1PR04MB5008.eurprd04.prod.outlook.com
 ([fe80::2d2c:455a:16e9:cd4f%2]) with mapi id 15.20.1580.019; Sun, 3 Feb 2019
 11:49:57 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Abel Vesa <abelvesa@linux.com>
Subject: [PATCH] soc: imx: Add generic i.MX8 SoC driver
Thread-Topic: [PATCH] soc: imx: Add generic i.MX8 SoC driver
Thread-Index: AQHUu7aVxVb7WzSFe0KD+xVLEa1s3A==
Date: Sun, 3 Feb 2019 11:49:57 +0000
Message-ID: <1549194583-7684-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0202CA0052.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::29) To VI1PR04MB5008.eurprd04.prod.outlook.com
 (2603:10a6:803:57::33)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5855;
 6:LdiIH32iDd8DuHS89uQuv5RtPZMe9uFSHcslTn/804NWovC22yqxcAkh9+PIWIW4RsULogaLyTPKVlSXRrV7A1ad7huO1V6Am4Z9Wq/t2XE1tsXW5Mxgl8EDgUj+JJGTibz/C97lvknMEFhme8N9CoITe1HUKIJD3h2SrSEQpl7xzgHvzorZD+Ivwmx6N4qwZkq/g8KMCewjdUk3HU6wJy/83lsEAtsjFpEAJm0h6XsxwOzqAcwPaP4bHsza4Lh1dO+jWBAVlPUzF2y7R/dHnAD9BadbensXEzeeR/0rqTLinViZXbz0AT17FFRNoHKd9+wZ5Aq+TxlqWDtGQ7MiyKdyO6iTG5GqBIRbMkkn/dMHGC8vQ7hiqKO3GmL/hW/WlN4tli5aphJnZA5aoTyiiHyPxo7EDIWeE5uiOiXc73MzXJok6z3VBnOcNkQQ9YnuljrbD2IKBbw1uMyxouUaRA==;
 5:16U5lLxsNuuYEENvkLCn0m4U7fnhC8pRU+Vgl8wJgK//R2B/DGzvr/eGls/Sqd8A0B8mJmCTmS5dPksYOGa+E93dO9makmy/KjoPaYxwG6eHg2cYjGsFwNVGra9ZCdzcbf9ng4c3IQaY5dSLOiqmMuNeHHCU3RzW6jfaCAaIeUC16CJizFKBRBlGsf95leIfu3707HP9qIbj4sWU/oS1gQ==;
 7:bDEcpvSAN2n1WfZ6IvC29FpyvznahpGW8XQwT0SaHE1sYxarok8B0F+5uTgB4uSghCPc24+ZUT/7rDJP72p+ai0jPA+npQD4TAK2Zh4Y2gqoDJlxer8RZdclG92QLHEICzFz6n3fW8PaR5zuToGzAg==
x-ms-office365-filtering-correlation-id: 221bedc2-7722-4a95-5822-08d689cdb81e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5855; 
x-ms-traffictypediagnostic: VI1PR04MB5855:
x-microsoft-antispam-prvs: <VI1PR04MB5855A0E74E133D35C0F534E1F66C0@VI1PR04MB5855.eurprd04.prod.outlook.com>
x-forefront-prvs: 0937FB07C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(376002)(136003)(396003)(39860400002)(199004)(189003)(44832011)(66066001)(6512007)(25786009)(52116002)(110136005)(54906003)(7736002)(476003)(36756003)(14454004)(386003)(53936002)(99286004)(256004)(102836004)(2616005)(26005)(486006)(305945005)(186003)(71200400001)(71190400001)(86362001)(4326008)(8676002)(97736004)(68736007)(6506007)(6436002)(81166006)(478600001)(8936002)(81156014)(6116002)(3846002)(2906002)(6486002)(50226002)(106356001)(105586002)(316002)(41533002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5855;
 H:VI1PR04MB5008.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p3rmkPXk2TXKj4haIWjDFBQen0U/sWNjK77Ufpt1mFqIpg5bg7RZgTg1QkasuAN+oQbz8mlALOF5xTYie0LeFgTRGSZBHTpzQjk433UTTVQUr6FUYRVjt9GM/lr2Wg6wgrnyUUWz5KJl1QmP0WaiacC76jH0XgioX+Dgv5jMx5ksysGbCCMNgCRm5+bigHzAdYU3BjOWP72hTksrWtsFA+3RouuvidYT7uPLwmdvUlklIxPcDx3XRVB/CY0rx+eJMcC32vux8VpnhJ7inuUBlvnKfwhdW2Va7TpSmcsiWy4AjDzmHAzlebIb58gyOqC2RugKoteGcd+R0w6Fk97Iv7lNkUM7PPAHDWA8X9BGM6XQtqkjxJtS4DSiCRGD3mbP10qM66CFaVSvKVkBTlsKlsrU4kkFrrADTYnMiTEq6iE=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 221bedc2-7722-4a95-5822-08d689cdb81e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2019 11:49:56.2646 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5855
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_035004_922570_A2032848 
X-CRM114-Status: GOOD (  14.95  )
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
Cc: Abel Vesa <abel.vesa@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add generic i.MX8 SoC driver along with the i.MX8MQ SoC specific code.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/soc/imx/Makefile   |   1 +
 drivers/soc/imx/soc-imx8.c | 108 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+)
 create mode 100644 drivers/soc/imx/soc-imx8.c

diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index 506a6f3..d6b529e0 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
 obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
+obj-$(CONFIG_ARCH_MXC) += soc-imx8.o
diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
new file mode 100644
index 0000000..69fe04e
--- /dev/null
+++ b/drivers/soc/imx/soc-imx8.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 NXP.
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+
+#define ANADIG_DIGPROG		0x6c
+
+struct imx8_soc_data {
+	char *name;
+	u32 (*soc_revision)(void);
+};
+
+static u32 __init imx_init_revision_from_anatop(void)
+{
+	struct device_node *np;
+	void __iomem *anatop_base;
+	u32 digprog;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-anatop");
+	anatop_base = of_iomap(np, 0);
+	WARN_ON(!anatop_base);
+	digprog = readl_relaxed(anatop_base + ANADIG_DIGPROG);
+	iounmap(anatop_base);
+
+	/*
+	 * Bit[7:4] is the base layer revision,
+	 * Bit[3:0] is the metal layer revision
+	 * e.g. 0x10 stands for Tapeout 1.0
+	 */
+	return digprog & 0xff;
+}
+
+u32 imx8mq_soc_revision(void)
+{
+	return imx_init_revision_from_anatop();
+}
+
+struct imx8_soc_data imx8mq_soc_data = {
+	.name = "i.MX8MQ",
+	.soc_revision = imx8mq_soc_revision,
+};
+
+static const struct of_device_id imx8_soc_match[] = {
+	{ .compatible = "fsl,imx8mq", .data = &imx8mq_soc_data, },
+	{ }
+};
+
+static int __init imx8_soc_init(void)
+{
+	struct soc_device_attribute *soc_dev_attr;
+	struct soc_device *soc_dev;
+	struct device_node *root;
+	const struct of_device_id *id;
+	u32 soc_rev = 0;
+	const struct imx8_soc_data *data;
+	int ret;
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENODEV;
+
+	soc_dev_attr->family = "Freescale i.MX";
+
+	root = of_find_node_by_path("/");
+	ret = of_property_read_string(root, "model", &soc_dev_attr->machine);
+	if (ret)
+		goto free_soc;
+
+	id = of_match_node(imx8_soc_match, root);
+	if (!id)
+		goto free_soc;
+
+	of_node_put(root);
+
+	data = id->data;
+	if (data) {
+		soc_dev_attr->soc_id = data->name;
+		if (data->soc_revision)
+			soc_rev = data->soc_revision();
+	}
+
+	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%d.%d",
+					   (soc_rev >> 4) & 0xf,
+					    soc_rev & 0xf);
+	if (!soc_dev_attr->revision)
+		goto free_soc;
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev))
+		goto free_rev;
+
+	return 0;
+
+free_rev:
+	kfree(soc_dev_attr->revision);
+free_soc:
+	kfree(soc_dev_attr);
+	return -ENODEV;
+}
+device_initcall(imx8_soc_init);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
