Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1A5C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:36:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 544FE20839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l4dAHpDD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Gz7YefQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544FE20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=YZ2Gu7AgRpttUVlsCGeBkV6zjq4S8wjvhXn/ufztLSE=; b=l4dAHpDDawvqWp
	CXahHFRnXEmGahhMkZkl2jDWf4pt/sSGlQzV1CFbxstLciU9Yy+5WHANut0JBPB1Sto7LN2k75U3x
	5i5EJtOayo9iczVP5JnDVhJ+2B1FvP7vYmb4qZy0WTo9AkaIV1Y5PTxMM5N1JjVrLaZ2wzXSAcMhQ
	/utq5tQCqiCdmyxUF1as3BgyLt95PWNDyTgMpPrQ98WNI5BFHngcFbf+0m3uSQVfYk2mruJGf1ePN
	Qqd8SQW0NKsJwVCITBBwHRmtN+5XlK29lJVu36+4vuiqe5ALWMtRk4nYYvtDc0O1/ztJpK2eqMfBp
	+ygrnhtkeTBJSMdxpr2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX9Mm-0002gk-Gs; Wed, 12 Dec 2018 18:36:16 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX9Mj-0002fd-Di
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 18:36:14 +0000
X-IronPort-AV: E=Sophos;i="5.56,345,1539673200"; d="scan'208";a="24135875"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 12 Dec 2018 11:36:02 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 12 Dec 2018 11:36:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNZLeQCCgEO22plAQ5Vi0TAAgHpdxlcxc+MfbwIBqVw=;
 b=Gz7YefQZoU9cNBlnX60pBVfHzaR1eSSH4O2t9IEWspD5iqok/bkgFw2eZjZzi1BDTvmGzTLS9lWXSyJqGCel1WW1nAFML3LzEEgNsZiX65uwOP32AzICNbFFsJ5OSxoN/O9lQZxC96smP0DJT9ZH3RvPoYXAF28NAzcU4MQEvA4=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2211.namprd11.prod.outlook.com (10.174.113.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Wed, 12 Dec 2018 18:35:59 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838%3]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 18:35:59 +0000
From: <Andrei.Stefanescu@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
 <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>
Subject: [PATCH] regulator: mcp16502: add support for suspend
Thread-Topic: [PATCH] regulator: mcp16502: add support for suspend
Thread-Index: AQHUkkmG6Jm26DdxjUue/RBWj6X37g==
Date: Wed, 12 Dec 2018 18:35:59 +0000
Message-ID: <1544639735-17654-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::25) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [213.233.110.155]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR1101MB2211;
 6:fjpN5HKHnvWGWHUFjohDoGxWPpaAf68Z/3p1PSDxyV9L9a4LqNIlQRk8I8fcWfIdlmh+tahMhAVojJLfHar8A7vqXnshQQJd6hr98iWuq8nH/k4pT9DNmLkrDhYG+uX3BRuQjerbTd2H4pzH2ZY93Ux3j22p4N010rasnFXTsq/V4RJYKq0LE72NuU2w288TE4f/5W120ZDYqX+l2JYDm+56jo/y/QSEmmsYCI4HnA0AlYpklVjVj5DsRFSg9s1hOR5eIc68dfaMvGEa4NvMj1DQu5kNPXONmCsclkpRvFBhD8hcbgiVheBOvo4D6mMUtO4sls7+f5BIRstgz4DTSuqgn6ZxwqnX9wBknJJfB2OauCpk1nMcTq1Ex+6B60PZqBa9Imr+WzSQ3JEGg20gq7tqnNbIccikp98Ow28Vrjq0vz72fGAeMO7qrZzUI54Po8EiIWMN8YigSbsxbGficA==;
 5:sV30nbIvOMBXuqI3fCw8qW8YbvmkiSQGspCmhbiANblJQ50YERmu6awiosuPwAJM7e29ggENJMz20JxwOrU32Pfs/Twk5LmAHkdnxzFusVl1MMm/f7bdF2rxlATFzFg8aC2k0ydIeaHaIaoEhLYzjSTffRAbpyWomQA3Fqan3LU=;
 7:fGBIipwjZilW+ATLZnb1+3DeJSOnCfdzSocB+NnD/JNsUFVRzgMRbQrXihxGJunVsTmdSHBY2+Na9sGIxzrchrvGxOzRDUHqII6SAW3kuA3ox8UTggTUHVT//InfcOcI8SHcUsdLqZ7S25UcApRkrg==
x-ms-office365-filtering-correlation-id: 66c0af9d-b104-4bc6-bad0-08d66060a8e5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR1101MB2211; 
x-ms-traffictypediagnostic: BN6PR1101MB2211:
x-microsoft-antispam-prvs: <BN6PR1101MB221185A526F8C6BC06ED1CAFEDA70@BN6PR1101MB2211.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201703061421075)(201703161042150)(6042181)(201708071742011)(7699051)(76991095);
 SRVR:BN6PR1101MB2211; BCL:0; PCL:0; RULEID:; SRVR:BN6PR1101MB2211; 
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(199004)(189003)(14444005)(106356001)(256004)(54906003)(476003)(2616005)(7736002)(102836004)(486006)(68736007)(8936002)(26005)(25786009)(2501003)(39060400002)(4326008)(6116002)(3846002)(97736004)(110136005)(107886003)(81156014)(186003)(53936002)(86362001)(15650500001)(72206003)(81166006)(105586002)(6506007)(8676002)(6486002)(2201001)(6512007)(498600001)(5660300001)(386003)(99286004)(2906002)(14454004)(305945005)(6436002)(36756003)(52116002)(71190400001)(71200400001)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1101MB2211;
 H:BN6PR1101MB2243.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uH60lIDuSzCbt7fi4gYFqc7rZjcAwJkVkuOTGel7eYSAqf257LeZandk6Jf6fBiYYPHOIVrwicTJpI8KxZixMY/Wwvoth0R7KZBIMgPLWVavQGi2iUQKTtjFQtmijpYcwZs3uzfTbr3D1ihG5TOuWd7C8psFoC/TDlTnC0THwITcKXOM78gUbI+K19FDdbD1g2seabxe2mwUBNPNQkj84qhUpO7Pj9K3m4hLezsz60KBf9/mEwl3dFD/zeesBHVN19x2bCYtLOt6gSM9RUAtXygPXdA+Fk4AmRmi9VR/SCqMp5VkWAq5IA9jX9/g+mPX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c0af9d-b104-4bc6-bad0-08d66060a8e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 18:35:59.2821 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2211
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_103613_500916_BF67E5F1 
X-CRM114-Status: GOOD (  13.77  )
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
Cc: devicetree@vger.kernel.org, Andrei.Stefanescu@microchip.com,
 linux-kernel@vger.kernel.org, andr3i.stefanescu@gmail.com,
 Cristian.Birsan@microchip.com, Claudiu.Beznea@microchip.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds support for entering/resuming suspend states.
It does this by setting the LPM pin of the PMIC.

When suspending the PMIC will enter the Low-power mode
when the LPM pin will be set to high. If the suspend target state
is suspend-to-mem, the PMIC will transition to Hibernate mode,
otherwise, if it is standby, it will remain in Low-power mode.

This patch depends on
0b60c4deca1d regulator: mcp16502: add regulator driver for MCP16502


Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
---
 drivers/regulator/mcp16502.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 7cbc96f..bde3172 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -497,6 +497,36 @@ static int mcp16502_probe(struct i2c_client *client,
 	return 0;
 }
 
+#ifdef CONFIG_SUSPEND
+static int mcp16502_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mcp16502 *mcp = i2c_get_clientdata(client);
+
+	mcp16502_gpio_set_mode(mcp, MCP16502_OPMODE_LPM);
+
+	return 0;
+}
+
+static int mcp16502_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mcp16502 *mcp = i2c_get_clientdata(client);
+
+	mcp16502_gpio_set_mode(mcp, MCP16502_OPMODE_ACTIVE);
+
+	return 0;
+}
+#else /* !CONFIG_SUSPEND */
+#define mcp16502_suspend NULL
+#define mcp16502_resume NULL
+#endif /* !CONFIG_SUSPEND */
+
+#ifdef CONFIG_PM
+static const struct dev_pm_ops mcp16502_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(mcp16502_suspend, mcp16502_resume)
+};
+#endif
 static const struct i2c_device_id mcp16502_i2c_id[] = {
 	{ "mcp16502", 0 },
 	{ }
@@ -508,6 +538,9 @@ static struct i2c_driver mcp16502_drv = {
 	.driver		= {
 		.name	= "mcp16502-regulator",
 		.of_match_table	= of_match_ptr(mcp16502_ids),
+#ifdef CONFIG_PM
+		.pm = &mcp16502_pm_ops,
+#endif
 	},
 	.id_table	= mcp16502_i2c_id,
 };
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
