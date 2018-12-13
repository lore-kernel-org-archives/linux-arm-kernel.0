Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB254C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:50:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 981962086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hTS2vurd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="CKSLK1hp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981962086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8UdlbJTQufAC6pEFezBisevGPSEV8UFDCTp/v9GzCHY=; b=hTS2vurdozJYon
	Aj7vDNELjkB1pwjJR+9kZa3Mjb6E4QFu0jVA9qOfKGn4QkaLywr3obbym8AEX8ksHR/qOCHV/skac
	U5Pqn5r3aSIYQ303PIIZc39Zm3zdmQBUvarc1s8CyuSUTM5DEk6MO1f7TlfjqPVaNuY+E6lzDmajb
	2lxybeytrCFPnjJa4SU5E1BSJvGgTuC3iSjm/mW9kZfEIUF8KF1hnIkrL6NUgTUCbi8FWuux9sy/u
	+wS8SGvxUO9u2YdHshwBhq4ZBDZyfsBJ6kZvACINeaeGCvgA1JGAmhQlFCX4CQSh9BDGin+mj6dYH
	cM1Jut1z1IAOnWjsveAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQRg-0006pT-Ve; Thu, 13 Dec 2018 12:50:28 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQRF-0005DQ-G3
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 12:50:04 +0000
X-IronPort-AV: E=Sophos;i="5.56,349,1539673200"; d="scan'208";a="24166666"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 13 Dec 2018 05:49:50 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 13 Dec 2018 05:49:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxxT2pAFXr1RN0I4DvwXHu2JGBntIzG2YdAm/5jxx/g=;
 b=CKSLK1hp7LrIZC3wERtG+hD2Vh9RBv010faRcgqsU6n7p4SCZOR4BFnJev+0BrRKJJ4QYa9EPx/klv5KFe3l5Wn5CXweHDilm08bDTuEPVRbA9PYcKHO9HVDG+KVcAQ3t6HPkNGAd1vQU+5F4hYyFVbV+UoGyhmuwu/WKIYCGh4=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0519.namprd11.prod.outlook.com (10.163.158.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Thu, 13 Dec 2018 12:49:48 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 12:49:48 +0000
From: <Claudiu.Beznea@microchip.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
 <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
Subject: [PATCH v4 1/6] regulator: act8945a-regulator: unlock expert registers
Thread-Topic: [PATCH v4 1/6] regulator: act8945a-regulator: unlock expert
 registers
Thread-Index: AQHUkuJUt0u4zqJzDkux07mn15Lo/w==
Date: Thu, 13 Dec 2018 12:49:48 +0000
Message-ID: <1544703110-27161-2-git-send-email-claudiu.beznea@microchip.com>
References: <1544703110-27161-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1544703110-27161-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0248.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::15) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BY2PR11MB0519;
 6:bVyKoAfh0wFEnjkW1GQVqSPgGND4Axujr5PHUHYy8n/SeBJoSy/JmKrI8kYZg0y+mKhsqRKe2YgROmhuTX48UXEyGuSZSbSi8XyaYiT/ZpluH7TpzzUg6j6bLkxL1JNgXNFq9Q2MLFoIFsmIFnsxsi/Ilw3XHL20Tt6lAQIOXd93UAYVNloItBh4lEi0vTG66r0pU5wAl3f1kk8tU/hUtr/hJRPyXNq4qaTagNAg37GP4UWmlJaqCi96kgfKfqRVtuKKuOMVaeGKjtOGIQejsRHCKt9XvlAfY/CgrY7AazqSDTtG8fL3PpyYgMnR838nmAMgwLCwacJcEIgk3lfnzeSH7zR6yvLddF9nuNVCX0gfchzbLGluw5XROAXL8EYjRKa197VevT2JCo4zY/LLuFrXGhs32RuTkcGKioVb1uD+6P6vS25uOvXAy78AV2D/QC25ImWImc6XBXauQW4j0sakqDrpekQCYwnWtKaXQZE=;
 5:pSRmctBTwk6doptGWRV1Qvj+IcJcaNk7JZTjgmA0SQnXxB9+fITblslhGpNsUhxNwxBgsCNUvhBoCKAW607eh8zGx9ccsO+wMK/py5NWltBlkA3Wqt2bAX+L10eFiV82GjMBJLxjTZDCGRAd2E4YVlI35XlENcbCFR2weROP72w=;
 7:r+Gt5CJBWjvgkJdbqZ0pHhj3R8Gx5VHHuK/a6nufO9fk+1jwcXX4ExuO9WqWjhNQnEt4U/qx1ICHGB1Rn31G9wySN7tRvx7ELwBPOvCdI6Pz9xyBylEWC6OkDjh8SCK5VnM8mYZTqCmRDXnTTqeBcg==
x-ms-office365-filtering-correlation-id: b41d0e67-9f6a-4953-6198-08d660f97722
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:BY2PR11MB0519; 
x-ms-traffictypediagnostic: BY2PR11MB0519:
x-microsoft-antispam-prvs: <BY2PR11MB0519CE222A29AFF57F90F85C87A00@BY2PR11MB0519.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:BY2PR11MB0519; BCL:0; PCL:0; RULEID:; SRVR:BY2PR11MB0519; 
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(316002)(5660300001)(305945005)(8936002)(97736004)(2501003)(102836004)(26005)(6436002)(36756003)(99286004)(476003)(68736007)(3846002)(386003)(6506007)(7736002)(14444005)(76176011)(52116002)(6486002)(6306002)(106356001)(6116002)(186003)(4326008)(105586002)(6512007)(256004)(53936002)(81166006)(81156014)(8676002)(2906002)(66066001)(39060400002)(25786009)(575784001)(966005)(2616005)(86362001)(486006)(446003)(6636002)(478600001)(54906003)(107886003)(110136005)(71200400001)(71190400001)(72206003)(11346002)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY2PR11MB0519;
 H:BY2PR11MB0744.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ab3OuIQGHCtyiEgX5FNn2hZtz7uvSlmEvhNkkvUglwFDe91k9CN34cfQn3IvljbUHK1DR5BpJgMMIiA7aBKYMYnux2z/jwox6FTmX4h3PKf1YqAa8EKN6gNaWYGma0g3PBf6vzYWkbZVrSjp4nulZADAqOljipkmbQziDYUq8XEqRVOHP0J1jVHkJ0rSjGutHupY9dqA30ivpLj1Pc/LJkvLHxzd9xH1zDqBB/svmuE0L9oPnRZ6t6nzEUntPkenB8W/F904nYm14Iq7DHG5PxlztYxqy1lVTdykuxIKIB5Yxpq6dP6MZs6xmkO/6mt4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b41d0e67-9f6a-4953-6198-08d660f97722
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 12:49:48.4992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0519
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_045001_702524_4B7C9819 
X-CRM114-Status: GOOD (  14.31  )
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

Unlock expert registers for act8945a.
This is based on orginal work of Boris Brezillon at [1].

[1] https://www.spinics.net/lists/kernel/msg2942960.html

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/regulator/act8945a-regulator.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act8945a-regulator.c
index 43fda8b4455a..8d71d9893d0d 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 
@@ -23,6 +24,7 @@
  */
 #define ACT8945A_SYS_MODE	0x00
 #define ACT8945A_SYS_CTRL	0x01
+#define ACT8945A_SYS_UNLK_REGS	0x0b
 #define ACT8945A_DCDC1_VSET1	0x20
 #define ACT8945A_DCDC1_VSET2	0x21
 #define ACT8945A_DCDC1_CTRL	0x22
@@ -123,9 +125,17 @@ static int act8945a_pmic_probe(struct platform_device *pdev)
 	struct regulator_config config = { };
 	const struct regulator_desc *regulators;
 	struct regulator_dev *rdev;
+	struct regmap *regmap;
 	int i, num_regulators;
 	bool voltage_select;
 
+	regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!regmap) {
+		dev_err(&pdev->dev,
+			"could not retrieve regmap from parent device\n");
+		return -EINVAL;
+	}
+
 	voltage_select = of_property_read_bool(pdev->dev.parent->of_node,
 					       "active-semi,vsel-high");
 
@@ -149,7 +159,8 @@ static int act8945a_pmic_probe(struct platform_device *pdev)
 		}
 	}
 
-	return 0;
+	/* Unlock expert registers. */
+	return regmap_write(regmap, ACT8945A_SYS_UNLK_REGS, 0xef);
 }
 
 static struct platform_driver act8945a_pmic_driver = {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
