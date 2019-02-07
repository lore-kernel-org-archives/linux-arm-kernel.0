Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D03C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:19:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 308EA2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XPXkGJxf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SMxsBvcw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308EA2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qJBMWlElR/iEQscg9GVfc/0GNgZHm2gZdx/YagxXN6U=; b=XPXkGJxfKVwrSO
	kyVzGrLVoDyr99DpZQzHy/X1qCK62VYkQOoDDjOW74tPBTmLTEtE/B6syJXUa5jLfqhCB4teUuRgm
	5hJzfVYYsbP3tGjVTVdbFy8NmzIc9bQs/xRz2NW6fhdsNJUyvdj9wbbzV17PmbihTyPuTJmR/1/Cm
	cw5yyUYerPDd+GZo8sS3HOkbA0iO+9+aQLsH7U/JpekvgW9zzd1eavSFHbUPo64ZET8f7737gwvg0
	3sYG3RDlJv01XI+n2yDCIKFyCDdA8NdogbtBLRuDMUFlMratZ7iY9V4xmFo2CWhq0UXNy6bakMBr0
	P8+0N6gfBKNMZPjUbWIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grlSj-0007no-6S; Thu, 07 Feb 2019 15:19:37 +0000
Received: from mail-ve1eur01on060e.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::60e]
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grlRw-0006st-20
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 15:18:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8vCXcx/ALS8BQhIjYb21a2pUbhUZsgRorOHda/gm2g=;
 b=SMxsBvcwo+LtQy1aWasuPUBg4zaaU0mvwMw/Wm6pcpOeLeeJYvgqeCmXgTIOqIzRlZ6yMd1zAZ/doPO+8jn204CCNqCVHaEc1CmvF8mXiNUsDW3cowTqMK8WutrIhq0Ud1ViNeas47L2jsMEc5coZvk/INR2rVdc7yAIUNqtZ68=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3846.eurprd04.prod.outlook.com (52.133.29.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Thu, 7 Feb 2019 15:18:42 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1%4]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 15:18:42 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] ARM: dts: imx6qdl-sabresd: remove reg_sensors'
 regulator-always-on
Thread-Topic: [PATCH 4/4] ARM: dts: imx6qdl-sabresd: remove reg_sensors'
 regulator-always-on
Thread-Index: AQHUvvho//YvBabVVE2M3kSRJbTJsw==
Date: Thu, 7 Feb 2019 15:18:42 +0000
Message-ID: <1549552397-22798-4-git-send-email-Anson.Huang@nxp.com>
References: <1549552397-22798-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1549552397-22798-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0193.apcprd02.prod.outlook.com
 (2603:1096:201:21::29) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR0402MB3846;
 6:x63PrktDUhhCNwlQSt3qj63MNScNKoZBVvt3Kb2hM5Q7FgJjLc1DJcotN4fPayxAuFKkpmpBItUdr4X8+9hU7UNwmDaAzn4MQJ3jr+zSk7hRjKD+tOzsIpmnlTRy6B6MAoWr1/e8Bo3a059+Zrh1dB3jsQxE3PFIS8VB6orthYF/O8s8HiA5nwMO4/DbNbLLcJbYkCp6ltEXXLSQ666/3DD7+nSdLHlMdaRrpDhPcz7WbwL8DmF6u+ch314bpYhZ6FU5ZIEx5VMV9Xgi1ZBINHq9Qi4XoqrYJc1BGBq0vf1mQHuEUnKfX1V49V4cWeuWJzLe/Ln6GUvIQpzTWeCxl38P7DEL7dtgogKyPtHcsoYbDLgBPSivDmHRIcdnIAIbbmeUI4TMrVsZnX1+/jkx+hkttr5YbF1P4qRDRD8n6lxiV+UBN38vOKeTtWzwCpWHBB6iwAC3yRkYQeWp0pWOuA==;
 5:975E3sYHHV7rSAzKCjP0PuC+A05S6vNd8XBTWrZIDmFHXlOvIwZ23P4YKIRZbHfOLvNB0U1IAyBxlyWdk5hfeci7pKW8xTz1A8+f3gsr2OLUptdm3nlZxgNwdu/FrI/olTytQT0hVOB34eCQvkBJOl8tfLKdbDIL/IfusNi7YY1/IeYu1CSRiBE/biH1rqnHCXFIUnCnCLd+BSUJqp7Z0w==;
 7:BjqBBwpFbpbmUwSw3Nh7M3hYWsQLpQ5xDUUHowL2r4bGl6hv88SftEK8urohT8vMfiEwpOSOqCFBLcyIPkpF8egAipG/TgmvGMYYDJVCLmb9FJClWYiW2yWWqljkHUBFlyTlScscRRTf0vHuUxgjsQ==
x-ms-office365-filtering-correlation-id: 9d0cd316-0cae-40fc-610c-08d68d0f8b26
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR0402MB3846; 
x-ms-traffictypediagnostic: AM6PR0402MB3846:
x-microsoft-antispam-prvs: <AM6PR0402MB384621AE01424A18A51B06EBF5680@AM6PR0402MB3846.eurprd04.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(366004)(376002)(396003)(346002)(136003)(189003)(199004)(2616005)(476003)(6486002)(86362001)(11346002)(446003)(2501003)(110136005)(2201001)(76176011)(52116002)(486006)(81156014)(26005)(81166006)(186003)(8676002)(6512007)(256004)(4744005)(7736002)(14444005)(305945005)(68736007)(316002)(386003)(8936002)(102836004)(478600001)(71190400001)(6436002)(6116002)(71200400001)(6506007)(50226002)(3846002)(4326008)(36756003)(105586002)(25786009)(14454004)(2906002)(106356001)(66066001)(53936002)(99286004)(97736004)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR0402MB3846;
 H:AM6PR0402MB3911.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Zu+vFKAP44LKHFNzWtKIN0+zZboHvV6nL7TJDUVnXAQ0k+mIJb59H6CYRjVBC5acklg064KldZCiCfYAr+QICN2p2UO6XcZB2RnGYxgG0gv1Vit9A/9Y18fMIOM1Xsz/+mF052W/qPZjF5kk1J0LpCYU8wiX28rdsWmf03WN+vhM5ga38ULF1JG3Xc9P2GsjCCUWyk0raZWSVT7kfZjqiu7VaQyD1sWWaYHmWKI4h726rN//wZIdVGhz6m6Khomc43OTUbvqTJV/LxFFrXg3RiMan2cSk2vr0sIMtPJ4XwWn3VN/rNW/arufF7ip9OoMm7hxSJnklJhy1hcJbA5aOGO98SbuV0d+xh6SbG9FV1tydtCuug/+zPyIHhU5hk/u+NgGxEhTtJFZwdqnbqKYZC0igIfDVMVo1VLM2DspPJU=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0cd316-0cae-40fc-610c-08d68d0f8b26
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 15:18:38.6335 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3846
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_071848_655465_A8BE9AFA 
X-CRM114-Status: GOOD (  10.26  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Now that all sensors supplied by reg_sensors have supported
regulator control, reg_sensors does NOT need to be always ON,
remove "regulator-always-on" to save power.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 80b9901..a070506 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -64,7 +64,6 @@
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio2 31 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
-		regulator-always-on;
 	};
 
 	gpio-keys {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
