Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516D7C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:01:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E224222BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H1sUe21N";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="wL6MnWYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E224222BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BRLe+RK8yxTAT+sMDWqT0egubM92bZMnJRf8u2G21s0=; b=H1sUe21NfiQVVj
	NOHjKzc/CFo/YKjXpcQpW44GicKGoH7CcrT2M9M/dt5HF7+9GVB9uTy8WcZEeELrxr8ybgtqsF6zE
	cCklkMerOQ90I3YxhxsS4YFnmiiXFgveCkO6jKvLQfhfilzbCh5D6E4NOci4esLNwt3FvhxIfo91c
	mVAO+bd9/umDmOETnzGAjYqVUaqMxN3Jrr8U3ngb1taFIukf4KxTi/o2THJIYBhTdipNaMpPVYkyP
	3D5kL2Ubs9nrkqYSWDCs9v0uB//+sfJEQQKUDHJC86Zp8JYk8n0INuhBqXmRTRbtCyOWB7PR27xX7
	U3xfOlsa/Sxup/wZSrhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtqQ6-0000EK-79; Wed, 13 Feb 2019 09:01:30 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtqOe-0005Ud-SI; Wed, 13 Feb 2019 09:00:07 +0000
X-IronPort-AV: E=Sophos;i="5.58,365,1544511600"; d="scan'208";a="26652873"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/AES128-SHA;
 13 Feb 2019 01:59:58 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 13 Feb 2019 01:59:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IZWL4twTy2xYkCdFqjyhzDlNJ6FSCI+6LfgKdArK4w=;
 b=wL6MnWYRPqK9ezSCpFGgoZrz0rJ3SnSjQCMpio7UQDIQ9T2ChKaywMDT1Bjv7htitfrEdtXyrKpkjitu40lwGjYoTS1bWpDxh7F3j2dyg0U7Eg6N44f0x6eC71tpnDBoicRLsR+kfYLsg8pspqsO+VFBjP5t8/bzE21s1lWWgVQ=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB0019.namprd11.prod.outlook.com (10.161.155.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 08:59:55 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 08:59:55 +0000
From: <Tudor.Ambarus@microchip.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <dwmw2@infradead.org>,
 <computersforpeace@gmail.com>, <bbrezillon@kernel.org>,
 <marek.vasut@gmail.com>, <richard@nod.at>, <miquel.raynal@bootlin.com>,
 <lee.jones@linaro.org>
Subject: [PATCH 04/11] memory: atmel-ebi: add sam9x60 EBI support
Thread-Topic: [PATCH 04/11] memory: atmel-ebi: add sam9x60 EBI support
Thread-Index: AQHUw3p9sN/CdCNCukG8e/clx2Pbpg==
Date: Wed, 13 Feb 2019 08:59:55 +0000
Message-ID: <20190213085930.31578-5-tudor.ambarus@microchip.com>
References: <20190213085930.31578-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190213085930.31578-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0085.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::11) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82e1e00d-b7a4-4fba-d9c6-08d691919f74
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB0019; 
x-ms-traffictypediagnostic: BN6PR11MB0019:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; BN6PR11MB0019;
 23:Rp5bUThHXzXSIrVmUVgFt9w9riOtQlTPe+1cABj?=
 =?iso-8859-1?Q?LadCoEs+h/BUvwWhMCPiiTthqL7Ydp4fh7pu/ARcnWhYHBqvSIo8OX9Z+/?=
 =?iso-8859-1?Q?UkD17JqwHS10HTcsoqMkz1/7ANu7YMlBKrbVsSLEBdF5AK6IAky7eYRm1x?=
 =?iso-8859-1?Q?EOzfojs1NC+0Oa1nr7eZanHSE2h+3BoRQjqKY99XAf4HZdBeAzJQRg/2NK?=
 =?iso-8859-1?Q?LQB6dmsLqo+d91Ond98pjvJTDC+vKOPiFV12e8Jv3TVRbWGgkzrEhaeEVg?=
 =?iso-8859-1?Q?N0gGkjeQTfgRkrpC/1AFl9YNr1YUb22kDAOEkjSYDBD818KShO2zRGtz0r?=
 =?iso-8859-1?Q?dKj3TVgHgbhPUg62fqw1Hn6e1wZqpxOOHs05seqMUqLBhpUG5fPDyYjEIq?=
 =?iso-8859-1?Q?FHcFUmBg74XOiPInQZcOLv2cIGqZUZiX2BT1+hk5NviX2jcZsofTzVsksI?=
 =?iso-8859-1?Q?VlM0GiRPkPsFhhsKdfFmpprqrrk4j0e3UL3zBPCSl8XToylF8Ze0I4rPF2?=
 =?iso-8859-1?Q?dRnWod3HprgKy8X+d+ZFY3KBauenod6k9TaN0Ua901zdcAmhHA/SoJnXDr?=
 =?iso-8859-1?Q?WMskDy/jb0Pjm7Egn3TD6HKVs6ZxeYEVk27zckd91watJI5fvdAIxpksH3?=
 =?iso-8859-1?Q?1KCd7LMBQ0ApRZxnNibD7q2nO39xiSHCPrDqgzdY15a1cUmvyckUPeNL62?=
 =?iso-8859-1?Q?WLJILBxFJdnW0TIFSMFRA3THL50jG1aeNexVOpPZbTTl6KOPpKcluF2wf+?=
 =?iso-8859-1?Q?GbN1mf/PjZGMOUtjwxIoC9jfuh0FpNcb/TGIug4CLe5ZtDM1WvcPHbAbZO?=
 =?iso-8859-1?Q?+IdmlYLSa9EqGLmYgVuFowVELVvWOEWSdEs8Mi7FuMXQvt3jtV7GHwSS44?=
 =?iso-8859-1?Q?nrTFB2pzq9MuUoKDb/xj1Q33QUt3/m4fkHhwgiQbN8oZUvLIZoZ3RKBfWg?=
 =?iso-8859-1?Q?vfZKTDjksZWHHAN5+okFLhK7ORjjCpG3OLKxeoPwrvAr9AWcP5R4cQlVTc?=
 =?iso-8859-1?Q?q04o/WHuGieS6jeCYfB03hs3g/A9VTQTSYgvsk2C2T3M1Cbh6moXOVnCz3?=
 =?iso-8859-1?Q?d4kppzv0XLxFroEzP1PRZz15lDflzbwZDEvPvL+M2mKhIkKTyAGBZhABzH?=
 =?iso-8859-1?Q?tDC3wYG3bOuDA7xrpAcEr2fWz/4Q7uaCPOqiQRDs+1UEzS0uxUiYgUgYo+?=
 =?iso-8859-1?Q?zk/rACzhwRUgYHsL34pzVt3kfnGOuzIOSkCt5ZE0zH8raLlUxflL85yuCE?=
 =?iso-8859-1?Q?JDbVvg2bkGMm3YbVDOhJ3JLWhShOh0AmzMcZ4O63+dBuqXy1EF0HV+0yU7?=
 =?iso-8859-1?Q?YzQfaPhJyuDUyvtssVRZ2ESPfXA7E1nlNFucCuUmIKxnp8tsGMLm1UPl3W?=
 =?iso-8859-1?Q?a6g8k4X4=3D?=
x-microsoft-antispam-prvs: <BN6PR11MB00194E87B3261799CECADE96F0660@BN6PR11MB0019.namprd11.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(81166006)(50226002)(106356001)(7416002)(6436002)(54906003)(2201001)(1076003)(81156014)(26005)(110136005)(476003)(102836004)(107886003)(8936002)(6512007)(6486002)(4326008)(446003)(2616005)(316002)(8676002)(105586002)(99286004)(66066001)(486006)(6116002)(3846002)(186003)(11346002)(86362001)(2906002)(72206003)(71190400001)(14454004)(76176011)(53936002)(71200400001)(478600001)(68736007)(6506007)(386003)(2501003)(52116002)(97736004)(7736002)(305945005)(256004)(25786009)(36756003)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB0019;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9Trk2sF0bZ66Sgm/DE4ITvUcPYoxWZ16Jt+zqOXMs2icmUQW73yThGnQgnLUS5la3u2bacTCX9/XgUSu1KbJobYC5pHXjsAgysl7w971WcnU3TuXJvePzwpZZ3NMRpFmyvlEHyuRSF8kqLADMDzU7xNwiXoSV+DjJJLOOUKSLj7+LI6ydhAvp2cAH7dsjM2fhJfzRgvlDsxe8AQzXvcm8R/2b5gpfuLnJ67//xF+O4CE2RtiOfhC1FWOgtIKapxkIwGWw+64SmO016NlLH1dm7/cQDlCIxXgHi/bKajo6cxkBU4UuRQElOLmldQpxm78mRpzyBgkQ1y+MgVzc87zuwGH407K0aEk1F6Hdh2viwX7Co7cAYE5LTwTON9SrLuroyiHBHxbu0Tc4IQwhsvTAor43ewUUhtM3oQ/QogqCKs=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e1e00d-b7a4-4fba-d9c6-08d691919f74
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 08:59:52.6074 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0019
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_010001_233181_8478C931 
X-CRM114-Status: UNSURE (   9.78  )
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
Cc: devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Tudor.Ambarus@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The sam9x60 board defines the CCFG_EBICSA register under SFR,
and not as a MATRIX register, as previous boards do.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/memory/atmel-ebi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index b45914cfa212..0322df9dc249 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/of_device.h>
 #include <linux/regmap.h>
+#include <soc/at91/atmel-sfr.h>
 
 struct atmel_ebi_dev_config {
 	int cs;
@@ -440,6 +441,15 @@ static const struct atmel_ebi_caps sama5d3_ebi_caps = {
 	.apply_config = sama5_ebi_apply_config,
 };
 
+static const struct atmel_ebi_caps sam9x60_ebi_caps = {
+	.available_cs = 0x3f,
+	.ebi_csa_offs = AT91_SFR_CCFG_EBICSA,
+	.regmap_name = "microchip,sfr",
+	.get_config = at91sam9_ebi_get_config,
+	.xlate_config = atmel_ebi_xslate_smc_config,
+	.apply_config = at91sam9_ebi_apply_config,
+};
+
 static const struct of_device_id atmel_ebi_id_table[] = {
 	{
 		.compatible = "atmel,at91sam9260-ebi",
@@ -473,6 +483,10 @@ static const struct of_device_id atmel_ebi_id_table[] = {
 		.compatible = "atmel,sama5d3-ebi",
 		.data = &sama5d3_ebi_caps,
 	},
+	{
+		.compatible = "microchip,sam9x60-ebi",
+		.data = &sam9x60_ebi_caps,
+	},
 	{ /* sentinel */ }
 };
 
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
