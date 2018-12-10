Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA945C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:51:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86D0920672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iaI3jwGm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rTz4lyMf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D0920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Hcg3lgkn3i2kPIxhc0NGF8v7sba7AYvUiQZv6fSfyCo=; b=iaI3jwGmBpg+H1
	LJk014W+Y/8gGuVM/xkntfn9fNfqUdg+6XLAH/TAJplA5YCzcOEiwQQ37TX8XBKMKPBzw3mkAJfCV
	fj52WdNG2ucSrUMeqQSCWLT8ishb2OPSCv+5jlWm7nUZpnhdX3FT2ZadzsABquiWy1U0yofpZFv0x
	NCDoCKiaHHOCl1y96uplOzzR2J8onmZI1/7BibrP4E427drh8s76CmR8zn2QIjzxsK2kfFXan2pby
	4qK0rBt0sLplG/oer48NUsNLufm1LRg8NpoQrOd/YpOBHo9OqVIHdqVcX8yUYpGpoaL2uZAuGUwg0
	C1ZpfNEwpF0y1mJi429Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOlp-0001ie-PC; Mon, 10 Dec 2018 16:51:01 +0000
Received: from mail-ve1eur02on0625.outbound.protection.outlook.com
 ([2a01:111:f400:fe06::625]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOlO-0001Dg-2J
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:50:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IhNVAJZhi6ZBQEWabR5aMQ+BIUVeziK0nRpNiLlpaI=;
 b=rTz4lyMfFw2oAsYXsLdNz8FGxIPUO8xqHZWYxhbnGTY0Q6+Cj9G8NW3FqTszuXe/LP+/dSq8ZUwHFFG8H2XiRuTnOuUHCKfKAQNQL4suY8M7u8MPmiizP//6nVm3VF8asaoSgG/xheSPgdhXK4ntsmKpMkPJUS1cOKAbk7REvw4=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3904.eurprd04.prod.outlook.com (52.134.17.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Mon, 10 Dec 2018 16:50:19 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::d9a8:33a8:4241:be86]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::d9a8:33a8:4241:be86%11]) with mapi id 15.20.1404.026; Mon, 10 Dec
 2018 16:50:19 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Leo Li <leoyang.li@nxp.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: [PATCH 4/5] soc: fsl: dpio: add a device_link at
 dpaa2_io_service_register
Thread-Topic: [PATCH 4/5] soc: fsl: dpio: add a device_link at
 dpaa2_io_service_register
Thread-Index: AQHUkKhuw2zDRH3/CkaLKonxEHQ5VQ==
Date: Mon, 10 Dec 2018 16:50:19 +0000
Message-ID: <1544460591-14888-5-git-send-email-ioana.ciornei@nxp.com>
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
x-microsoft-exchange-diagnostics: 1; VI1PR0402MB3904;
 6:MtDewYFj1c7dpPMgYLUBoQyJYIEs1z+5DeiPNAPzPI59/IlsqtRGvRc054Ny85FIa1K/Rw0yC3kspmoV+y/Zg5Kkl24Rj5dNCAHJMoRtmUbn8k+lrM6LUJ3wFx6z21FkVX8x9iSGaJdsLabpGI9JymbMYCFFJnulIXbYjZkNe0s+bh/KACkjo+Vx0KEMNYMIA4s1hXD0Gh5WwsmnJ/IYxu2f90sf78j4om/6bwZzFc1XFjlr8xykgUwglvEehNlSN7ExvPCR9Ti3Js3c3jL26WiUcYE7G52NFXJFfWtnLWzm1E7PFPU28D/4YC1W+TEAxaVlU9Baqq3V+ZzWj+ziQbk/7sAjb3R5ir52z9UC7nxwWdo9XgiOntbbsll5E2Ac5S0nnP/j+mqBJKhB6bWwJ15Rh/ynqyIrLtLGUSD6CFPKUJGSLI+Q3TRJPbD8AHEEo1ZJe9Td+GDTxJaWeZt3tA==;
 5:JLRICbUdx73X8EvMa1KA5otfIaPA4jjdWjGNZJAYVWtn1Jc0XyULDfM2j21ryH7mbCE/uJKco+88hZucO7ahNitw1n+DH9hYroppNPNuMsIQoDi8FwvIrR8O7ghtfOjcxPesmWl7b1kivbLf8QZhHcro0w1stn/qv+0z204s5kg=;
 7:8W/SgKfQZwyJaFsqSBQioGJIZhAhcKGLK4Tgu6t7PPP3bjY0rLiD1zV8MxjeMacrqRyovmuvFj13wM//givFMJolOkLoA675YjKRr8A95jtgz/U/DcwF1eXZhp/dIbYViTkaJvSINEdzAaT+dZ+qag==
x-ms-office365-filtering-correlation-id: 6a5ebb7d-2ef1-4c44-0671-08d65ebf9137
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3904; 
x-ms-traffictypediagnostic: VI1PR0402MB3904:
x-microsoft-antispam-prvs: <VI1PR0402MB3904D9DE30BF72F36C1223C5E0A50@VI1PR0402MB3904.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR0402MB3904; BCL:0; PCL:0; RULEID:; SRVR:VI1PR0402MB3904; 
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(376002)(346002)(396003)(39860400002)(136003)(199004)(189003)(6486002)(5024004)(4326008)(14444005)(44832011)(386003)(6506007)(486006)(316002)(68736007)(256004)(446003)(11346002)(52116002)(6436002)(2616005)(186003)(8676002)(8936002)(2906002)(26005)(81156014)(81166006)(97736004)(5660300001)(3846002)(478600001)(36756003)(14454004)(6116002)(2501003)(2201001)(25786009)(71190400001)(71200400001)(106356001)(105586002)(53936002)(305945005)(6512007)(76176011)(476003)(102836004)(54906003)(99286004)(7736002)(86362001)(110136005)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3904;
 H:VI1PR0402MB2800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ELfDYjRMzhNaAhn5Ql+/6c6iTXX0mQ1tOElUdHzgYNKKXtYo5oUMb9W7wXHDtFQtUi4acOLNU+4Bx3xGx3xFIQ8StQQEOeh55/HFSATrPPbyE65gxlalJJ1GelVdvyf+DiawrtGWNaN+NxIsFZKesDng5cpx4uAh2p94Fc+gLPw1Pv72Jol0+B5nDxUc5M+N90Z1PALm9BqYFM1DdV3rFRwI/ybmmUGnV4Ya3GDFZyZCyi5pZOC1BxT71xbtxf3MzFjXAqjBphbjUhYreRcUJ+kU8T9+FI3E+7dvCZu9YkIBNBw1/VqWhciCkUUb+2gy
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5ebb7d-2ef1-4c44-0671-08d65ebf9137
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 16:50:19.1143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3904
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_085034_106267_96A171FD 
X-CRM114-Status: GOOD (  19.65  )
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

Automatically add a device link between the actual device requesting the
dpaa2_io_service_register and the underlying dpaa2_io used. This link
will ensure that when a DPIO device, which is indirectly used by other
devices, is unbound any consumer devices will be also unbound from their
drivers.

For example, any DPNI, bound to the dpaa2-eth driver, which is using
DPIO devices will be unbound before its supplier device.

Also, add a new parameter to the dpaa2_io_service_[de]register functions
to specify the requesting device (ie the consumer).

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/crypto/caam/caamalg_qi2.c                |  6 +++---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c |  9 +++++----
 drivers/soc/fsl/dpio/dpio-service.c              | 16 ++++++++++++++--
 include/soc/fsl/dpaa2-io.h                       |  6 ++++--
 4 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 7d8ac02..3167539 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -4371,7 +4371,7 @@ static int __cold dpaa2_dpseci_dpio_setup(struct dpaa2_caam_priv *priv)
 		nctx->cb = dpaa2_caam_fqdan_cb;
 
 		/* Register notification callbacks */
-		err = dpaa2_io_service_register(NULL, nctx);
+		err = dpaa2_io_service_register(NULL, nctx, dev);
 		if (unlikely(err)) {
 			dev_dbg(dev, "No affine DPIO for cpu %d\n", cpu);
 			nctx->cb = NULL;
@@ -4404,7 +4404,7 @@ static int __cold dpaa2_dpseci_dpio_setup(struct dpaa2_caam_priv *priv)
 		ppriv = per_cpu_ptr(priv->ppriv, cpu);
 		if (!ppriv->nctx.cb)
 			break;
-		dpaa2_io_service_deregister(NULL, &ppriv->nctx);
+		dpaa2_io_service_deregister(NULL, &ppriv->nctx, dev);
 	}
 
 	for_each_online_cpu(cpu) {
@@ -4424,7 +4424,7 @@ static void __cold dpaa2_dpseci_dpio_free(struct dpaa2_caam_priv *priv)
 
 	for_each_online_cpu(cpu) {
 		ppriv = per_cpu_ptr(priv->ppriv, cpu);
-		dpaa2_io_service_deregister(NULL, &ppriv->nctx);
+		dpaa2_io_service_deregister(NULL, &ppriv->nctx, priv->dev);
 		dpaa2_io_store_destroy(ppriv->store);
 
 		if (++i == priv->num_pairs)
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 04d5c44..e8790f9 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -1570,7 +1570,7 @@ static int setup_dpio(struct dpaa2_eth_priv *priv)
 
 		/* Register the new context */
 		channel->dpio = dpaa2_io_service_select(i);
-		err = dpaa2_io_service_register(channel->dpio, nctx);
+		err = dpaa2_io_service_register(channel->dpio, nctx, dev);
 		if (err) {
 			dev_dbg(dev, "No affine DPIO for cpu %d\n", i);
 			/* If no affine DPIO for this core, there's probably
@@ -1610,7 +1610,7 @@ static int setup_dpio(struct dpaa2_eth_priv *priv)
 	return 0;
 
 err_set_cdan:
-	dpaa2_io_service_deregister(channel->dpio, nctx);
+	dpaa2_io_service_deregister(channel->dpio, nctx, dev);
 err_service_reg:
 	free_channel(priv, channel);
 err_alloc_ch:
@@ -1630,13 +1630,14 @@ static int setup_dpio(struct dpaa2_eth_priv *priv)
 
 static void free_dpio(struct dpaa2_eth_priv *priv)
 {
-	int i;
+	struct device *dev = priv->net_dev->dev.parent;
 	struct dpaa2_eth_channel *ch;
+	int i;
 
 	/* deregister CDAN notifications and free channels */
 	for (i = 0; i < priv->num_channels; i++) {
 		ch = priv->channel[i];
-		dpaa2_io_service_deregister(ch->dpio, &ch->nctx);
+		dpaa2_io_service_deregister(ch->dpio, &ch->nctx, dev);
 		free_channel(priv, ch);
 	}
 }
diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
index 87e01710..01b24ac 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -237,6 +237,7 @@ int dpaa2_io_get_cpu(struct dpaa2_io *d)
  *                               notifications on the given DPIO service.
  * @d:   the given DPIO service.
  * @ctx: the notification context.
+ * @dev: the device that requests the register
  *
  * The caller should make the MC command to attach a DPAA2 object to
  * a DPIO after this function completes successfully.  In that way:
@@ -251,14 +252,20 @@ int dpaa2_io_get_cpu(struct dpaa2_io *d)
  * Return 0 for success, or -ENODEV for failure.
  */
 int dpaa2_io_service_register(struct dpaa2_io *d,
-			      struct dpaa2_io_notification_ctx *ctx)
+			      struct dpaa2_io_notification_ctx *ctx,
+			      struct device *dev)
 {
+	struct device_link *link;
 	unsigned long irqflags;
 
 	d = service_select_by_cpu(d, ctx->desired_cpu);
 	if (!d)
 		return -ENODEV;
 
+	link = device_link_add(dev, d->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
+	if (!link)
+		return -EINVAL;
+
 	ctx->dpio_id = d->dpio_desc.dpio_id;
 	ctx->qman64 = (u64)(uintptr_t)ctx;
 	ctx->dpio_private = d;
@@ -279,12 +286,14 @@ int dpaa2_io_service_register(struct dpaa2_io *d,
  * dpaa2_io_service_deregister - The opposite of 'register'.
  * @service: the given DPIO service.
  * @ctx: the notification context.
+ * @dev: the device that requests to be deregistered
  *
  * This function should be called only after sending the MC command to
  * to detach the notification-producing device from the DPIO.
  */
 void dpaa2_io_service_deregister(struct dpaa2_io *service,
-				 struct dpaa2_io_notification_ctx *ctx)
+				 struct dpaa2_io_notification_ctx *ctx,
+				 struct device *dev)
 {
 	struct dpaa2_io *d = ctx->dpio_private;
 	unsigned long irqflags;
@@ -295,6 +304,9 @@ void dpaa2_io_service_deregister(struct dpaa2_io *service,
 	spin_lock_irqsave(&d->lock_notifications, irqflags);
 	list_del(&ctx->node);
 	spin_unlock_irqrestore(&d->lock_notifications, irqflags);
+
+	if (dev)
+		device_link_remove(dev, d->dev);
 }
 EXPORT_SYMBOL_GPL(dpaa2_io_service_deregister);
 
diff --git a/include/soc/fsl/dpaa2-io.h b/include/soc/fsl/dpaa2-io.h
index 5b5ba26..850e46d 100644
--- a/include/soc/fsl/dpaa2-io.h
+++ b/include/soc/fsl/dpaa2-io.h
@@ -94,9 +94,11 @@ struct dpaa2_io_notification_ctx {
 int dpaa2_io_get_cpu(struct dpaa2_io *d);
 
 int dpaa2_io_service_register(struct dpaa2_io *service,
-			      struct dpaa2_io_notification_ctx *ctx);
+			      struct dpaa2_io_notification_ctx *ctx,
+			      struct device *dev);
 void dpaa2_io_service_deregister(struct dpaa2_io *service,
-				 struct dpaa2_io_notification_ctx *ctx);
+				 struct dpaa2_io_notification_ctx *ctx,
+				 struct device *dev);
 int dpaa2_io_service_rearm(struct dpaa2_io *service,
 			   struct dpaa2_io_notification_ctx *ctx);
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
