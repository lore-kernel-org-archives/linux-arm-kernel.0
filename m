Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806DAC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:19:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45CD42175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sc8uNmvN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RmOpGyXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45CD42175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VI9Ti70f9QhKWtMHIvw+4xcl/drMS2+L1RlNY9jUtvA=; b=Sc8uNmvN+jO6Ua
	iz5+FXa38JeAuyYgfGlx6UKF9nULY230mtd59toAqaeS3d3y4VmaPj+VBqeU23lCA5uzdOak+X6bE
	3kNO/UAhTYqeXBtGta4gYqOBX/sEmngjEVKz3I7miA1TMZEWtSoGYqfBlIXRBtGIZnPUxXXRzg08y
	pW1IPpvdFEbQbkNzIk6V2EGw0Wd7bL1grMtbtXG9ilkKuTTLligP0rzUrS7VfQlXJ31c8pMNMV9Mq
	MXbLN41GFInXOkwuIeYSTQcGFB/Zvci0cg5sHSe4XLggOQ0TQUth1zcb6ixGVHTPKsrpiYlasvj/P
	judu2eW+YcCZOhKMFXXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grlSR-0007Ss-FU; Thu, 07 Feb 2019 15:19:19 +0000
Received: from mail-ve1eur01on060e.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::60e]
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grlRq-0006st-Nc
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 15:18:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSFn8cdpt1eoAnepnuJm0hYlJEQgbR1zqZIjUDVZJnc=;
 b=RmOpGyXznFe5ZijpIqbB4li9xzIQEAxDpsypxCqrAGnozjysTpQcW63hHggpKjTpyMX/k3wWgmmEOSzD4vmdFauuZf6i1PtUSJYaUmEcC/MArtwouKxxYzASCSMR2a4ueuJ71Nl6dPwEIlFdeFAUR+1YGl4iXzRxqVJ+kuKWbKk=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3846.eurprd04.prod.outlook.com (52.133.29.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Thu, 7 Feb 2019 15:18:38 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1%4]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 15:18:38 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] ARM: dts: imx6qdl-sabresd: add regulators control for
 mma8451 sensor
Thread-Topic: [PATCH 3/4] ARM: dts: imx6qdl-sabresd: add regulators control
 for mma8451 sensor
Thread-Index: AQHUvvhmt2fh6/DLD0uLoYNB/nAPdQ==
Date: Thu, 7 Feb 2019 15:18:38 +0000
Message-ID: <1549552397-22798-3-git-send-email-Anson.Huang@nxp.com>
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
 6:BrMxQCBAf4IDUS8FUuWuMJB/yOPSGjlr+AGEduJWpYF7nTnl+V4sdA3X/JT83+TDYGmesATG7irMjMjFk/eET6eIiN6gGQg0Mx2IjWVgnxaGnFjGYRiA/ZvMBFyAnr7Dyu+oL/q6G2Z29ZUfJ/b0bK1OontFDLIIxWxjilK0gMRopCo2upcby9KHKYqznL1DcSEIGOdcCJmpqDDIRMlkqWJL8NsixsR29xo91W5uS51wRBlfp8Tg4KXyTenTPx6s10eGaTcdy7YNzTwApzxZ0NN3A7FuvM0+FZ4ltHS5SFPDE6h01HLpBz3ttSbcX8V2D2i+4qSy5hl+77baswopSAbtWpodrMc8+1O+Y3hgO4vS5u1+iaQ3asqGqjCcGxnwwvpFbND0vVsdrkt26kLFNbMHK3fSSXsLJ7V3NcvhbSQDOHit2UtZZWOSGN6Xfi/6WgGufNeZqZ1eqfOQSyGzNw==;
 5:8DAWDNhA878vTpqaLXBBrCGECzx+FMEXTk/dwmM6BXkFtbuOYvjdtr3AEeXe1ZXXzgYE5s/sLtPnCWKwB+iHoIYHBmkPRzlbLe+fVmz472h3XaW+y+NkMVMi508t/IUoyp+2uvPC4wdWOEyZl0WH8mCiCUSzL6IBRmsGSshxOVUM6rqe8TtTalt/ZilTV40vtPtuWk0Bet6mZaX12uBbxw==;
 7:JN8cnzhu0f+iNdgenzSTjk6Ar2ap8PbxtjM2Oo+iWT4y5avLf5MVa1gFXQrd5fWFMPiWaYVJiFpGqVOVEbxJbSmN7MswE75cfVyD0jroL4BpAaZjo3AOI+eYO5POCND7GFUGyEi2j9F/wlIMMTHCuA==
x-ms-office365-filtering-correlation-id: 564023e1-542c-4e21-dd58-08d68d0f88c7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR0402MB3846; 
x-ms-traffictypediagnostic: AM6PR0402MB3846:
x-microsoft-antispam-prvs: <AM6PR0402MB38467F5D70758CBB77006564F5680@AM6PR0402MB3846.eurprd04.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(366004)(376002)(396003)(346002)(136003)(189003)(199004)(2616005)(476003)(6486002)(86362001)(11346002)(446003)(2501003)(110136005)(2201001)(76176011)(52116002)(486006)(81156014)(26005)(81166006)(186003)(8676002)(6512007)(256004)(4744005)(7736002)(305945005)(68736007)(316002)(386003)(8936002)(102836004)(478600001)(71190400001)(6436002)(6116002)(71200400001)(6506007)(50226002)(3846002)(4326008)(36756003)(105586002)(25786009)(14454004)(2906002)(106356001)(66066001)(53936002)(99286004)(97736004)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR0402MB3846;
 H:AM6PR0402MB3911.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8jQLAs/L/da24GOypPGMZ1rt5DKYFoS8zw7ra31gVaI5f5s2nzY+1xCsSyVDlC2dXAG/u+kf/tPbJomEHan9qfu1OKX9rKexWYkcGHSw3JHUiHkusDtpnl7gMcp9OBnK64idWRMxgUkodj5BH6rHKlFbwHGvjnAWhXKY0o6kqa+y948CZ9fauWD+V1RQ4SF2wL339uE4ykz+BAX5Eg0N37RmhrQB2DYb1bubkitTyB07AZ+KFolazWoQUpEYfPIrD5DUE6pthX4tKVSeiyxaKvF+L/IA8xTEBIllAbSW4f3GKAbWpeYakseMrFjeDeRjpVOSDijJsEXYscAB6HAazMGY4iyIrXHIqiBUlEPVXI3rDb9wbYHzNi8tnfGBWnlTDIbIJ1fE9Ysmsoy5HvOjsaOwffGdN4LcCzvvrI/V7Zk=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564023e1-542c-4e21-dd58-08d68d0f88c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 15:18:34.6656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3846
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_071843_300902_2F03E689 
X-CRM114-Status: GOOD (  10.32  )
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

The mma8451 sensor driver has supported regulators control,
assign the power supplies for mma8451 to enable the control.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 618f186a..80b9901 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -250,6 +250,8 @@
 		pinctrl-0 = <&pinctrl_i2c1_mma8451_int>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
+		vdd-supply = <&reg_sensors>;
+		vddio-supply = <&reg_sensors>;
 	};
 
 	ov5642: camera@3c {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
