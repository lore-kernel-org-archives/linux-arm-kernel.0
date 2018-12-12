Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EBFC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:10:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 733D320873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dtWSL1Ee";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TJUfkTPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 733D320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=l0GMwjDBoN9zEFBcTyfOJ2pVKyim/o9GgSUtDGj/2B0=; b=dtWSL1Ee15XUGr
	4aRc+vqCRP0TRjD6RdMTygEmc9bZU6nx2hEAD2oOBBY0F2CMvC4HP3mHfeRwEB+zJj8nyxIRBMcyX
	lVVWWmIDk/G2GIdacrpCJDnnCQ3s/PJD5aUkqcap6WJ9kITUlp9arMJ2/cgPQV89HHOhY/K83TveK
	S5ZGPyGjYpuRwAHZM0l3jNoyHofEx53LdsMw1zWhgONbrK6iG8+EX5JtDaDqTsZtPO8GxQ6XZRKNG
	s3QRBIn/+hL0wIMgBwxcu6h0MvZmxygIp3nPLDtD1LmdudFdR9Rf2JOK0d0S8YQvMYFDTxs3rPDpP
	ffZccnRFx8u9gJMjpFvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWyeo-0002pA-0U; Wed, 12 Dec 2018 07:10:10 +0000
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWyei-0001tG-Oa
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 07:10:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oOqFd2i65LWfVfDOqjHZNarHOAG3riGMNPbQntGwyY=;
 b=TJUfkTPt/Roq9zyyVk7FXwKXK12hbAUUKbcVEEIYpEgRqhLzaagxIClcSVTc9uo/BWYXxIdD5S+S7ZzBKo20GCMTZILHI4UVdEmFCl8DRlWbliqKJDbQ7ycrWvWvcjsW+j1plsLdv+xqhlWB/C+O3+FYVcqvrUe/Z0YDiGb5NRQ=
Received: from HE1PR0402MB3323.eurprd04.prod.outlook.com (10.167.125.20) by
 HE1PR0402MB2811.eurprd04.prod.outlook.com (10.175.29.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Wed, 12 Dec 2018 07:09:49 +0000
Received: from HE1PR0402MB3323.eurprd04.prod.outlook.com
 ([fe80::f95d:89f3:77e0:b668]) by HE1PR0402MB3323.eurprd04.prod.outlook.com
 ([fe80::f95d:89f3:77e0:b668%5]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 07:09:49 +0000
From: Pankaj Bansal <pankaj.bansal@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Shawn Guo <shawnguo@kernel.org>, Leo
 Li <leoyang.li@nxp.com>
Subject: [PATCH 0/3] dts: fsl: lsch2: dts modifications for chassis 2 devices
Thread-Topic: [PATCH 0/3] dts: fsl: lsch2: dts modifications for chassis 2
 devices
Thread-Index: AQHUkemrrSmmDF8VfkyFEGEbCdtxHQ==
Date: Wed, 12 Dec 2018 07:09:49 +0000
Message-ID: <20181212123505.32415-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PN1PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::11) To HE1PR0402MB3323.eurprd04.prod.outlook.com
 (2603:10a6:7:81::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HE1PR0402MB2811;
 6:IK04i37hR9i+pW/APdCHVYeXXlqZYBf85MaZwwKG7FiTGQLqGG1BIb9RBT26zn4f2OBmSm8FIKTH033zIMQTC/p8UORbrE5Wlgsr8113RTqyTdk6uIWxwqgGAcZoOUnRsozGlI8FAT/t/IakPcWzzT4Bn8afWsA1/nxDup/888rjWE7+N24wByBXh5HUzYMSmuHfkQFBGkUdRxiTWwdt7KsYbGu0u8i0Z549mpbDp6vrRvSf6IS7GFxFyTwFeHIbfpQkxwqCShlIlpL4+3exsP0AQLMML0vCU6b/7VguLANv9BYPtchCWJJXyhowKG837uGzLmeMqtLK+YOS5u86DT8cE4ngi9SUtBOIjd/x47pSHTno/Qsfjn3L1d2b/eM8msHq6R2p003YMddd2VaEnSaLBPRBDugCS7ZB59KSddF1sXeH9N2bp31Q2sc8NHP/AD0eQwK0AXaPtgsX+5oZSg==;
 5:MFVjYwHMf36N6GukGsJvfuzPG/Ux4C8TUzaF9JMRBImcJIxuAnUdPX6TuYo+t45bdOwpplAK8oJMmACYzvpe+Ui99zdj0Qr6Ct8xzNx4897YWV5f16BswDpL7LcC6jgal81eab9XYzDk/QARK3pluiHWJUmsYlst8aLZVYnRQZY=;
 7:x/RFLkaYcgZDxAwjj7ktHCkMLoCN/vlx307fd9Aos5AlY7zwOjf0QsuVndwNXAvJUA6ZZOhHmX7WIEe7kiB69NeW56eQhuKXP7yynxBh6j5lbYV+cZe3NWfLPfWvFUB3IUO15IpGhF/FLFSXV0DZCA==
x-ms-office365-filtering-correlation-id: e8179108-829d-44a8-af01-08d66000cdce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR0402MB2811; 
x-ms-traffictypediagnostic: HE1PR0402MB2811:
x-microsoft-antispam-prvs: <HE1PR0402MB28118B48CD0045BCE8F867C5F1A70@HE1PR0402MB2811.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231472)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:HE1PR0402MB2811; BCL:0; PCL:0; RULEID:; SRVR:HE1PR0402MB2811; 
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(346002)(366004)(39860400002)(136003)(189003)(199004)(55236004)(2501003)(81166006)(7736002)(305945005)(14444005)(486006)(66066001)(8936002)(476003)(2616005)(5660300001)(44832011)(81156014)(8676002)(256004)(106356001)(25786009)(105586002)(97736004)(2906002)(52116002)(4326008)(966005)(6486002)(1076002)(6636002)(478600001)(6436002)(6116002)(3846002)(99286004)(110136005)(6306002)(36756003)(316002)(14454004)(54906003)(386003)(6506007)(6512007)(186003)(102836004)(86362001)(26005)(71200400001)(71190400001)(53936002)(78486014)(68736007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR0402MB2811;
 H:HE1PR0402MB3323.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PTGSZNny1XOyC2l1kX1IcblrNRGXj5+2j4O/z7n/camRL0NMZ7XjvsDUr4CAJHOAWVx0pZf1wnUGlpp6Bxq2Y3s9nXAlYeijA9JpJJNzLqg3mCpnTHpbsoFFEBHDby/33zeubF9eGWN7snk0kDt7BGf1/mDUExkAnE/EdRfy+4WzkURSid5moIPA+s7ab9UzchUtVONvsB0J+XbMTyS1+Y9ztFCjWH7SjRv5JYIVCEV5uj2/EjYh2MI+vIZxI5u6wwxp7yfDBM2JX0912Dhk02cINWrWD4zLZgDWOBCYa3zqpQrC6QnVchNVxtHPwhKR
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8179108-829d-44a8-af01-08d66000cdce
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 07:09:49.5359 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2811
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_231004_845388_16A60B02 
X-CRM114-Status: GOOD (  11.25  )
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
 Pankaj Bansal <pankaj.bansal@nxp.com>, Varun Sethi <V.Sethi@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series fixes some issues with the chassis 2 bases dts/dtsi
files.

The reference for patches is as follows:
patch 1 : https://elinux.org/Device_Tree_Linux#disabled_nodes
patch 2 : https://elixir.bootlin.com/linux/v4.19.8/source/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts#L121
patch 3 : https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/common-properties.txt

Cc: Varun Sethi <V.Sethi@nxp.com>

Pankaj Bansal (3):
  dts: arm64: fsl: lsch2: fix status field of serdes controlled devices
  dts: arm64: fsl: lsch2: fix the rgmii phy type
  dts: arm64: fsl: lsch2: Fix the endianness property in nodes

 .../boot/dts/freescale/fsl-ls1043a-qds.dts    | 18 ++++++++++++
 .../boot/dts/freescale/fsl-ls1043a-rdb.dts    | 17 +++++++++++
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  4 +++
 .../boot/dts/freescale/fsl-ls1046a-qds.dts    | 18 ++++++++++++
 .../boot/dts/freescale/fsl-ls1046a-rdb.dts    | 28 +++++++++++++++++--
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |  6 ++--
 .../dts/freescale/qoriq-fman3-0-10g-0.dtsi    |  1 +
 .../dts/freescale/qoriq-fman3-0-10g-1.dtsi    |  1 +
 .../dts/freescale/qoriq-fman3-0-1g-0.dtsi     |  1 +
 .../dts/freescale/qoriq-fman3-0-1g-1.dtsi     |  1 +
 .../dts/freescale/qoriq-fman3-0-1g-2.dtsi     |  1 +
 .../dts/freescale/qoriq-fman3-0-1g-3.dtsi     |  1 +
 .../dts/freescale/qoriq-fman3-0-1g-4.dtsi     |  1 +
 .../dts/freescale/qoriq-fman3-0-1g-5.dtsi     |  1 +
 14 files changed, 95 insertions(+), 4 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
