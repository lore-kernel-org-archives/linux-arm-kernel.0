Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0F3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:26:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB81520C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uyrBEf7o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="W51+FEil"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB81520C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kEHZL/ivrwN9R47OOYLsL0HB1b8Tp/jwvTrqjZHtNTk=; b=uyrBEf7oY+XEZh
	WNJeGCs1j8WyeMrPbzWQc4Lsg0d6HQBbgg14A1FH//t55/qAkaHhaPL214j1GcA8eZi9wZ5Y+ZyB+
	Gyhmwa4DSJnFxaXu3JEMRcCo9JbMk2mkTcfmK7AFCiVagv78ZW6JDFo2SyPosh7v5KjqlEq+ukYKo
	bXO85malZSSFubCRjR/v9W22xITkU9VEospLApZMmJHttqBUCk384Rhss2QjO903gk7Kvxzl1yalq
	FT/1T3Aq+4cnrXidGOyymCt4OIJ874nzuZ/X/QkeLFSS7F2UAJnJ3Gf+Ko/5m/T9NId1f36DDpbNa
	jYi469Pm3srW5ZYnjWMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz224-0002BM-39; Wed, 27 Feb 2019 16:26:08 +0000
Received: from esa5.microchip.iphmx.com ([216.71.150.166])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz20h-0007xE-GY
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 16:24:57 +0000
X-IronPort-AV: E=Sophos;i="5.58,420,1544511600"; d="scan'208";a="25323669"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 27 Feb 2019 09:24:43 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Wed, 27 Feb 2019 09:24:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2LlApE9KLEwvJ1Xgh4TXz5Ls7//fcDvuKAIwlZx2AU=;
 b=W51+FEil8MeZFAnmu3A49xgTeULdwIRsFHPKknqgzzvjEIdE/Hopt9qVXmyy+U4PQjIu04Q4LcrkrwOJMBznNd6eSlprKVCiIjdY+692yp38mcAJEsmwb8A4cvNAXNXSymzIABkZAYjioXauP972Qd6LYI5VBz2ZVmuNNIiTi1I=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1806.namprd11.prod.outlook.com (10.175.53.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Wed, 27 Feb 2019 16:24:40 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6%8]) with mapi id 15.20.1643.022; Wed, 27 Feb 2019
 16:24:40 +0000
From: <Claudiu.Beznea@microchip.com>
To: <lee.jones@linaro.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
 <airlied@linux.ie>, <daniel@ffwll.ch>, <thierry.reding@gmail.com>
Subject: [PATCH 6/7] drm: atmel-hlcdc: enable sys_clk during initalization.
Thread-Topic: [PATCH 6/7] drm: atmel-hlcdc: enable sys_clk during
 initalization.
Thread-Index: AQHUzrjwAYRRhdyfPkqrFMqRJO5EaA==
Date: Wed, 27 Feb 2019 16:24:40 +0000
Message-ID: <1551284609-14594-7-git-send-email-claudiu.beznea@microchip.com>
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
x-ms-office365-filtering-correlation-id: 5153c137-2c2e-4142-5950-08d69cd012ce
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1806; 
x-ms-traffictypediagnostic: MWHPR11MB1806:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; MWHPR11MB1806;
 23:wU4N65EdWtaeha6HAdZE4GkSWr67vyjIHRXluDQ?=
 =?iso-8859-1?Q?vBElUgZuwdd+nI48b3VtRR65PKp7YqNADPhVBEuKuQm+qW0R/ZZGwWEEiY?=
 =?iso-8859-1?Q?zkmM7pFJEa9hhjvqlQWze0kfCqTYkqFrCxYGeHZrFrvcoIEc14ZRTTYD/n?=
 =?iso-8859-1?Q?siZg53mi885VvGgnt5AVu4m5/EnLpQmzCoAYMChiHrhhNincZrfL5BEtRI?=
 =?iso-8859-1?Q?LNS1MjoUOzA0uFImznzKoIUP4bGRsfM/M+WAXrPDNizPj82FXCTPdGCdJ8?=
 =?iso-8859-1?Q?jwo9fI3sQJNwGqnddHC1KU5ogfYMPzRupEY+/0BE3dETqk6LhUfy1kSzey?=
 =?iso-8859-1?Q?+1XPenS61r9OGYmGs2bbQeiXPJ7HeOtHgco2/hOQ99zkSAMoaZG/pzWE7k?=
 =?iso-8859-1?Q?it9WOyUIQsuoCetbfWAFZvJ3xGjdUG0Pas0XtMFMUsZzDLiT+sizjY2E64?=
 =?iso-8859-1?Q?rv9Im8lf1dROU0U+lGVynf1UkBu0mFFaQYGq1gKsrf878PxFvVvHACx9J3?=
 =?iso-8859-1?Q?LQMjNwN+F4du8V01KUdf9f+seGIoyhF9e3h4HIDDFzxvHRM7Mr1GAusS3j?=
 =?iso-8859-1?Q?g8gH+5ODxQZoUSqpu9hyEpx1JnusiiOvs3XQQOZKAfgAhXFMFz31+/Bk6I?=
 =?iso-8859-1?Q?Q5t7rZtYF3zOi5O37I7IZhZ+kj8QX+Y43UM/tLTE1wBQBxDorXwV3EZP55?=
 =?iso-8859-1?Q?+TGL4pCk10FAXROR3YW9qsUva1nZlA7qcm6KZ7VN8ceUzM6xwGa7DGsiq3?=
 =?iso-8859-1?Q?KxBpn4jZrXxCpXSmwTZBPKGRBYdmAswu6RgO0bCVZuBDs/Simmv1gHuoub?=
 =?iso-8859-1?Q?yu8Nnbwxaf5E6uOtgtxJV2fFObquInQqKdH4oLRkxw2SctuhRdkAq3QGQk?=
 =?iso-8859-1?Q?dcN73xOoZEtO61b68cejrxFMjhF1H7sdyVwln8cmyCXB1JFDIHEheW4kZn?=
 =?iso-8859-1?Q?BuCIvM+XOWuWrOvdE97C57v+jjJIu2+Ebg8b/KWjzBg8gR5syWUM16gdpt?=
 =?iso-8859-1?Q?WTB5oCHaK2+aHu0ZA0mVVhkfrRx0ICYUQZBhKgV3wCk3PVGBuJ7kOQ//wF?=
 =?iso-8859-1?Q?bUvrmc51e7cPtVi8ss7ItY35X2qGNJiOC/8ny+74Oj8JuGvD8n2JqNKc5V?=
 =?iso-8859-1?Q?ypBmjhde/O0xDiVohSMZplXL1Z9ik6biuwGZ8pqjsmZMd4KfHFRj9qh4Or?=
 =?iso-8859-1?Q?MBUVwCDexsdnNARmtyyfyL6vTR2V/CvjhNC8m+B5YyLqBvhEzl4CXvpjXE?=
 =?iso-8859-1?Q?hY3ei7N6LhYw8gDt1iqPDaY0R7MkPWsSLzGup7AhsZdTDDadV+naIJAiHD?=
 =?iso-8859-1?Q?bQgOOJnGgV8yFqIuvzE5/gecEYyPafpJ7cAx0b4K4l/f7lvV5pfIY4Ez8Z?=
 =?iso-8859-1?Q?cgCxcuSQSM4c3pSY78U0v1oKkoFcQ?=
x-microsoft-antispam-prvs: <MWHPR11MB180659EE8DBFA2F9884144D187740@MWHPR11MB1806.namprd11.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(39860400002)(396003)(366004)(136003)(376002)(189003)(199004)(11346002)(105586002)(25786009)(6436002)(8936002)(36756003)(4326008)(66066001)(6486002)(486006)(476003)(76176011)(50226002)(52116002)(186003)(107886003)(72206003)(99286004)(478600001)(2616005)(7416002)(68736007)(110136005)(14454004)(2201001)(71190400001)(6116002)(6506007)(86362001)(446003)(71200400001)(386003)(97736004)(8676002)(3846002)(53936002)(81156014)(54906003)(14444005)(81166006)(256004)(2501003)(316002)(305945005)(6512007)(7736002)(26005)(102836004)(2906002)(106356001)(5660300002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1806;
 H:MWHPR11MB1549.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xEo9pd9SV4OiaKgDnXpvzSdbDr7jWKC34+OGPJBB2w2mjVNt6c1QoAWoqUGlTJ8nBE9Z3FtKSZqQ9Cg37IDQy1EEXJsvMIJb585Tk1LY5+1WpsrYWUZKjJdcfWf3UXLquB2wxrR1702lXXjpb8ga18ZNMX4mIMAcIljQAikUdyrFxee+tvWlqW5LE7IshvZ2wWT+Eu9HqDs306b8F7jL0WhSV11qsUzNbink73rUXvm0GSczk6mAeeCztJVe8aItj3rnqd0EeKlQL2Xn78tG+1S/hc7/4aw0BsWgBL2OgROi5g+wOpS7Nc4dWFc9C/Set9C7FIyhI7hg75l3ExQVGkTmilUC9xrHS6iO8J6GdfkfphXJzDIjNi0HPC6C1bn8Gvdxbv6p2YrZMjbtnwQ/Zg7Cc2pSIW2z+pml2x+UrfE=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5153c137-2c2e-4142-5950-08d69cd012ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 16:24:35.4217 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1806
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_082444_676617_4C9FE09E 
X-CRM114-Status: GOOD (  11.93  )
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
 Sandeep.Sheriker@microchip.com, Claudiu.Beznea@microchip.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>

For SAM9X60 SoC, sys_clk is through lcd_gclk clock source and this
needs to be enabled before enabling lcd_clk.

Signed-off-by: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>
[claudiu.beznea@microchip.com: add fixed_clksrc checks]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index 0be13eceedba..8bf51f853721 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -625,10 +625,18 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
 	dc->hlcdc = dev_get_drvdata(dev->dev->parent);
 	dev->dev_private = dc;
 
+	if (dc->desc->fixed_clksrc) {
+		ret = clk_prepare_enable(dc->hlcdc->sys_clk);
+		if (ret) {
+			dev_err(dev->dev, "failed to enable sys_clk\n");
+			goto err_destroy_wq;
+		}
+	}
+
 	ret = clk_prepare_enable(dc->hlcdc->periph_clk);
 	if (ret) {
 		dev_err(dev->dev, "failed to enable periph_clk\n");
-		goto err_destroy_wq;
+		goto err_sys_clk_disable;
 	}
 
 	pm_runtime_enable(dev->dev);
@@ -664,6 +672,9 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
 err_periph_clk_disable:
 	pm_runtime_disable(dev->dev);
 	clk_disable_unprepare(dc->hlcdc->periph_clk);
+err_sys_clk_disable:
+	if (dc->desc->fixed_clksrc)
+		clk_disable_unprepare(dc->hlcdc->sys_clk);
 
 err_destroy_wq:
 	destroy_workqueue(dc->wq);
@@ -688,6 +699,8 @@ static void atmel_hlcdc_dc_unload(struct drm_device *dev)
 
 	pm_runtime_disable(dev->dev);
 	clk_disable_unprepare(dc->hlcdc->periph_clk);
+	if (dc->desc->fixed_clksrc)
+		clk_disable_unprepare(dc->hlcdc->sys_clk);
 	destroy_workqueue(dc->wq);
 }
 
@@ -805,6 +818,8 @@ static int atmel_hlcdc_dc_drm_suspend(struct device *dev)
 	regmap_read(regmap, ATMEL_HLCDC_IMR, &dc->suspend.imr);
 	regmap_write(regmap, ATMEL_HLCDC_IDR, dc->suspend.imr);
 	clk_disable_unprepare(dc->hlcdc->periph_clk);
+	if (dc->desc->fixed_clksrc)
+		clk_disable_unprepare(dc->hlcdc->sys_clk);
 
 	return 0;
 }
@@ -814,6 +829,8 @@ static int atmel_hlcdc_dc_drm_resume(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct atmel_hlcdc_dc *dc = drm_dev->dev_private;
 
+	if (dc->desc->fixed_clksrc)
+		clk_prepare_enable(dc->hlcdc->sys_clk);
 	clk_prepare_enable(dc->hlcdc->periph_clk);
 	regmap_write(dc->hlcdc->regmap, ATMEL_HLCDC_IER, dc->suspend.imr);
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
