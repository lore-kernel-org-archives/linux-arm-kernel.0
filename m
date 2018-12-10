Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D78FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:51:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D03B2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HYKZ/Xue";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F2ams2C8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D03B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bexbcutL70djxAYoXrxCvyr5vRPS7BiSQpgIn3C1Bzg=; b=HYKZ/XueCwtH68
	h4YLSSPk398KE1nARrBX9u1YCWqlI4ihBZL7S7ThW9zi/NnJFfZPuehM5vvSgZ0mQwnmsdGdQBY0S
	uWfCFpMdH42Dp6msVHzsOLafR9GOIcOLYWYPOMq4uFYs0VM1V5BJAvE3qeHGhBNOar7Zd8IVjDrBM
	touzZKO9sDRrPFYiF5XDOn3ZB+Joz0AykULmbdo2BbkBpXK7I29h6TUWxJ7sDWoMFaIayvMv+Bp1Y
	B10r8SfwOM++55QN2rUP/S4vXABN9Ka8yy2tpJN6IVeXOBzJwrg+zfXNfNw5jUn7Snr7/q1B8Dsic
	0mDsFq+zhz4GCPeLlL4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOmY-0002TE-Kl; Mon, 10 Dec 2018 16:51:46 +0000
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOlV-0001DI-9d
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:50:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkoVm4kdfVirtVH/yGa+3tlpcU6sozT1IqFzresa29Y=;
 b=F2ams2C860ZwJIVokdLg4xFVPrFZ3GWXurTDu3d4P/v/SUOQHBIUeJ5mWMV9bG2xvdqO65F2cJ3WY+IqW55ms1nT5+xdnCzx/9yYPow1WUlCeIffFxDTlajOoRTIlUgU0u8U7RgdENoxttxtoMF1iocPqHcwtYrHl1Bs+ZOwCVM=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB2750.eurprd04.prod.outlook.com (10.175.22.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Mon, 10 Dec 2018 16:50:18 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::d9a8:33a8:4241:be86]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::d9a8:33a8:4241:be86%11]) with mapi id 15.20.1404.026; Mon, 10 Dec
 2018 16:50:18 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Leo Li <leoyang.li@nxp.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: [PATCH 3/5] soc: fsl: dpio: store a backpointer to the device backing
 the dpaa2_io
Thread-Topic: [PATCH 3/5] soc: fsl: dpio: store a backpointer to the device
 backing the dpaa2_io
Thread-Index: AQHUkKhuPbioaeRTqk6l3vGVtHGdEQ==
Date: Mon, 10 Dec 2018 16:50:18 +0000
Message-ID: <1544460591-14888-4-git-send-email-ioana.ciornei@nxp.com>
References: <1544460591-14888-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1544460591-14888-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0145.eurprd08.prod.outlook.com
 (2603:10a6:800:d5::23) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0402MB2750;
 6:YuqWesw23NWIktvpE9yUzX9lx3Pngq7hGnLggyQCukWDy/3eTLfyi4mNtYTu1h/V5jLIRrBEPUy9J4PfnEBhbiN7FB3sJl9u/w0mR0o4S96EHUn3Ei8BTl6aIKxcg/d2cneLIoBNq/LsGGhDXRz0BJ89b01EfCKvsOtq73sxHpqMnJsKKxpnYMUNa1AKztI1baQxfBrfQFt2oOPPTlPRxxG49h9rYeGkBerEcu0+UJqoI+cYkKnWwT2dVtqNF4uPeaiGcovSyXwWHqv8kgTN8im7DhHdXNAvlDM+CWX+uCoKGG57tIO3/ghi51oDxo9wZIcFPwUps+YUwMh6Ij7TX/5+kLkoI4XhN9ePWLN0VTV1gcX1+ddyOF35erScnZmQDFID5AelGgtlIjCs8JZNAz43qQGU2qBpYymHPRGU2vVJ35areVojqdVm6oehjMfO7wQlZXqSd077juPEYipmcQ==;
 5:uK6x+awDndB2QdTNvIJgtb/L5wvwt3Bpjjg3xoHNgzMZ/KrtOoYyVahPQSawgdS34Cx7NUkHAfwLSnjidWwfGwrI7K46dcvSqTdLNYh5/gt2l8n6fgQ3hh2oeYmGYKzcs98oUFr/EAKhTUm2i8K0Tu2UOCZNu6vfq6HfzJQNPDE=;
 7:0lwV7v2TLoheqBtkMyixowWmCsbTWDiBi0rHtF2LOh8rJqYX5bFpO/Od/EysNTiWu/sfCUS9RLXSscyIr063e0lFsFNjyRlxYONR8P+Zjmf/azLWR+68BLtYXBCeXxhcsILb/v9r8Z2LatgBauu5bQ==
x-ms-office365-filtering-correlation-id: 9a0aab9d-4f14-43e1-4b5b-08d65ebf90e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB2750; 
x-ms-traffictypediagnostic: VI1PR0402MB2750:
x-microsoft-antispam-prvs: <VI1PR0402MB2750CA4E001AFC1221135B38E0A50@VI1PR0402MB2750.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR0402MB2750; BCL:0; PCL:0; RULEID:; SRVR:VI1PR0402MB2750; 
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(366004)(136003)(376002)(346002)(199004)(189003)(186003)(2501003)(11346002)(44832011)(53936002)(2616005)(71190400001)(476003)(2201001)(3846002)(6116002)(71200400001)(66066001)(486006)(305945005)(7736002)(86362001)(68736007)(36756003)(6436002)(81156014)(14444005)(316002)(110136005)(8936002)(14454004)(81166006)(478600001)(446003)(256004)(54906003)(25786009)(8676002)(6486002)(99286004)(76176011)(102836004)(106356001)(26005)(105586002)(386003)(2906002)(97736004)(5660300001)(6506007)(52116002)(6512007)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB2750;
 H:VI1PR0402MB2800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 84cCxDaWfNA7x3wSHCXcqE5SFohgaauoYNwpJzO49gDMi+hYQkJHxrkr5KRix/gwhGNr0X0sQSeXe2s0Qt0mndrfnI3NXTt7LqQ2AXVPT83ClMhMIYM12iGqXWRlUvsiR4CLboyzUQNDXufAwhJ7upXghODmknrCFFunZqGugmHT5y1A9G3CwmUQCP8WlkrMmuDXWU7rUL/Nxzg7odkJLQoeMC1lgstGB1PAY1D3hf+dyZa8V0u2/HWIxSUJdvwdTck53QIJtoYcvWuszL+J+qwT2y0xyr2Hi0NmGu6ClxRjBTLxF2ZGBpwyfbm6C6UR
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0aab9d-4f14-43e1-4b5b-08d65ebf90e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 16:50:18.5088 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2750
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_085042_063122_591E253D 
X-CRM114-Status: GOOD (  16.10  )
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
Cc: Roy Pledge <roy.pledge@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
 Horia Geanta <horia.geanta@nxp.com>, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a new field in the dpaa2_io structure to hold a backpointer to the
actual DPIO device.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/soc/fsl/dpio/dpio-driver.c  | 2 +-
 drivers/soc/fsl/dpio/dpio-service.c | 7 ++++++-
 include/soc/fsl/dpaa2-io.h          | 3 ++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
index 5286723..2d4af32 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -176,7 +176,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
 	if (err)
 		goto err_register_dpio_irq;
 
-	priv->io = dpaa2_io_create(&desc);
+	priv->io = dpaa2_io_create(&desc, dev);
 	if (!priv->io) {
 		dev_err(dev, "dpaa2_io_create failed\n");
 		err = -ENOMEM;
diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
index 5583d28..87e01710 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -27,6 +27,7 @@ struct dpaa2_io {
 	/* protect notifications list */
 	spinlock_t lock_notifications;
 	struct list_head notifications;
+	struct device *dev;
 };
 
 struct dpaa2_io_store {
@@ -98,13 +99,15 @@ struct dpaa2_io *dpaa2_io_service_select(int cpu)
 /**
  * dpaa2_io_create() - create a dpaa2_io object.
  * @desc: the dpaa2_io descriptor
+ * @dev: the actual DPIO device
  *
  * Activates a "struct dpaa2_io" corresponding to the given config of an actual
  * DPIO object.
  *
  * Return a valid dpaa2_io object for success, or NULL for failure.
  */
-struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_desc *desc)
+struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_desc *desc,
+				 struct device *dev)
 {
 	struct dpaa2_io *obj = kmalloc(sizeof(*obj), GFP_KERNEL);
 
@@ -146,6 +149,8 @@ struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_desc *desc)
 		dpio_by_cpu[desc->cpu] = obj;
 	spin_unlock(&dpio_list_lock);
 
+	obj->dev = dev;
+
 	return obj;
 }
 
diff --git a/include/soc/fsl/dpaa2-io.h b/include/soc/fsl/dpaa2-io.h
index e11eed1..5b5ba26 100644
--- a/include/soc/fsl/dpaa2-io.h
+++ b/include/soc/fsl/dpaa2-io.h
@@ -57,7 +57,8 @@ struct dpaa2_io_desc {
 	u32 qman_version;
 };
 
-struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_desc *desc);
+struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_desc *desc,
+				 struct device *dev);
 
 void dpaa2_io_down(struct dpaa2_io *d);
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
