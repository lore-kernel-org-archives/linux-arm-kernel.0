Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D186CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:38:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A071B21902
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YB0xThlO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P1XzkdtZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A071B21902
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1QHbMeY4CETKiucqOTw4Zlyd5zh6nm7IfXMmdf/JYlI=; b=YB0xThlOxC/4Gg
	Kini+MI4XnZBeyUh7+zU9+KJpPbQOK8U9h/Qb0dtRFQZnsbRv0ZLh5jlPWmJnFAvgCq4M1Py1erz7
	GMZamTlFC+lwMfQ1QRV1zPHYLdUSqi9EwyL2g2EVwVFBwfS2z2ywRwdR6y09ZqIOPCcQ0isKxXbju
	AcLKVTWeRBbaH4O/lWmRyhMK7r1OvCEeFcTkLAl67H8OM+QcKgxjO1fn9DTZlYNyJqiksZMxmuHzm
	FK/Ney1WxMLgqbidqSBPX5MW5CFeaEthK+642PuEVG4nJiSneT2NFz7ZcUNalFFpYF6rjDtJrJ1E7
	vh8y2iQnDEE5yAxPQTtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwT14-0003s9-GQ; Wed, 20 Feb 2019 14:38:30 +0000
Received: from mail-eopbgr40087.outbound.protection.outlook.com ([40.107.4.87]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwT11-0003rH-2D
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 14:38:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUgEZTf3JikD95+qvKdhfBTxahgDdQAjUv6RzP23D0Q=;
 b=P1XzkdtZFvJw1V+8aHOQQQP0hSecGXizrPHWmv69HJRqvNHWBWMTwfRCD3WeOaSl0hoai5T0M9UTGT9NG1EY6XVg69r505DHgmcPUqYrFBa+Eyxp2LOjgOfVP8VLyou/gaQtDO4gVjtGJWNQxcqpa1vhgMvUzkgUNCQE9y5YtDk=
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com (52.135.168.141) by
 AM6PR04MB5975.eurprd04.prod.outlook.com (20.178.94.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 14:38:24 +0000
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08]) by AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08%5]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 14:38:23 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/3] firmware: imx: scu-pd: generalize the implementation
Thread-Topic: [PATCH 0/3] firmware: imx: scu-pd: generalize the implementation
Thread-Index: AQHUySnusuHh5S/UWkWe6S7ocFkvvQ==
Date: Wed, 20 Feb 2019 14:38:23 +0000
Message-ID: <1550673013-21462-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0074.apcprd03.prod.outlook.com
 (2603:1096:203:72::14) To AM6PR04MB4215.eurprd04.prod.outlook.com
 (2603:10a6:209:4f::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a7bc80a-5846-420e-2e8a-08d697411107
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB5975; 
x-ms-traffictypediagnostic: AM6PR04MB5975:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; AM6PR04MB5975;
 23:CyTAhcrT+2eBAcsICIr9i7mxjtBncETBPka5Iwo?=
 =?iso-8859-1?Q?KY4MDB5t+F3Pk4IexO/lxZ0iHYQMDZmIezV3QKyH9G6Va37UmxayNJXv9m?=
 =?iso-8859-1?Q?F1J/+4Wbmpjv/qGiXtbEUfQl2X/ZcHoFEb/lsaui+RBzNMy5tDeDFeoE3+?=
 =?iso-8859-1?Q?XFYbZRSLUuSlQe8aDP5TOIxakKrm03EmaPIxQEC/526jhtLmO4PlFxnBmk?=
 =?iso-8859-1?Q?c2haxHydEB0fXAMksSl8NnvZXl50+wyhFkCmjmM+Fg053jBjoA8uRJkoE3?=
 =?iso-8859-1?Q?FRtIarLcGqBjgMuzWbpWlA7xlP91KkUW3QSky3m989totMGhZ2KKqUEeRu?=
 =?iso-8859-1?Q?PwG77v0CUy91n2IG5/1pG92hwrBlJ9XJUyiy8IFufIwILoxPp4pO8TjJVF?=
 =?iso-8859-1?Q?f1NkeyiVd03xhJQnFtLOBzU/5qgELHQZvVrsTdn2z3ieDYGWZ0joSqgXcY?=
 =?iso-8859-1?Q?ntOAg3ES2Pp+mqHpXfr9j3aPbOMkPIHOIhw4OZsTxsf6fxuNH45rUsUOvH?=
 =?iso-8859-1?Q?qx0zjdw26WgERNZ97w52MrZbk2Nmxic70mIXPBeY0dZmwaHiiSSAITLmed?=
 =?iso-8859-1?Q?kgyjsEhEnMoCLFexYYCwLfHuFW3p6xYS4YS1od8jJ/NaJTKHEsitYEr5fI?=
 =?iso-8859-1?Q?RSwfVJyr2f/kNVFL/0WqNaFU0WsJyQ+mNq4JegtHXKcim/jwFSy/WMeAIW?=
 =?iso-8859-1?Q?eUVeSqwiH2gYQ0qthEOfGtrJEtbeS7FBlZe/d7bikQotTyAZH8En+Ib0um?=
 =?iso-8859-1?Q?60QgaHJEPXRuwlbKyAnrWDip8q1BN9F3ERnFzNqiPIsTa4cyOZrucrlVyV?=
 =?iso-8859-1?Q?/1fleP+NKvtyojur+g8sg0MFBpCb8AYykTuoFh5WprFJT3qHX8YPqHtwrd?=
 =?iso-8859-1?Q?tPQoY6WkDmZdq+1xBUYymjkWvNmGVwZuJUDt1P5MeNlpn1QTgGyz/94qgV?=
 =?iso-8859-1?Q?9UXvj9x2dgcmicRVV1X1ICEAu50gLA7FmCtAEwe0EcPpW6vd0sqckVnKst?=
 =?iso-8859-1?Q?n4lqjEGzUP5ItD0toLAxfyZPn8B0RU7pTqpp26mwfwV04BBzOlq0jykP8Y?=
 =?iso-8859-1?Q?T34k4tEOOmW0lQHa3Wikmh9MGy8Lahr6+sZznpUDMRBIBcfqV9sq1gZga6?=
 =?iso-8859-1?Q?ci1NOcYlEfbXeE2K3uXjnwPPBfM26hizNqXfp/6QvWg0eGt/URKA1C5Qcz?=
 =?iso-8859-1?Q?dO6spcfZ0G34hd8GELz5If1liswYoJaWUNqJD/t2qRBQr0Js0NwhHVZaxJ?=
 =?iso-8859-1?Q?5Pfk364Zkjkrcfl1SukZIXiaTx8QpU0br/oDpGw=3D=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB597538A7AFD86B0BDFC27F10807D0@AM6PR04MB5975.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(366004)(39860400002)(136003)(396003)(189003)(199004)(14454004)(4326008)(81166006)(476003)(81156014)(6916009)(25786009)(186003)(2616005)(105586002)(8936002)(102836004)(66066001)(86362001)(71200400001)(3846002)(2501003)(54906003)(71190400001)(68736007)(6116002)(52116002)(6486002)(106356001)(486006)(6436002)(386003)(4744005)(316002)(305945005)(478600001)(50226002)(6506007)(7736002)(5640700003)(8676002)(256004)(6512007)(2906002)(53936002)(26005)(99286004)(44832011)(5660300002)(36756003)(97736004)(2351001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB5975;
 H:AM6PR04MB4215.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HEUw1pc20wkJckWRbB3deUjEg3OMyoESEfkdsE1wkomO0lvFDv5qzqSd9HukhlUl1Ebu4LGP1uhPlToYui161/fJwmgOVJroYyPc+Fw+uX7XYV+JIKO3bHfU5ZqAdqTr7fJ0jLbAfILEQo2ZkBs6T5EzK8+Szk89TZcP/ugpMgR5XuDk1fZLPBkoJE55Kf4ipUE/JwvZ0ppmh3LTuV2TstnBBTA5ou4HmSKYkiOZ1Zgmph13WCh9uwf2kRM03IZrXFrKZssPeHQulUhGwOB708ZnFoMr4ODsdgWLd+myGsxm5zOPf1PG+fGqhifH1Ha19dVgT1MbafC3/flPkQJ0vPzGXxEIGJHUWpLeXWPYdKN2iR7CQCZq5WOTzSXDz25/bPA+H5Q7X0+WuxHTopaeZx0aZ8E0tHN5qqnF6eAj43I=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7bc80a-5846-420e-2e8a-08d697411107
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 14:38:19.9150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5975
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_063827_401535_AF443822 
X-CRM114-Status: UNSURE (   7.98  )
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
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "khilman@kernel.org" <khilman@kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series used to further generalize the driver implementation for
better adding new SCU based platforms. e.g. imx8qm which is mostly the same
as imx8qxp except a minor SS name and resource avaliability difference.
e.g.
QXP has ADMA SS while QM has DMA and Audio SS separately.
So we decouple the SS information from domain names.

Dong Aisheng (3):
  firmware: imx: scu-pd: use bool to set postfix
  firmware: imx: scu-pd: add specifying the base of domain name index
    support
  firmware: imx: scu-pd: decouple the SS information from domain names

 drivers/firmware/imx/scu-pd.c | 121 ++++++++++++++++++++++--------------------
 1 file changed, 64 insertions(+), 57 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
