Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DC3C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:06:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 344882084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LGqRkItB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VPkTURWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344882084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=txt40ehX88hemDpHZ1LEk3x+xNamEht161aAVa8bENw=; b=LGqRkItB3j1kLW
	ozKBqM1yQLLDwppormhF6Mj37Lexke7Oud0InwvV1KwtL0prKhh8kGWjXfl/LAoXQsltv1XXa7gkJ
	+if+T5lQ+AWiwhEDQTL6rCk0Xr6nVaYncNoYj4kp5xLD3/4J74Z+EwhFBTyJWehPHuEl/YY9qoE+n
	06Fcrke6OpZkFUMHeNh4UP1fljMUHiTwSpKoYVM9Fs0+kPqS59NgShVyZ13I4WXFluShrHpOEab4Z
	dnye9MXOm0i7uQJkZJvIiv6R/9O8kskcPNRnPINm3Lw4C+H0tSuLM3wZliQ5yNwvUH38vZwLD0Osc
	WGzo9Xy9LzJ/lhffcj8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gopZH-0004Xm-GR; Wed, 30 Jan 2019 13:06:15 +0000
Received: from mail-eopbgr40055.outbound.protection.outlook.com ([40.107.4.55]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gopZ1-0004Ij-8M
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 13:06:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXxyazSZWTDE5DNLBMqpFIiE4wO6XqRVk6ersIC8OlA=;
 b=VPkTURWjKCGUYFMHD6YMPTWXbkbqaQdadSnJ//xpy6oI1JtFpTn75hxviIx8C2JcwlsGq+z9m7nExuYKKJauNV4ZXyH+66RX9hT8DPhQ9IT9bAsCkbxXp3Xff631cc57NG+/cxpm3pRxOWrGrP7C5ROTcLCY8atGP2V+iij0K1g=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Wed, 30 Jan 2019 13:05:55 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51%2]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 13:05:55 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 1/4] dt-binding: irq: imx-irqsteer: use irq number instead
 of group number
Thread-Topic: [PATCH V2 1/4] dt-binding: irq: imx-irqsteer: use irq number
 instead of group number
Thread-Index: AQHUuJyI2fEUmpKRtEa26OM/xF2qWQ==
Date: Wed, 30 Jan 2019 13:05:55 +0000
Message-ID: <1548853196-11447-2-git-send-email-aisheng.dong@nxp.com>
References: <1548853196-11447-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1548853196-11447-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::33) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4211;
 6:VooOpG7gO8iK4iWu0znXj8xrnC9u0+cDb+SXprIvKPFwO7xYsEilJ59m4Izccn0r+trC5q4Bm2hQhSlNtTZr6ROa1OCsldt8kz51cQ5aNKc2sGtLKul5c7m/raOwzEc9V8MzC6rV4R7ksNLMR2aeMlqcEPFrtTdySwR8C+9NHt/6RSdp3rpnd6oDZTODEqyTH4vofmL3q3H20Me6mDSdzaakYntY5Nd0almM5OkaMZdEHycBOszyUPTLSE38dr1kFWRU2f19+hceraYmKG1j5pnJ/YCoiVZ28Hp0wRqNin2d3TD6ImkVHT3gIRuisI0djlZz6eVQsx/gCYQa9NA56uUHsyrhKrjliNXV0Xm0nI64tA4qQirXC8AmeWJ2PA6e//yCqV/d47Dt8fogDrlj5NTxiwj0NjSryT9xkpGtWX/f1ALAvKm2pa4g0xgAtmoFdQQ84PSyac3XK18ivLkTvw==;
 5:TeTVxbSOieoRcQJKTNtIt2hP6BVoxcjpECupWfb/VHorL9XXWY0d4ecKeLTcV3l2kyiRH/a3yhPpxeTEFEhNjAGhlM3FwupX5CG6RWK+DX3wdDCvBZqPIus6+6ZitrH9OPlpZAomPC4msYIUhl19cDsqAFCXYpC2LL6WQd9oM18pmEAHAl//1gIP7vFnReKrjQTLVva2+AZkNkZ35FqmJg==;
 7:KvAq7Bk9+vKRebpweqZ5f/04WGFEGAImLtnH9EgxOQziF9BuT7mLuly4+V27IIy18KnQLrVaCcpJKQSjUNrJbUmYrrn7Ug6hG9/O/C9fgIPE1WsIeIlcYV4zOauDY90X/6usqISSSuOZpN3Ymiuwkw==
x-ms-office365-filtering-correlation-id: 0203df92-921d-4c06-16d7-08d686b3ab43
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4211; 
x-ms-traffictypediagnostic: AM0PR04MB4211:
x-microsoft-antispam-prvs: <AM0PR04MB421196793A7BA344C764859080900@AM0PR04MB4211.eurprd04.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(346002)(136003)(396003)(376002)(366004)(54534003)(199004)(189003)(2906002)(54906003)(53936002)(478600001)(71190400001)(71200400001)(6916009)(52116002)(6486002)(14454004)(50226002)(6436002)(7736002)(305945005)(2501003)(105586002)(106356001)(97736004)(2351001)(6116002)(3846002)(186003)(256004)(386003)(26005)(6506007)(86362001)(76176011)(102836004)(316002)(99286004)(66066001)(36756003)(2616005)(11346002)(5640700003)(25786009)(486006)(446003)(476003)(44832011)(6512007)(8676002)(68736007)(8936002)(81156014)(81166006)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4211;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2MFrC5vlo9xpEix1YM09uVnwnhUEsafDl7rsmqdSCpTssSXbzpKr6FNuLCvJDWQ2sW//mnWr8pcK+jU68MT4HDX567bCUnvnNqFJrz/u4L5ONxj7nU6AZfBb2THZc7RWPqaHTZbpNoRlVrdhWVwO0Y6p1dRkZ0mdK/26QyOu06x1f2pqOY4rPLtwbVrEMNomacm8optyYEll5Iw0ze7SCEbtrpba5A60IlhjjWtSFFRwLlBU/DEVdfpFnaauiQf4541A+rCJ0sSbwHTDKb/J9hu13f3yZs90jvw/GNofkxSWKuGrODILeGIeL7ynhA3N0IqIlBffnsUJbEK5ciZ8VhH3ZKayYqZ2TByv7kLWAxeukCg3uEnK0EVPUeJfH+rrGyWeOYrIP6q/ga4Gts2OkOjJlo+q3Q+hgoRET3Z2rgM=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0203df92-921d-4c06-16d7-08d686b3ab43
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 13:05:51.7579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4211
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_050559_296548_124CB6AC 
X-CRM114-Status: GOOD (  10.09  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Not all 64 interrupts may be used in one group. e.g. most irqsteer in
imx8qxp and imx8qm subsystems supports only 32 interrupts.

As the IP integration parameters are Channel number and interrupts number,
let's use fsl,num-irqs to represents how many interrupts supported
by this irqsteer channel.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
 v1->v2:
  * change property name fsl,irqs-per-chan to fsl,num-irqs.
---
 .../devicetree/bindings/interrupt-controller/fsl,irqsteer.txt       | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
index 45790ce..6d0a41b 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
@@ -16,8 +16,8 @@ Required properties:
 - #interrupt-cells: Specifies the number of cells needed to encode an
   interrupt source. The value must be 1.
 - fsl,channel: The output channel that all input IRQs should be steered into.
-- fsl,irq-groups: Number of IRQ groups managed by this controller instance.
-  Each group manages 64 input interrupts.
+- fsl,num-irqs: Number of input interrupts of this channel.
+  Should be multiple of 32 input interrupts and up to 512 interrupts.
 
 Example:
 
@@ -28,7 +28,7 @@ Example:
 		clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
 		clock-names = "ipg";
 		fsl,channel = <0>;
-		fsl,irq-groups = <1>;
+		fsl,num-irqs = <64>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 	};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
