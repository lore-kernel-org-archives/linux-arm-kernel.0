Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BF8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:46:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1338C2084F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gmxJOXMG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Ek6p/b5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1338C2084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EuIlJ5qdR31oJD5RvDyod7T2TShKOs1crWQS1r8wkqs=; b=gmxJOXMGM2yFo8
	Nb0MzwydoEn5O8/90Gty0tTw0TFfmEL99sPPXHMOqalZY8rWr85t+7gXdfo64QVmWl5hq6lKp98hf
	9X1/HDbVHLuQa27JDWruNAWLRV3ntHrAUUadSk59Ra6cjCEpo0oGHSjXkoqJSNS9nakmeYQW/aPs/
	MQ6OvMnylBJ2p8B2ztJrrZmq85VyrvQ1/gEkulQ0Dbjac3MWx5cXrQ7QhokhatJnGwx8dtmgTyTis
	vX7/S6sj9oJXPln4IQ/FI0HhCy2fGfOYE4NcALAiHcNOWaMngPNu9DIiktkW0D+FYDOdeCGBLDbbS
	btw1SUq2z8PdHpexxnkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwofu-0005YF-Sb; Thu, 21 Feb 2019 13:46:06 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwofi-0005Jr-IA
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 13:45:57 +0000
X-IronPort-AV: E=Sophos;i="5.58,395,1544511600"; d="scan'208";a="24225445"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 21 Feb 2019 06:45:50 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 21 Feb 2019 06:45:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DC9Sg3RKw34ixaN2S3M72KryUsEVfr17/Cjot5fMG3g=;
 b=Ek6p/b5BYEV/HPde0b/RH7xdfAyVoupmLUrmGJ1FGGSs9GIqxHMt45pOHLNlJDpQDI3ICriVtVcJ57fO02glwD3PJglfVx5qsuxqN9HfjPDTa9HEb4hpZH6V9fSIIjHyvf/1XVyC1eXyHhH7DGW9vHVGeSRAxQi6Q3NHTE++lgw=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1677.namprd11.prod.outlook.com (10.172.55.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 21 Feb 2019 13:45:48 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e%6]) with mapi id 15.20.1643.016; Thu, 21 Feb 2019
 13:45:48 +0000
From: <Claudiu.Beznea@microchip.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <sre@kernel.org>
Subject: [PATCH v2 1/3] power: reset: at91-poweroff: add RTT wakeup capability
Thread-Topic: [PATCH v2 1/3] power: reset: at91-poweroff: add RTT wakeup
 capability
Thread-Index: AQHUyevAV4hXVGKMOUuIUcZK/AzqJA==
Date: Thu, 21 Feb 2019 13:45:48 +0000
Message-ID: <1550756716-3032-2-git-send-email-claudiu.beznea@microchip.com>
References: <1550756716-3032-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550756716-3032-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P190CA0036.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::49) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bda0993-3601-4807-1699-08d69802e2aa
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1677; 
x-ms-traffictypediagnostic: MWHPR11MB1677:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; MWHPR11MB1677;
 23:Fj/riKE3LSOBGRzgFiJ1vTKInuWlrITxXoxxN06?=
 =?iso-8859-1?Q?nDrIyMJEl7BOZsMzcdDHJmeMd4uvUk81SPdz5U3/rkCr7sGUz6xIP0es/o?=
 =?iso-8859-1?Q?F1C5y2yBkWrHgMTAtzHT7rJsoCDkQtCywDOcad66djXP5tkXOekBolLpYN?=
 =?iso-8859-1?Q?jFiVCibA72qHRpenwemM1prtiNjeSHfibMT3OdEx0j3hfjchHWQKLFTJl5?=
 =?iso-8859-1?Q?SEV/2+C21/aR1HZkXnakR/AmYYA1UtkXrXqLxgG95gs+AzXeS59QzKXQxS?=
 =?iso-8859-1?Q?FGhLq0/GntL4bgKFUxtPQ6D+apwlNheJCBiY9uaixBvcgV8ekPqS8eU3oF?=
 =?iso-8859-1?Q?7b1DPPqkCB68KlNEhA1hqNV8T9galCodqpsmpjPbblwKCSECkuVBnqCWxS?=
 =?iso-8859-1?Q?+Ws+0XVCsKiz0zsySn+UR2z1pRKEGraU9+EktJXob1tGwAcBZQ6BCwpoAv?=
 =?iso-8859-1?Q?osnCRPlw/nVSAu8EDxIpz/J3L0ehQYh6CPfrSptdn6T/UQTRVvsJfb2A2B?=
 =?iso-8859-1?Q?rOjfW40dkfj8z8kiZk7EkJQLw/7+x9vFydlGNQAnIXj8PBa/8OzQy3N/be?=
 =?iso-8859-1?Q?vNGWtDA3NoBRF1qi25usQmlynR0tIenG1CuTQdDPPbbN1mym9hpoRng+bG?=
 =?iso-8859-1?Q?S8SEuXhbZptU+r9/OFJZ+LXvEHEb/q1kqjH4UIqwsrg3wx53JRvpNKTnaH?=
 =?iso-8859-1?Q?vSh2vYotLF1ch4+9Oa5eelYq8MI7IH+I5PtNfPIzgW4SeJXNkJB1MiXqpZ?=
 =?iso-8859-1?Q?hOoMQIES8WJYCvpFQ1ywaoWJWJWGLG9JY30gfS/h6qKnc4JceTkB3T6ucp?=
 =?iso-8859-1?Q?DT5sKIux8IPEZWaV6oRkBwRvHkhDXnF3wrujXpufI0/t++HCblKKc7YoQY?=
 =?iso-8859-1?Q?czf4Nc9dBnAfFk4B8LIaYVtcp0QENhTwZ3xRyAHLu2v6Jv8zUXcWSICbQM?=
 =?iso-8859-1?Q?+yZQL+zHDQ6v4dhwictKDdmPbLrHb0xiXupbB4yCOVnC0gGv0xIfuZwbvX?=
 =?iso-8859-1?Q?yjuejj+SGX97eD4xWbmV0KGwwQNPWuPve6mcdDJOlCQdG4syQzZs0P7b+j?=
 =?iso-8859-1?Q?ePM7nsxBPMjs48C7HtKPuOwLvCumEXQ+OmPEBFLuMV0SXpEfAnzpRDB4OE?=
 =?iso-8859-1?Q?U8q21n4xnLC0jyrhk8nFPXr8AM2Yr3Xcrjm4TiUliOm4g6d3t8KudIZ3R0?=
 =?iso-8859-1?Q?WL5i2mNclh9wfDGss4KMWNAGvDnef3kdMLtmmLbYIO9vGCclqX0ZPtd33M?=
 =?iso-8859-1?Q?yCwDq3CbNs6Xj/bfLQN0jvwifPxO+6vQsLi3ZR9a5h7JLrQB80epLZetEg?=
 =?iso-8859-1?Q?V0=3D?=
x-microsoft-antispam-prvs: <MWHPR11MB16774D76AEC5B02AD45E8DC1877E0@MWHPR11MB1677.namprd11.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(346002)(136003)(366004)(376002)(396003)(189003)(199004)(6436002)(6486002)(66066001)(36756003)(107886003)(5660300002)(81166006)(97736004)(8676002)(25786009)(2501003)(4326008)(81156014)(7736002)(305945005)(8936002)(26005)(50226002)(53936002)(186003)(6506007)(386003)(102836004)(6116002)(3846002)(14454004)(316002)(478600001)(72206003)(2906002)(106356001)(54906003)(256004)(110136005)(6512007)(486006)(71200400001)(71190400001)(68736007)(86362001)(476003)(52116002)(446003)(11346002)(99286004)(2616005)(105586002)(76176011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1677;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s++/JLV7L9qlIFqby6fqMBQIt/5c7uqy3sWq32RWcRltDhvT3fbx8xJH/k0FhbdZCt7xWq4FdU8+WhnrNIa2Jsu0zofH2sQ5xWFmQWOEDhJGd4WrQP2JWn9/vYOEfpNycVjivHpEy1FXxi1xKRFVdE2EQDtJtt0dNfnC6vmSE1TXvTURvAnLgs99N+dztJRqmmq3mnL5vwWaze3GL24DNNLp8/K5ftOQAx2Ywctnc5R+Cnatt8QwKsPYOiRJ3pwO4YRlJuOpNgMqS3ucToYGfI2YPFkUWloh6fDwMB/B40ay2SMrkWLogFq4DckkWYeSqSHaHM3ZYJyJIU5yA8BnbDlTYKRZ8l0mE52QHkfAR5QuPAIXW8cNEDDEFd6DiCObFhPSLqTys/IwVvsEBWu61SBM7uwcJHH6W+LjsNZ+cqU=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bda0993-3601-4807-1699-08d69802e2aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 13:45:45.0874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1677
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_054554_654521_365D56DC 
X-CRM114-Status: UNSURE (   9.03  )
X-CRM114-Notice: Please train this message.
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
Cc: devicetree@vger.kernel.org, Claudiu.Beznea@microchip.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add RTT wakeup capability.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/power/reset/at91-sama5d2_shdwc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index 2b686c55b717..0747e0cdf350 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -57,15 +57,21 @@
 
 #define SHDW_WK_PIN(reg, cfg)	((reg) & AT91_SHDW_WKUPIS((cfg)->wkup_pin_input))
 #define SHDW_RTCWK(reg, cfg)	(((reg) >> ((cfg)->sr_rtcwk_shift)) & 0x1)
+#define SHDW_RTTWK(reg, cfg)	(((reg) >> ((cfg)->sr_rttwk_shift)) & 0x1)
 #define SHDW_RTCWKEN(cfg)	(1 << ((cfg)->mr_rtcwk_shift))
+#define SHDW_RTTWKEN(cfg)	(1 << ((cfg)->mr_rttwk_shift))
 
 #define DBC_PERIOD_US(x)	DIV_ROUND_UP_ULL((1000000 * (x)), \
 							SLOW_CLOCK_FREQ)
 
+#define SHDW_CFG_NOT_USED	(32)
+
 struct shdwc_config {
 	u8 wkup_pin_input;
 	u8 mr_rtcwk_shift;
+	u8 mr_rttwk_shift;
 	u8 sr_rtcwk_shift;
+	u8 sr_rttwk_shift;
 };
 
 struct shdwc {
@@ -104,6 +110,8 @@ static void __init at91_wakeup_status(struct platform_device *pdev)
 		reason = "WKUP pin";
 	else if (SHDW_RTCWK(reg, shdw->cfg))
 		reason = "RTC";
+	else if (SHDW_RTTWK(reg, shdw->cfg))
+		reason = "RTT";
 
 	pr_info("AT91: Wake-Up source: %s\n", reason);
 }
@@ -221,6 +229,9 @@ static void at91_shdwc_dt_configure(struct platform_device *pdev)
 	if (of_property_read_bool(np, "atmel,wakeup-rtc-timer"))
 		mode |= SHDW_RTCWKEN(shdw->cfg);
 
+	if (of_property_read_bool(np, "atmel,wakeup-rtt-timer"))
+		mode |= SHDW_RTTWKEN(shdw->cfg);
+
 	dev_dbg(&pdev->dev, "%s: mode = %#x\n", __func__, mode);
 	writel(mode, shdw->shdwc_base + AT91_SHDW_MR);
 
@@ -231,7 +242,10 @@ static void at91_shdwc_dt_configure(struct platform_device *pdev)
 static const struct shdwc_config sama5d2_shdwc_config = {
 	.wkup_pin_input = 0,
 	.mr_rtcwk_shift = 17,
+	.mr_rttwk_shift	= SHDW_CFG_NOT_USED,
 	.sr_rtcwk_shift = 5,
+	.sr_rttwk_shift = SHDW_CFG_NOT_USED,
+};
 };
 
 static const struct of_device_id at91_shdwc_of_match[] = {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
