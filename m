Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876FCC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:10:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E3D52087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A6z0eWm2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="llNyvUms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3D52087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1Wi+XjHxB1OECwCeaR/P0bVw7xAtgfpQfeQT/wx9Zd0=; b=A6z0eWm2+WMyWR
	YUJwzrH7BFygrBgNeRDlXnJRP9CATkgPpOOwXqbT2bKoqeefxW9BNijnuRJhvMloOzyrbLmSKpA7x
	iP8om/4nh/kLHbwFibelN3vI2fcZmAJnUmghSV3OxfaX+BQSN8lpBYHknYswKQiTYKb0pNxxnl3Oe
	YBovjx3XU6lRWJxQNvxZbgsgvJziXQq5oLFC5tRFSkXDFwpy/Zs6FF0376L+auZqn42qlWc+0ElyU
	bnqVhvLgDKhyJox8FNgT81KrPg99XzO2/1qzOTuev4ffaauAoo3qIE+aphvJIU3cHIyzYydlScwFH
	RDmwEZKhiOElTb4GwQkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp7Qr-0002P3-VE; Thu, 31 Jan 2019 08:10:45 +0000
Received: from mail-eopbgr150059.outbound.protection.outlook.com
 ([40.107.15.59] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp7KA-0005cS-HG
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 08:04:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmKWgIw4oMQIxBcwlFwhdQP25iDgp5jljvMPKKX+U54=;
 b=llNyvUms8pE2+TrFW4Ey0ILRYdBCZBvIOSfrilydpyBLHFcTe6M4jGTnZS3uoY4p5UEHrJjNEZbWpo5B5ibxb0hhn3wM4A0+SaZFqwVQdlByvFoHdSyIz5iB1OLoIA3krqKaJsGeWjZHtuka6XMbDMuKssajD/6MSth2uiYJm60=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5298.eurprd04.prod.outlook.com (20.177.42.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Thu, 31 Jan 2019 08:03:43 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51%2]) with mapi id 15.20.1580.019; Thu, 31 Jan 2019
 08:03:43 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 2/4] dt-bindings: irq: imx-irqsteer: add multi output
 interrupts support
Thread-Topic: [PATCH V3 2/4] dt-bindings: irq: imx-irqsteer: add multi output
 interrupts support
Thread-Index: AQHUuTt8PgNPpOmrA0+KGlk6eJo21w==
Date: Thu, 31 Jan 2019 08:03:43 +0000
Message-ID: <1548921464-28917-3-git-send-email-aisheng.dong@nxp.com>
References: <1548921464-28917-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1548921464-28917-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0184.apcprd02.prod.outlook.com
 (2603:1096:201:21::20) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5298;
 6:v9z5sjZjDq6n3RVj1VH/2eXhtCqOzz4z7vAQ7V9WVUNlrIQWt2uwTT2pPKwkEQ2JkkTwNLKTCIwDA7H5d/QHXRdeUpMfOs4dg1YIhTMO5PZBkNuJsaA2pqlFBkfIGLNVRNFixDGzWlEv3sK5D1L4i9sifIlHmzzsF/cS6m1nVaJfhJx7hFskxREoiZbONcR5dIxbyBQFn4Z1IWvJM2Z/q7AtnOSbYH06FfUV1L7SjR1mZNEPWWPejMZc9wGg8gQtSRYMJdUqf+w3TVe7/1JsLp2I6Oa9U7nlZkTFYtwLhul0H0RVoNTDr7broC3GErJ/tDe5K3oV5TE5+oJIWs+OUWLbwocyMbSf8oW80CsjwYr8vlwDqxFmqtNE6mqEvSENlf3SFYpmQ2Nz1AdCxQ+6EyzvTKnyPF895dP6GsQ3SjJ+8YxfUEHC6UPzkjDVbS3EpMPgmc0EDPHpyoCBohCXbw==;
 5:hvIEkXeqmzp7J8nVmhEMCZv0oGVPk490d3oBki9YtYm6nkJyd0FJNbsEi5sElGTPYAHU09hEIdxAdArri/1DgBltFsNziU4X/IFcxdaNl5T1hZYKVzGP3XYMqHxzJ6/xNShowFHO5C9SYvy516vuEfZqpIsP0VdIiA682dKZyejj1Ud1qJJSY4FijExGlA4ON3rzbA1zN/18Auj2nciWjA==;
 7:oj8PZhsBQxyTCfhxAWT3tON2QVxxriuJXMiRxEqHM+xBHCtpkeYwcXW7J4gL0I7dmG5WmMv9WjxpBBVqQ0AR64+M8+5MtBF6B6GeZ/CldS01ouTIgNuTBAUzd4ICBRLd/zZpS8WuYb5TpmdKwQ766w==
x-ms-office365-filtering-correlation-id: 14ad1edd-adf1-410e-001e-08d687529e3b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5298; 
x-ms-traffictypediagnostic: AM0PR04MB5298:
x-microsoft-antispam-prvs: <AM0PR04MB5298F05CBB28306345488D5B80910@AM0PR04MB5298.eurprd04.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(136003)(39860400002)(346002)(396003)(376002)(189003)(199004)(54534003)(97736004)(256004)(102836004)(5640700003)(316002)(6486002)(386003)(6506007)(71200400001)(71190400001)(2351001)(36756003)(2501003)(4326008)(54906003)(2906002)(6512007)(25786009)(6436002)(99286004)(53936002)(86362001)(305945005)(52116002)(81166006)(44832011)(105586002)(8676002)(486006)(446003)(3846002)(7736002)(76176011)(6116002)(81156014)(11346002)(2616005)(8936002)(476003)(106356001)(50226002)(478600001)(6916009)(14454004)(186003)(68736007)(66066001)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5298;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bdbsSm9fVNQBkznRyKPmw6yuFcVngdvRbLjUtZ1TjilEyq7EzGX2M0aTZTsJ5pzKJ6SF3ZlnImoUU1ri3xdOFf0WKdNyaaVeljF23J3M0+EzXvfNjvtu8IhZU7xOogktpdbRvQ7EgxazrDfFolThJ07lkd2TV+1F6gp0CvCZF7eJOucWivQ7JVh61Y+XiXY+IS2a1kFdt7IB0MTbqoNSs0pKhpevAw23Do6DzC9jnkRJyszJPKKx43ZOvS07REG7a3TPB0Tw5QIapZchhBQTpZB1EiOHDROc5MdSqJ4irxJ79Dp58erk7o0xctf2XHfjTeoGqxYd30nSSYnc1dD7acwgGNSMcanU2bZSVJGLrjYlvft07sWgbv+2WJWmAKh2/LsXpnVmGyUIs3XS7gp+WaFaXS2H1U2WYvNxkKCJu7g=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ad1edd-adf1-410e-001e-08d687529e3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 08:03:39.8045 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5298
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_000350_953301_77D2F9DE 
X-CRM114-Status: UNSURE (   9.64  )
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

One irqsteer channel can support up to 8 output interrupts.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v2->v3:
 * fix a typo
v1->v2:
 * remove one unnecessary note.
---
 .../devicetree/bindings/interrupt-controller/fsl,irqsteer.txt        | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
index 6d0a41b..582991c 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
@@ -6,8 +6,9 @@ Required properties:
 	- "fsl,imx8m-irqsteer"
 	- "fsl,imx-irqsteer"
 - reg: Physical base address and size of registers.
-- interrupts: Should contain the parent interrupt line used to multiplex the
-  input interrupts.
+- interrupts: Should contain the up to 8 parent interrupt lines used to
+  multiplex the input interrupts. They should be specified sequentially
+  from output 0 to 7.
 - clocks: Should contain one clock for entry in clock-names
   see Documentation/devicetree/bindings/clock/clock-bindings.txt
 - clock-names:
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
