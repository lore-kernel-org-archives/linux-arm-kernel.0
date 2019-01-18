Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6C4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:54:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4634620850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EXRUbAVe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AT7h48Fl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4634620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6k+wLVbuwVPGjbQuThiBIF8voePgvqUxVFLqipoGtCo=; b=EXRUbAVe+f8rGm
	IYe12SM0bs3MofYeNvNEj/tmwdsNNSAH/wrSNPvygkZZmw5WhLoMIvMmGJl20WrAl9b2y1NprBnfw
	9L3PmE3mrRcQwgzGjsJx+85kKq1iEatTJyXG+PCt7NA7Bk1iGDHayj483xG88PvGV3hOOLTOfly/1
	LoM+Gu/eClszrUEQzYeOYQjtYofEOhCo93EJQmsX/yE3xgw9dGbt1yRysAHC9P8j8VgL6E/7lTZ18
	PLYGz9sLyHsE6FbXDaYri1mig6cNTu129L/q//2oqxgcIu0I+/k6pgBS5Hf1CCwfA42yXRYGmLX0Z
	5W0X5hTLYLna0lkYQhjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkOz5-0006tw-DY; Fri, 18 Jan 2019 07:54:35 +0000
Received: from mail-eopbgr80054.outbound.protection.outlook.com ([40.107.8.54]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkOyU-0006BE-7E
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 07:54:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xF/DGTmgql/u0Rm20oun0kOIoGbJr1bdcmzdeTpSDuk=;
 b=AT7h48Flvn31MDNonYbgYOZzrfUdtOb8RqZJCKQBzurf9Lal0aZnnyN4PjctbTaOlv1oVNt+8K/Z9BeJnMrlxH2titNfFXqnjtxV5RQl5EQJ2/1rmMKwN9HswbTG8RgT5AX2VBtxc6TntfbDiIz7osllEhoGuPBH9kqSLdFn+DU=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB6001.eurprd04.prod.outlook.com (20.178.114.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Fri, 18 Jan 2019 07:53:54 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 07:53:54 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] irq: imx-irqsteer: change to use reg_num instead of
 irq_group
Thread-Topic: [PATCH 3/4] irq: imx-irqsteer: change to use reg_num instead of
 irq_group
Thread-Index: AQHUrwL1mZbwrCQ4VE60JWrhOnWQXg==
Date: Fri, 18 Jan 2019 07:53:53 +0000
Message-ID: <1547797668-30342-4-git-send-email-aisheng.dong@nxp.com>
References: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0197.apcprd02.prod.outlook.com
 (2603:1096:201:21::33) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB6001;
 6:MZzb6sKBr3GqG4LPrEB7L0iYf+7FgCvZ3wxMsUs6y3Gi4rrji1efH/2pMf3mJzbSfhVQzoquMdCCkg+SX+cD7Tb6l56a+3SL3qcjJh2O0VTW3EirtQD0Cx3DL4TFUGlHHefxnNo1luEGBeaVxVUY8t+9imeuvbuLWiPeVHYyJQWN/5DpJoOE+ZVYOac7CtiN3YqMyidgdxx1Oie23GtOpWJeVOz1RqFnMxzUITOTSVzhmBJC8jtg5cVl87cm3CrmGm/b9hefieyIDxPtGTW5jwZ/ibs+YVIaiYCC7vIqOzOBHkDXzW9hUSO6GeeVe/cUX6CNcMAoIYrVxzRdMTBDK8kA3UVTxIC5tWG6YSv120uJaSSiMIi8ERg/Yt1n2dV37OXv7EV2NFo5e6LBkgvgFctqNWU5U53xfRm5Jiq4m4wkAqGmnzv4zO01NRudUOrjUOF8lVzzQn0imvDPfeyQWQ==;
 5:JXMXqGsNT67BKiWd6BlXUYihznLeXgc9AU9qvodXiLDFr/CJ+Rh3hvJZ8QDdreBkTEvniRwYdusXo0Ajyfraia3Tc5o8B4qzHhQuWen8gtdQQe5pw/T9+kemsH/nOstshDeh9fHuU9/vY98NDb6lNfPpGqFNPWMTTZdEwwbg01cLFuD/DVJzBtz5CYiA8OcL6A4pYqH/aEG0VIfAgpw9eg==;
 7:/2d1GJJ7BrvCgVulKXr/FrF+fmlfmPc/Unmi+m+vtaiUhzgVkQmNgunmxeP2AL9WKJ7Wjr7f1W8YWaMQnpnEPOj16y+5E8u0wnUVhSTAFBS7FZnI8qq5tMYhn9BYoCxWYSJdgXWLZiP31R9y4SqWGg==
x-ms-office365-filtering-correlation-id: 6d0e0805-bc13-47d2-7837-08d67d1a178e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB6001; 
x-ms-traffictypediagnostic: AM0PR04MB6001:
x-microsoft-antispam-prvs: <AM0PR04MB600118D054662E84C155D772809C0@AM0PR04MB6001.eurprd04.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(366004)(346002)(376002)(136003)(199004)(189003)(7736002)(486006)(54906003)(81156014)(316002)(256004)(6486002)(305945005)(53936002)(99286004)(44832011)(8936002)(8676002)(36756003)(81166006)(6512007)(2501003)(5660300001)(6116002)(446003)(3846002)(2616005)(5640700003)(11346002)(50226002)(97736004)(14444005)(26005)(105586002)(6506007)(71190400001)(71200400001)(2351001)(476003)(186003)(102836004)(6436002)(76176011)(4326008)(25786009)(52116002)(386003)(86362001)(6916009)(2906002)(68736007)(66066001)(478600001)(14454004)(106356001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB6001;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FaQdBlmW79c8NQ8xzbIQUSwjVZUl5Gek51BxnbaGrNz3jWL2SJJSxnctCDoGOW9/ekMrfKPR8ZPxXevymbF25giq4DlSC+Uy1XkuLAR6lf0t+OzgMlDLGdHWwIA50fA8cVfKTZlehy2PuNIjTxCCub1ItRPemqzKMJJs4vnMlBLwKjhoPqMNAFyFhWR2FrsCBivaQ5+jZTBOfM8yqCD7V+KvKoniZmJBLX2vMHmodPBDiL9zlDm3mpOUnX4e4FHivqV1+InL0TJW7JJlK21EaW3SITZsrJ3pURanr/B6EQbiB9MqYLbPsibDJncIXZoRKUXJFiw2NWocy4kek44iBWYrLBbSZjy+OXEPio7v2t+JDX56xbm7eT/00Xvrh4aPJnoK8BGjRuKrtp/UaW8KTWsIIFmSF3hRqjDDhBgcSJ4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0e0805-bc13-47d2-7837-08d67d1a178e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 07:53:49.9751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6001
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_235358_315453_5E25B472 
X-CRM114-Status: GOOD (  17.12  )
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

One group can manage 64 interrupts by using two registers (e.g. STATUS/SET).
However, the integrated irqsteer may support only 32 interrupts which
needs only one register in a group. But the current driver assume there's
a mininum of two registers in a group which result in a wrong register map
for 32 interrupts per channel irqsteer. Let's use the reg_num caculated by
interrupts per channel instead of irq_group to cover this case.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/irqchip/irq-imx-irqsteer.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index 5b3f1d7..1bebf0a 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -13,7 +13,7 @@
 #include <linux/of_platform.h>
 #include <linux/spinlock.h>
 
-#define CTRL_STRIDE_OFF(_t, _r)	(_t * 8 * _r)
+#define CTRL_STRIDE_OFF(_t, _r)	(_t * 4 * _r)
 #define CHANCTRL		0x0
 #define CHANMASK(n, t)		(CTRL_STRIDE_OFF(t, 0) + 0x4 * (n) + 0x4)
 #define CHANSET(n, t)		(CTRL_STRIDE_OFF(t, 1) + 0x4 * (n) + 0x4)
@@ -26,7 +26,7 @@ struct irqsteer_data {
 	struct clk		*ipg_clk;
 	int			irq;
 	raw_spinlock_t		lock;
-	int			irq_groups;
+	int			reg_num;
 	int			channel;
 	struct irq_domain	*domain;
 	u32			*saved_reg;
@@ -35,7 +35,7 @@ struct irqsteer_data {
 static int imx_irqsteer_get_reg_index(struct irqsteer_data *data,
 				      unsigned long irqnum)
 {
-	return (data->irq_groups * 2 - irqnum / 32 - 1);
+	return (data->reg_num - irqnum / 32 - 1);
 }
 
 static void imx_irqsteer_irq_unmask(struct irq_data *d)
@@ -46,9 +46,9 @@ static void imx_irqsteer_irq_unmask(struct irq_data *d)
 	u32 val;
 
 	raw_spin_lock_irqsave(&data->lock, flags);
-	val = readl_relaxed(data->regs + CHANMASK(idx, data->irq_groups));
+	val = readl_relaxed(data->regs + CHANMASK(idx, data->reg_num));
 	val |= BIT(d->hwirq % 32);
-	writel_relaxed(val, data->regs + CHANMASK(idx, data->irq_groups));
+	writel_relaxed(val, data->regs + CHANMASK(idx, data->reg_num));
 	raw_spin_unlock_irqrestore(&data->lock, flags);
 }
 
@@ -60,9 +60,9 @@ static void imx_irqsteer_irq_mask(struct irq_data *d)
 	u32 val;
 
 	raw_spin_lock_irqsave(&data->lock, flags);
-	val = readl_relaxed(data->regs + CHANMASK(idx, data->irq_groups));
+	val = readl_relaxed(data->regs + CHANMASK(idx, data->reg_num));
 	val &= ~BIT(d->hwirq % 32);
-	writel_relaxed(val, data->regs + CHANMASK(idx, data->irq_groups));
+	writel_relaxed(val, data->regs + CHANMASK(idx, data->reg_num));
 	raw_spin_unlock_irqrestore(&data->lock, flags);
 }
 
@@ -94,13 +94,13 @@ static void imx_irqsteer_irq_handler(struct irq_desc *desc)
 
 	chained_irq_enter(irq_desc_get_chip(desc), desc);
 
-	for (i = 0; i < data->irq_groups * 64; i += 32) {
+	for (i = 0; i < data->reg_num * 32; i += 32) {
 		int idx = imx_irqsteer_get_reg_index(data, i);
 		unsigned long irqmap;
 		int pos, virq;
 
 		irqmap = readl_relaxed(data->regs +
-				       CHANSTATUS(idx, data->irq_groups));
+				       CHANSTATUS(idx, data->reg_num));
 
 		for_each_set_bit(pos, &irqmap, 32) {
 			virq = irq_find_mapping(data->domain, pos + i);
@@ -146,12 +146,15 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 
 	raw_spin_lock_init(&data->lock);
 
-	of_property_read_u32(np, "fsl,irq-groups", &data->irq_groups);
+	of_property_read_u32(np, "fsl,chan-irq-number", &data->reg_num);
 	of_property_read_u32(np, "fsl,channel", &data->channel);
 
+	/* one register bit map represents 32 input interrupts */
+	data->reg_num /= 32;
+
 	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
 		data->saved_reg = devm_kzalloc(&pdev->dev,
-					sizeof(u32) * data->irq_groups * 2,
+					sizeof(u32) * data->reg_num,
 					GFP_KERNEL);
 		if (!data->saved_reg)
 			return -ENOMEM;
@@ -166,7 +169,7 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 	/* steer all IRQs into configured channel */
 	writel_relaxed(BIT(data->channel), data->regs + CHANCTRL);
 
-	data->domain = irq_domain_add_linear(np, data->irq_groups * 64,
+	data->domain = irq_domain_add_linear(np, data->reg_num * 32,
 					     &imx_irqsteer_domain_ops, data);
 	if (!data->domain) {
 		dev_err(&pdev->dev, "failed to create IRQ domain\n");
@@ -199,9 +202,9 @@ static void imx_irqsteer_save_regs(struct irqsteer_data *data)
 {
 	int i;
 
-	for (i = 0; i < data->irq_groups * 2; i++)
+	for (i = 0; i < data->reg_num; i++)
 		data->saved_reg[i] = readl_relaxed(data->regs +
-						CHANMASK(i, data->irq_groups));
+						CHANMASK(i, data->reg_num));
 }
 
 static void imx_irqsteer_restore_regs(struct irqsteer_data *data)
@@ -209,9 +212,9 @@ static void imx_irqsteer_restore_regs(struct irqsteer_data *data)
 	int i;
 
 	writel_relaxed(BIT(data->channel), data->regs + CHANCTRL);
-	for (i = 0; i < data->irq_groups * 2; i++)
+	for (i = 0; i < data->reg_num; i++)
 		writel_relaxed(data->saved_reg[i],
-			       data->regs + CHANMASK(i, data->irq_groups));
+			       data->regs + CHANMASK(i, data->reg_num));
 }
 
 static int imx_irqsteer_suspend(struct device *dev)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
