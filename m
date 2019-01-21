Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F93FC2F3A0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:31:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D0962085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NvSR55e7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="HT8yGrb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0962085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WHpoOGU4GYEmTsWHRoUzQ2v5Yb6lkynjDlA/cI60hpk=; b=NvSR55e7qijICp
	M8NYp5sESNoIE1ApLs7NKLFoDC5HUTMHsUyUuXJNQXplSXlGWnIhB56L54/+sECxItJm/bDLUlc58
	48/Nk+D2VNfgdi6oltm0rTTmwFho49+QZqm4X+PuQHYgwEq9bJUj6WhrKjuRIjI27Esjp+jCAhSX+
	3dLP0sFgkEcBdRzZwlNEokcWdEVEPR0IXUEd225CAyy4Li4HzqzhG7cr5FSEeBqxbFprnxXiVbkzz
	HjC2DfOrfkmkHDtwB7DL/pCoREDKkyzZW+eE5dqqjW5DZQpak5BZAAn1G7ELbxPD2HcdnPkraTbRD
	Nqp3eyl7mxZTJYSrQEsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glYjw-0001t4-Cc; Mon, 21 Jan 2019 12:31:44 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glYjE-0001As-BA
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 12:31:04 +0000
X-IronPort-AV: E=Sophos;i="5.56,503,1539673200"; d="scan'208";a="22851350"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 21 Jan 2019 05:30:59 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 21 Jan 2019 05:30:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+fk+zC59QYsLhDY21paBqWAZl1SRhfODpasLgtZdPg=;
 b=HT8yGrb7e+YKYXuBsOs9yqqF+N7GWut7K/A2tQpxPv9q1widYvJIZydJZjYhRSXHtNMNCSXlg7Fpf8aThzABCZCgqpzYZ2NEXR3UizQ8oUNAsEQUuQwyf57VVZdI0exj1MvYBm4fyl717Al2O4Avk8txV+Wg8fCT2JV4FP8c0Mg=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB2064.namprd11.prod.outlook.com (10.169.236.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Mon, 21 Jan 2019 12:30:57 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%8]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 12:30:57 +0000
From: <Claudiu.Beznea@microchip.com>
To: <thierry.reding@gmail.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>, 
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>
Subject: [PATCH 3/4] pwm: atmel: add support for SAM9X60's PWM controller
Thread-Topic: [PATCH 3/4] pwm: atmel: add support for SAM9X60's PWM controller
Thread-Index: AQHUsYUoc3gFiFGgJEiYtUuc8i0+lQ==
Date: Mon, 21 Jan 2019 12:30:57 +0000
Message-ID: <1548073783-22640-4-git-send-email-claudiu.beznea@microchip.com>
References: <1548073783-22640-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1548073783-22640-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0038.namprd07.prod.outlook.com
 (2603:10b6:a03:60::15) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB2064;
 6:ATVP8qpn9a2+nGcTMMWE3FijGNNHifutqVzr31cCG1DKmvq7D96eHL3n0M/7oI1fEx8gDswr4TB6M0Hg5/zIx7S2ZO4l+JlF7/1vm3j2eb3MpR8YjK23A3dvPlBDg7bBYu8b6SZqTywD0+unAvW6pRc71fYuTWujBmKBqZF2VirtX+vk5Sh461efkt3ak5w60cZsZi4cTG0AZWIcTfosBS8B3rpE3t8TeTCPf7mcB32e9sFChYzw2PEkfK53Mp2iMsbv0KfLysZdWlZgkT/YO9WzicJcJ+XCdAJMTKCT6nFaIN63mimn8MrzwBcovsTebE1gUl6YTj5Yl19VHaKAwfPIMEOIj58Rggg3witnxKi+dJ8A2uMSnO9eYV0vyYMRXD97t+itw2yLUQj56QdLsf6kL35yC45ZRxb9dhVvGRxomEs+4i0DPlvYPn0sEEfJh/xZcYWRpNJ8UKFpdbWHxg==;
 5:/tyKXde5grB58CX+uR+0NDJ3MLh+rnrxVsFgpgsrNvthCJh/o/nnU5SFb3Sl3Ga/XHuHK6+r4+F1ixF6uBmSp34pLNfeymC22/+Ms0QIv9qyDJpWhHMDipgXaYV/clZ+9/LPb0M4VNIMFopwgY+YWaEaAH2BAf4QL0up+t2Ly2zmebEsD8Osuf5n3PyLnljVrjnfX+xJY303plh1YoKYcQ==;
 7:K3WW5fwbbiYBGGC5nHUbm7ljbMYGGtrf+5sXoDj0mrGzuufW57x/4J3VQJ473fe6FDFL1DIypoCEythjbdDAfIcJvB8PLXL6XX9Wpo+4HtWnst76gA/F0c3Id4XSLcZqzB6thfYJr9T5u/5HHxw6zA==
x-ms-office365-filtering-correlation-id: 42eb1dca-d01a-4a83-ce3a-08d67f9c4ae3
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB2064; 
x-ms-traffictypediagnostic: MWHPR11MB2064:
x-microsoft-antispam-prvs: <MWHPR11MB20645F06BF78A246BF23FED3879F0@MWHPR11MB2064.namprd11.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(346002)(366004)(136003)(39860400002)(189003)(199004)(186003)(6436002)(6636002)(53936002)(4326008)(50226002)(6116002)(105586002)(52116002)(446003)(106356001)(97736004)(3846002)(36756003)(7736002)(305945005)(6486002)(39060400002)(316002)(26005)(6512007)(99286004)(71200400001)(107886003)(71190400001)(86362001)(25786009)(68736007)(256004)(14454004)(8936002)(8676002)(2906002)(81156014)(386003)(6506007)(81166006)(476003)(2616005)(2501003)(76176011)(54906003)(11346002)(102836004)(66066001)(72206003)(478600001)(110136005)(486006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB2064;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fs5v+T3uk3YPqRQg3wSLt/f41QDgfOsrKX/AzacMHre3COZcFPhkSD6zlSTbxoCQZb9V2R7k6c57sYQ6V+hGzxvkbEBzBlwtondKPX4pqFHlIcNivrH1exiXidLPYMcttAMJCexAQzdxUaiVE0brwMQ7To+UyNrLO3EIR/sYzjX9pRAtiLle/Bczu/YS70iEEem0Ewi2r3TVZ9YB69Cv8KbwwF8koLMYBVOudr5tZs7hklb7nc52O5abdfoUbdf+SsAQt1T7TRiTnXE46ZlaCqcAZJMoVQgbfHZk6g2TqPYoOxfxmtEcujnWq9Mi++AjFZM+cn2wim+JkjpmTEEC1UzumtYC7Nj+ZHuF3xHqpCDcD2r+iTVMM/8SIIN6Avt/p+eZs2j/Z9TVv6XBBLVQO3t9pAbe7CQ2AGgajXK4yn0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 42eb1dca-d01a-4a83-ce3a-08d67f9c4ae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 12:30:53.8354 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2064
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_043100_821363_704D93B4 
X-CRM114-Status: GOOD (  10.73  )
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
Cc: linux-pwm@vger.kernel.org, Claudiu.Beznea@microchip.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add support for SAM9X60's PWM controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-atmel.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 44f4a1c9f60b..44a99ba60e11 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -315,6 +315,20 @@ static const struct atmel_pwm_data atmel_pwm_data_v2 = {
 	},
 };
 
+static const struct atmel_pwm_data atmel_pwm_data_v3 = {
+	.regs = {
+		.period		= PWMV1_CPRD,
+		.period_upd	= PWMV1_CUPD,
+		.duty		= PWMV1_CDTY,
+		.duty_upd	= PWMV1_CUPD,
+	},
+	.cfg = {
+		/* 32 bits to keep period and duty. */
+		.max_period	= PWM_MAXV2_PRD,
+		.max_pres	= PRD_MAXV1_PRES,
+	},
+};
+
 static const struct platform_device_id atmel_pwm_devtypes[] = {
 	{
 		.name = "at91sam9rl-pwm",
@@ -339,6 +353,9 @@ static const struct of_device_id atmel_pwm_dt_ids[] = {
 		.compatible = "atmel,sama5d2-pwm",
 		.data = &atmel_pwm_data_v2,
 	}, {
+		.compatible = "microchip,sam9x60-pwm",
+		.data = &atmel_pwm_data_v3,
+	}, {
 		/* sentinel */
 	},
 };
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
