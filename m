Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E857C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:10:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DED782173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P/RsuvGG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M7qh427I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED782173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=X3gxrNczUpDjVv7UiVDCP0D49ofE7+EO8u6oJERInGU=; b=P/RsuvGGBSw83B
	M+7BClj6I/H5lCMSDAAFn3vPSghV5u+gEJFDXEpXlOleXGkbn0829tkQkfteZ5hiN/xatoRxkY/9B
	9Ghs0Sbn4V5qr5ssduJUAKnFjBnRimz4p7W+tquT/fjZ+mCMcIsowZtLg+fIremy//s/gT8WVk7Bz
	rgFSMl3xn6eA6Urdm4S/qigvqbY1E96ChH080a6M8KPzleHmJp9jRX8+uxvgsqBa7mtYzWZI8scKU
	EpNxRZqTBctbJs3El+fB84fmbF9lqGpbXi4pmzOdU0u6+2CeGJXaPcQKJXSxleSrrB8OWHWT46ZwJ
	Bf5+46qzYMK9GeNCnFJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyZhO-0002wJ-N9; Tue, 26 Feb 2019 10:10:54 +0000
Received: from mail-eopbgr130043.outbound.protection.outlook.com
 ([40.107.13.43] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyZhL-0002vy-WD
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 10:10:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlVW7FuyJL1lviyVJqTIJlyj0gVro3M76EetL/oYmWY=;
 b=M7qh427IEtrWu1UmMpq5tZH+kedKjipO44ivEfGpMY00X5h3SJVIBIgU6iUrGicNJDwp/PXR2h+ZecCqdM6p+r8S9V9Xw5pKt2QmuUdXd8Cw7ue6x9IXDY/EX1YkPP9Oz6op0c43PQcXEaMrslmFo494/ychnmvEseIdGrMN1F8=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 26 Feb 2019 10:10:46 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::7437:2195:ffd3:a33a]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::7437:2195:ffd3:a33a%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 10:10:46 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
To: "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "oss@buserror.net"
 <oss@buserror.net>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "mturquette@baylibre.com"
 <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org"
 <viresh.kumar@linaro.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "linux-kernel-owner@vger.kernel.org"
 <linux-kernel-owner@vger.kernel.org>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de"
 <arnd@arndb.de>, "kstewart@linuxfoundation.org"
 <kstewart@linuxfoundation.org>, "yamada.masahiro@socionext.com"
 <yamada.masahiro@socionext.com>, Leo Li <leoyang.li@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: [PATCH v1 0/4] arm64: dts: NXP: add basic dts file for LX2160A SoC
Thread-Topic: [PATCH v1 0/4] arm64: dts: NXP: add basic dts file for LX2160A
 SoC
Thread-Index: AQHUzbuK+PMriY4fR0+7hv0/i3vTSA==
Date: Tue, 26 Feb 2019 10:10:46 +0000
Message-ID: <1551132245-6089-1-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::21) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:53::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [92.120.1.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49ca1841-ed43-4c9e-7460-08d69bd2ac64
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5726; 
x-ms-traffictypediagnostic: VI1PR04MB5726:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB5726;
 23:wxtVswVupM+N7aScgpBdlWRnNo6O+yCNbEz4qpK?=
 =?iso-8859-1?Q?4Wu7C8+v3uFceocYqKWNIQhOk9adFw0Le+T4yBPtOieqDhXi5WvzKRFPbG?=
 =?iso-8859-1?Q?v0N0td8Z72ErpUpgbhAFYXEXKsM1YG3HgCDRRBHZ4lEXX8t8bR5oIU3q2g?=
 =?iso-8859-1?Q?dDHeHmsLC8L7P/boXJ7vMS4vdHEal2PgyTy4795B29M0WHTpfGJ6xwra+V?=
 =?iso-8859-1?Q?WTcr4f1054SQDRiuijQK8k6OvI+BFr+lUCFvKhj70xJQ5WesYumPExLvxL?=
 =?iso-8859-1?Q?G9A1JK5eqTMP7nZw65re78kxtJVyPgD7vw9pnXICUzz9KYHvdrchx7adFQ?=
 =?iso-8859-1?Q?j8N0wpZ6dgMomdyOcOr8+77a6TWGHE3ExlxLP11ZWv2wUHgzMOkakNxivX?=
 =?iso-8859-1?Q?Uis8hhLc6NRkc3bU9z4XvX9fLQoprJfpZAQa1KY6uRg4cLlurJwNAY7WAB?=
 =?iso-8859-1?Q?S9vjTiZiNsDy1dZeKnDIisbvIN/nZg+J1k9rGJclC+qfw1LcosZf6/9FI9?=
 =?iso-8859-1?Q?wwG6qA8kBwD6yfL7s4uN+naQz8vA+OPkD1RLJib9JSteqv8VIlg/beTX+j?=
 =?iso-8859-1?Q?lWemW6pwgxCKCSrQHWEkAJKOvYTzxQlumGyh53+qpbZzVHLEx9Lf7w1zT+?=
 =?iso-8859-1?Q?0W+2vzvG8ZcDUr18rL8pDVyFpyxc/poRLFvnlOacTSCArSs4ph9nlrRwGS?=
 =?iso-8859-1?Q?lNknJgYqN8ZnRi/8QLTtsZnebA+v/V/f7nI7KGmJUYf0+aAAVsFT9k8Yqn?=
 =?iso-8859-1?Q?NUi6Rx6t/WqZgiPIm8H+KZM+I9nVNMcxOT+Cox0dcNa1LbJHCPYX1DmmXQ?=
 =?iso-8859-1?Q?YM5Nb5NUj2jZcnOv90HlHYPlbbdegQ0efgazGhcTJ1UTssZjcEruaQ04AJ?=
 =?iso-8859-1?Q?waGtaTkWfUZrwPVV0Rb2Xa+mBL59NvLp0JSDnqufkf0TLuFWeZc1pNSX+k?=
 =?iso-8859-1?Q?YoKveuHhWHpNHB/tHJdhGD7ehMExWDdqbbhM5q44i9qzCpXnl/9wVqJbq8?=
 =?iso-8859-1?Q?bzX38alSmfG6y1vRVFBW8Ibf8p4tVjv4gOhTfbIZPA4gqdlNJzgOlBPEuw?=
 =?iso-8859-1?Q?HzVj8j87JDPSyiPuDpYZTlJiWopjCY0xsXSBkWebsjDqGLjiJ/ZDQnP7fw?=
 =?iso-8859-1?Q?ETSrZ9fHLSDiQP/m+6/3hx33RVAvlZiC7jwJQUaJ78jsGuUfgO2fmutI2D?=
 =?iso-8859-1?Q?HtGe40xYkAJtJ6zAMbcuDtSio1jdZKbrMWNR15ASV0KV697SSK6VT2T38m?=
 =?iso-8859-1?Q?oyxFnKpmN1qyMZhJkRWLO54jEaTtB6fkR4cRhS2VfBg58r0SRuvkJSOOn/?=
 =?iso-8859-1?Q?kOmC/oX015ohfUMnS3nWoDjNpYX0slNJdpc/eu5qrTyCKUq+ZkK616UieR?=
 =?iso-8859-1?Q?miZSvhfE=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB5726431276480A216C5BC117F37B0@VI1PR04MB5726.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(6116002)(3846002)(50226002)(4326008)(26005)(99286004)(6506007)(386003)(316002)(54906003)(110136005)(8936002)(8676002)(102836004)(305945005)(36756003)(25786009)(53936002)(6486002)(81156014)(81166006)(478600001)(6436002)(44832011)(2906002)(6512007)(71200400001)(2501003)(6306002)(71190400001)(66066001)(106356001)(105586002)(5660300002)(14454004)(7416002)(97736004)(256004)(14444005)(966005)(68736007)(7736002)(486006)(4744005)(86362001)(2616005)(476003)(2201001)(52116002)(186003)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5726;
 H:VI1PR04MB4800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jhydYefqmPF1docIuJy4/FMk7wful5QpevVEu8sTyqZWreSbLRFrm80X5cOlFX29aCzmtBskpd6kaoPODKyM+GdBbpYaG1i+OwkvOykW+miuLM4K9LQbnN7znqij1Fvf3S+abCz1dzJ835bBl2YVuf+vrUJWfM/yacYAuF5Jl3hKE41NxS/MDnh4K30T6TK0jUcqcWzJzC0mIMzU+LTNuv6j+GR2HH4UHEra0S6KnrBkRbe+9zqK1t8qdTwnwkUMo3QgRgoJTupsDXd19ocm8pYux/nhDzepRNLlw1lNh2bDKdBObDGiYAhP+wXb07hdDtwCuirBFlk9s6Z42fVuEImq5Ua+zn1SfRGumg2fMjaRKjKtGYMUEuZAbqfC1mTnz0AHPgLmHGiCbW/Z/CABbtGoZUVTaXLMFXw0oMJqWG8=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ca1841-ed43-4c9e-7460-08d69bd2ac64
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 10:10:40.7902 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5726
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_021052_037466_DD7A00FF 
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
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 Vabhav Sharma <vabhav.sharma@nxp.com>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

These patches were reviewed and acked but dropped during merge window.
Patchwork link was https://lore.kernel.org/patchwork/cover/1004155/

Changes for v1:
- Updated lx2160a clockgen in alphabetical order

Vabhav Sharma (2):
  dt-bindings: arm64: add compatible for LX2160A
  soc/fsl/guts: Add definition for LX2160A

Yogesh Gaur (2):
  clk: qoriq: increase array size of cmux_to_group
  clk: qoriq: Add clockgen support for lx2160a

 .../bindings/arm/freescale/fsl,layerscape-dcfg.txt       |  2 +-
 Documentation/devicetree/bindings/arm/fsl.txt            | 12 ++++++++++++
 Documentation/devicetree/bindings/clock/qoriq-clock.txt  |  1 +
 drivers/clk/clk-qoriq.c                                  | 16 ++++++++++++++--
 drivers/cpufreq/qoriq-cpufreq.c                          |  1 +
 drivers/soc/fsl/guts.c                                   |  6 ++++++
 6 files changed, 35 insertions(+), 3 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
