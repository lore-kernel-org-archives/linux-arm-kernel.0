Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55BDC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:02:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86EF22075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LAf+eHWD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kN4u46C+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EF22075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=DiSgJpzmsSpXy9asO1uDsg6r0o2mB6/oPY2ROPCpFNI=; b=LAf+eHWDtQR2s7
	oe3d+TbNV9pJB5OBuSkGZErwHfE16yxXohKbTMgt/LSSrDsyB77/8G/Bi6eQx8oiFA+Br5p/lpB4X
	38xXOMATXbApMZHb20sbLTP/EUvRQi7HpdB1AMXNhACdIr2byJqwiswET4ZIQN51gCzYYm5QY580Z
	xtxkNpdkvPanVYZvfj1zXBKhNIQWN6qckyiGzLNZxyCBi5GHc6DsmfoVEAe5ai11cDCEB/2MD5Wiw
	N63GRQJkZaSf8lac3RK7ZVmEfTFrCtDcndpYMNSS2qtSxvzojfo+nsKMm+sLBhAw6+hy/3Qr77wIO
	aZWzTNEWAMkFRTd6XzTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXLx4-0005W9-FO; Thu, 13 Dec 2018 08:02:34 +0000
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXLwv-0005Kw-2k
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 08:02:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJZjyU6ccTOZSxHhgeSPBJR+RPXSb4uuoAnZi2HyBRU=;
 b=kN4u46C+kaBVZiUNGVuSaQbDIhqEvTT6kaV5Pbqexnx+NZF914dujGsWo8SD+350DpFD4XCThsSuF7yW37k7JtzpE8sPvOt3agP/DcEiStr6L5V5YtC96bN1ow6uDAou6sYj+Bzn82TS9lmOufcdaXXKV2m4hmD4PWZPeO3vg9w=
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com (52.133.46.11) by
 AM0PR0402MB3890.eurprd04.prod.outlook.com (52.133.39.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.23; Thu, 13 Dec 2018 08:02:12 +0000
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::94f8:5fdd:f384:8af8]) by AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::94f8:5fdd:f384:8af8%8]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 08:02:12 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>, "lorenzo.pieralisi@arm.com"
 <lorenzo.pieralisi@arm.com>, "l.stach@pengutronix.de"
 <l.stach@pengutronix.de>, "andrew.smirnov@gmail.com"
 <andrew.smirnov@gmail.com>
Subject: [v2] PCI: imx: make msi work without pcieportbus
Thread-Topic: [v2] PCI: imx: make msi work without pcieportbus
Thread-Index: AQHUkron3jfJ309qkk6cQky/juy8wQ==
Date: Thu, 13 Dec 2018 08:02:11 +0000
Message-ID: <1544687042-16595-1-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:202:16::17) To AM0PR0402MB3570.eurprd04.prod.outlook.com
 (2603:10a6:208:1c::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hongxing.zhu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR0402MB3890;
 6:pNxNXvfZwQTQ4HRVQBdpa1KMy8CxxyuFrUeThBw29Q5E3qtYrONxtlnRbfD26wco1uRLSSmHndK7pvS4B+srK5Ca1qRB0/kQY/YcOSIrmyfw0chTNKkKUi3zDoHSKTpmoteNJbfUUCp7SELkDmmATgheYO3XzVSxXVv66lWK7d08o9FB+IxxI4D8HiRBW5vp8ll3HWQn+fEz7wU+vHVq+MWoUrok6upsk+h9v86HnfhE/06VbsMm7+RFAvCZSzMwddNdKnZ9dsNHRrpNZYwj0Cay+eRh/Qowxs1vXG2Qc03VMGv5M3/bLjK17uhnKAIXPWKad9hFxOhprcztgM58n+90agW39ISaiGRh6Ekgo19qgPn7kGSL6o2fHKYRTjGt4lTRpTxwbIrGQ5kKqQmVQ5fpmf7M16mUk9tB7IXQyj2mZXqU6NjkOJw0+DdTkDGSjxrJosRAeVCaKAUCrJk2wg==;
 5:iJynBbD4gAwKLNA2EQhmR1qBG5MvY8zJ/7FQXfFccY0/gLNhyaWLJ63W7b6h3rwlPDUXF48K6HXS8Xkz8VShk15Eh/wGKCsN12ZHrTWbAiDfWG7JVIDSPy22EooZ8N4yRtcFFQsnZE5ubkjXnGQPXZ/nLzrH1A6twvEQQcK9OEw=;
 7:NkdZbHm95OMkTCb+ZoZ8rZpAlCr1Los4tHceOfzFCKwhfwLxMfLAINLOXHzso6GIjv7wLoZVOzgmTAFuMik0sjrMaoI41y5If5r08e71vOavsBJ/edsymlMA971ucdOlHa225QWJCcehWt4CNUN1CQ==
x-ms-office365-filtering-correlation-id: 7c635fd1-429c-4ced-d7c2-08d660d14981
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR0402MB3890; 
x-ms-traffictypediagnostic: AM0PR0402MB3890:
x-microsoft-antispam-prvs: <AM0PR0402MB389051E3EFEE84EF14D2F49B8CA00@AM0PR0402MB3890.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR0402MB3890; BCL:0; PCL:0; RULEID:; SRVR:AM0PR0402MB3890; 
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(346002)(366004)(376002)(396003)(39860400002)(189003)(199004)(186003)(2201001)(5660300001)(81166006)(386003)(26005)(6436002)(8676002)(6506007)(14454004)(575784001)(50226002)(81156014)(105586002)(86362001)(4326008)(52116002)(8936002)(106356001)(71190400001)(478600001)(6486002)(71200400001)(102836004)(68736007)(99286004)(66066001)(53936002)(6512007)(6116002)(3846002)(36756003)(2501003)(54906003)(256004)(25786009)(486006)(14444005)(7736002)(2616005)(39060400002)(476003)(2906002)(97736004)(316002)(110136005)(305945005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR0402MB3890;
 H:AM0PR0402MB3570.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ofTFTgiqRwBm9PwPD8st8UaOG6TVv1Pjw/BIoL6eaJz6uiFlWigrxLIe/fS1XHNA8C6MS8yWujNdKoI5IUZoycajX91G0+JLnu3BjH3URqbpvbDNv1AKsD7mXuCvOaHYhgmay5GYJaxfNFIKvkTbsEuuy3RhfVRWuDk4+h6jYSmbnr1QN45CDw1PvD+eNHtnmruj1tCECpQtHm8IOEr8qSzTpk60OFelVi97eAHaAAjvfVwbSIVucdicSKA6tu+hicaI/1k5+tXd+Ueutv9bskXhVRVWMjYa5vpIhZw7hE72vBY67C+d9dkMe2P0as58
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c635fd1-429c-4ced-d7c2-08d660d14981
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 08:02:11.9893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3890
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_000225_120126_89409DAD 
X-CRM114-Status: GOOD (  12.52  )
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
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

MSI_EN of iMX PCIe RC would be asserted when
PCIEPORTBUS driver is selected.
Thus, the MSI works fine on iMX PCIe before.
Assert it unconditionally when MSI is supported.
Otherwise, the MSI wouldn't be triggered although
the EP is present and the MSIs are assigned.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 26087b3..d3e4296 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -74,6 +74,7 @@ struct imx6_pcie {
 #define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
 
 /* PCIe Root Complex registers (memory-mapped) */
+#define PCI_MSI_CAP				0x50
 #define PCIE_RC_LCR				0x7c
 #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1	0x1
 #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2	0x2
@@ -926,6 +927,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	struct resource *dbi_base;
 	struct device_node *node = dev->of_node;
 	int ret;
+	u16 val;
 
 	imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
 	if (!imx6_pcie)
@@ -1070,6 +1072,11 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	ret = imx6_add_pcie_port(imx6_pcie, pdev);
 	if (ret < 0)
 		return ret;
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		val = dw_pcie_readw_dbi(pci, PCI_MSI_CAP + PCI_MSI_FLAGS);
+		val |= PCI_MSI_FLAGS_ENABLE;
+		dw_pcie_writew_dbi(pci, PCI_MSI_CAP + PCI_MSI_FLAGS, val);
+	}
 
 	return 0;
 }
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
