Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9B5C3712F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:50:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A5F2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RX9SH8+M";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="evZFChmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A5F2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dTMrwCto2kXP/G+5cpUC1pCXvxcD5h+NHSAI0E9W3y0=; b=RX9SH8+MhC0eUC
	eEEY8LF9rTnkwLH1P+U08ichapMMYTUhKy8z8admvvIVjobDO3IEWJdSgpjfxjjutMsBf6JrPvU+J
	rDSo7Vrl6vcxC+9pZzNxtVWnZ2xMP/h8oVvoa5jFKg/RSy/8eW7/ArJAx9AfBjiRuFPkWdAlPF5k2
	Qx6n5Uts87uFy4Pr6S8dACSzVhkTXtmjcfc1+Ubml2hnfHdPvHsMiuck97XKFpyWPIOdWDpTqN70B
	AbZi2WmyKbBxeVcoLKWtOAn/p5ZHN98BIG2EqQruY97/aMsaZandixca+V9O+rxL0ljxUnaeLPYr0
	9BSSAmebC/IywwkLBy3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gliOR-0006lB-0o; Mon, 21 Jan 2019 22:50:11 +0000
Received: from mail-eopbgr130087.outbound.protection.outlook.com
 ([40.107.13.87] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gliOO-0006Nh-Fc
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 22:50:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7elZ0njTDdw2oNI3hlDAhkS0x3ohz69vk+TzwFBcd2o=;
 b=evZFChmiG2V4gyC4LQJGL6XRq8APcMDvC13VeSl7VC0R3myWXEj03GTipU7JUTrn2E8R2cqrDRCM2wrGWurbNpliH7Hc1Aub8CmJy/vTsrsHHKQ/gDZyrfiDV6EfovLyZGb30XC4krDOQff3Kiu4DbhgxI43vI2e8fOoHQULnRM=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB5983.eurprd04.prod.outlook.com (20.178.123.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Mon, 21 Jan 2019 22:50:03 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::92d:bf44:9c1d:b907]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::92d:bf44:9c1d:b907%6]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 22:50:03 +0000
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Lukas F . Hartmann"
 <lukas@mntmn.com>, Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 0/2] PCI: imx: imx6_pcie_attach_pd
Thread-Topic: [PATCH 0/2] PCI: imx: imx6_pcie_attach_pd
Thread-Index: AQHUsdul4u42yyl+Nk+tlCvq1YG46g==
Date: Mon, 21 Jan 2019 22:50:03 +0000
Message-ID: <cover.1548110502.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM5PR0701CA0051.eurprd07.prod.outlook.com
 (2603:10a6:203:2::13) To VI1PR04MB5533.eurprd04.prod.outlook.com
 (2603:10a6:803:d2::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5983;
 6:ESeplKXhh3PLWs/qeFSSAACFlNLzMmJOTw7CaMLFPIai80SddCpWVX8zVUBasDVfcWSfcJw9TKVvppTMScCQfpdR0RdC1F52ckOcNYUTphL3c8ckGXwq0a0mZWzqwhbuKns6O3Q407Fxq7awuUVIaKE9xprN5PDLE0NXOv0Nm+D4r6if1rPYn6XcVqPFUmqd/CWPAcvxxjDvAkk9sLDzeOg7A4AdUbrW7eVNH/zb4S0n6sRg+tpdlWgKfhYArdeM3Md0mrWTip+ZqusLS918KbXcv6wVwi8T2X185CG2wwgfPcd2dqw2+u/a61BU7UQHspv1If7/41lYSBnF3G71Mb0sUiYi7tI8UpqEGBpkx6fYeOHeiG2J2MAcN0wvmfl6RyY0y9YcaCr+yp94JbY7vhghv0gd1a95dzd9ahYCg8SPd4MjuhrASXC6r/sGwzvVgMxCrLTThYtSEZE94OOeJQ==;
 5:x74/wgnpRQgDv89QqUf+mBITL6K2LflfAsWN9ckVEqypGjhfkGsCLWUChbG2Nmn9fd9LGGRV+2OrYfGqTngbPWkBkBatB5yhI3s1i5E8d2Efj5QXhedw806P8zxMhjq9HSmYilYs5FjuWm+4b+cITbq8zbnNJ4z3n10nHZHBX/HqBK4mTWf7PwbQDk4RjjeZZRaxWpsMqcwu1oSbFPjLhw==;
 7:ybJRcdirm4bTUMmvZe+NmpBNVldjJBS+NYJFtEGOBJQ13HWWgLi2qOHnORWpxV20Zc+aKRignlYNYdTUbvA3XEqMxth+n48pXh3zBX1ASGqZIcJLGSvbx6xpdVM70ttDP8BuEnZHFFsCbewASzXbfg==
x-ms-office365-filtering-correlation-id: 4946f833-1ed9-4d10-01c0-08d67ff2c7a5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5983; 
x-ms-traffictypediagnostic: VI1PR04MB5983:
x-microsoft-antispam-prvs: <VI1PR04MB598382BC47F6AF00BF0F7354EE9F0@VI1PR04MB5983.eurprd04.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(4326008)(99286004)(478600001)(71190400001)(71200400001)(14444005)(256004)(52116002)(68736007)(6436002)(25786009)(6486002)(386003)(106356001)(53936002)(4744005)(66066001)(50226002)(6506007)(36756003)(186003)(97736004)(102836004)(26005)(8676002)(305945005)(54906003)(6512007)(8936002)(486006)(316002)(44832011)(6116002)(110136005)(476003)(86362001)(2616005)(14454004)(2906002)(3846002)(81166006)(81156014)(7736002)(105586002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5983;
 H:VI1PR04MB5533.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cJp1vRXvlKwOCwTKIabksSoRl25aWvjfCWK1fCQitAG7IURWLn1CWackQnAIVDGIY71CCubperRZm2INGily68IbH0iR1DV2ZAmq0U5E9cZG3m+irmpl/3LD47/eH0VSe9enbe3cgiWYVoGKmhwQNKGyqNGAxkN90iJWHrzSy0GS3DrHRobPF1TOGn2Wlz7SU/sFN/U9l7XEx1EuqP/rQB1ZH2bLANBFTrXVmHVLjnqLWPF7L5ZGxOG8Dqr0E0ZlztIW7oa1jebAeE6XXKJT0347vEph3ZbSgSdH7FEr6tw107Gr9z1kP7FmNV++v2L3jqxr2wudAz9gwCpgCAWnivQgaCg9hso4jhb3FEUkIHqe4h8SqsvvFpiB6VS4+w+QQAC2Q+tU+oYX4cWXzKlP5qJ3OX+eAy/i/9uVn1DOvbQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4946f833-1ed9-4d10-01c0-08d67ff2c7a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 22:50:02.0671 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5983
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_145008_586182_89BE8AD2 
X-CRM114-Status: UNSURE (   7.99  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Richard Zhu <hongxing.zhu@nxp.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This fixes pci probing on imx6qp as reported by Lukas Hartmann.

The second patch fixes a check that shouldn't actually fail.

Leonard Crestez (2):
  PCI: imx: Fix probe failure without power domain
  PCI: imx: Fix checking pd_pcie_phy device_link

 drivers/pci/controller/dwc/pci-imx6.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
