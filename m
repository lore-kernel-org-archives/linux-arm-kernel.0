Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C25C10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:26:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 530B420663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jw+b2d4+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g+L2oL6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530B420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=q+IVTZCTBl0pNpRncGkJOHF6GvOBlLnBHdpG81DTCq0=; b=jw+b2d4+2Vt0yr
	ydYGbn8haHFeoWJINHRzVRqVLQ53/fDBxtlStsB0B8GvX0t170ij4cRlCuYQEtokFd9pGI6852V6p
	e8pYgR+E5bCH0mDr3ZW+xap2iUYrBdRVmZXH32IR1LIou12ijUUjtOw4fOrtclq1crhVgAEso6Txx
	wbkj9Iox7zUtoHADHSFfYRiE6Co1sXOSSXqpPVm51X2vAq1nGCafXo32MjDgWL1NR4UOYsXa+tUsU
	m9LlQDzFAQrHZdF49XUwp4EEyNNC8kBnLFNV2naJlUCJTUiXhE3z2VjNmPO/v6zxQNsOz12lYYJkb
	+YdijifnRnme2vcdg9uA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyGHK-00041G-Nj; Mon, 25 Feb 2019 13:26:42 +0000
Received: from mail-eopbgr10056.outbound.protection.outlook.com ([40.107.1.56]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyGHH-00040W-Qd
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 13:26:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKadJ+iD/ToyauEJTz8cocyYqyi6xtzZym9twgqe/fQ=;
 b=g+L2oL6EuiR9eYJRM7CZYuwXt+/SQnP5twiBzMkzj1/cPNIiAIX36SqgccWiPWe/9duLzZFZntqf8d6JMqW186svAqn+RQvj3YjMlRU7RLL8D08BB2GO+oF7YP3Ho3e5EQuwL+IBVDtTNG409gz9j3CzddHLxj370slbbtYk0Ag=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Mon, 25 Feb 2019 13:26:35 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 13:26:35 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: [PATCH 0/5 v2] Enable wm8524 on i.MX8MQ
Thread-Topic: [PATCH 0/5 v2] Enable wm8524 on i.MX8MQ
Thread-Index: AQHUzQ26g2/RbCa+RUmAu9r826fqhQ==
Date: Mon, 25 Feb 2019 13:26:35 +0000
Message-ID: <20190225132617.10987-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0192.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::22) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f7efc81-9cb3-4330-ae05-08d69b24dd02
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3485; 
x-ms-traffictypediagnostic: VI1PR0402MB3485:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR0402MB3485;
 23:PXuYnhY5DY1z5X4QS6Qft41iuYvZpK45VuL2F?=
 =?iso-8859-1?Q?Vm/BXZOr9SEb65nBJPrI8ZM9hVUcy5iPeOv/Kf3wLKTe8iY53znD67ibE5?=
 =?iso-8859-1?Q?IVwlAQHX9HM2U5xMpcln9YzBvLniMwDDt2IkLaKueoOxZJ/QoVpgSd5M19?=
 =?iso-8859-1?Q?YDZ788JgXy1vVvgCI1KIDvY+3uB8M9+hepZGb+uaCtvm5m3L7HwMaIKB9Z?=
 =?iso-8859-1?Q?7k3qLqSgBlYTC8zlCQGWncDSVl1LU2U3fjv9GiMuLXZRckEwv+iMW6SFGB?=
 =?iso-8859-1?Q?TYnzKV7PwIP+DewrjDg17D6Y0blhAkjLjguiZqhFrrMBlnWDb/8ByviUFc?=
 =?iso-8859-1?Q?BptgIXIuztAPLlT0Ddanb8nutz4UqVU8NBTyt+GzjQwYvRg93HhNn0Qfru?=
 =?iso-8859-1?Q?9cEgn1SkHkgmRn6j1DYiX9W8z1kf2y27ta4+DpQcPvhgAwfxW+BppeLLxO?=
 =?iso-8859-1?Q?bHXV/W2PgeldCRD63eETOAxKGIJr3P6OsY/du0r9/f6lNP5RYO7EdI6EQn?=
 =?iso-8859-1?Q?7YQQEAmZrzBEfcbSv/ngpy3g2hCz4dMfmBY+JEcIMIisfCbMUWAo1YCF1p?=
 =?iso-8859-1?Q?GTNJWiwm7WCAfJOC8vyzlmu/Ww4Cqi68DDAInxRZH889rIttx6IWEQyGtO?=
 =?iso-8859-1?Q?B4Jrpt0T9Kk0WNrgHPK+ExzOnz+gxpbB5rWgoqjnRiZRRQLlLdH4DXV6MV?=
 =?iso-8859-1?Q?6cj8KydvtS6djR7LPpMd1AZr2uIzUZUddGhE9rF1To3alKgIF1LFqKZm/C?=
 =?iso-8859-1?Q?FmvwAXqdqJJmPkMf6yaiBLMiFIDnu95gcDmFMAg26DK3wo2bUOHFFgvh6X?=
 =?iso-8859-1?Q?QdRLn0nFOBXBo8V52x29h24F0UqoicFkeFoXxZxesScKcRkePNYf2Qx7fF?=
 =?iso-8859-1?Q?8RYCOW5TZ/ksptdqjQGwrULZefyirjt7eBAGvzXExOM9smf0P6VVOGak29?=
 =?iso-8859-1?Q?tqrGUm26bWI/FQvL30VM5RuWKO1N/boPQP5XWItWpkVYH/jlEGEOQo4C6t?=
 =?iso-8859-1?Q?wrfZBP9d4oQ8eGlk9azFKFluR+uQAMGsawYHy/qQQYCcSPB6LmFyxOKxO1?=
 =?iso-8859-1?Q?Le0rGdafGJaJMTcjOq9Wtn8dBI6IEcyNXB3qTWfXnxVrcrJsKLiARtlIwP?=
 =?iso-8859-1?Q?SQP3nvL+2EDKE/3VnneWNbrUtA6Q/rue1upvOX79cgyVY4UwuxiJLjKUl2?=
 =?iso-8859-1?Q?MUj40zGpYvR+RUt5CMrbHFaXHsC4K2lcayih6Xky4Y6H4OQZnlXh964JdE?=
 =?iso-8859-1?Q?LCVX4c+McvGMtAjlY8wE/SnEJycsniDQZsx2DDob/6dOIwYi0xxim9ZGvd?=
 =?iso-8859-1?Q?kqmZtmPr2J11lBOwiPkosMKgWarG2oqUgdB3imcuEGJklS0oPLDLOjTOBf?=
 =?iso-8859-1?Q?IaABSIyu5Q=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB348516F8A41795ECACBDF3D6F97A0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39860400002)(199004)(189003)(6116002)(105586002)(106356001)(5660300002)(81166006)(71190400001)(81156014)(2351001)(97736004)(1730700003)(71200400001)(66066001)(478600001)(8676002)(14444005)(2906002)(3846002)(305945005)(86362001)(14454004)(7416002)(7736002)(6486002)(6436002)(316002)(5640700003)(6916009)(6512007)(36756003)(256004)(26005)(476003)(54906003)(4744005)(4326008)(486006)(2501003)(50226002)(68736007)(44832011)(99286004)(52116002)(2616005)(1076003)(8936002)(53936002)(102836004)(386003)(6506007)(186003)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3485;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZRjSCEMViEP7rD5u4QzrUgn9k9KPTd+CImpyFwDXesxk1bBMkBDnRhu/q+srzvbuZZeSWm33zS0VvRA+tpyan8HFX5ANTD57WtT9N21b5+sDhz+MUCVgK0QnQV88+H5djqwaE6+aZBw8S3WufzajGILUQ31QLP67KJ1L4ojg4MdaM64zdjdDiASXDoQTmD+34tOsttdUXAyDfEhxm2nXQOncaqD5QCFmlOiywyIuEgY4QhJRlc3gHheDb8IGxbt1uMjzwg+dxk3uIvWkZW49R1HnAzobViAvxwXIOlr63CsgYANJVvm4U2IFM5lS/llAmi723P/+QH3oh0F/7aHeHWf7R5jfG0FM3lJrK5WW/ecW4jxb9UrGd5Kt5Xo9Zw8xlhasuaPnAHBqmt0HimUI12m2YeOMVhjtdDZC73v31n4=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7efc81-9cb3-4330-ae05-08d69b24dd02
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 13:26:34.0806 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3485
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_052639_863777_4CF49758 
X-CRM114-Status: UNSURE (   9.34  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "baruch@tkos.co.il" <baruch@tkos.co.il>, Abel Vesa <abel.vesa@nxp.com>,
 "ccaione@baylibre.com" <ccaione@baylibre.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
 "angus@akkea.ca" <angus@akkea.ca>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Aisheng Dong <aisheng.dong@nxp.com>, "agx@sigxcpu.org" <agx@sigxcpu.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On i.MX8MQ we can start the party using the wm8524 codec
which gets it's data through the SAI2 interface.

In order to make it work this patch series enables the SDMA nodes,
sets the correct pinctrl configuration and uses the simple card
machine driver to put everything together.

Changes since v1:
	- added cover letter
	- remove "fsl,imx8mq-sdma" compatible for sdma.

Daniel Baluta (5):
  arm64: dts: imx8mq: Add SDMA nodes
  arm64: dts: imx8mq: Add SAI2 node
  arm64: dts: imx8qm: Add SAI pinctrl configuration
  arm64: dts: imx8qm: Enable SAI2 for wm8524 codec
  arm64: dts: imx8qm: Enable wm8524 codec

 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 48 ++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 38 ++++++++++++++++
 2 files changed, 86 insertions(+)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
