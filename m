Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014F7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:56:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C60FA222DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I1RgW4pj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="OsOwH3f4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60FA222DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dAIWL1BWyY++8DqHK0+OQ3LUBMKHmXBn8Dd4eCO1O2Y=; b=I1RgW4pj1Mqnww
	gteNicR90yHmTu9WVg6HIc33yZ4ckP+2rzDwYX79z2SEi62VbZtKyT1NG3SBRQnV6MxGBP706lc6+
	NaU90vbNXZxP13Ycj16QkeAKKJn0QeKVDAtsAzzZ4ZvejzwltXBMagYUhrn4SqqTde+MdY97UZxeP
	1c2C0Yqfv1pVLKsvUjbfLR+y6xW7po2NBQuHKf8gv6EXvx0z+HHOp2WLooe2nwumumF5YGrvW4Whz
	jBQgKzFAQ2A+Oo6WTNucqy6YSiyZrrKwm6elkWUfZvRhPyr2jGSjkMEth9Xr9Ox4Rvo7lgBLAQ1t7
	x2Q7SSsK5RTVz6pM8OxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guJMq-0008Hn-9U; Thu, 14 Feb 2019 15:56:04 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guJLo-0005uL-GY
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 15:55:12 +0000
X-IronPort-AV: E=Sophos;i="5.58,369,1544511600"; d="scan'208";a="23863296"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA;
 14 Feb 2019 08:54:49 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 14 Feb 2019 08:54:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGchSv9RbTaQmFcdqhfXfcH7NXDgKrn5e+tMQXSJON4=;
 b=OsOwH3f4iLVg12ClV+6CrGfHVbpiBHX/gCn3Kg3k4XQz69gbkhgEyyvs+zBcozd+fWMk/3msGE8g0swYqBTAUkfByXhTIRtSjmbs5NKma5eSRrspmydLNPdS/iG5TK4LghYWC3hiuuo/61s68HhghEPJtqwxAVR7mR3sJ91ywuA=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1472.namprd11.prod.outlook.com (10.172.53.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Thu, 14 Feb 2019 15:54:47 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 15:54:47 +0000
From: <Claudiu.Beznea@microchip.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <linux@armlinux.org.uk>,
 <mturquette@baylibre.com>, <sboyd@kernel.org>
Subject: [PATCH 4/8] ARM: at91: pm: keep at91_pm_backup_init() only for
 SAMA5D2 SoCs
Thread-Topic: [PATCH 4/8] ARM: at91: pm: keep at91_pm_backup_init() only for
 SAMA5D2 SoCs
Thread-Index: AQHUxH2cEKHImCWzc0WPV8IYMoowWQ==
Date: Thu, 14 Feb 2019 15:54:47 +0000
Message-ID: <1550159642-26878-5-git-send-email-claudiu.beznea@microchip.com>
References: <1550159642-26878-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550159642-26878-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0901CA0098.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::24) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [213.233.85.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3bb4697-e9ca-4649-a0ea-08d69294be50
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1472; 
x-ms-traffictypediagnostic: MWHPR11MB1472:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; MWHPR11MB1472;
 23:77mAhVBDf18ysdSTNvhjybAe4/FJXvMUMHmPdBm?=
 =?iso-8859-1?Q?102YLUEdNhTzHxiJVXhbOahwmH/MMSeROKoPybS+hQOySWlVUWQH7zi1ib?=
 =?iso-8859-1?Q?6VOLf5la19CHMjqE6KrX1IolGzugRdg6xv89vTs60tBlFJ+jWyYsMYUvNm?=
 =?iso-8859-1?Q?siFMkBqJyY6zYDmPHGTOHtpjmecY8xVdBDu6WkrG1TUgjvs5Awr7zYU13E?=
 =?iso-8859-1?Q?AmQcPwxDpC0bMam95tZVOwAuK5uw1V/OlX7UUlXxloCbQ9QKgB/WR6w1DG?=
 =?iso-8859-1?Q?2wmpypDEldG8w4tEdozORwZWYxQwO+T0Ddulrn6wQ7Orpkt5m6LvSv7oiQ?=
 =?iso-8859-1?Q?sDaE5oOY6z/38QnKamrxVwjT70cFKpgVRZFup0CLsl5L/0z8ECgKj+jd4Z?=
 =?iso-8859-1?Q?9luBjo3MnBFxDUcvnU8Rt0T5jY0XqflzGJa+SCQP6eiUoVk0v/ViM6X5TK?=
 =?iso-8859-1?Q?ToOPacCQJZjungdkNn1reus3WUZGUdQMPcLIhVt6EXdFmPFeEXKHJufRDt?=
 =?iso-8859-1?Q?YPl1jE52QPwPAMMTFQ1TJCUtLRXwEW8JbqTIDAWy7I3BGE1g14+ydEFwRB?=
 =?iso-8859-1?Q?UJnPjOV2nBGqJndM+POLiOuiwKR//NmFafJo6+5orE5YMS6xzuvdJ9Bfb/?=
 =?iso-8859-1?Q?ilUAusedne7/1LmhVENaCGXDqyCR861VjO9z+IDmE/smVFA4B/LISb/iM8?=
 =?iso-8859-1?Q?m8YAcHVFC3DYvIsysiglzDEEbrNnN7v+FfrjDChsWAGDAsUatN/riZ81IH?=
 =?iso-8859-1?Q?fDqh+RjTJdeTDfOdcYoD1ePxEH6t0wguW58BYzZx5D4jcz8vQQJ8m+r4WE?=
 =?iso-8859-1?Q?ZaBttouEHbjr5RggFtIwauQE0drTRNCUJ1wVTGErD9m+/QXyS3qIJLGfZ9?=
 =?iso-8859-1?Q?bJnti3eat7eVQNu18VpYUTjiOXHaso08oCIAh5/Yv0ge2R3s6a7BXuPwuk?=
 =?iso-8859-1?Q?aSbL8LExfOJtRQF0ia9SL9Exh2+z1mw0lUylxfLBDUwYLKMqnXk4nn92FR?=
 =?iso-8859-1?Q?N3tkGkkbUWa/SlbxGPDI36LGR2qN0o9Igp2MbsZ0LNA0X3kOk8ZWyBUmS1?=
 =?iso-8859-1?Q?J2OeQK5dRoCK7hvOw9jahkRrTOf2OzeK3XvpaF6b7Bg61hqUOVczhGS6P8?=
 =?iso-8859-1?Q?lih94GsnS0YXrJd24t8e9HlQsrMIgMLins94nTH7wgVex7KqpMj48feCd+?=
 =?iso-8859-1?Q?9d2PFxIVOZ8bjPppM0IJ+qhwQj2U8ETOuEemwU0aA3TDFbKQJZVdpl5R4G?=
 =?iso-8859-1?Q?UM40lfAomyg/rVAG5l7Ias5Hz1H6njMyHmz9hUsdIblmN35WMYGf0dzY38?=
 =?iso-8859-1?Q?HGQwe92NXlKo5NGtivMRPXL5blIaRlYHdhFa0E8L+zz8Q=3D=3D?=
x-microsoft-antispam-prvs: <MWHPR11MB14720DAC56AE63BA19599FAA87670@MWHPR11MB1472.namprd11.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(6029001)(346002)(396003)(376002)(366004)(136003)(39860400002)(189003)(199004)(50226002)(478600001)(52116002)(2501003)(110136005)(25786009)(316002)(66066001)(8936002)(2906002)(8676002)(72206003)(68736007)(4326008)(54906003)(76176011)(81166006)(99286004)(6512007)(256004)(81156014)(305945005)(7736002)(6486002)(6436002)(26005)(186003)(6506007)(476003)(106356001)(105586002)(7416002)(14454004)(446003)(6116002)(102836004)(386003)(11346002)(97736004)(2201001)(71190400001)(107886003)(4744005)(71200400001)(3846002)(86362001)(53936002)(2616005)(36756003)(486006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1472;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Liu6btIHccEwIDx7ySMotSvHN9g22KKd544q77C60EjBJNxBNGON7NAUJ4+Oc1251JIN+5qqu08qfxJifHXGrtuvP0Ej1Yr+fNJbm6Mi5smrAPnwgSGzWhR4zQvACYDB5QshktnRpp2X2bPzuaZzxTBEYVSTtKu1x29o8JKGZUQIcH/tJgDs1sJLqwvHQNTvhN9DFv07v06Z9T84iteufDQuxnF5Xx+MoVE27fHvkc+5Lfl92YvejWLaNwpCVJC4AxLZaNza1KsB2vYn++uTe2tRmD3pdpIgkb8w6j1eDUfYXXsdg3D5f7cckwlhoABCgTEQT2BzotlWCrSnzIhl9FZbvfirxaUkdHVPMfJPbRPuZmq8xLcshhmmJ9gzzxg8ZY8sheF+0G4VHwEl1LxE0hBAJjoXUMMKAImTB3kZePw=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d3bb4697-e9ca-4649-a0ea-08d69294be50
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 15:54:42.3620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1472
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_075501_135913_7A19924F 
X-CRM114-Status: UNSURE (   9.72  )
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
 linux-clk@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

In at91_pm_backup_init() return if it is not about SAMA5D2 SoCs.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index e42db02eafe4..c83f78000ab3 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -588,6 +588,9 @@ static int __init at91_pm_backup_init(void)
 	struct platform_device *pdev = NULL;
 	int ret = -ENODEV;
 
+	if (!IS_ENABLED(CONFIG_SOC_SAMA5D2))
+		return -EPERM;
+
 	if (!at91_is_pm_mode_active(AT91_PM_BACKUP))
 		return 0;
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
