Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA48C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:01:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09F1B21019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qc82SJ4x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uSHYxRPK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F1B21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/kKUlskG213NtFg34ofndYkRfEd2Q5NyHFXI35axcN4=; b=Qc82SJ4xLXGLbA
	IKUzLoYsLdUqPmgMkfSBD5/bnPvUnMEI4lXO5pGzXyfdJYx6BQga2OojCnyXtAGXWq3SwrJXkdFkW
	3k7HMtdVnUVEm9xrc50Gkg81hzLB/OKfqN79z6C+S/35RkNpYvfqfG/3U3HMLgkkAqoh+qjBQYaxR
	JzzW3LMQQbChUOR4nvl86LTGnPg88bClnKlCqMoCSkwV69wLo4veSQLQjvjqL2KeTR09naifGqU3c
	Xn1sBlWyY78aBINqXhZb5JbpebZF9jP1vPBzjWzPhocZowUXwcyBt3i5lQu73EgzIY1vykHpxCdtD
	T1F8DbAaQzy9uUH/L2gQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmDTv-00074w-0t; Wed, 23 Jan 2019 08:01:55 +0000
Received: from mail-eopbgr30078.outbound.protection.outlook.com ([40.107.3.78]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmDTU-0006fC-L3
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 08:01:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAdDEoXk0f/CP5Ggd1Nnff1SqHPuZxmgBFDT4AgAo3M=;
 b=uSHYxRPKAXdzzoN6t6FaCsb9BtXNf2y8ogy3S5EZrIjRODz1dk0xM37VDElSDjjOPWHs/GE6MowxZ/G/Dp1TfaIbE4Z8w92xmTBjJyNTgCPj/IFBB9zBhjGWPnlfZiNTnR7m/HsOEXOFqfqOekEnvf7eyu/D2D02h/jvPyZbvyk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3851.eurprd04.prod.outlook.com (52.134.73.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Wed, 23 Jan 2019 08:01:16 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1537.031; Wed, 23 Jan 2019
 08:01:16 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, Aisheng
 Dong <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org"
 <ulf.hansson@linaro.org>, Daniel Baluta <daniel.baluta@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/3] firmware: imx: enable imx scu general irq function
Thread-Topic: [PATCH 2/3] firmware: imx: enable imx scu general irq function
Thread-Index: AQHUsvHRXuytUps5mk6GTK7yeDAbWQ==
Date: Wed, 23 Jan 2019 08:01:16 +0000
Message-ID: <1548230179-26076-2-git-send-email-Anson.Huang@nxp.com>
References: <1548230179-26076-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1548230179-26076-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0142.apcprd02.prod.outlook.com
 (2603:1096:202:16::26) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB3PR0402MB3851;
 6:vkJefNddgCWwCynIIYXX2qFTljJxIeZKZ9Oqmj/Z2rTXBHb1ng3B0iITTUM3xjRt7zZs4EJqZUVkXT/KqjK//1Epp7924rFNI9uoXxjmc4DHT4tXLVMZytfzoSsZBtKYjxak/gRmERMOlN1bgvSI4dA8eKYwtfG0XEWRTgX7XsgcuFfgeFB9kAjSMQqa+obcWKjhI2XWmcDMQQA0zQ+NCAWnwLE+F0b/UcFHia8qhnT5E5c+hNaKkBYPAJKkzKwSY5X7ERA4n8SMheAfNvDb8KbVcoskV6CEsJRGs2OMEaHcG3FpdM729QDUNdzJHZeNHfS/0++qy2/9QY0ZwygLAVt8eoHpCMk3GduR456pxgLZBX9rOIKhgaTrix8M+g0Kp42orNXHZ/zTli0rWoxV/jUESNXvb1Ua9edyxarDFsFEy73xwuK5jp9faCiDtWR39M3Bgn0wdfu3bbqUPf8upg==;
 5:18j4r2QiYAL7KmYM7cSDWwibQc+M95qMgS/zXpXXcFGJtaK1wjuWC0CRLxk1RzDo2l/pGpPFdb0Gdo9O7DSeYlt4soOkngqdW3RmOFznXnZQbOqxjpCfuNcQ9FAg3zZzwvnL6uwUV4wyir9I5UKJX+oGn02IdpsTNMheH1DQ1fTDUJdMD3XCVDacrwpfPyp4IDd4m8Xm8n/QxXD+QHvoDQ==;
 7:XU78+iiSfyEQ4qnVvY8RI43U2aii8J/0Dka/qtTMAuEyWHSPDRzCxsbOU1QHDA/y/mtaYMFcQZCxiZm05Onh+R1SpHMeMPIHBWNdODZqiMLfCbtgpLj4ssip45pMV2lDeAZZ/ZDbbivxbpdRSCMoJw==
x-ms-office365-filtering-correlation-id: ae96021c-63c7-4478-998a-08d68108f399
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3851; 
x-ms-traffictypediagnostic: DB3PR0402MB3851:
x-microsoft-antispam-prvs: <DB3PR0402MB3851FBC6CB916BFFBAA75A02F5990@DB3PR0402MB3851.eurprd04.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(396003)(39860400002)(136003)(376002)(366004)(189003)(199004)(39060400002)(14454004)(106356001)(25786009)(6512007)(4326008)(478600001)(6486002)(68736007)(105586002)(36756003)(6436002)(53936002)(97736004)(7416002)(6506007)(66066001)(86362001)(102836004)(386003)(6116002)(11346002)(2616005)(476003)(3846002)(186003)(2906002)(305945005)(71200400001)(256004)(81166006)(316002)(81156014)(110136005)(8676002)(99286004)(50226002)(8936002)(71190400001)(26005)(52116002)(14444005)(76176011)(2501003)(486006)(7736002)(2201001)(446003)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3851;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: B/t4Y9eOVRzYA4/muE+A/HNdTKnfm3lavHxU6veYu3ORg2RdjaM8cax+e7lYd6nDVPLQB2jk8iHTX/VF4hT35M5axaHTQMTNAu+r8EQrr22RcuJQT6nsjnVdKSfMaNRunILSnfiZa5eEoHsJ4fpM1M2b9ZVRMfyrqVlfZa0gVGNOKNynV3cDKX+xakBzPPvpse0Kju1aL7TXKTGNNKaf4Cq99DoBAux3mGePPLrcWPAiYzfceYzOG+4SGnHxuyvm/qlUxebmchQkYyqfxMtzYIUaxxAznEY3QFE2+GCp5QYHiwF+oQ8m8ziaVd0Fg1/rankX3bxkJ9IdEECyOx8HhZoJxOxg8WQ6QprlxJU+oSSetjAG5X5Cpw0ucg1dND3dKiM76E0WPcIKxwiyYRNEs7ohVcVOkOuTPH/13rlXO8A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae96021c-63c7-4478-998a-08d68108f399
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 08:01:12.3029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3851
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_000129_110119_68F7EE74 
X-CRM114-Status: GOOD (  16.39  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The System Controller Firmware (SCFW) controls RTC, thermal
and WDOG etc., these resources' interrupt function are managed
by SCU. When any IRQ pending, SCU will notify Linux via MU general
interrupt channel #3, and Linux kernel needs to call SCU APIs
to get IRQ status and notify each module to handle the interrupt.

Since there is no data transmission for SCU IRQ notification, so
doorbell mode is used for this MU channel, and SCU driver will
use notifier mechanism to broadcast to every module which registers
the SCU block notifier.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/firmware/imx/imx-scu.c   | 101 +++++++++++++++++++++++++++++++++++++++
 include/linux/firmware/imx/sci.h |   3 ++
 2 files changed, 104 insertions(+)

diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 2bb1a19..e93bea5 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -7,6 +7,7 @@
  *
  */
 
+#include <dt-bindings/firmware/imx/rsrc.h>
 #include <linux/err.h>
 #include <linux/firmware/imx/types.h>
 #include <linux/firmware/imx/ipc.h>
@@ -21,6 +22,8 @@
 
 #define SCU_MU_CHAN_NUM		8
 #define MAX_RX_TIMEOUT		(msecs_to_jiffies(30))
+#define IMX_SC_IRQ_FUNC_STATUS	2
+#define IMX_SC_IRQ_NUM_GROUP	6
 
 struct imx_sc_chan {
 	struct imx_sc_ipc *sc_ipc;
@@ -77,7 +80,23 @@ static int imx_sc_linux_errmap[IMX_SC_ERR_LAST] = {
 	-EIO,	 /* IMX_SC_ERR_FAIL */
 };
 
+struct imx_sc_msg_irq_get_status {
+	struct imx_sc_rpc_msg hdr;
+	union {
+		struct {
+			u16 resource;
+			u8 group;
+			u8 reserved;
+		} send;
+		struct {
+			u32 status;
+		} receive;
+	} data;
+} __packed;
+
 static struct imx_sc_ipc *imx_sc_ipc_handle;
+static struct work_struct imx_sc_general_irq_work;
+static BLOCKING_NOTIFIER_HEAD(imx_scu_notifier_chain);
 
 static inline int imx_sc_to_linux_errno(int errno)
 {
@@ -194,6 +213,86 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool have_resp)
 }
 EXPORT_SYMBOL(imx_scu_call_rpc);
 
+int imx_scu_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&imx_scu_notifier_chain, nb);
+}
+EXPORT_SYMBOL(imx_scu_register_notifier);
+
+int imx_scu_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&imx_scu_notifier_chain, nb);
+}
+EXPORT_SYMBOL(imx_scu_unregister_notifier);
+
+static int imx_scu_notifier_call_chain(unsigned long status, u8 *group)
+{
+	return blocking_notifier_call_chain(&imx_scu_notifier_chain,
+					    status, (void *)group);
+}
+
+static void imx_scu_general_irq_work_handler(struct work_struct *work)
+{
+	struct imx_sc_msg_irq_get_status msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	u32 irq_status;
+	int ret;
+	u8 i;
+
+	for (i = 0; i < IMX_SC_IRQ_NUM_GROUP; i++) {
+		hdr->ver = IMX_SC_RPC_VERSION;
+		hdr->svc = IMX_SC_RPC_SVC_IRQ;
+		hdr->func = IMX_SC_IRQ_FUNC_STATUS;
+		hdr->size = 2;
+
+		msg.data.send.resource = IMX_SC_R_MU_1A;
+		msg.data.send.group = i;
+
+		ret = imx_scu_call_rpc(imx_sc_ipc_handle, &msg, true);
+		if (ret) {
+			pr_err("get irq status failed, ret %d\n", ret);
+			return;
+		}
+
+		irq_status = msg.data.receive.status;
+		if (!irq_status)
+			continue;
+
+		imx_scu_notifier_call_chain(irq_status, &i);
+	}
+}
+
+static void imx_scu_rxdb_callback(struct mbox_client *c, void *msg)
+{
+	schedule_work(&imx_sc_general_irq_work);
+}
+
+static int imx_scu_enable_general_irq_channel(struct device *dev)
+{
+	struct mbox_client *cl;
+	struct mbox_chan *ch;
+	int ret = 0;
+
+	cl = devm_kzalloc(dev, sizeof(*cl), GFP_KERNEL);
+	if (!cl)
+		return -ENOMEM;
+
+	cl->dev = dev;
+	cl->rx_callback = imx_scu_rxdb_callback;
+
+	/* SCU general IRQ uses general interrupt channel 3 */
+	ch = mbox_request_channel_byname(cl, "gi3");
+	if (IS_ERR(ch)) {
+		ret = PTR_ERR(ch);
+		dev_err(dev, "failed to request mbox chan gi3, ret %d\n", ret);
+		return ret;
+	}
+
+	INIT_WORK(&imx_sc_general_irq_work, imx_scu_general_irq_work_handler);
+
+	return ret;
+}
+
 static int imx_scu_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -246,6 +345,8 @@ static int imx_scu_probe(struct platform_device *pdev)
 
 	imx_sc_ipc_handle = sc_ipc;
 
+	imx_scu_enable_general_irq_channel(dev);
+
 	dev_info(dev, "NXP i.MX SCU Initialized\n");
 
 	return devm_of_platform_populate(dev);
diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
index ebc5509..9d608db 100644
--- a/include/linux/firmware/imx/sci.h
+++ b/include/linux/firmware/imx/sci.h
@@ -15,4 +15,7 @@
 
 #include <linux/firmware/imx/svc/misc.h>
 #include <linux/firmware/imx/svc/pm.h>
+
+int imx_scu_register_notifier(struct notifier_block *nb);
+int imx_scu_unregister_notifier(struct notifier_block *nb);
 #endif /* _SC_SCI_H */
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
