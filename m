Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC21AC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 03:29:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7C6120861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 03:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RNNJPEms";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rRZLYkMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C6120861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=teXT3H3RtvCijbiOdGEYNu028pntNyr6d0LhAvjjxko=; b=RNNJPEmsVJD996
	mDt0a1SKaKvUUDr+P57m0zDVOAavDFBMOW0DUIdoc1R575+8XdIjFNA9zEvCT2pCq6d4WeUqnjlBR
	SbhwVm5YDuzcsUmjhCAQIKwM65a2V/JehlI2y7iszoy+Exb84g5Sa8MBTzTuGJp/l8f5x4gJDwF7g
	GD8BR7LZH6KUY8hdEdvkyjzge87TiiUMTGibsX0mpPSOzez+GqjGI+aCTdcboSQk9dFDXKEFv4RMz
	x61QFE9dI0a+OBOIsG9TlDzqXICqLAwG/apL4HJqk1ZHEO56W4xDZ4yQyTg01DOeVUC24cTDFDhMm
	Mj0a7Z25ys2FIQPykoug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glmko-0005h9-Lp; Tue, 22 Jan 2019 03:29:34 +0000
Received: from mail-eopbgr60061.outbound.protection.outlook.com ([40.107.6.61]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glmkk-0005gZ-Tl
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 03:29:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8Wq/jIYAhSIzVUXwGevh+56kPcloVWwk8cz9mpLoDA=;
 b=rRZLYkMSQUsXSbngQUgHr9YdQrWwZt38e80wD4MG214QGKlyW9z2/dHJ3pMG+kyYvLxtA0TuizxbLER27Wo4Q7Zdjk9zucXdssE1oo/7X2hE7uoSdT0ec4XecPlu9mAxGBHNEWMVSWQlgZw/BpYoOZsz8e3q5CdS8EQ8tm/Jbjs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3929.eurprd04.prod.outlook.com (52.134.70.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Tue, 22 Jan 2019 03:29:24 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 03:29:24 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "a.zummo@towertech.it" <a.zummo@towertech.it>,
 "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, "linux-rtc@vger.kernel.org"
 <linux-rtc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH] rtc: imx-sc: add rtc set time support
Thread-Topic: [PATCH] rtc: imx-sc: add rtc set time support
Thread-Index: AQHUsgKsboFOYTBbXkGWmnrJUtGfDQ==
Date: Tue, 22 Jan 2019 03:29:24 +0000
Message-ID: <1548127476-7958-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2P15301CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::23) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB3PR0402MB3929;
 6:p9HPNjnNGiEaK3FXrb3Fc1inxYDx+4cJrdMU6aZ1z/Ibnsu/ijQzbbgCky3axPcN8tZ/S3VV0CYMoB5KaWP0/kQsSVmj4e4KGQXK24lM092eDwmfoqe+Lbnny+6XXOzXj3k8cxYjCcfNjJDyzj9EN9zf8pxxBA9fTl0pwxMZZojvLATeqHRMx+TwEd9C3jR/3qEWPDxarXir8NTVUfB+15f61+XHWV38U57KBxYjfdRNByztadxtiq+giKm0O6cEWKq5VFs/IkyZ6QRaZLqjzkYOv0w1AfOby8ecFs8m3r4/sMSMjIsvixXCZENIDVelJaeAwG+XQ3JkuoRLFIVl+rg1kku3dVGWDvrp9MGLL4vcZuUC0TwC+GTjB/aV/kTyAiFGrwhYWvQ+YakBqjYbSk52tYh06FZ9Ea6tuVzwF1L2b4FWAnRxdK5/zFNX0osZEM5PUpPMCPcTwp2FyK1OUA==;
 5:hhz40ZDDfqPhwZFd3nHJTduerdZJiU2WWm0xMQJsvyYqxiYkn8ygpRR0Ck+UH5d2tDyzIi0InEyjGcqw5/jCI5eWZmq4UgqnpT7cxPtMleS/2j/69Fx57zWQ05EzfwMznXPvki/B1363mkluHIUP3UiH8cUcxIuaw5y668Ap/SrwRSOUCXqqvABqauxK2KxlfCDOl+nZRjA9mcAYtsHZGw==;
 7:l1L9udk5q5QnREdfLkGci3KdF3ZK6d1E9ZTel952Dkvs8kTxVEW67faJb9wxjQklpN3kBSSHVQo+45GoKLckFsLcQd5SqXm7h8AYx/caCjz0DcitT3iH1rf2SRYzYBWhI4Thh41+t+/TikFNfpGbsQ==
x-ms-office365-filtering-correlation-id: cc89aeab-dcbc-451a-33db-08d68019ce4e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3929; 
x-ms-traffictypediagnostic: DB3PR0402MB3929:
x-microsoft-antispam-prvs: <DB3PR0402MB39299C0C367F39B75236BD7FF5980@DB3PR0402MB3929.eurprd04.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(366004)(39860400002)(346002)(136003)(376002)(199004)(189003)(6486002)(36756003)(81166006)(68736007)(478600001)(25786009)(4326008)(53936002)(6512007)(6116002)(3846002)(305945005)(7736002)(486006)(6436002)(2906002)(86362001)(14454004)(81156014)(50226002)(52116002)(8936002)(8676002)(316002)(102836004)(97736004)(106356001)(6506007)(386003)(66066001)(105586002)(71200400001)(71190400001)(110136005)(476003)(2501003)(2201001)(186003)(2616005)(99286004)(256004)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3929;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Tp18lG2L/YorqeqMT1Ldx+Yk7Ze3YnDhktTj36Y7GHE7CeYeRsbIY+ViHJpaB+p5GLdx49Zh+f9VXpBp9MGRFWptPfYBGJb0IjzIZCkeV/79PJv3ioJJic5Zv8nglhecIK9PVMhetJHNd4S0ETtH2Ntv/D2nB48M/knw/B42CpDcixWXAL9CNRA4peFLWHx8LRL3UAXOIdBlT/1nblNUNrILYbnlRFmBTutUGTiCz5kDrzxM/wY5vOsKd4kNGFGV9WCB0cG7L3jTBaFj5n1VL55rwFaeSLky9e8OPZmkO9fN/MMj9VxeTUG5OETpItFcZVaW+V8pr++7Iu68YoEppjQPgEvsAYmHLW7PNKBSOxIwFoVYTALVRyePbKmPVsOCSs7zahHGrefieaz+VVP033RHLIpD3zb6T+DzxkQZYyU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc89aeab-dcbc-451a-33db-08d68019ce4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 03:29:21.0146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3929
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_192931_059860_FA5F3F5C 
X-CRM114-Status: GOOD (  14.13  )
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

This patch adds i.MX system controller RTC set time support, the
RTC set time is implemented via SIP(silicon provider) runtime
service call and ARM-Trusted-Firmware will communicate with system
controller via MU(message unit) IPC to set RTC time.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/rtc/rtc-imx-sc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/rtc/rtc-imx-sc.c b/drivers/rtc/rtc-imx-sc.c
index 7ff0854..60570a2 100644
--- a/drivers/rtc/rtc-imx-sc.c
+++ b/drivers/rtc/rtc-imx-sc.c
@@ -3,6 +3,7 @@
  * Copyright 2018 NXP.
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/firmware/imx/sci.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -12,6 +13,9 @@
 #define IMX_SC_TIMER_FUNC_GET_RTC_SEC1970	9
 #define IMX_SC_TIMER_FUNC_SET_RTC_TIME		6
 
+#define IMX_SIP_SRTC			0xC2000002
+#define IMX_SIP_SRTC_SET_TIME		0x0
+
 static struct imx_sc_ipc *rtc_ipc_handle;
 static struct rtc_device *imx_sc_rtc;
 
@@ -42,8 +46,23 @@ static int imx_sc_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
+static int imx_sc_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct arm_smccc_res res;
+
+	/* pack 2 time parameters into 1 register, 16 bits for each */
+	arm_smccc_smc(IMX_SIP_SRTC, IMX_SIP_SRTC_SET_TIME,
+		      ((tm->tm_year + 1900) << 16) | (tm->tm_mon + 1),
+		      (tm->tm_mday << 16) | tm->tm_hour,
+		      (tm->tm_min << 16) | tm->tm_sec,
+		      0, 0, 0, &res);
+
+	return res.a0;
+}
+
 static const struct rtc_class_ops imx_sc_rtc_ops = {
 	.read_time = imx_sc_rtc_read_time,
+	.set_time = imx_sc_rtc_set_time,
 };
 
 static int imx_sc_rtc_probe(struct platform_device *pdev)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
