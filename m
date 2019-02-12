Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BECBC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:11:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48A9020821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IOYfAtVn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lYlOIuKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A9020821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5gkjLilAXBRaHZZUHO3ltS8XRBVjJcNmgVwA3NK66hA=; b=IOYfAtVnHaViMl
	y1nYSAyc0Rj1b9qG2jSpUWKzeKfu+k3kOymRQJ4uEeeZxPH3RVix9dPa8wauaqY0S3l71wZs0zvG9
	6UfZ9yoTJmHD5H9evIrvswZ86VfCj/nO/eexiH2yfwMPbl0qWyl9ItGJCfp8FnMSdvtq6wRsJRSj3
	7cnnTxqfrWEtG6rdKWbSALimnkJQYXRZVidXjGHutmWdDI3ybFrf20OAeC0Uc5IBW/EB0RFGrfeGg
	iEoXAc/Sq1lUoaype6aVXI6SPd60Kw12xGBfj367HvZoyloMiQ66k88pi2PQ2QaK9q9qF5jm5tx+Y
	MvkT5mAWohjfXKZP8KrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtWuL-0005s9-5f; Tue, 12 Feb 2019 12:11:25 +0000
Received: from mail-ve1eur03on0601.outbound.protection.outlook.com
 ([2a01:111:f400:fe09::601]
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtWu6-0005dY-35
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 12:11:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7na6WwPdNhNLYWqdrKqMz9wgkBZMFr5WaJcaZiTOuLQ=;
 b=lYlOIuKLqvr7mitrS+pBjy0cah5nWn+f/vnJvzcdm0j6CkWqkvszFrlS2bUqoPnP766enLIG8uYY+mRb8DSisOHMAb1KoTrOMh5ClT1E1Ufs1OWeuaX0E+UHUDaGRYlQ8VwO8tkQaqkMIv8qviWXywmo2XRiccWZcbieWU8bPkA=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6323.eurprd04.prod.outlook.com (20.179.36.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Tue, 12 Feb 2019 12:11:02 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 12:11:02 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Anson Huang <anson.huang@nxp.com>, Rob Herring <robh@kernel.org>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Mark Rutland
 <mark.rutland@arm.com>
Subject: [PATCH] arm64: dts: imx8mq: Add cpu opp table
Thread-Topic: [PATCH] arm64: dts: imx8mq: Add cpu opp table
Thread-Index: AQHUwswF0jCrGFVmyEmVHUYdS4x2MQ==
Date: Tue, 12 Feb 2019 12:11:02 +0000
Message-ID: <1549973439-26706-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0077.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::18) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB6323;
 6:phQZR894/LNjRfPmhZIF5yH4ApBXePIc+SOWPfLVT1cQ9emLcfeZJxisyGVUgLaAIjuhmlXues7JghmLgttzct6SGyiJr661ccnBGnYs/55ZKbxXKL+RUQjbhSSyrSHMVfFnwxPT00NfjDprPjYk/GCsDH5GCLlCpTz9vDbqzlaf3p90W+dIsVlL6SAhpOIBK4lvFfu2Njo6j82+NsawSYEIJY5BQlzuRRp7BDMZ0DVdTVnI17QgWB3ZcMi2Tc+RltH/xT9CTYbhAXt5CxQvZrpws/Hbc+F89aA2FkALRoLwWvyiM4D8w1B6WYPWA4iMSRshw8olmpO0Ovv+hBVCSCEUCIQ1JlM5AZu8zYtciR74i+I+Yw68HECjFS/hG4HClZvAKAU7biKe3gblRRV8U/4hX0qLs7tqfzyNH+0so3C9F3Mab24w3ce6OYcyczKj6bPucmqRTjQJAqeYkouMww==;
 5:czntZSPWwsPKaA5+dvnb9ljZUxfPAqglCg3XI7kra6prRkhAndlsQHRz8GHq7ZC9iCb8+X/MJPFJSy0a2MDLcr18u+ck5Y2L/qJE/n52YBHVjJH/JbSH4eMC/YdF2oE5BwANi5i4wiy2T2/R55HqQH0A+DPm0zfnuQECjCYOYdml0gck1xMkbO5WT3zcBnkSWY/wGFJXvBlyVVYiuKsTxg==;
 7:sRgcL4XQ47wXSfMJ7dpdmv9RZ8/Oa9w0fijyAsqHRmk8t7OQMnQP6WnKIZ8VxKMUmXx6LphZ5u/bihUfqnOU/efVQ2B9/nkgARyEpnBNgPtZPWlAFDrXp/K3UAYSuhFwBYO0GfZ4hrM8CkSsTcDxCA==
x-ms-office365-filtering-correlation-id: be0eeb5f-2f75-4218-40fd-08d690e327ef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB6323; 
x-ms-traffictypediagnostic: AM0PR04MB6323:
x-microsoft-antispam-prvs: <AM0PR04MB63233532C742B046660FFE24F6650@AM0PR04MB6323.eurprd04.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(396003)(136003)(376002)(366004)(39860400002)(199004)(189003)(4326008)(4744005)(25786009)(36756003)(106356001)(71190400001)(6436002)(68736007)(6486002)(71200400001)(6116002)(2906002)(14454004)(8936002)(3846002)(7736002)(50226002)(102836004)(97736004)(86362001)(186003)(6512007)(478600001)(53936002)(256004)(8676002)(2616005)(316002)(66066001)(54906003)(81166006)(110136005)(81156014)(105586002)(44832011)(386003)(6506007)(99286004)(486006)(26005)(476003)(305945005)(52116002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB6323;
 H:AM0PR04MB5779.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fYSUxUw4qvxiW1nrN71dBbt+lkOxx/ybQHsvsabhtieYRi15sul5kUXG7KYpSWwqIGSP1C+KmwDgcMzp/3PyVuQYQ6HaNLIAOO18KYy77fcQJhxpelNFuxFuYf3MT3VGnuolZ0KJXg9qWlxO/vP9RoPZ6eQd1mFFTktbCNjkPqdmY67Kb4UJExpphIb6nTq1bIKa9lqIYVxkhQHz+NlaEiJVBSaUOX5akq6oKLNJeFAvh4GoqG7jr6iWenQ4AHS7trF0SBdZfNhPKd000ZXnwNyZCm1Zfi+k48Ni/TctLYg76Zh/iroDBu0TidNuH09I+T9P13Mxf60AbDiSKNVdxOCgKs/pPlee4qjFRw2j92o6w6JJdWpgAqYqsIhET4yFJaYqMilreu1SypOWHOS294r0dP+eivaQF0MyL5yxhrg=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0eeb5f-2f75-4218-40fd-08d690e327ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 12:11:01.5066 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6323
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_041110_208428_2DF53815 
X-CRM114-Status: GOOD (  10.02  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Anson Huang <Anson.Huang@nxp.com>

Add i.MX8MQ cpu OPP table info for cpu-freq driver.

Signed-off-by: Anson Huang <anson.huang@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 9155bd4..579015c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -672,3 +672,17 @@
 		};
 	};
 };
+
+&A53_0 {
+	operating-points = <
+		/* kHz    uV */
+		1200000 900000
+		800000  900000
+	>;
+	clocks = <&clk IMX8MQ_CLK_A53_DIV>, <&clk IMX8MQ_CLK_A53_SRC>,
+		<&clk IMX8MQ_ARM_PLL>, <&clk IMX8MQ_ARM_PLL_OUT>,
+		<&clk IMX8MQ_SYS1_PLL_800M>;
+	clock-names = "a53", "arm_a53_src", "arm_pll",
+		"arm_pll_out", "sys1_pll_800m";
+	clock-latency = <61036>;
+};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
