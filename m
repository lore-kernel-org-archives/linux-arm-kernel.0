Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A70FC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:10:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43EF020844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UiCfYHCq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M6+vIV4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43EF020844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fpk+MMLiyHOFQbfC1Uea8Yy7DDifwuACAIugQtJ9lvk=; b=UiCfYHCq34xYXT
	APBXCjvIz74D+lDLZ+qytNtdcs7chCXQ3cMm1ltPbnabMJFL60ulKJCf+uE6qQfsNvQ4AcxKEScgY
	BdErdmLXP2SGqsDnnlsf/6LtZup48pp/PxXa3zzdwVbNAcpEaPD9m70XC0efNd/UyEXMtoJZBqZmu
	pI1allWy13SOLBjtnmSPJ9EML/kE+9Ro260QeTOHD5T8e0r6DbVeWK6SYCu7rKJlp6cXjKBEoV3F7
	FarqWL+a3WFl9XDOw7JpQdq23LILtD9mSXcL/TkZKrzIuqqD0rCj8DwVh0U18MhfK2AUuYbQpgndO
	PZzgLNuob3pVgu5ilv3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqaH1-0005cL-Mf; Mon, 04 Feb 2019 09:10:39 +0000
Received: from mail-eopbgr00061.outbound.protection.outlook.com ([40.107.0.61]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqaGV-0004NR-SG
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 09:10:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQlrlWaQuEhOTis0NBAUjBQuKzyqCo+n/zGPGbJESAM=;
 b=M6+vIV4EGa4h9BMykC/q1GP8C/X7u/COKeT9zN6SeM5VQ8SfF5h6bepS3EqkIxZhWhpbHUzae/pzEa4vQorRSqyYK1frABT5mFWqr7b6Ck1v4VA2O/Om/cFTmksHbOMINxq0yIZRL+YJuyOfh/yKQ50NgEyOXxJK4KyalWZn5TY=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2448.eurprd04.prod.outlook.com (10.168.64.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Mon, 4 Feb 2019 09:10:04 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe%8]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 09:10:04 +0000
From: Pankaj Bansal <pankaj.bansal@nxp.com>
To: Leo Li <leoyang.li@nxp.com>
Subject: [PATCH v3 2/2] drivers: soc: fsl: add qixis driver
Thread-Topic: [PATCH v3 2/2] drivers: soc: fsl: add qixis driver
Thread-Index: AQHUvGlq5QpFuw3iE0KaAu9EZS6m4A==
Date: Mon, 4 Feb 2019 09:10:04 +0000
Message-ID: <20190204143449.25040-3-pankaj.bansal@nxp.com>
References: <20190204143449.25040-1-pankaj.bansal@nxp.com>
In-Reply-To: <20190204143449.25040-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::23) To VI1PR0401MB2496.eurprd04.prod.outlook.com
 (2603:10a6:800:56::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [92.120.1.69]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0401MB2448;
 6:4xBxZ8EGaJIlvJ72ugQQX7v4LiejvXt8Tsvl4uOrVj3Ifa2/WDB0gwEfBKV0t7FbUXn+RXTHj+C6jCD6i4+MQJTcMoDKfm+hcacLuQUhuQK3sy/VQjPryF4VBAmMRmxV5G42MrwQ2sDVcIrul5n9bpOCxXvPhrL0adH3iUnWOWKHchqGB5RR7bbKvJYLYglfFO/8qWxXahf163riUlwpPBWBkUzLsjo24AMvUcCPadd8m+yAVdvKsuiPSoOge69o1/VpFz1yXU5GjNiGBhTGIZFTUfkw3jg9pq4/OaDss74K4Fx7vnSZbB1fm6yKuVUY1+BitO7S4Iw59VgzdM8AkHVtPTeYaS9AUua+ORAaeOqXh5VTQXrXbsHkE/dHpc6C7GHRtmIYnAWMk2kbZTAcOkH6teVVkaXGqPbpUONNPevB0Ow24kjy7j8TKjyldgVnF5gJLZlszHIjjl3IOuaWNQ==;
 5:eQUv3AiP1sNumsW70OEorQ5FBtr4xH/EomYsfhgJALWg/sodjbdl4YnKsTjFoZwu9+3bVEoKVCeIUx2+Fcoj82B69v9al09QhOtEJBkvc8knETaqP6TZgx31GaFHg14AE6VdyFCQepcoDhFUteb8jCx8Q7JbT/LGijmN7thpayumlN/loQ2kVo2QCBxNyipyVSxJ8KY2sZoVUO5eIk5T9Q==;
 7:hniWtLSAEnpSIUUk4jdVDs2mew+09b7LTAIjiuywyM1IcL0DzURRNwZngqa14SeKrsmTwxCOw0VxdLVYeddPoghyw+kKIQuSkUSNKLDTpaGa+DBwLfniPhCXnkVS2Kkh+w7vy2gnWDx1dqfwiBWfNQ==
x-ms-office365-filtering-correlation-id: 1888f5b6-e3a4-4f31-7168-08d68a808c7d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0401MB2448; 
x-ms-traffictypediagnostic: VI1PR0401MB2448:
x-microsoft-antispam-prvs: <VI1PR0401MB244877D19E5E5F5A586189A4F16D0@VI1PR0401MB2448.eurprd04.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(36756003)(6486002)(186003)(106356001)(6306002)(6116002)(476003)(14454004)(486006)(7736002)(305945005)(6512007)(966005)(44832011)(8936002)(6436002)(2616005)(3846002)(1076003)(26005)(50226002)(6506007)(386003)(99286004)(11346002)(446003)(102836004)(76176011)(81166006)(81156014)(8676002)(52116002)(86362001)(2906002)(316002)(71200400001)(6636002)(71190400001)(37006003)(478600001)(25786009)(54906003)(105586002)(68736007)(256004)(4326008)(6862004)(97736004)(66066001)(107886003)(53936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB2448;
 H:VI1PR0401MB2496.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g+wNJ1BdS+ZcWmhrcJGiIYZuvkBV1r9c6NrPz/aPPJpFFNggQ5Fzh+RR+0zkSnorVVrzgX2IxFf2t3OY5GWHZtqrc2B4zKdLOYBEpKKnusxK4GtLMKLiNzudOOBu6fMtjONmbwk1s9/qxak82x7688/3POr5a+SfnoZOFpS+UUpX8iMDywn5Su2o94oZmtt+NWyjdaM0NI6XunyuSOoWPZ0GXhA5gcpAw1mdhoYKnos7xrcNWpVxaZG3+uZkbOra5uY1qRS6hZP1mLkaBWgNFqGpXNyrnZGVuIOt68fkYRXzutJgz6wKUyhGnK3/sf8TcOc0wDNoFT1UgPfsZZsuJIXApRwrQnFCx3oC5WRDEz3NcVK/myAU7sBEx9sLFOMWtWku1L1WWJYE3rMGYHIh9iUSZcN8VpgEKIhsuxuEz70=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1888f5b6-e3a4-4f31-7168-08d68a808c7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 09:10:02.5892 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2448
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_011007_921040_9BCC2735 
X-CRM114-Status: GOOD (  16.92  )
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
Cc: Pankaj Bansal <pankaj.bansal@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Wang Dongsheng <dongsheng.wang@freescale.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

FPGA on LX2160AQDS/LX2160ARDB connected on I2C bus, so add qixis
driver which is basically an i2c client driver to control FPGA.

Also added platform driver for MMIO based FPGA, like the one available
on LS2088ARDB/LS2088AQDS.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
---

Notes:
    V3:
    - Add MMIO based FPGA driver
    V2:
    - Modify the driver to not create platform devices corresponding to subnodes.
      because the subnodes are not actual devices.
    - Use mdio_mux_regmap_init/mdio_mux_regmap_uninit
    - Remove header file from include folder, as no qixis api is called from outside
    - Add regmap_exit in driver's remove function
    Dendencies:
    - https://www.mail-archive.com/netdev@vger.kernel.org/msg281274.html

 drivers/soc/fsl/Kconfig      |  11 ++
 drivers/soc/fsl/Makefile     |   1 +
 drivers/soc/fsl/qixis_ctrl.c | 207 +++++++++++++++++++++++++++++++++
 3 files changed, 219 insertions(+)

diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
index 8f80e8bbf29e..75993be04e42 100644
--- a/drivers/soc/fsl/Kconfig
+++ b/drivers/soc/fsl/Kconfig
@@ -28,4 +28,15 @@ config FSL_MC_DPIO
 	  other DPAA2 objects. This driver does not expose the DPIO
 	  objects individually, but groups them under a service layer
 	  API.
+
+config FSL_QIXIS
+	tristate "QIXIS system controller driver"
+	depends on OF
+	select REGMAP_I2C
+	select REGMAP_MMIO
+	default n
+	help
+	  Say y here to enable QIXIS system controller api. The qixis driver
+	  provides FPGA functions to control system.
+
 endmenu
diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
index 803ef1bfb5ff..47e0cfc66ca4 100644
--- a/drivers/soc/fsl/Makefile
+++ b/drivers/soc/fsl/Makefile
@@ -5,5 +5,6 @@
 obj-$(CONFIG_FSL_DPAA)                 += qbman/
 obj-$(CONFIG_QUICC_ENGINE)		+= qe/
 obj-$(CONFIG_CPM)			+= qe/
+obj-$(CONFIG_FSL_QIXIS) 		+= qixis_ctrl.o
 obj-$(CONFIG_FSL_GUTS)			+= guts.o
 obj-$(CONFIG_FSL_MC_DPIO) 		+= dpio/
diff --git a/drivers/soc/fsl/qixis_ctrl.c b/drivers/soc/fsl/qixis_ctrl.c
new file mode 100644
index 000000000000..36a3e1abc465
--- /dev/null
+++ b/drivers/soc/fsl/qixis_ctrl.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/* Freescale QIXIS system controller driver.
+ *
+ * Copyright 2015 Freescale Semiconductor, Inc.
+ * Copyright 2018-2019 NXP
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/mdio-mux.h>
+
+/* QIXIS MAP */
+struct fsl_qixis_regs {
+	u8		id;		/* Identification Registers */
+	u8		version;	/* Version Register */
+	u8		qixis_ver;	/* QIXIS Version Register */
+	u8		reserved1[0x1f];
+};
+
+struct mdio_mux_data {
+	void			*data;
+	struct list_head	link;
+};
+
+struct qixis_priv {
+	struct regmap		*regmap;
+	struct list_head	mdio_mux_list;
+};
+
+static struct regmap_config qixis_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int fsl_qixis_mdio_mux_init(struct device *dev, struct qixis_priv *priv)
+{
+	struct device_node *child;
+	struct mdio_mux_data *mux_data;
+	int ret;
+
+	INIT_LIST_HEAD(&priv->mdio_mux_list);
+	for_each_child_of_node(dev->of_node, child) {
+		if (!of_node_name_prefix(child, "mdio-mux"))
+			continue;
+
+		mux_data = devm_kzalloc(dev, sizeof(struct mdio_mux_data),
+					GFP_KERNEL);
+		if (!mux_data)
+			return -ENOMEM;
+		ret = mdio_mux_regmap_init(dev, child, &mux_data->data);
+		if (ret)
+			return ret;
+		list_add(&mux_data->link, &priv->mdio_mux_list);
+	}
+
+	return 0;
+}
+
+static int fsl_qixis_mdio_mux_uninit(struct qixis_priv *priv)
+{
+	struct list_head *pos;
+	struct mdio_mux_data *mux_data;
+
+	list_for_each(pos, &priv->mdio_mux_list) {
+		mux_data = list_entry(pos, struct mdio_mux_data, link);
+		mdio_mux_regmap_uninit(mux_data->data);
+	}
+
+	return 0;
+}
+
+static int fsl_qixis_probe(struct platform_device *pdev)
+{
+	static struct fsl_qixis_regs __iomem *qixis;
+	struct qixis_priv *priv;
+	int ret;
+	u32 qver;
+
+	qixis = of_iomap(pdev->dev.of_node, 0);
+	if (IS_ERR_OR_NULL(qixis)) {
+		pr_err("%s: Could not map qixis registers\n", __func__);
+		return -ENODEV;
+	}
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(struct qixis_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->regmap = devm_regmap_init_mmio(&pdev->dev, qixis,
+					     &qixis_regmap_config);
+	regmap_read(priv->regmap, offsetof(struct fsl_qixis_regs, qixis_ver),
+		    &qver);
+	pr_info("Freescale QIXIS Version: 0x%08x\n", qver);
+
+	ret = fsl_qixis_mdio_mux_init(&pdev->dev, priv);
+	if (ret)
+		goto error;
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+error:
+	regmap_exit(priv->regmap);
+
+	return ret;
+}
+
+static int fsl_qixis_remove(struct platform_device *pdev)
+{
+	struct qixis_priv *priv;
+
+	priv = platform_get_drvdata(pdev);
+	fsl_qixis_mdio_mux_uninit(priv);
+	regmap_exit(priv->regmap);
+
+	return 0;
+}
+
+static const struct of_device_id fsl_qixis_of_match[] = {
+	{ .compatible = "fsl,fpga-qixis", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, fsl_qixis_of_match);
+
+static struct platform_driver fsl_qixis_driver = {
+	.driver = {
+		.name = "qixis_ctrl",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(fsl_qixis_of_match),
+	},
+	.probe = fsl_qixis_probe,
+	.remove = fsl_qixis_remove,
+};
+module_platform_driver(fsl_qixis_driver);
+
+static int fsl_qixis_i2c_probe(struct i2c_client *client)
+{
+	struct qixis_priv *priv;
+	int ret;
+	u32 qver;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -EOPNOTSUPP;
+
+	priv = devm_kzalloc(&client->dev, sizeof(struct qixis_priv),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->regmap = regmap_init_i2c(client, &qixis_regmap_config);
+	regmap_read(priv->regmap, offsetof(struct fsl_qixis_regs, qixis_ver),
+		    &qver);
+	pr_info("Freescale QIXIS Version: 0x%08x\n", qver);
+
+	ret = fsl_qixis_mdio_mux_init(&client->dev, priv);
+	if (ret)
+		goto error;
+
+	i2c_set_clientdata(client, priv);
+
+	return 0;
+error:
+	regmap_exit(priv->regmap);
+
+	return ret;
+}
+
+static int fsl_qixis_i2c_remove(struct i2c_client *client)
+{
+	struct qixis_priv *priv;
+
+	priv = i2c_get_clientdata(client);
+	fsl_qixis_mdio_mux_uninit(priv);
+	regmap_exit(priv->regmap);
+
+	return 0;
+}
+
+static const struct of_device_id fsl_qixis_i2c_of_match[] = {
+	{ .compatible = "fsl,fpga-qixis-i2c" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, fsl_qixis_i2c_of_match);
+
+static struct i2c_driver fsl_qixis_i2c_driver = {
+	.driver = {
+		.name	= "qixis_ctrl",
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(fsl_qixis_i2c_of_match),
+	},
+	.probe_new	= fsl_qixis_i2c_probe,
+	.remove		= fsl_qixis_i2c_remove,
+};
+module_i2c_driver(fsl_qixis_i2c_driver);
+
+MODULE_AUTHOR("Wang Dongsheng <dongsheng.wang@freescale.com>");
+MODULE_DESCRIPTION("Freescale QIXIS system controller driver");
+MODULE_LICENSE("GPL");
+
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
