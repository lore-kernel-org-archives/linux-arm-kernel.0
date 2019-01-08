Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1CEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:57:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92332206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sM4HmNHk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="R9rdhltO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92332206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ob+0K52ckIERrziCbK+EzuZ5IFDBpmvEWfY4SKjpcPc=; b=sM4HmNHkG7kT89
	85Wli97crJGLlgn6dJeRCrB5c6ySkD/hYBIIPoSLcaIHXUqRIDbiatWqeF0DHdbhQ/XXz0qa8iB6r
	oHVyYd0KBt9x0z64MWZ0bSS8HaUZQE1nuDEfcJgl+qF+U6ZnetiJs3bOdZM+YCVkpjk5wATQ7mxNn
	1bYXQ+pv82EAfrMQpvAqZgQ5+hZjCylsM/AB/xokr+DjD6c4/0B84frOA6dKTiuiycGzMoZrV6o3y
	QQhCsr3JIPoFwHFsTIzBCSscx6GU+80TLlLglVAnp3RFqUGs/DzeM9Im7wFOjmib1JGdfKhcZJ6iv
	RZIOs3eaBTpo0GG3xflg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggp49-0004GL-S1; Tue, 08 Jan 2019 10:57:01 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggp3j-0003nG-9r
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 10:56:39 +0000
X-IronPort-AV: E=Sophos;i="5.56,453,1539673200"; d="scan'208";a="25051843"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 08 Jan 2019 03:56:33 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 8 Jan 2019 03:56:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfPvz3EWSyHiOROnv51qNGv0c8PxUBr56m9FxRmG9fA=;
 b=R9rdhltOP2j6OaQZCRkfXkO9uLTwD20QmWss52ZKu0T+Ac6a8L1bk3EGEQh8rMpaxD7j50O1jzQnlLo+qS+EcRnNFy1/hghMJxcWF0fQHfksOM8FiJJbdMRb3nrUPQhUCbTuJt9rHI2dk2qzs/EFCm4rHwedERSeeicI0PAjKbE=
Received: from CY4PR11MB1909.namprd11.prod.outlook.com (10.175.61.147) by
 CY4PR11MB1399.namprd11.prod.outlook.com (10.173.17.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Tue, 8 Jan 2019 10:56:32 +0000
Received: from CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::5478:c9ff:e5b2:2b4e]) by CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::5478:c9ff:e5b2:2b4e%9]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 10:56:32 +0000
From: <Claudiu.Beznea@microchip.com>
To: <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <linux@armlinux.org.uk>,
 <lgirdwood@gmail.com>, <broonie@kernel.org>, <rjw@rjwysocki.net>,
 <pavel@ucw.cz>, <len.brown@intel.com>
Subject: [PATCH v2 2/3] regulator: core: add helper to check if regulator is
 disabled in suspend
Thread-Topic: [PATCH v2 2/3] regulator: core: add helper to check if regulator
 is disabled in suspend
Thread-Index: AQHUp0DQuBK0W+8S40WNFSmYgBfyCg==
Date: Tue, 8 Jan 2019 10:56:32 +0000
Message-ID: <1546944944-13911-3-git-send-email-claudiu.beznea@microchip.com>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0113.eurprd04.prod.outlook.com
 (2603:10a6:803:64::48) To CY4PR11MB1909.namprd11.prod.outlook.com
 (2603:10b6:903:11f::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; CY4PR11MB1399;
 6:vF6n5IdIE6ZLBYV5Ypa9W3jX+MTFS9CFVisic1T4JFjgyPQMnRpKS55Wkn3uB5oH4IZ8nc6CkySFn4q8SDXV1Hl9dAtOW94/0Ucr26OCCDfepq7jQgB+jFVIUfsNIgzoJmBswLtftnOTlX6Nl7oa6klnaTFpgeDxgtwAO77bydBQYaUCEAP+GJzChq1OgmDr9I547zuWvv9UJmozdFVL1FDUJd1Qn+1+6viACg0C7MOi7sI8F79YtwoAOc9X6psZdX0xTyRqaOwqThkHHsOQmCR+FNesXudOyOoBaP4Q+K2mNh7ZHJTfv7wI+ofnhVSeuVPVFruvFEkDyD/aPag2l5a1O0Gqj4zr9a5B15NOjxsULeB6bPiGM8/6FzUmACWpLgAMNF/G4k4GRpaMPWLfHG3uiXp5Ob0Y39lAFxuB30EToFmvcSqWC1KSR2+kG0J2XY01gjEXHxMxgTeOSHmV/w==;
 5:gGudJ/08/hjm7SMPekg3IFX+ghFLeD4k/CmD4e7EW+EmaOrIempw0TkJmfqNK1SabJpJvP7Rvuf2qsu5tSsbYpImXS76cIvTpbIjbOYozKtVR/+zn5H85S4ED8MxsV5A4V5LgL5seqz7wcK2YGXCKP0WuVZMRc7m6AkUBChRZX/HLrY3zoQFpPLPgFKSl5RUe/iZnpu1bJRhUzD+Mgdwaw==;
 7:YRBTUtspPj9i8KcpNjY2IFm4KBUIm+jTNNDeBbglS5ckLATApe8/ex2G9M7TVFwyLBDB/WpYA2UYdgAArNj9o7KOuYA42veJtG9fXfus3ID1BRFuEBYRDMUY2plIeesMmMQOndWfund5lUIuydRyGg==
x-ms-office365-filtering-correlation-id: eaf88f77-5609-418d-aa2b-08d67557f301
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR11MB1399; 
x-ms-traffictypediagnostic: CY4PR11MB1399:
x-microsoft-antispam-prvs: <CY4PR11MB13992ED858EEA982B6884A35878A0@CY4PR11MB1399.namprd11.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(366004)(189003)(199004)(6512007)(72206003)(8936002)(2616005)(476003)(102836004)(478600001)(11346002)(97736004)(36756003)(256004)(14444005)(86362001)(71190400001)(2906002)(71200400001)(66066001)(3846002)(6116002)(2201001)(316002)(54906003)(186003)(2501003)(110136005)(305945005)(7736002)(14454004)(446003)(6486002)(6436002)(8676002)(7416002)(6506007)(386003)(81156014)(81166006)(5660300001)(25786009)(99286004)(26005)(39060400002)(107886003)(15650500001)(106356001)(105586002)(76176011)(52116002)(68736007)(4326008)(486006)(53936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR11MB1399;
 H:CY4PR11MB1909.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ClAkgeg/6e9R6tGeKCPfI9UXQ4ZliithjGgdRFZzdF1Ee2tqGKFgWM+6jBeplapkmBv00RNankxUNdyAIrBAMyOmbnfgNyqx85M3EZrOYgVIz3Cw/cLDfHrsbkv8BaeovngGmcmfw81Y51kMvaVPDC+MYJOKyFk3hECCVxGDWJMmMDZmbrXsl8dGpKPX9XgPcusNJZjmmAcs6amV3zZtsdL7PB+cgrqks6n4tM3YXLB6Dm3JVIVz8H6EqLPyLrWqZFBhtF/7RQC03gcoVsXPHfuyXGP/T2KJWiIyKsV0sTi9V2mubdDhAx7UjmMdBS8G
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf88f77-5609-418d-aa2b-08d67557f301
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 10:56:32.1580 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1399
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_025635_699875_1E98CAA1 
X-CRM114-Status: GOOD (  10.42  )
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
Cc: Claudiu.Beznea@microchip.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add helper to check if regulator will be disabled in suspend.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/regulator/core.c           | 17 +++++++++++++++++
 include/linux/regulator/consumer.h |  7 +++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index b9d7b45c7295..3b761969732a 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3786,6 +3786,23 @@ int regulator_suspend_disable(struct regulator_dev *rdev,
 }
 EXPORT_SYMBOL_GPL(regulator_suspend_disable);
 
+bool regulator_is_disabled_in_suspend(struct regulator *regulator,
+				      suspend_state_t state)
+{
+	struct regulator_state *rstate;
+
+	if (!regulator->rdev->constraints)
+		return false;
+
+	rstate = regulator_get_suspend_state(regulator->rdev, state);
+	if (!rstate)
+		return false;
+
+	return regulator->rdev->desc->ops->set_suspend_disable &&
+	       rstate->enabled == DISABLE_IN_SUSPEND;
+}
+EXPORT_SYMBOL_GPL(regulator_is_disabled_in_suspend);
+
 static int _regulator_set_suspend_voltage(struct regulator *regulator,
 					  int min_uV, int max_uV,
 					  suspend_state_t state)
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index f3f76051e8b0..cf5e71dc63ce 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -36,6 +36,7 @@
 #define __LINUX_REGULATOR_CONSUMER_H_
 
 #include <linux/err.h>
+#include <linux/suspend.h>
 
 struct device;
 struct notifier_block;
@@ -285,6 +286,9 @@ void devm_regulator_unregister_notifier(struct regulator *regulator,
 void *regulator_get_drvdata(struct regulator *regulator);
 void regulator_set_drvdata(struct regulator *regulator, void *data);
 
+/* regulator suspend/resume state */
+bool regulator_is_disabled_in_suspend(struct regulator *regulator,
+				      suspend_state_t state);
 #else
 
 /*
@@ -579,6 +583,9 @@ static inline int regulator_list_voltage(struct regulator *regulator, unsigned s
 	return -EINVAL;
 }
 
+bool regulator_is_disabled_in_suspend(struct regulator *regulator,
+				      suspend_state_t state);
+
 #endif
 
 static inline int regulator_set_voltage_triplet(struct regulator *regulator,
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
