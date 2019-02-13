Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D26C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:13:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF811218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W5i2ffwN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="szyYqyKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF811218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lo0Jgi/K1glPsrAdK14u6ZYp3dz5gjjI6OFjqOZXbJM=; b=W5i2ffwNeYaH9V
	7UE0ldzol8vjncHvPJqgiz1NUoT1LMB7fMCuhwt/dbQVt/B9VpDmv/VD7ojsMSZbjsH1AyQA3cqBS
	meSSAJoVqTK9w5JACq5pyIpxIDHHDwpX96IpHwcAe1o1A2OmhNcO/toMHl7/9PTApql9PlwIJgcZz
	Klh3PPiPsgXNMWivhKUTb7g1/rsM0Pr2zdup+2jVz3nkFMDsfP8BMYcNNz4v7/iRJpCc5YXcr2m+d
	DewaA9cjkuc/24hoNtmRYOcc7YHC7nyJsoe1OTQsFwGgSwYcvk+uhV4MfOpu/Z+rVdO387G581O47
	2DKaFlI90GLDAJ2rX4Zg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtz23-0005Pf-Ee; Wed, 13 Feb 2019 18:13:15 +0000
Received: from mail-eopbgr30044.outbound.protection.outlook.com ([40.107.3.44]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtz1T-0004dy-EL
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 18:12:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWTPLNbtuf/9VNzWLUjQaPgfR6KNSczRH6WDkiy1Zt4=;
 b=szyYqyKeOOWzwYzXvq3oWreZMmS/DCYCEOVAoN48y9dAM46ays4Cngheh1LhcRg4cVzmPt2sagQ/O6ODDhSuwIzY1Nl1gWdlJyqPVyzXbv7vGPVCwaf1b2/6V3qcUa27VXz6hJGiJFOS8CRW9xrN3pOz9XROg9fY7aTh4m1D/Uc=
Received: from VI1PR04MB4910.eurprd04.prod.outlook.com (20.177.49.159) by
 VI1PR04MB6223.eurprd04.prod.outlook.com (20.179.26.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 18:12:36 +0000
Received: from VI1PR04MB4910.eurprd04.prod.outlook.com
 ([fe80::6cc7:b375:76f7:b849]) by VI1PR04MB4910.eurprd04.prod.outlook.com
 ([fe80::6cc7:b375:76f7:b849%5]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 18:12:35 +0000
From: Frank Li <frank.li@nxp.com>
To: "mark.rutland@arm.com" <mark.rutland@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 dl-linux-imx <linux-imx@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "lznuaa@gmail.com" <lznuaa@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V3 4/4] MAINTAINERS: Added imx DDR performonitor driver
 maintainer information
Thread-Topic: [PATCH V3 4/4] MAINTAINERS: Added imx DDR performonitor driver
 maintainer information
Thread-Index: AQHUw8eyMhn1qIna7EuJ3Yf6EED4fg==
Date: Wed, 13 Feb 2019 18:12:35 +0000
Message-ID: <1550081533-25000-4-git-send-email-Frank.Li@nxp.com>
References: <1550081533-25000-1-git-send-email-Frank.Li@nxp.com>
In-Reply-To: <1550081533-25000-1-git-send-email-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:805:3e::49) To VI1PR04MB4910.eurprd04.prod.outlook.com
 (2603:10a6:803:56::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=frank.li@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.5.2
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11580771-0bac-4bb6-8ef5-08d691ded4a4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB6223; 
x-ms-traffictypediagnostic: VI1PR04MB6223:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB6223;
 23:6hw6V8O+YkKNm7iM8J+JgHi21paLVbLhIiCrdiL?=
 =?iso-8859-1?Q?V4WhEoPaN788bw23tfskGCIflSj8UHQ9JDBHQOfERfy09bdJG3yjTJs+Wy?=
 =?iso-8859-1?Q?Lswrfz1SNJXeZjYQtRVoFIr8+9bImZcTGLgb+yArOK5nNn0i1d4wUKUzXT?=
 =?iso-8859-1?Q?r22kewMaJYkeLxS3zJhW2c06yo01htBd5bOJdUiA8cGrOp6NJlRzlhoNz8?=
 =?iso-8859-1?Q?v8l04j8cpndQF5pFAGKaJYLbe2i/SQR1FnY0qpu7l7V6kZksjj5zT0PB1j?=
 =?iso-8859-1?Q?eABHb8hv3Rr704t39imN6bWpNzzsGoVhLAU7++MHkn6nESoMlYYmABcMxD?=
 =?iso-8859-1?Q?TBHQb8NJX9zyYA90QxH3yoAkl+GHT547Kz7/d/BwHxnlwbRhYSmGUYIQqn?=
 =?iso-8859-1?Q?HvVSb0oq4mQzHjGn1vbqD38qjgqj0ZXIoHnmMjfqF02asN+QfttCUM8hO3?=
 =?iso-8859-1?Q?eca9Tbzbz/8Oy7/v89SUuxrWNlUQT8Rxt+IJV0/CkrJrrPehbgHQlnpPZ2?=
 =?iso-8859-1?Q?rD4lI20AMn0liDCb4Hec4pTfYc4gFeKPki9CPrkocvCkl90UmlGFmMuRun?=
 =?iso-8859-1?Q?WRdYRWtHZHR9nIkRt8TItdt1qgDHeAj5EW+l+HZHwfCOT+68x3jKi58g16?=
 =?iso-8859-1?Q?jtrI2nkrKylH27cr9CEDXidCoEI1Tcp/kCVRk4Szf1pg8pM1w4uPqop6BK?=
 =?iso-8859-1?Q?3WorZ+tKOK0yrkhmWkwha09RyfE7qvjpp4tlqt+1cbM2svblujaDtGd3Fw?=
 =?iso-8859-1?Q?DSN6iAj6+Adyg0NqdH3gTznc3JpbH0AN1+ndZYP3Vt3JiNPchxQstpl+Fd?=
 =?iso-8859-1?Q?lRQ+NrDLcmX5eWwG0BXD+uy5NmLDT9+Kk5UqPb7j2lvVGQBYYQqZY+HFEt?=
 =?iso-8859-1?Q?/qPCyn8zyhFDs6dFI6n26Wq4+S4f2kbk3A8YXxdf4VrMa79tOpIiFIkVFO?=
 =?iso-8859-1?Q?JB2uwnroQrOsGKAVqaTNz9TJvk5Anlm7VcHQGrn5M4FvA4OrJxZ2XmOrbW?=
 =?iso-8859-1?Q?pO+Y7htuFLCUen+Opc4EXL+YgAWIpYlP3brsBAiXMrZKyZyHHijNO6KwNn?=
 =?iso-8859-1?Q?EhleCvDFmo3VA+D8QlLAOOWGzap64ls4iu0ikCxD4giUWJFZ0AYnSGMI4T?=
 =?iso-8859-1?Q?5/8C0zb2yzpS9gGHK3Njlp2FnrMip/j76m9la/E3U7hbdPYC9ywOQ2OuLX?=
 =?iso-8859-1?Q?muM5JwsRY1M84I/oVkuN458gT5ghFDN2/JxX9lMIvqndrHwPSF+mwu4y4O?=
 =?iso-8859-1?Q?v+cJtPCIKqotzwkceU9a4EPIzXZjZR95cbygZ2ZIkiieB5f6xduQYflRNy?=
 =?iso-8859-1?Q?rI=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB6223187C16B57C96C10DF04388660@VI1PR04MB6223.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(376002)(346002)(366004)(39860400002)(199004)(189003)(6436002)(2616005)(66066001)(76176011)(52116002)(2906002)(99286004)(6486002)(386003)(478600001)(102836004)(256004)(26005)(186003)(53936002)(6506007)(7416002)(36756003)(2501003)(110136005)(316002)(476003)(486006)(68736007)(446003)(6512007)(11346002)(105586002)(14454004)(4744005)(106356001)(86362001)(25786009)(2201001)(50226002)(8936002)(71190400001)(71200400001)(4326008)(305945005)(7736002)(8676002)(97736004)(81156014)(6116002)(81166006)(3846002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB6223;
 H:VI1PR04MB4910.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iEbjFnXoN0HDHE18kN++qXuexpx5VW2FXKk6pgBfd9giFcOx/zfxUCNIXtgjZfiVoA5HT5XoL+SNvY34I0pnQwm95pcU5mez1bbWNMPtZB6w5/goieuUgQYpRYQEPYoscHroYnktDgoA5LFgHaTOAFBmgwutRnn4AYBBoydswg2LDZJxBeLZ8RUhc9ApkOqk3n74iEaMWerPWXyDAFvCyOl7dlaNVLsardL852ywRNBwZEw+sDRr7c0cVUSWoGV6EfpW1e+7Vi7oX2AwDVjDElz251ttbEKUqNqcgHp4+D3U5JORd/nvVXz2MJJjqWVROatvlbgooLm0rm9AH/TTiI8r5T4DTkLEwUzliUDtZx9sUAoe7JAciM7mf0hbCos0jEx50DkrBSTGTZQpjp7dLfe+SZCnPXFMJpzkAoY7eZw=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11580771-0bac-4bb6-8ef5-08d691ded4a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 18:12:33.4710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6223
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_101239_680930_D9DB846E 
X-CRM114-Status: UNSURE (   8.29  )
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
Cc: Frank Li <frank.li@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add DDR perf counter driver maintainer information

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
No change from v1 to v3

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ba068e..687be0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6163,6 +6163,13 @@ L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/busses/i2c-cpm.c
 
+FREESCALE IMX DDR Performance Monitor DRIVER
+M:	Frank Li <Frank.li@nxp.com>
+L:	linux-arm-kernel@lists.infradead.org
+S:	Maintained
+F:	drivers/perf/fsl_imx8_ddr_perf.c
+F:	Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
+
 FREESCALE IMX LPI2C DRIVER
 M:	Dong Aisheng <aisheng.dong@nxp.com>
 L:	linux-i2c@vger.kernel.org
-- 
2.5.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
