Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80910C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:17:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E6A521726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ju19OCEe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mfEi4rEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6A521726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LHBvJsEa094oyQ3KPBqVkoNzGYLCkm6iMSDBtAm9XCw=; b=ju19OCEeTFSxDv
	+/W2nK/oTi45r8eSgevy5BbUjUiHEkjSPK52L+S9QD6GbBPJUvMnK88paivsD60vlgIWF6k2XUh6c
	sklSWmBXxCGDGcC3gYt5X0q+9PJ8joAkrLgpD24THSjebI8kqVW4oAo2SblWwtCBB1BpL8UAE2hxm
	/lC93xRQTwo6bbh5EDdTzgucMGEz/lAUDH7Bs/nKyKLkYYLv0RFUo5OxbyGiybB0rbSuWf0k7mXvq
	17oDcTKtXiht6HuUO6sO3oSKiI6N2nh9q9nEAN3ve95VU4kdm4GHd/3R+MaZEFQBDUOaivn7VDUKG
	IGWJUPbHlyrwhBP0nIWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmDj3-0005MU-0c; Wed, 23 Jan 2019 08:17:33 +0000
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmDiR-0004ds-P0
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 08:17:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8X/r4YiyPFidW8VKVVaeHevsvmKCjyyFOH6HNbwqf4=;
 b=mfEi4rEkH+lRLtr5au0dtUu8piiJzjiNpaD/BQlpvnzpv0VY45vrXRCcaRpbNS2+Tkp2aXkazqc3KR1vpH7+S1ddjL+Nkep+hWG6Dqs2hWvTR40OWocMEkUppmmg+Q4ImnH66U6R9K2tXgf8k/cszeNvJAIApG/qa0Y/xHSJCqI=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5954.eurprd04.prod.outlook.com (20.178.112.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Wed, 23 Jan 2019 08:16:52 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1558.016; Wed, 23 Jan 2019
 08:16:52 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH V2 3/5] dt-bindings: clock: update CPU clock ID name
Thread-Topic: [PATCH V2 3/5] dt-bindings: clock: update CPU clock ID name
Thread-Index: AQHUsvP/O+Vf7Z/SeUispxSFpbwACw==
Date: Wed, 23 Jan 2019 08:16:52 +0000
Message-ID: <1548231044-4344-4-git-send-email-aisheng.dong@nxp.com>
References: <1548231044-4344-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1548231044-4344-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0020.apcprd03.prod.outlook.com
 (2603:1096:202::30) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5954;
 6:J7Od8esgWykB1pRk06RdnWsb8ojorZtGDfj6caC+NnwqG/qRvqxFew5xcXQ2KPV6hhOBu4eHFo6L3b1HdUL+3Ahe7GzRsrTdBVniP31X5JyKl0zPP/KTQNyt0JK42G0R3GQvExkGO+Qhi7EgqqDoI9UA0NzhEiPI5+uqz++xYdzcmcZxK0CGl9N05p0kRuEHAQXj3mIwtz5cmi2BIlkFFeZl5xtCkYfmCHZfD84mckhSDu6eiwN8G3ioEXAcdb0hXWrChrVpwMEjsq7xeHTPGrx6qzFBFwqETa7BN4ttlKlK+muKmHJpVIx0/aWckCJTa6xRhoQaPHwZT9ztELSRlaU+HFAPbEJtwf9HT09zH7NfaD+WJ2zKd5gg8mK/Ik08d5NHb1MzEJpbasBDm7j5PAo7ZOZ92kUljjRrqdvHZLgo2ee6zfGVN9Req7fYvy7fLT5bEggfY/2b/5GUKLbnmQ==;
 5:rStXu5JlnP6a7AO6xag/SXO4UFvGCPwMCNrYqge6wSK3KKPkLZrq61P9vhi1TcuZQbNd0VuioLn/uJRe97yMZMnxkYeOO4INfI3cWh87Fc/H048S0gLYI5T+gWnlwhBYszHuom6l7rSpZY9GIi/OyzD6Pkjciu0SQ2zSdzkmTCmF9HIV6oEpZqhgsrj4h5w25qmP8qSpo0YYxR2D4JqdYQ==;
 7:rySxltchChyGhJOavZxF6qAfefzApG8R8ALHAJMRmHBuq0rHKGSz9mxUXiRuksjWes4XOAuTYGWHMn1ZjM+KvHX8rBfGNbgs4a5arVA0SDzlC8SSfXkEjF6msH46CnSZGbgjUZpUCmJ4lMqgf5AmFw==
x-ms-office365-filtering-correlation-id: 29893650-e4df-4b65-1379-08d6810b214d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5954; 
x-ms-traffictypediagnostic: AM0PR04MB5954:
x-microsoft-antispam-prvs: <AM0PR04MB59540735489A9BF4F1865DFC80990@AM0PR04MB5954.eurprd04.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(39860400002)(346002)(366004)(136003)(396003)(189003)(199004)(446003)(11346002)(97736004)(6916009)(256004)(14444005)(2501003)(7736002)(26005)(3846002)(6116002)(476003)(6512007)(486006)(53936002)(4326008)(2616005)(186003)(68736007)(15650500001)(71190400001)(86362001)(71200400001)(52116002)(66066001)(6486002)(36756003)(106356001)(102836004)(76176011)(2351001)(105586002)(6506007)(386003)(5640700003)(6436002)(14454004)(478600001)(4744005)(25786009)(44832011)(305945005)(2906002)(81156014)(81166006)(316002)(54906003)(8936002)(99286004)(50226002)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5954;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fgftiVFjmWwNrirTEanvIebExEckQ5CphZ3zBAqo5DhPNmQMVFF0Oq7ljKFOpnWr9P0jI+mh7Pl3Xi+b2pyjHyryiwhc2sB3WqTZ1OtmBrSb3qqnnlhWPphyu71ORTIdS4Afg5gekLzoG2m+ttquBjOI5Zdv+K8M29+wO5YHbxLcEMMMxuFKzb9kaYgmk4jjRTXhGzFONaYWQ2kkqUQ+f3hBA3IfTgPZK+sXSXcobZHb2kR+8p8V3HCsM9ip5nrS/CBsMfezYh3A2rCMi1yofBvUDtH4AxcW5VG/ka/omtdRc1mCHLQu8oxQjxO2lT4/ddVsIg68cg0c1TBDAi0QzCl7T4nSJvoOBGdPkAAJz/+X985U+nXPNT4GuAOjOXKswnURwPU0FQLe+Dn+d26/G0N+6wBA6b3ugr9w29Wze1U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29893650-e4df-4b65-1379-08d6810b214d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 08:16:48.6450 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5954
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_001656_230980_43F3A502 
X-CRM114-Status: GOOD (  12.67  )
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
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Update the CPU clocks to CPU cluster clock.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 include/dt-bindings/clock/imx8-clock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx8-clock.h b/include/dt-bindings/clock/imx8-clock.h
index 4236818..aa9b9a0 100644
--- a/include/dt-bindings/clock/imx8-clock.h
+++ b/include/dt-bindings/clock/imx8-clock.h
@@ -12,7 +12,7 @@
 #define IMX_CLK_DUMMY				0
 
 /* CPU */
-#define IMX_A35_CLK					1
+#define IMX_CPU_CLUSTER_A35_CLK				1
 
 /* LSIO SS */
 #define IMX_LSIO_MEM_CLK				2
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
