Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA3BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:23:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601ED20815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TWRFjB2t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sVd65Fb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601ED20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=i50KabWOzJA4oc0Fu5eOflisTsNenDPp8KeQ99h8utU=; b=TWRFjB2tlkyUvB
	8FTiwBorDbsvuw39lKqkPVlydgbO7dzQM1GU6GghzbeZCFjgudkg0fwKKKzMAcmJVmPMkV/buhH5y
	5NeguwYwbWvaI8bPS3GfhTImvCMxoffs9D0BH4FhiHJq+KQA3SA7cv2W4CM9B9byez1wixlNr5kPK
	Gj+vhNNoUwS4nNU1DohFdhcyJNSHnIZSJRJxGBwq9rMt2dxTvh0cccVHlDjaDD8PmI1tEVw7R9U/B
	hCe5eMPEOjEalr8jQaZgZ562Uv4t58fRqN7DrhV28WqlMmI2Jn2wIfmR2b5qH2NX+vxM5+PM3NfbC
	vuRnfVKtz13C0I8HhcKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHD8-0003rF-6y; Tue, 18 Dec 2018 15:23:06 +0000
Received: from mail-eopbgr130070.outbound.protection.outlook.com
 ([40.107.13.70] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZHD4-0003pt-TB
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:23:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZ1G3i+y3ZnRCwiDU+Zz98/CEhW2IVFgxGGTLz/9jPU=;
 b=sVd65Fb/17wiFbwxS4G+JTFNX48E/XIab9dPhPIS5ssRyUjNkkDapagcvII6bDPloOihl1uiY2hAz2RmtelWNkSjjtcUUR1Ha6rezvRYEbKKq7c9WfuzdThWmrFi481aJZ9ydSM70OkLFEd1pB8wrqqonb85s4ra9FRlNRUtooQ=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4819.eurprd04.prod.outlook.com (20.176.215.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Tue, 18 Dec 2018 15:22:49 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%6]) with mapi id 15.20.1425.023; Tue, 18 Dec 2018
 15:22:49 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: [PATCH 0/2] pinctrl: imx: add imx8qm pinctrl support
Thread-Topic: [PATCH 0/2] pinctrl: imx: add imx8qm pinctrl support
Thread-Index: AQHUluWJu0BW63xMXE+AmBGV971Ftg==
Date: Tue, 18 Dec 2018 15:22:49 +0000
Message-ID: <1545146239-30993-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::15) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4819;
 6:GBV6XDw8hhUpMDKCi2FxfN4uwvYZ5GRHqRmodJrFfrT+GSV7GVzlt3M3+uBipo69mdRHgpA8O4hHtHz8nUJFHl2HOhYvUVjIxYT2PsYvISEJkeft5JwecTmnsv1Kae9njhNDr7ZsHpYu5uVAY52SKUl2jIn635X6A3RzuVXasqdETPqXPdayh9rec3IGUQofjsOD8B0EPetjGR//9K0lBsG9UzBsS4iqiOE1k26IXc0OKEfpVrKBwC8KVk9/MdsdVpGmF2kdoKqW6guFirr8XFxCMWghtewACtf9YSNE7XKuJTfzQRcz2cZYqlBKeqrB6UrYA/R54KwHJDh9aLlgR+acebEXIJZSlrxwNAjQUuL4VEhg16Db3EaEfw0y2CitMcX86z6NyOkL54Bf8pGTuZeQWoqD6nZrbT+JSaj+27xb2dH+aOuW+9d+SWKrnFQHncett4po82mjQcTrjad+aQ==;
 5:Xael1uZPV3ErNR7FwuQmXhjx3HuyXMNioZKPWB3R24ASNdraEILzOjB7gTkZjY64CK0yiPer510b2NBxgv2dSJrqUzyNfXJSgOfZhMugmWgvuRICspa9n1CgN4wbzDTV2siTZ7ItirgJsYXmYX/cQ8RQxvfBqHgLeylinnD/pRs=;
 7:7JTllVygUIdjqGMzSeBA/cuYSDP6Witp7WG6KwvumusZfftqiNFUHpwJt16Q0Q4Hx6tREzFrv1zPsFln94tGuB/YHm7y9nQApfngbWyugS7cYpV+3b9quNpikMA6rBrE68szgFrk8WjVxc08MYXmOA==
x-ms-office365-filtering-correlation-id: ad0b6e3b-06f8-4a25-9bf9-08d664fcab5f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4819; 
x-ms-traffictypediagnostic: AM0PR04MB4819:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-microsoft-antispam-prvs: <AM0PR04MB4819DC84BBA9945AAAD1019480BD0@AM0PR04MB4819.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4819; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4819; 
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(346002)(376002)(366004)(136003)(39860400002)(189003)(199004)(81156014)(105586002)(81166006)(86362001)(6512007)(26005)(53936002)(2351001)(6116002)(8676002)(50226002)(97736004)(3846002)(54906003)(316002)(36756003)(486006)(2906002)(6916009)(476003)(5640700003)(68736007)(8936002)(44832011)(2616005)(5660300001)(71200400001)(14444005)(14454004)(25786009)(478600001)(52116002)(2501003)(305945005)(99286004)(66066001)(6436002)(102836004)(4326008)(386003)(71190400001)(6506007)(256004)(186003)(6486002)(106356001)(39060400002)(7736002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4819;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ClFHPudKS59Hzigefebvytbk2IyLWsDj2gIs8xu7QHhhleoM4Qr8fIlwjy5m8QcBM3W/dlMVTzsm1MtwOx5Ej3ac/9Aftc+Xw4v4xb6JRgd4b3/J93xrYNdQG9zErFLqFwdB5pnaDLSkv1+SRpNMJGCRKGLXYi9lp+thfDsm0l3ChNuAzdMXCVcuMBoOiLV3STfZ3WwolZ1v/09ubG8LmczMa7F/bCJ3v2iXLbIbYIgJMjhMOkNyBnNBZyzrSj9/AUKBIO10bJgxoQzgkpMUqCOB8iuIcPaxJ28MwmDeqt40ZOtgE74GN2960nL0H3qL
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0b6e3b-06f8-4a25-9bf9-08d664fcab5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 15:22:49.7647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4819
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_072303_007051_7DC26F53 
X-CRM114-Status: GOOD (  11.89  )
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
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "stefan@agner.ch" <stefan@agner.ch>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series adds i.MX8QM pinctrl support which is based on
the pad service provided by SCU firmware.

Dong Aisheng (2):
  dt-bindings: arm: fsl-scu: add imx8qm pinctrl support
  pinctrl: imx: add imx8qm driver

 .../devicetree/bindings/arm/freescale/fsl,scu.txt  |   5 +-
 drivers/pinctrl/freescale/Kconfig                  |   7 +
 drivers/pinctrl/freescale/Makefile                 |   1 +
 drivers/pinctrl/freescale/pinctrl-imx8qm.c         | 326 +++++++
 include/dt-bindings/pinctrl/pads-imx8qm.h          | 960 +++++++++++++++++++++
 5 files changed, 1298 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pinctrl/freescale/pinctrl-imx8qm.c
 create mode 100644 include/dt-bindings/pinctrl/pads-imx8qm.h

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
