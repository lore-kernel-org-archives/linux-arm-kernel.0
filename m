Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD3EC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:15:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A34A62083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GNpyoixm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uS4dV5IO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34A62083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F3eb8EcRBW1o6JG2korou2Glo8vJlI0DA0QaAi6Lb6A=; b=GNpyoixmzf8hn8
	nKJYlAblhmQhwQcfV/8/P8h5/3i5EqlBHcbNIBc38Tma/MTBdrfwGUEMOfx+lnm7TdajzN071sCum
	WzpCYY+6hP9OuZh3s5IzA2Fyv5ncUnBHBqpzUusTVM6VX3p2FHsMdigwWA/r0rScnUoR7Xz8uqvav
	0yGQGymBLPNBmCNgRtRUYdPG+Wj0FXf+8HPYYvONyExQKJnt+ejayy8gzahETntfDwAZDjnioGQwp
	wyh0OWSA0GGgyTarZlzXWcPEEFYDRBs3GZNfxlgrCg70y5/ioKb73XitZ39ajzk0GLVSxl25jq4ie
	s6r6N7vAmpphAXnXi5eA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqxlK-0002o1-UL; Tue, 05 Feb 2019 10:15:30 +0000
Received: from mail-eopbgr140040.outbound.protection.outlook.com
 ([40.107.14.40] helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqxkf-0000zW-Ek
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 10:14:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEeCugRCEzwda8+ww8BQ87phkWrfvHjrH4KOQhdI4ok=;
 b=uS4dV5IOvJOsOSJ1oDEJlsQJ+tsTYEvo9oVN76Il44ZwFZTW5ZgevrbDLL2P2bjnXlF/y38VmC7254XmJ0G/hTpI7ylPIF3hJqNjZBSwygqT6TD3QyrrKs1gzFaaUy5TtftF485x/i1uUAIclsU3qMsY2BjaHNaCZ9GpebXaZmw=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2030.eurprd04.prod.outlook.com (10.166.141.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Tue, 5 Feb 2019 10:14:43 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 10:14:43 +0000
From: Pankaj Bansal <pankaj.bansal@nxp.com>
To: Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 2/2] drivers: soc: fsl: add qixis driver
Thread-Topic: [PATCH v4 2/2] drivers: soc: fsl: add qixis driver
Thread-Index: AQHUvTucmPc6ljT2C0iw7LN0XZriZw==
Date: Tue, 5 Feb 2019 10:14:42 +0000
Message-ID: <20190205153924.7204-3-pankaj.bansal@nxp.com>
References: <20190205153924.7204-1-pankaj.bansal@nxp.com>
In-Reply-To: <20190205153924.7204-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::29) To VI1PR0401MB2496.eurprd04.prod.outlook.com
 (2603:10a6:800:56::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [92.120.1.69]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0401MB2030;
 6:bU0F4L/k3aDHwn/een25uXgVLp6WRPDGsr1Hg6OL1cAfR3V08oOvxbZacUxx24DtIZAW3uzjoEIElkstMPWgPHmsYkbDotgOMKH9dwPeHw7lOKlDwRf7oFY8Q733RWF/IinUr+xsblivv/C4AHbPYtSaPV8yPfnnqntII90nx2BKhZJA1XsZYidRYWi4izUKLzSsqQ8PeJ0TbBf+7LF58/pGVLTrScK21dJeTG77Pp5LE0Qd4Sc3aWxSmSIiPVG+OPEDgOW7NLg16VpZDwPcycXz6AJDrLf0EMH9SKrnmvW9P95bVmrq9RUDWoRHI7pAYg5Dd8lDeNxgaAHwdgjEtYU9rbF2WiYwj/fOBveHSDrPYqWlmgimOQKw1o7+FIXsIcmcR4sTM7xPAlGGzI0NJsbSVb4ufNHvW/1GWlGM+x1D+SxyBS86L1Uz71u7NwlbkvnWTlDSQuqupeuxg+UaSg==;
 5:n77AcTiGsCArUuNHv3wzQ9L/ukTYgROmvStEPQnUkZibcxV3GcE33olFgBNux+/AVaky/jz5ML3XO5qFfA2J0kPuR6fm5+2jqJWu4Atln1+jow7hmP88pOZJ6rrdcRhtPy7q8910orkab4rDBVR0/3Em38DJFoV94yyJIIsqflPFrM7xzmoB8B8C6JApI9F4yOW2+ph4cdZ8YZ5c2B2L1w==;
 7:QtiJfoaC2Gyur88wuBLCixnhdy9ZtvJ+kg/2STyTAneImGFpIWfn1+Nt5tATzO3FOgQc5VAI5QGDsupdX/BvrNx5D1V5rqAbv1pu/AFbPkK5AuctXnxGzqWMpOHKqycFhnkAf/cF49ypdUxqJbzn9Q==
x-ms-office365-filtering-correlation-id: 0bcf9609-9048-49ce-2b8e-08d68b52bef7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0401MB2030; 
x-ms-traffictypediagnostic: VI1PR0401MB2030:
x-microsoft-antispam-prvs: <VI1PR0401MB20307D2744175F80947BA235F16E0@VI1PR0401MB2030.eurprd04.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(376002)(366004)(136003)(346002)(199004)(189003)(25786009)(8676002)(2906002)(26005)(14454004)(102836004)(107886003)(386003)(6506007)(99286004)(6436002)(6486002)(6512007)(4326008)(8936002)(71190400001)(81166006)(81156014)(71200400001)(256004)(6306002)(105586002)(76176011)(36756003)(106356001)(52116002)(486006)(6116002)(3846002)(44832011)(446003)(7736002)(110136005)(11346002)(476003)(2616005)(966005)(68736007)(316002)(86362001)(53936002)(186003)(1076003)(50226002)(305945005)(478600001)(97736004)(54906003)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB2030;
 H:VI1PR0401MB2496.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +XqmeUdkOevlZQ7LvgvgMzg1ICnh/JlFO0pOYd8WS6cwr+LNBsOB0tC/u0yz5ugnR17f0/MldkyEgZw5oqEybyf0+b2zbM+HrPYLQ1DcdxnGFKCYsk7d9VtL+Di47IeFK5lJ7JnqI93Hg2/D6VQgUI4Yi70kmiYFLpPJ5VQN+ekPqU5ATNwm2zF6hWMnYUi/txlZ1aSpBvmX37yKoZsAdPxQP3BXb6T41QAhyKE3uF3uNsKJLJ345rfe2QM5iirvAPSoNdu6KAjPyJmUqBYoBy2CV+cs8nPOnJqM642v6kqN0+jO8GA622VLe2b3Una2D8I/i63HvolY1hqU2K2kKtcBHV70J75Y6Ldbwtcv4hvX41rge2wn3j1C2VNtU5HFhXIJZ8Zlg0MexSA3zRHhGrLV8HymBLURPQR+kQBhKfU=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bcf9609-9048-49ce-2b8e-08d68b52bef7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 10:14:41.1851 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2030
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_021449_736360_8B2EC687 
X-CRM114-Status: GOOD (  17.11  )
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
Cc: "open list : OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
 Pankaj Bansal <pankaj.bansal@nxp.com>,
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
    V4:
    - Fix compilation error when qixis_ctrl is built as standalone module.
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
 drivers/soc/fsl/qixis_ctrl.c | 222 +++++++++++++++++++++++++++++++++
 3 files changed, 234 insertions(+)

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
index 000000000000..a8108bfd5195
--- /dev/null
+++ b/drivers/soc/fsl/qixis_ctrl.c
@@ -0,0 +1,222 @@
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
+		.name	= "qixis_ctrl_i2c",
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(fsl_qixis_i2c_of_match),
+	},
+	.probe_new	= fsl_qixis_i2c_probe,
+	.remove		= fsl_qixis_i2c_remove,
+};
+
+static int __init fsl_qixis_init(void)
+{
+	pr_info("FSL: Qixis Control driver\n");
+
+	if (platform_driver_register(&fsl_qixis_driver))
+		pr_warn("could not register Qixis Control platform driver\n");
+	return i2c_add_driver(&fsl_qixis_i2c_driver);
+}
+module_init(fsl_qixis_init);
+
+static void __exit fsl_qixis_exit(void)
+{
+	platform_driver_unregister(&fsl_qixis_driver);
+	i2c_del_driver(&fsl_qixis_i2c_driver);
+}
+module_exit(fsl_qixis_exit);
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
