Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27E2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:31:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD3A12073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D7mHi2sm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="SbQ9qzc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3A12073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H3xiCuzAIuAQcz+pkOO6LdixOkGocn0ox8/cQHfSiXk=; b=D7mHi2smDybzGz
	7E+8siRTljKG8ZMsimkDNKIIKlCPjZcp+0mgBSkCn/bXwnH4mQBgyxBzzkdNMLWPfF9ajOSJUnDCM
	fbGmoz5q9li2NuRstuDJlMBJhwqLYhWW6iVpQ0tAo0wjVu5PFHWq4IOKGnJb71X34vQeVK8dY1HUL
	IUfGJw8Em1UsVK9rZQlYpanxCG75Naay1WQSI1afJUnQ/ES0vZP+xjV3xqGtnTeKE/1xA17HnUQUX
	M4ErUBTHksD0bDb7aKnaQUSAiQaUS5UBBgdfrdH7nte1AFcXyVbg9HKf6xvamReXRuEnd8eWluk6/
	HB7wZKOm5kQjIrALsG5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf35f-0000ys-Ij; Thu, 03 Jan 2019 13:31:15 +0000
Received: from esa5.microchip.iphmx.com ([216.71.150.166])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf34S-0006tA-8s
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 13:30:06 +0000
X-IronPort-AV: E=Sophos;i="5.56,435,1539673200"; d="scan'208";a="22933262"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 03 Jan 2019 06:29:59 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 3 Jan 2019 06:30:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbW1EiKkgAj/gBxHMet2Sam7zBrYJeYeJuf2xaMqGnY=;
 b=SbQ9qzc6cCwi2IRrtliRYg5xU5+KRctbLcGMKHqZrDx5x0dI+5izwFV6135N5prbErvaSMiQwwUx28VpfOJnXA9AAj783aOqBd+pBnDH1SOY6zW+Z2e852WsKlIHiGAHdz+sa/TKfrM5TmrQvstaJ00+vbYKMXKI5RdPCsqqR5w=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1984.namprd11.prod.outlook.com (10.175.54.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 3 Jan 2019 13:29:57 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627%6]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 13:29:57 +0000
From: <Claudiu.Beznea@microchip.com>
To: <thierry.reding@gmail.com>, <corbet@lwn.net>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>
Subject: [PATCH v8 5/6] pwm: add documentation for pwm push-pull mode
Thread-Topic: [PATCH v8 5/6] pwm: add documentation for pwm push-pull mode
Thread-Index: AQHUo2hrpXORaGbfU06xWvz69aRPVA==
Date: Thu, 3 Jan 2019 13:29:57 +0000
Message-ID: <1546522081-23659-6-git-send-email-claudiu.beznea@microchip.com>
References: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0209.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::33) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB1984;
 6:tflFfglim7X03m8+5nCzxDIp8WFnQwuAbPGJJ3DlphuXJX6z0Fg6T4uqAdJotGSTWql49ykhdmr7QPT9yd5QYzVDsHMyUUyjReTq792hD0fpOTf2u0IPVrU26AL88izuX/x06NNFi4x7vokkd4NsV8NrAwbnkdn+kEhrzPi9uL30HAzzXh8l/tLv3vRpFuefqgv9DTps8agil0wxMTxOond/SDBaGeP+BmdTeuA7Wzjvw7a7KmNM3p39ETk9jO2xFioukdmsxhQjQSe4Poj3CnnZcQXDW90DrYYM+sVL6CR+MN6757gW9/aaFbIIATZnCCcL23LTdG06rmK9aDuG53zt++i3NcV9EVVyLi47J8JrI+sZGcokxToAa+HUnlgfwsWoIhg0wTBWdlqzrnQeAzteDQRlKEN1dbtGJ1KMBasulXMlU0v4ftC1AA7UghiyzgJK2VLcfKpJbbkDREFPjw==;
 5:OxVYLVpDrgysI0hnhrWxYHnQoN8a+FqAMzRb2gxWqXKiVnC05gsKNV2XjUMTpZn+A2KWLjiEMdfNB7NbQ2HPlWCjQ9jDrx0POtM2Z3AIOOclfikBFLgMYgtmEIh1SxMX9adBGJWo0mbDQPnHHZHHQGLAcPL20jEb9TyeXouWeGZnd/yB+KyXrSLvRY6JzmGQmuK7qMyAmMDxqttWY9pG0g==;
 7:v+Y1/DPiEYvjRol+5eP+5ueNE6eKaqxkDPrTA8eZmlT1PyC3daxXbAsxKvCvw+tpmBvaxJykK9fjx6LTBH/0zyXe3FeCzl6LT9ykkVZobz7OovbxEs+uZcyFfvbiy2n03Mbyyl/FpnSI84hrZoRZ5A==
x-ms-office365-filtering-correlation-id: 5255ddc9-f2cd-4eb5-58ff-08d6717f8d7d
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1984; 
x-ms-traffictypediagnostic: MWHPR11MB1984:
x-microsoft-antispam-prvs: <MWHPR11MB198474BF7D7D7D1ACDADB519878D0@MWHPR11MB1984.namprd11.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:MWHPR11MB1984; BCL:0; PCL:0; RULEID:; SRVR:MWHPR11MB1984; 
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(11346002)(71190400001)(6486002)(2501003)(72206003)(14454004)(2616005)(476003)(97736004)(446003)(5660300001)(478600001)(316002)(6636002)(86362001)(99286004)(54906003)(52116002)(110136005)(71200400001)(6436002)(6512007)(186003)(53936002)(305945005)(7736002)(3846002)(39060400002)(6506007)(386003)(6116002)(105586002)(106356001)(107886003)(68736007)(76176011)(36756003)(4326008)(26005)(81156014)(81166006)(102836004)(8936002)(66066001)(2906002)(486006)(8676002)(256004)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1984;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gms4XmnVFhH4KgLZZKtvJvT/CWGMgDQcGhu+iFz1sBUimJYDTMe+qz/g+2vfzwtBtKSiegVynLqBABm6xVE35CoubxeZTPrlHJqLpsc8MjSWFrdMIhcbNyLXh9Rq7piH5AJs+/KmAFBQZpMksI0zgj9PQftSKQaqSIRyoXtECCzU7M+JpaO3oebAReKxpOWF8/LA/CcA3sC4sFuiesMSkVyozoV0YUSCJmeneb0XtrYeLTBGclK9TZPJ4ETuM91sigDrmVIhsIWUiGXxLhabrBEsXB7DRdS2FzPXh2CnCOmx4Abv799/BKyiJIKtbqdH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5255ddc9-f2cd-4eb5-58ff-08d6717f8d7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 13:29:57.1824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1984
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_053001_208505_2EE9D1BA 
X-CRM114-Status: UNSURE (   9.88  )
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
Cc: linux-pwm@vger.kernel.org, Claudiu.Beznea@microchip.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add documentation for PWM push-pull mode.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/pwm.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index 669fd4c9cc8e..80552627627d 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -130,6 +130,22 @@ channel that was exported. The following properties will then be available:
     PWMx_1   |__|    |__|    |__|    |__|
              ^       ^       ^       ^
 
+    Push-pull mode - for PWM channels with two outputs; output waveforms
+        for a PWM channel in push-pull mode, with normal polarity looks like
+        this:
+              __              __
+    PWMx_0 __|  |____________|  |__________
+                      __              __
+    PWMx_1 __________|  |____________|  |__
+             ^       ^       ^       ^
+
+    If polarity is inversed:
+           __    ____________    __________
+    PWMx_0   |__|            |__|
+           __________    ____________    __
+    PWMx_1           |__|            |__|
+             ^       ^       ^       ^
+
     Where '^' specifies the beginning of a period.
 
 Implementing a PWM driver
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
