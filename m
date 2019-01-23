Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8A6C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:01:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF38521019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V48/oG0J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zd/biH39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF38521019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2W3mePWsP4qvr1P90XBw2rbq9GBQbLQ6CE9kHmknyfQ=; b=V48/oG0JZw9amc
	V/1qKF8wLid3nzQZ3DmJtoL6aU0LEDwh/LshCiXrcr2sxXt4tIMUZ6URBz7gDkyfCueTTX9venCOQ
	jXqM+UHsfNsiGOkfXaCv8oRHtVQOAKgjRp5uqiQKCjpdKIX0wAEkuwATiHvde0+RleyNM69PoIHxw
	QwHBcmGj519G4Ph95x/xkNi0/Du9fTpRl4fZOXaLNv8AEs/513qre329YwQy4cF9kmO01HHbJ7OFk
	X1hEltr6vXNbKo8hqQngEMewBtVhMNyT6DNbEvE1pwKffFyRNyzXTfx9b4bDz8DpT5pGcHrjpKOrJ
	/OzlFnYAw+SXMV+adIfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmDTj-0006uG-F5; Wed, 23 Jan 2019 08:01:43 +0000
Received: from mail-eopbgr60047.outbound.protection.outlook.com ([40.107.6.47]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmDTV-0006fh-AO
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 08:01:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SUU8VHtQZsmWZLKbrAciB6qXVY8vYAWGI6nntnWvo8=;
 b=Zd/biH39l++MSy1aXLIs/X7qFHirTNRpko2ShqPwcVUeAOr6E70Cw6sXstQO3IADB9WnxWzfrFQBhWUovPTm+STRtmn1f9z3a0dpX1Ri2CZRu5+1HWfZkv51UehXijK+KCRz91Gewmf/FJLsUl0v2tKEDWE2FOESqGlH54YqeCA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3882.eurprd04.prod.outlook.com (52.134.72.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Wed, 23 Jan 2019 08:01:26 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1537.031; Wed, 23 Jan 2019
 08:01:26 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, Aisheng
 Dong <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org"
 <ulf.hansson@linaro.org>, Daniel Baluta <daniel.baluta@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 3/3] arm64: dts: freescale: imx8qxp: enable scu general irq
 channel
Thread-Topic: [PATCH 3/3] arm64: dts: freescale: imx8qxp: enable scu general
 irq channel
Thread-Index: AQHUsvHUdPc3T/5XfkGbvS3LZCHmiA==
Date: Wed, 23 Jan 2019 08:01:21 +0000
Message-ID: <1548230179-26076-3-git-send-email-Anson.Huang@nxp.com>
References: <1548230179-26076-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1548230179-26076-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0142.apcprd02.prod.outlook.com
 (2603:1096:202:16::26) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB3PR0402MB3882;
 6:fIH7PQazgy5rIpOl/ckIo6UDG4SOjZP0U2OJjnLex4q9zeD0UXzk6mydz0CIWNC48R68mZnn/8uBfBPTwj0XdrnjqhmWGFjVUyulemEuGUA1njXG57Po6W2dO126Y1SA8BZbstbgLdqW82m1MV0z/tM00EFrdVK+2Lw9Sqp5SrzrgvvRm7CJhWOTcP4tTVH5hrMY5eXsXmx09+w2IqCLEpWpClcBd0DOaFfMfHiO+a9I1bymI081s1vT9JwHDwWXouMq4TRQTuJ61lTgb/iu9ssBnlo/H0fqwQvQWEgaN5dhBs9eHs7UYIUh9YGmarVVSyDLv9jUv6FhOMha7ioLt0+wvvywgtcRc8opqZ8SgdfBNE6qcmkFsML5fAXtSSU8rPHRpnVtYfib5/dKdhylMhiFjq0lzfJXtewlr1UXupnPDZSGVWdElKLedYBpiAVfYwQaiD/7MV/HG27I4wDZXg==;
 5:IBIvTCfiNs4hj8EmlDrGB+MO9sDfMww/tQlrx7qDPT1zM47+5jNatPiY2BjLSihEcrsYVKxePZqJ4tAqncSGLIAQWvpYphUI5z1BOvGKVBfGgnG+QBTwSd8B+I/Zb47OAQi15KwfCg0Vuwh80CTRilsEEnSh0j8KcVb1SU1C5gkEL30fVVjXG8ilordbKjRdeDmFJhW7hrC6vKDV+3OipQ==;
 7:6hUwhQkn3aWUopChcCD55fLHCAbD0za+wTU5UIWObSaJfmjVS4u3RVFmIAw7buS9cW7nPOVorEiiKj68sv0/+0mxSF1Hrx3Vk2yU74R2DhVSBAHPV3rozhBkVVOI1aJ/BdCE0K9epO224rwRdHYz2g==
x-ms-office365-filtering-correlation-id: 67084ca0-eb19-4508-0216-08d68108f68b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3882; 
x-ms-traffictypediagnostic: DB3PR0402MB3882:
x-microsoft-antispam-prvs: <DB3PR0402MB3882A368F88FA438151B6A36F5990@DB3PR0402MB3882.eurprd04.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(39860400002)(366004)(136003)(346002)(189003)(199004)(186003)(2616005)(66066001)(3846002)(446003)(52116002)(476003)(11346002)(256004)(4744005)(86362001)(39060400002)(76176011)(6486002)(7416002)(26005)(2906002)(102836004)(4326008)(53936002)(2201001)(7736002)(25786009)(6512007)(8676002)(81166006)(305945005)(81156014)(8936002)(6506007)(6116002)(486006)(386003)(2501003)(36756003)(6436002)(106356001)(50226002)(97736004)(99286004)(105586002)(68736007)(6666004)(316002)(71200400001)(71190400001)(14454004)(110136005)(478600001)(921003)(32563001)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3882;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9Kqiq8MzD464NOLkgPOM3LwaATzmRvABFmHhzFWcZe6U/Opmjdkgzlmt6vAiQwSP9PvZvSFWod0BOdghcposwGDBkfZEN4AxjswhJVbls7x3K+JWBHPvPTpb9KarKYXjgvxLCJlkvfPz7EPHuYiqUOZqhW8jwvHLUF96WOIcG9q/2WS26C6LJbtVMSxwXtP5n3dg9ZRPrUpwUsgm9iKN/ipFDz+3EoB6KOfuwIpiomL/QnlxmubY7P64G7TaJ93+wCVGdMEJTqr+JiS5Rh+Db7GgEcE+WKZ7N2PLxXS1p/uJ5cBJuUA5MRNkWkOpwHpuhvnqW0N3GstptlaqiPC/l7hMDF7CIDfNGrwuUiVtsWmRSJPNVsmqY+cKmfAvQsvbLQC56bgPRoUPkbq2XeFILlDAna29kIHxxJPttyDGSyA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67084ca0-eb19-4508-0216-08d68108f68b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 08:01:17.2092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3882
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_000129_729243_547CE449 
X-CRM114-Status: GOOD (  12.11  )
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

On i.MX8QXP, SCU uses MU1 general interrupt channel #3 to notify
user for IRQs of RTC alarm, thermal alarm and WDOG etc., mailbox
RX doorbell mode is used for this function, this patch adds
support for it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 4c3dd95..4021f25 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -87,7 +87,8 @@
 	scu {
 		compatible = "fsl,imx-scu";
 		mbox-names = "tx0", "tx1", "tx2", "tx3",
-			     "rx0", "rx1", "rx2", "rx3";
+			     "rx0", "rx1", "rx2", "rx3",
+			     "gi3";
 		mboxes = <&lsio_mu1 0 0
 			  &lsio_mu1 0 1
 			  &lsio_mu1 0 2
@@ -95,7 +96,8 @@
 			  &lsio_mu1 1 0
 			  &lsio_mu1 1 1
 			  &lsio_mu1 1 2
-			  &lsio_mu1 1 3>;
+			  &lsio_mu1 1 3
+			  &lsio_mu1 3 3>;
 
 		clk: clock-controller {
 			compatible = "fsl,imx8qxp-clk";
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
