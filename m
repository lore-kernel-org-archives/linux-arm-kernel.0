Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E49C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:01:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 827A220874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y/27+cSY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MlyWhOLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827A220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=G8pMCOynZ1miVlhV4RxMAopLCHmIE44tpTD80t84S1Q=; b=Y/27+cSYgcALdc
	RfL51JV0pQRk1ZElWL6I6rVB1WgdyFwf7uYHle3LHtZxvX8WdzcM3Aqu+ASo57ovNz8DIndv/02qv
	wwsUmyNMkmS6axuDOWPmXvbJx11vvTUCB6OK4p7DCBLvkwGh5s2C+zQTUXfKajfr1pGLbdCAduRmx
	C6KRAS5JDvTiJyDMkc8WNL7uFZSqvr5IzGMfdGPdj7aY7bJ8IKXIv55lKG2FUWnYUvxMeE6X9VA0P
	Debl8tM8/vR+xs+fjHYMFxZJn5zR96MVItkdSCog0f4b69egpILHvqe30k8BqhmU8hh0Q/lXj/NPT
	5RZtqmWRhA6gEYKabsfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYuOH-0007I0-6m; Mon, 17 Dec 2018 15:01:05 +0000
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYuOB-0007Fd-Pq
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 15:01:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvDY4S7/3T4sBjFcaNA1PSNeAuNfob6ob/y6i+lN5TM=;
 b=MlyWhOLReJ9qZ94fphShADcPMRz7badM5zAtfv6NNSbXQhfVt1J8cRf/GymVQ0drDt7s03GauvFpEP+6aekQqGyMhu3NXpXM0wt7ssB2ar7+cfIcsT9fKnU74pcgqCT1YGSuRe+C+lfCb8qknWgLQk9aowJnnEG5Tzu+lm8fJOk=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB6212.eurprd04.prod.outlook.com (20.179.34.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Mon, 17 Dec 2018 15:00:46 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%6]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 15:00:46 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V5 0/4] arm64: imx: add imx8qxp support
Thread-Topic: [PATCH V5 0/4] arm64: imx: add imx8qxp support
Thread-Index: AQHUlhlKXscGYrfVHUmBEE/Tqx8NFQ==
Date: Mon, 17 Dec 2018 15:00:46 +0000
Message-ID: <1545058517-18643-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::29) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB6212;
 6:h0RDQe0UAWbpK1F2A2e0k5fmah/z6JbhffMXcl1/pe36eWxkDwOPZ1/XkuBr2Wn2zoBco4t/JZTsvHmAKmmEbxGa6LWkUNAReAzegpUdR66CGug4QbtLgJ+gxQKgpgCIQCkNjYgOHHO1sS7e4jj3daKgWjmIIzVItkm2AscRUKKe+FoEEZquApkunCKw4yxHLrydol2GoPMvYLgYNKxflFD5F4OApJabJ13ERifbTmfn3a6Y0RhoH66zp87L2SJCoZETJ0Hr9p/yWZsLThNOziO9lmGLnojmD28fwFGNCYxpmQ6CKLfwAYsrpplBo+LXscGNsR1C9Cw25tDaFR0oJyLn52C7IJs8+RZfiHkE0j2mUxkUaAvwfXh7LxOpXFt2SQafI8Cwz1Y1Tgz2C+LiNSk1NYK4yQaSM15gggTqmODVHBsJa+pPzOmlbXawczrjXR9lPBhvcYcekDx2iexGnA==;
 5:hWZ4i2L1iBeNzSRL+nzdY1CSf7gOH5Iv38IdwK+s2uH/9ygEEiRV4g5eawXEp+lsD1GiXH/g9kmzEcVwpU4KV33krskj19wzzfVTQLkS1YPtuFEWp1JajNbXxaKRy+LSqQz6mcCJ2A10lbrx29ZNKdoMY6HCAXyIwqevYl2Q99o=;
 7:8tt+g+zHDPFwA0cqRJYkNl4iImSpWgBaWahN1iz9NpEqepAeEH69a/i8zpVgiIM4OQzK/zTdIUl7b0qAJm8WnC2weY+8gycaJCffbeDU7boT45S82qO9lA63d7WWa9A4DEV1aMMs+8rKWXQ10e09ww==
x-ms-office365-filtering-correlation-id: 32920db0-05ae-4eaa-817d-08d664306c6b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB6212; 
x-ms-traffictypediagnostic: AM0PR04MB6212:
x-microsoft-antispam-prvs: <AM0PR04MB62129F5E4F2142F16719BFC680BC0@AM0PR04MB6212.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB6212; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB6212; 
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(39860400002)(366004)(136003)(396003)(54534003)(189003)(199004)(2351001)(81166006)(81156014)(6512007)(39060400002)(99286004)(305945005)(6306002)(8676002)(106356001)(8936002)(105586002)(6506007)(386003)(186003)(316002)(2616005)(102836004)(6916009)(26005)(966005)(3846002)(476003)(478600001)(486006)(6486002)(36756003)(44832011)(50226002)(256004)(5660300001)(6116002)(66066001)(5640700003)(25786009)(6436002)(71200400001)(71190400001)(52116002)(54906003)(97736004)(7736002)(2501003)(14454004)(53936002)(2906002)(4326008)(86362001)(68736007)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB6212;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CaZYuVXiqhTFjKVHJDxUutmZzm834GNd4vpTh5/BL2ztIAAzb/tF5hIpeTX3NHu09idohQhQF4VGKxjxawINtdyYfRcf5J4Rj7ojIa3cCfyIdOvgDqrW3KXtJN8wcLge4461BFBtHd/PUl/B+SDwuC9EFnu5dd2YeV4iLk4nlvH3OQATEe6gcsWL6Hd97MSVikYVKcA00Zhi4wR0XZRDDHmFOOpGmuNClgwk2FyI5HnJJcoSDzyijqrSjF7XUdarp92iUeaK28rkyDwUC8BEnGEbk1PywA/HLkv4uGPwhf20azS5xKz+Jf3qNY89/RKJ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32920db0-05ae-4eaa-817d-08d664306c6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 15:00:46.5946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6212
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_070059_835220_E4106F31 
X-CRM114-Status: GOOD (  12.98  )
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
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add imx8qxp mek basic support with the function
Lpuart
uSDHC
FEC
GPIO

Note:
This patch series depends on CLK[1] and PINCTRL[2] and looks like no way
to resolve the dependency, but wait until 4.21-rc1.
[1] https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/log/?h=clk-imx8qxp
[2] pinctrl: imx: add imx8qxp driver
    https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel

ChangeLog:
v4->v5:
 * remove the dependency of SOC_IMX8QXP
 * the original Patch 2 adding SOC_IMX8QXP is dropped
v4:
 * change to new power domain binding suggested by Ulf
 * Note below patches were merged separetely by each SS maintainer,
   so dropped in this seris
   dt-bindings: mmc: fsl-imx-esdhc: add imx8qxp compatible string
   dt-bindings: i2c: i2c-imx-lpi2c: add imx8qxp compatible string
   dt-bindings: spi: lpspi: add imx8qxp compatible string

Dong Aisheng (4):
  dt-bindings: serial: lpuart: add imx8qxp compatible string
  arm64: dts: imx: add imx8qxp support
  arm64: dts: imx: add imx8qxp mek support
  defconfig: arm64: add imx8qxp support

 Documentation/devicetree/bindings/arm/fsl.txt      |   8 +
 .../devicetree/bindings/serial/fsl-lpuart.txt      |   2 +
 arch/arm64/boot/dts/freescale/Makefile             |   1 +
 arch/arm64/boot/dts/freescale/imx8-ca35.dtsi       |  61 +++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts      | 137 +++++++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         | 409 +++++++++++++++++++++
 arch/arm64/configs/defconfig                       |  10 +
 7 files changed, 628 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ca35.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp.dtsi

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
