Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F569C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:07:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B0DA2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ciZFskZC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zh9OgPv+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0DA2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JLFeYL+0Giz5yPmbIeO+FB3OZ8DMhE1RFQiwR4uPNSI=; b=ciZFskZCNbuW7k
	x/nsbnF+4E9WligKgPlss+fPmWAdyUVULo1AZWf1yiGCg6F5C/VQOSeBZkcs7HYYS2say/uxGtlBW
	P81SE29LLfamovbV50jTT31QjWiJ25Y+B4RGfhuRd2d6bhhSHIZ3/SFs5LWk5T1Kx+XLb71B4i6Js
	tpXduulnR2Oo9Xn2G0pu4sWgN3WwA7K4vmCq0Tz0mnIyP5uK2geKnTysWaz8nn4RXXd8XlnfSlVje
	ncRWSZ93RhvVdGzzfidu6YgpY0EpVZj+bBwY6XJZIoXjUp2vdXgBbKcCGZKDx/nGIXFwBPxL1o35n
	n55IViJHJyoerPY+HUcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gopaT-0005RH-PI; Wed, 30 Jan 2019 13:07:29 +0000
Received: from mail-eopbgr10072.outbound.protection.outlook.com ([40.107.1.72]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gopZE-0004Nx-L4
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 13:06:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iZyEx8VlcbHp8pVhJaRGjm6MZIDXJlNrzKc7nU2heo=;
 b=Zh9OgPv+oov330x0/pE6iuJ4WW7X4Mq8D2d/EOLC3x9IN6helNrgUyEEm+zkUnfmSRxEjVlpYy0r75X/ow40AZ3I5GLoSgILB1kwbPFdCoUT6goW71FTCGUuvxeSwi37tTnkIxLoBAHwvf25h8kjRiTM3Cn+H/j383SnrnfcsAE=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB6033.eurprd04.prod.outlook.com (20.179.32.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.20; Wed, 30 Jan 2019 13:06:07 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51%2]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 13:06:07 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 4/4] irq: imx: irqsteer: add multi output interrupts support
Thread-Topic: [PATCH V2 4/4] irq: imx: irqsteer: add multi output interrupts
 support
Thread-Index: AQHUuJyQDrz3jPZXTky6ZbN3eVmsCA==
Date: Wed, 30 Jan 2019 13:06:07 +0000
Message-ID: <1548853196-11447-5-git-send-email-aisheng.dong@nxp.com>
References: <1548853196-11447-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1548853196-11447-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::33) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB6033;
 6:kLCcIYEpCAphVf+zSpB4imF4zgKuC4L6xKDRzwfAeq5iyikPlzbl4YYTMXdQSa2iMReXvOiZyWOriSorZcnY+SRMcjmjGRsgSOW6V4fWl9ziHIKEoWxmq8lulA/EawmmZzLccpIpYMSXudNqY+1AWU5JzFhH5QHaD7YPRmWD8Pv3EkfUYTe9xFUaf+PrfDafyupexQeUWAaR6Tbbz2UML/mZt0quqIeBL80chKpAi8pLc6NnZt33Rbcz1jHdA7zaPHs7kjIdv7y6j7NmZYC/otKay4ElCtXU8Sav7kiGi6PVjwKUVC9TRUZ3aAiASeqmDHYPHJIUBBzfPaNLVfS9Y64sSpmwh8dyLXQWDgW8WcMXi0c5YGmZH9k5bW8tYLsxQv5rZhfQQxAGsZrYA+kZ2C+G5mIpyA5CSf897QvowO2mbwa6D79ahFEu6srVDgrE+Q4KGqHClieV6qaVYB1m4A==;
 5:/2DzkUBRRrU1FJXt8NV0B+Pa6Q3kO1phc2mgbQ9ahRiQ859kppyrozF6LihHgGuGlZW7veCXO+Ov2fpdZzurZsyqUREip5UdlOM4hi0g/VkpBMoMDQPl6vCXBe0pSgqUI7uculXvrE/xBNQfD0Zw1XAACfbnZZukEwB51xWxikhO9kXT+Hk2OTMxWpnt1ns2wuM2hks/UbGlGJwcdOKyWQ==;
 7:IUoQp9wDzhMX+e/pznwQw0n48fueNcmmQMZ/Q+v2I5XxDOdI/9x9nNe6DIt+LCdkJJfLRaA4nNCdfCmfVKtNRtqeP9Ylz6T/hzFt1tJoHxTYST5FR3VTTm98QhpeSnAY4iosHt0Q/UbeoiBzLNciTw==
x-ms-office365-filtering-correlation-id: 68a71300-6f91-4fb9-a334-08d686b3b23d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB6033; 
x-ms-traffictypediagnostic: AM0PR04MB6033:
x-microsoft-antispam-prvs: <AM0PR04MB603335C18A579F894AB2E2D180900@AM0PR04MB6033.eurprd04.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(136003)(376002)(396003)(346002)(39860400002)(189003)(199004)(54534003)(316002)(81156014)(50226002)(2351001)(106356001)(71190400001)(44832011)(486006)(68736007)(52116002)(186003)(71200400001)(4326008)(25786009)(26005)(105586002)(478600001)(86362001)(76176011)(102836004)(386003)(6506007)(81166006)(2906002)(8676002)(476003)(97736004)(6916009)(6512007)(53936002)(66066001)(2616005)(14444005)(8936002)(6436002)(7736002)(305945005)(14454004)(36756003)(54906003)(2501003)(6116002)(6486002)(446003)(11346002)(3846002)(5640700003)(256004)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB6033;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: v2FVSBbHVn6K37lroBNqIXfPM22AmOrpLk6Atpt3f2sdUJ8NnbZSTtsC/OlzcoxGT6KqNZkLM84zYkmFIJbB4yj1s6wKa7BAo/zGMxBFonvzq/8hrMWW38kxk4n4m3kTxQXMeL5Nr1/9vqUtBWEDKtCOuhoVUmVR3sQVkBCrMCXwdBNXYqzZA8DjWIOUIzkq/Lb6yJdMCCQIYZ4RfoLNqqe7LGCMCXjTkoLWA0pwtLJW0MF2crrYBPCFUmXZvPfroVh4C1MMAavFFrRigHd3SnsuA8Q+K1lEEGRfLsTuNmDqgF+FGZ7IfXhEKRlmWsEarVCTzsaJ2P4mV/UZ9Q60+AjdH75qb1916uxLPIE3X8qgpCBC0nBXO4f8MWQWzE3BnzAf7ca/8PlmDlPJkXU0Wu72q3J/fopzV0pRBpNqWKw=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a71300-6f91-4fb9-a334-08d686b3b23d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 13:06:03.4482 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6033
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_050613_086679_770B1C40 
X-CRM114-Status: GOOD (  16.67  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

One irqsteer channel can support up to 8 output interrupts.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v1->v2:
 * calculate irq_count by fsl,num-irqs instead of parsing interrupts
   property from devicetree to match the input interrupts and outputs
 * improve output interrupt handler by searching only two registers
   withint the same group
---
 drivers/irqchip/irq-imx-irqsteer.c | 76 +++++++++++++++++++++++++++++---------
 1 file changed, 59 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index 67ed862..cc40039 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -10,6 +10,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/spinlock.h>
 
@@ -21,10 +22,13 @@
 #define CHAN_MINTDIS(t)		(CTRL_STRIDE_OFF(t, 3) + 0x4)
 #define CHAN_MASTRSTAT(t)	(CTRL_STRIDE_OFF(t, 3) + 0x8)
 
+#define CHAN_MAX_OUTPUT_INT	0x8
+
 struct irqsteer_data {
 	void __iomem		*regs;
 	struct clk		*ipg_clk;
-	int			irq;
+	int			irq[CHAN_MAX_OUTPUT_INT];
+	int			irq_count;
 	raw_spinlock_t		lock;
 	int			reg_num;
 	int			channel;
@@ -87,26 +91,45 @@ static const struct irq_domain_ops imx_irqsteer_domain_ops = {
 	.xlate		= irq_domain_xlate_onecell,
 };
 
+static int imx_irqsteer_get_hwirq_base(struct irqsteer_data *data, u32 irq)
+{
+	int i;
+
+	for (i = 0; i < data->irq_count; i++) {
+		if (data->irq[i] == irq)
+			break;
+	}
+
+	return i * 64;
+}
+
 static void imx_irqsteer_irq_handler(struct irq_desc *desc)
 {
 	struct irqsteer_data *data = irq_desc_get_handler_data(desc);
+	int hwirq;
 	int i;
 
 	chained_irq_enter(irq_desc_get_chip(desc), desc);
 
-	for (i = 0; i < data->reg_num * 32; i += 32) {
-		int idx = imx_irqsteer_get_reg_index(data, i);
+	hwirq = imx_irqsteer_get_hwirq_base(data, irq_desc_get_irq(desc));
+
+	for (i = 0; i < 2; i++) {
+		int idx = imx_irqsteer_get_reg_index(data, hwirq);
 		unsigned long irqmap;
 		int pos, virq;
 
+		if (hwirq >= data->reg_num * 32)
+			break;
+
 		irqmap = readl_relaxed(data->regs +
 				       CHANSTATUS(idx, data->reg_num));
 
 		for_each_set_bit(pos, &irqmap, 32) {
-			virq = irq_find_mapping(data->domain, pos + i);
+			virq = irq_find_mapping(data->domain, pos + hwirq);
 			if (virq)
 				generic_handle_irq(virq);
 		}
+		hwirq += 32;
 	}
 
 	chained_irq_exit(irq_desc_get_chip(desc), desc);
@@ -117,7 +140,8 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct irqsteer_data *data;
 	struct resource *res;
-	int ret;
+	u32 irqs_num;
+	int i, ret;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -130,12 +154,6 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 		return PTR_ERR(data->regs);
 	}
 
-	data->irq = platform_get_irq(pdev, 0);
-	if (data->irq <= 0) {
-		dev_err(&pdev->dev, "failed to get irq\n");
-		return -ENODEV;
-	}
-
 	data->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(data->ipg_clk)) {
 		ret = PTR_ERR(data->ipg_clk);
@@ -146,11 +164,17 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 
 	raw_spin_lock_init(&data->lock);
 
-	of_property_read_u32(np, "fsl,num-irqs", &data->reg_num);
+	of_property_read_u32(np, "fsl,num-irqs", &irqs_num);
 	of_property_read_u32(np, "fsl,channel", &data->channel);
 
-	/* one register bit map represents 32 input interrupts */
-	data->reg_num /= 32;
+	/*
+	 * There is one output irqs for each group of 64 inputs.
+	 * One register bit map can represent 32 input interrupts.
+	 */
+	data->irq_count = irqs_num / 64;
+	if (irqs_num % 64)
+		data->irq_count += 1;
+	data->reg_num = irqs_num / 32;
 
 	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
 		data->saved_reg = devm_kzalloc(&pdev->dev,
@@ -177,8 +201,22 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	irq_set_chained_handler_and_data(data->irq, imx_irqsteer_irq_handler,
-					 data);
+	if (!data->irq_count || data->irq_count > CHAN_MAX_OUTPUT_INT) {
+		clk_disable_unprepare(data->ipg_clk);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < data->irq_count; i++) {
+		data->irq[i] = irq_of_parse_and_map(np, i);
+		if (!data->irq[i]) {
+			clk_disable_unprepare(data->ipg_clk);
+			return -EINVAL;
+		}
+
+		irq_set_chained_handler_and_data(data->irq[i],
+						 imx_irqsteer_irq_handler,
+						 data);
+	}
 
 	platform_set_drvdata(pdev, data);
 
@@ -188,8 +226,12 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 static int imx_irqsteer_remove(struct platform_device *pdev)
 {
 	struct irqsteer_data *irqsteer_data = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < irqsteer_data->irq_count; i++)
+		irq_set_chained_handler_and_data(irqsteer_data->irq[i],
+						 NULL, NULL);
 
-	irq_set_chained_handler_and_data(irqsteer_data->irq, NULL, NULL);
 	irq_domain_remove(irqsteer_data->domain);
 
 	clk_disable_unprepare(irqsteer_data->ipg_clk);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
