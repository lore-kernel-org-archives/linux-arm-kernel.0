Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A166AC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:58:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71E9220855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b4DYCmHE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="rJEuc+7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E9220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=isGhvtsOWQ5Qqu/yrm7iUQC4DrFo1LzQenT6PNXWOTY=; b=b4DYCmHELB7UHH
	/gwumjHwHe+ZYx3XT+uUO7ZYCZwT0hfS8bXz8fMR6lxZf7F4v2lrfqI8y7uli0qEsGRNhUPSZG4lv
	AXy4qD3jqI/vGMRZ9QYslber38dye0q2N0KRkK2ZzmFm2/mTiMxm4CZswte9mrjJXNZnk0YK+PnIM
	OPj7p3EtH8DjZ5C8YqBHj+UhlVzWjslFg2gmEVvQyvWr0MPuKQEYe0ensshoVsvonVdtLh+l7t7mu
	ZQj3jKgnP4+Jo6xzc9nkXpJlGcAcNW/nXLSJTJIJUC7zViuNrSuTFtE8sQIcKGgdKvaw7lZUoa8hu
	4Xgp7PI0dxxyDxH013Uw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWkQ3-0006Y6-QM; Tue, 11 Dec 2018 15:57:59 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWkP9-0005Vs-Kc
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 15:57:05 +0000
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; d="scan'208";a="24239886"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 11 Dec 2018 08:56:52 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Tue, 11 Dec 2018 08:56:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyUsVR2vP3b30ui9wooEsbttVTjegX/NS06gcPyMgnE=;
 b=rJEuc+7qu3JM6KxB/TpxUSg1KgU8XA8VfM+vfU8pbjYNuztHYxtuhiAS+iAh9hltI+PKLYK7oNqOIBxpjK+GDV8Veg2FFyW72V2Z88SnMUKHVmzL+JS0gt3sRlR6v+3rpemMV8QuluQa3OH5uiRMhHzXs19Cke9gYtMMk1MUaDE=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0792.namprd11.prod.outlook.com (10.163.112.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Tue, 11 Dec 2018 15:56:50 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681%5]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 15:56:50 +0000
From: <Claudiu.Beznea@microchip.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <mark.rutland@arm.com>
Subject: [PATCH v3 4/6] regulator: act8945a-regulator: add shutdown function
Thread-Topic: [PATCH v3 4/6] regulator: act8945a-regulator: add shutdown
 function
Thread-Index: AQHUkWogZ52Q/Ih4UEibIP5thNGkQQ==
Date: Tue, 11 Dec 2018 15:56:50 +0000
Message-ID: <1544543768-2066-5-git-send-email-claudiu.beznea@microchip.com>
References: <1544543768-2066-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1544543768-2066-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0902CA0050.eurprd09.prod.outlook.com
 (2603:10a6:802:1::39) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BY2PR11MB0792;
 6:o2sTXVzx2fpwPKS/7bwXgtRIgqZsnMMEE6CBpr9VoEEIcPqt3LM4HF7RgeNijecPMIqm/9MUHdlc2lYTTruhkGi6wLier4iM5L1ZbkthtmepimyDMjMev0IJClnaVm84PArveSOkxp5mcNSX6KDAqYQLM3n43klyw0fv8/fQqBBERHgX+xdDt7N7AUQqTOz9wcaRmJ0pik4PII7qO4CPrTexYnWCojF9bTFIAnPsh8BwOIfTQc4FFLoheYLjOxKdgPWrjf8Fu7uTQzA/U3h1KsCuAsvUpY+1tTK5OrT2+nmbIATSkaxk6dBxX5pDfDtcs/Znqdw0dTtd64ydxkTwsFA/Qsr/ZrGkwdqbU5v3BBHt5YsZqFL9RChwtnTKgFmz+329xeLGxesdSJpWlFjscxhcvI0foq0JXDlSG6FY22rR4p+JoJyHZgGQ6jGyCmQibQsM0W/vIWvi3/ESTZxeTg==;
 5:hlzCqw8qcXI/3qo3YdWJBONbGDjc7InwwEGiodnk5d03BQ8SJxhICy3IzWi+yZY4QthtmEwPgsQbP1n/ZR/cFgdkpyPgqoMJJs/YaKKF8QfX72+R3ppHO1rCa42v1tNdjNSZCMYNUO5ZEbwAqqbzQHpOOBRVITcdGgOvSxBR/Bo=;
 7:NpLwp7B4IyHuK1VLZCd0h3fyni32MsDjL26lB2bGzIzD2suXCon/Ydx3QIDvi4LEQlIO07QyKu3NMGdHAWpYd21Qiqs8/tl5C3GONbIzsoCFVN0RRmygBFEhIrw85CnZniLU2US9pMIN+5ZNnfCrIQ==
x-ms-office365-filtering-correlation-id: 655a17ec-7cdc-47fe-e5d0-08d65f8142f6
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BY2PR11MB0792; 
x-ms-traffictypediagnostic: BY2PR11MB0792:
x-microsoft-antispam-prvs: <BY2PR11MB0792EDDEB7CDC766D2AEC0CB87A60@BY2PR11MB0792.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:BY2PR11MB0792; BCL:0; PCL:0; RULEID:; SRVR:BY2PR11MB0792; 
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(136003)(366004)(346002)(396003)(39860400002)(199004)(189003)(54906003)(36756003)(476003)(14454004)(39060400002)(68736007)(53936002)(72206003)(478600001)(316002)(106356001)(110136005)(305945005)(86362001)(107886003)(7736002)(2906002)(966005)(4326008)(102836004)(486006)(81166006)(99286004)(8936002)(25786009)(186003)(6306002)(3846002)(66066001)(26005)(8676002)(76176011)(71190400001)(71200400001)(6506007)(52116002)(386003)(6116002)(2501003)(81156014)(6512007)(5660300001)(97736004)(2616005)(6486002)(446003)(11346002)(6436002)(14444005)(105586002)(256004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY2PR11MB0792;
 H:BY2PR11MB0744.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 85C6lI+FZ5kFMGbYfBCOcpjtXDUSH1X2ySUsVzY/agmuU4mK3yjwWpW7QV1bYVzsR2gvGpl/e7WCx9KKGU3dagim2iwv71xRuAoSIsOVn85z+yQLmXN+gb2sbHk1KGEkpudgqDUUt7A75QkL6vsoImOi67XZBl2djiVB3VuFg74upOX8j5kRORX1KMLrUJWP1wuzDh21xAOtsb0BlbTRzr6eaAtv+TRIg4dPo2sWGQ3sc8TlAsTObUhhOgw1bRB1jkmNJgRP7D+iNBWXk9lhX06qzSRPXBIpl2GkrTEkJmm/Yu4ELvRDne/uffBLcBCN
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 655a17ec-7cdc-47fe-e5d0-08d65f8142f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 15:56:50.2134 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0792
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_075703_778511_B5CB53FE 
X-CRM114-Status: GOOD (  12.74  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Claudiu.Beznea@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Implement shutdown method to make sure the PMIC will not enter the suspend
state when the system is shutdown.

This work is based on work done by Borris Brezillon on [1].

[1] https://www.spinics.net/lists/kernel/msg2942960.html

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/regulator/act8945a-regulator.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act8945a-regulator.c
index f4d60743efb3..90572b6370c6 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -339,12 +339,23 @@ static int act8945a_suspend(struct device *pdev)
 
 SIMPLE_DEV_PM_OPS(act8945a_pm, act8945a_suspend, NULL);
 
+static void act8945a_pmic_shutdown(struct platform_device *pdev)
+{
+	struct act8945a_pmic *act8945a = platform_get_drvdata(pdev);
+
+	/*
+	 * Ask the PMIC to shutdown everything on the next PWRHLD transition.
+	 */
+	regmap_write(act8945a->regmap, ACT8945A_SYS_CTRL, 0x0);
+}
+
 static struct platform_driver act8945a_pmic_driver = {
 	.driver = {
 		.name = "act8945a-regulator",
 		.pm = &act8945a_pm,
 	},
 	.probe = act8945a_pmic_probe,
+	.shutdown = act8945a_pmic_shutdown,
 };
 module_platform_driver(act8945a_pmic_driver);
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
