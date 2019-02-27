Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225CBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:25:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D05B220C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MPX3sjKr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="MK+jawX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05B220C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GlfF9G7Q+KF9pEHMI1pWswdlvbbFU+xYMxrGK1t4hEc=; b=MPX3sjKriz1uLE
	vpwysfKo84aSl/2poM+Ludmkh2IHSS+yo5ZnhisiKC2k77ZrADRiOz1QbHLtaRIDkFdmVaKgKGY2w
	1GdAzZyqXozHa6V4VuhoQoDmXE54+6Ux3mQu3tQRNdQjwh5aA3gviCW5+u+/k/lLTDNZOhtkdpoQd
	526DyW99otQN+oU9k9S7oAD3chMbP5LbGeZOzt3XbU9dkYwE2RgmLsAddt9hU4HWovdJL4jF4m3kB
	jE2G22KbBDPf1GDLaVptY5DZF/FTeJfDeZ2Yf0dGOY83juqiCPxJPzDnJsRMGZY200U+KpfYmRKBD
	1e7TppF43Khr4w73oeng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz21m-0001nF-C7; Wed, 27 Feb 2019 16:25:50 +0000
Received: from esa5.microchip.iphmx.com ([216.71.150.166])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz20a-0007xE-0y
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 16:24:40 +0000
X-IronPort-AV: E=Sophos;i="5.58,420,1544511600"; d="scan'208";a="25323653"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 27 Feb 2019 09:24:33 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Wed, 27 Feb 2019 09:24:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwSGtbK7YlE0MWXaYss8ytXvS2vK4pfauPtmUYIt3K0=;
 b=MK+jawX8F9pqGpSCk1YbXQXi4c2P7ZZC+tt1whKvzlK4TeNc2uuzCl9Vv+FEe6As0BiG14ZdDBlNck904c9oZ65kCFmN2+3awZebA7ZtJUOHPN4PI5+Mt96L3D+6j+TFxbRQ39FfWb+OXMOuebolAob1GE6gLRk0BEzLJqVIaGU=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1600.namprd11.prod.outlook.com (10.172.54.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Wed, 27 Feb 2019 16:24:30 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6%8]) with mapi id 15.20.1643.022; Wed, 27 Feb 2019
 16:24:30 +0000
From: <Claudiu.Beznea@microchip.com>
To: <lee.jones@linaro.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
 <airlied@linux.ie>, <daniel@ffwll.ch>, <thierry.reding@gmail.com>
Subject: [PATCH 4/7] mfd: atmel-hlcdc: add compatible for SAM9X60 HLCD
 controller
Thread-Topic: [PATCH 4/7] mfd: atmel-hlcdc: add compatible for SAM9X60 HLCD
 controller
Thread-Index: AQHUzrjqj0V4EIYRXEWHIx1OfW8kHg==
Date: Wed, 27 Feb 2019 16:24:30 +0000
Message-ID: <1551284609-14594-5-git-send-email-claudiu.beznea@microchip.com>
References: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0112.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::14) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb140186-7bb3-4355-b31f-08d69cd00cbb
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1600; 
x-ms-traffictypediagnostic: MWHPR11MB1600:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; MWHPR11MB1600;
 23:B4uGFkoLdvfu4+dPQrBSRUBGXMqXKkI4/X3Y4YX?=
 =?iso-8859-1?Q?PlZvZ1y9y5LxHc0JK2UoiQX3yS6gvothJWdX4QTGk+5lOn1f2KMy4AxmNl?=
 =?iso-8859-1?Q?xC/62AhJ5+5WmekiSQDXpacvzPaWoBCGl/LExdlM5H/ZcbGJ3AlXrzES+j?=
 =?iso-8859-1?Q?+5DLhUklnfi1W+TgdqwjnvfUY/TN+pwtTWrpor8L4U3CkYPvbX99iaTVX1?=
 =?iso-8859-1?Q?AUcCemBgFroZGG1JxQrUtc1PPxRUQcm3U4bB0vZuQ5/qfCakWijw7G8FPk?=
 =?iso-8859-1?Q?NuZVJ8raMQRmsAUcSUoSLZK7LHQ0pAk9elt32NiBnyEebUK/iy2EQ6NkyV?=
 =?iso-8859-1?Q?kg0576wqKID5DycyxrfCaTeEkNupGPHyQXp+vjXBjFj4HkAYeFS1nVpnXq?=
 =?iso-8859-1?Q?7i1YkwASQj0LwSFMvJLpWdNa0/w1GcnNMU8AmlPrqiF4ZMINSlS/ZeJNcA?=
 =?iso-8859-1?Q?ax1CnC815RZBo5ozEhuBxC1k3QAjqq81k5x10HTIQf3IEZw41Py7hSPUCD?=
 =?iso-8859-1?Q?/zkJPHWkEh3D+vtbtFOiVK24LnnQq7xmYd22r4Y+AW++hk1dqRwbIey2e0?=
 =?iso-8859-1?Q?3f+yjKKDQHJHXTeeu+TFqq0PYZYtwEcWr0BoB8dnl9yJJUIir7e3aBcUVk?=
 =?iso-8859-1?Q?AR1eVRgMY2mCyhCoMdFVy2AY9rZJGlJmITyMHfogEJMbT4U0lC5XHTTVgB?=
 =?iso-8859-1?Q?4zPzcEKkv0vh/8lGurssnIyXTsakEMexySYez1aFAgy5sV8vjjv4OzObUb?=
 =?iso-8859-1?Q?OL2y7nDSFEaGwxSRJDq5b6Mwb0bi/h+xl1teww+Yz9pmIbeC+KjKdSfi9i?=
 =?iso-8859-1?Q?AkxMYxsu+Vv2WPfOjLViRo7w+Lu+z8/utnkHbcjUKN5rSnK7Q0GEw8Syde?=
 =?iso-8859-1?Q?+xVOOPw+KW3owQT1hO8eo9lBzk8wBO1HLaAlfAXgdd9Bcs067Z1WydOe0A?=
 =?iso-8859-1?Q?hGBDh8UQgUjnRVdl9161u4eEJIw2rWkYCAMh7dBBTzi9dpVvO2mMh7DUSw?=
 =?iso-8859-1?Q?WlRxR1vlNd6NN08v2SjY6SmqtZxiz2dDyifMPQPYF8eyfZwX994uu7FvFv?=
 =?iso-8859-1?Q?ZQxNF1qPt3UN+8D6ca62TkyJJWjogiNnnn4yswfc6Lrin993IAWW8NDL5Z?=
 =?iso-8859-1?Q?Sid1KZwob4ZJucK6KbKMW46RQWWSXWMkoK07c5V95KeLUgdfajNj69dJpR?=
 =?iso-8859-1?Q?GRlkZbp7T2XCd8WQvDpcYqQvR9LTxtgtbnDkoYgBqvYRj3x0HqfbrvKeGf?=
 =?iso-8859-1?Q?HNQaoY/PQZOCue2vqe7rG6LimRINifwwBo5AMFEKdG8Q0ShoS9mfCi5Dre?=
 =?iso-8859-1?Q?2sD5T2GHZzhtKLrfP1loJSaamzsjjJQpan0rm6Ppd4k4vP3BfNlyXgazzZ?=
 =?iso-8859-1?Q?w7ZJBZwg1mTDAvKLWETuHgl3KnfKx?=
x-microsoft-antispam-prvs: <MWHPR11MB1600D0E659D8E5CB4D1A22AA87740@MWHPR11MB1600.namprd11.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(52116002)(76176011)(5660300002)(97736004)(110136005)(316002)(71200400001)(3846002)(4744005)(54906003)(478600001)(71190400001)(6486002)(6436002)(53936002)(86362001)(2501003)(6116002)(256004)(107886003)(2201001)(6512007)(7736002)(4326008)(102836004)(386003)(8936002)(305945005)(50226002)(11346002)(476003)(26005)(446003)(8676002)(81166006)(81156014)(6506007)(7416002)(486006)(106356001)(105586002)(14454004)(72206003)(99286004)(36756003)(68736007)(66066001)(186003)(2616005)(25786009)(2906002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1600;
 H:MWHPR11MB1549.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FU4Hy5opo3Hwo1rtqruvlMn9v5sH6mmZ6QiWmVpxqMkzYleIgCh63qADOHah+fsDZvXzIR9SsTopFHNzU8G+pc0JYrqq2b9eGQsuWZhMhGTjkkyeDxeWAM0XDtqimnYx8PsIJw+hWJm9hXlQMJGYzplB3i7J0JDudh9nuooEfKnUyWrtlSVyA9NMOkXeq6XZZox+1DS+0p8vPJ/+7qjxwH1sozFIam1EBgZ5RAIswByhII5WDidZg91/dvYqyojv7hw0CPUI1eLIUIUmjZy48hvlR1DsVP0jm2XCcBW5nwxrPu/QrrWPt2pUPYXpAMi6LtuWitYkilySDeTQMysD+XEw+i6yIF29iCrqQBQjYgn1k1iwrY8RdrTLGrGSwejQlCnxWRlEf5tlKe5Oo5FtEvSLqBCUuHNop/RkMuoFOV4=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bb140186-7bb3-4355-b31f-08d69cd00cbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 16:24:25.8717 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1600
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_082436_525049_B76C97BB 
X-CRM114-Status: UNSURE (   9.20  )
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
Cc: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Claudiu.Beznea@microchip.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add compatible for SAM9X60 HLCD controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/mfd/atmel-hlcdc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/atmel-hlcdc.c b/drivers/mfd/atmel-hlcdc.c
index e82543bcfdc8..35a9e16f9902 100644
--- a/drivers/mfd/atmel-hlcdc.c
+++ b/drivers/mfd/atmel-hlcdc.c
@@ -141,6 +141,7 @@ static const struct of_device_id atmel_hlcdc_match[] = {
 	{ .compatible = "atmel,sama5d2-hlcdc" },
 	{ .compatible = "atmel,sama5d3-hlcdc" },
 	{ .compatible = "atmel,sama5d4-hlcdc" },
+	{ .compatible = "microchip,sam9x60-hlcdc" },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, atmel_hlcdc_match);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
