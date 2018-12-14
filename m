Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21155C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:44:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E480A204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SiZ5fpi9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WA2hL9u5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E480A204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=V8M4K3X7jVPPthfAD6AKniweymkwkhRNiEq15sZYvpI=; b=SiZ5fpi9rxEEu6
	1HcMyz8PDSawbxjfBRcU4rwZwFkhxWLFXtdIIfMUzdxN+1IeQN/qroEZPAg8T1y6x6Kagstg+HUhX
	PnBqk310I+9zxp385oUhI//f/LPowsL9kv4q8zW+c7LVlF6OrJz3v6/XJfeDWmMzQIUCAuHKXbG4Y
	uZg2xLetIGr5Z//kIY3s1N6Ch8afg2NsLUqJ5fX23rQ+4tixl+IgxsTlPtiaKf3GnM9Bag8NmI5Am
	Iw7oPaJuMC9hSLLez/s9TXusEqS2i9eMtrcgBx6P0+DRk5UIBEs/DQRtdzPILPGrJ/55GpvVM+sfr
	MQP+p20U5NRAQeN9bkRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXhD8-0002AA-7H; Fri, 14 Dec 2018 06:44:34 +0000
Received: from mail-eopbgr60066.outbound.protection.outlook.com ([40.107.6.66]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXhD4-00029D-3r
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 06:44:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OulzC/eyu6I3AFh6MTraStAHRz2PIDcUqxH16bJ394Q=;
 b=WA2hL9u5JNHlHYqJDNxLvDsXKHaV6JR0exgI60ez3gosQxSfnieOCsDa/cUShv4GGtommwHTjpW3VfUF0qa5vaRrbsss2KeiYBYaIqX7d2JMBKdwFlikVuqlVucI2/OjXz3lG8z8OAiCq4FV6x50QHaMqt4jQncQ+4jSPq1ZIFw=
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com (52.133.46.11) by
 AM0PR0402MB3491.eurprd04.prod.outlook.com (52.133.45.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Fri, 14 Dec 2018 06:44:15 +0000
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::94f8:5fdd:f384:8af8]) by AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::94f8:5fdd:f384:8af8%8]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 06:44:15 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>, "lorenzo.pieralisi@arm.com"
 <lorenzo.pieralisi@arm.com>, "l.stach@pengutronix.de"
 <l.stach@pengutronix.de>, "andrew.smirnov@gmail.com"
 <andrew.smirnov@gmail.com>
Subject: [v4] PCI: imx: make msi work without CONFIG_PCIEPORTBUS=y
Thread-Topic: [v4] PCI: imx: make msi work without CONFIG_PCIEPORTBUS=y
Thread-Index: AQHUk3htX9ByhenO70SYEZSF8G6UHg==
Date: Fri, 14 Dec 2018 06:44:15 +0000
Message-ID: <1544768762-18124-1-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0063.apcprd04.prod.outlook.com
 (2603:1096:202:14::31) To AM0PR0402MB3570.eurprd04.prod.outlook.com
 (2603:10a6:208:1c::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hongxing.zhu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR0402MB3491;
 6:6wa5B2/6CqFyOBHykD3HlrTb/GainQQqrCWPygJ3kc239L6re61wr88+10h+Hgvo97lop+JSK1raGreu4otIGT5hxmucWQsUDLDiuvgx0W9XyWZTQIHJLv1km/MnhvX1EVfNq63EA07gg0A75HE61nmEx+tqXwkYgxBp0Zu4X7wnCkxHYvqhJhZgCCheyLvKroOL2LpwpgGOFY4iNMLd2CtFtLq5PxgZ2FE02Itv4YZL7ItrI0aoC9GgAcd6/GGy8eLeyF+8fikJZxM+C6pRmtCyc+EA+1edhY5AZhJ1AYDHtNTY3tGudHbKjtI3i8YyanBds5WFaEax7W3aiHVK6ikfxAnZcjVCkhLsAdk/StlgYUKm3A/RkFwS8dOC2v5sGzQ/rFEKnijNDtHS5OGXmpko4wAwX6AJEyZAhYQQKLWzYVOQTBRKnKKaHjCBLgKapuDUljB0PTCcFuNhhK8OAg==;
 5:bZyOkIFMmkwLniQ/hspzAamJ4e083hDjchGGPWprpigvqpfISwDKvnaLHxFBbqL0VUEGUn6dcMk6rfkfS6ti6EqxYPQR7nhDPX/h4yeWU9q0+1Gjj9Yp8MMPr53TQU223c8Ps4JEH0RWXnCu3ezfv7xbu8FqQsdyVFKu7ekUBmE=;
 7:qGekjGcUDgUE2CGLKyork7Ndl3Ba1VfW+Fkn7AYkV89i+PbmafY1FywvVWiWzNZwJFHPnQ7UIkJjTqZaC2QLJiOS9KZrbem2fQG1bMv6eox1EHwpDC1brTD9vMbBkHJDWIjt+HIxMHKSp4w5kfrGpw==
x-ms-office365-filtering-correlation-id: d523edcb-6112-4472-be68-08d6618f9059
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR0402MB3491; 
x-ms-traffictypediagnostic: AM0PR0402MB3491:
x-microsoft-antispam-prvs: <AM0PR0402MB3491027BFAA55B64F09D924A8CA10@AM0PR0402MB3491.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR0402MB3491; BCL:0; PCL:0; RULEID:; SRVR:AM0PR0402MB3491; 
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(136003)(366004)(396003)(39860400002)(189003)(199004)(50226002)(3846002)(6116002)(486006)(2616005)(36756003)(2906002)(39060400002)(6512007)(476003)(2501003)(105586002)(8936002)(81156014)(8676002)(81166006)(53936002)(2201001)(106356001)(66066001)(478600001)(14454004)(25786009)(54906003)(110136005)(97736004)(316002)(52116002)(99286004)(186003)(6506007)(386003)(26005)(102836004)(86362001)(305945005)(7736002)(6436002)(6486002)(71200400001)(256004)(14444005)(575784001)(71190400001)(68736007)(4326008)(5660300001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR0402MB3491;
 H:AM0PR0402MB3570.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xuj7g8gtewbpRRiHj36As+BY4nsAWWecV6T4xXzeZpSBM8im4PMgL3KBLzIilYDYkoEQ3CR7bYEJKG1dPsrMPYY744pUjsDBctIiMaF0OX1rYboDvJ5ReFaRQDjHnBvIXxFgu6mrG+/a2lX6zKnwdJlzMxkkQHly0aKC5dFS8ss8n88k7HCkwt20N9jgeBuQDqGOWZ5HNY752qvkTsWKgSj5ysPlJ1dhZTAzA7IiDlJjvLjB4T12RGlwLhvcXAapamwv6sPf6O0b4ROkd8ZCHUb7IcGNwIuq7rTioqInbD+b/LKezxiczLIexrShNV8r
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d523edcb-6112-4472-be68-08d6618f9059
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 06:44:15.1613 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3491
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_224430_172265_72EF1DD9 
X-CRM114-Status: GOOD (  15.55  )
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

Assertion of the MSI Enable bit of RC's MSI CAP is mandatory required to
trigger MSI on i.MX6 PCIe.
This bit would be asserted when CONFIG_PCIEPORTBUS=y.
Thus, the MSI works fine on i.MX6 PCIe before the commit "f3fdfc4".

Assert it unconditionally when MSI is enabled.
Otherwise, the MSI wouldn't be triggered although the EP is present and
the MSIs are assigned.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
Changes v1 -> v2:
* Assert the MSI_EN unconditionally when MSI is supported.
Changes v2 -> v3:
* Remove the IS_ENABLED(CONFIG_PCI_MSI) since the driver depends on
PCI_MSI_IRQ_DOMAIN
* Extended with a check for pci_msi_enabled() to see if the user
explicitly want legacy IRQs
Changes v3 -> v4:
* Refer to Bjorn's comments, refine the subject and commit log and change
the PCI_MSI_CAP to PCIE_RC_IMX6_MSI_CAP.
---
 drivers/pci/controller/dwc/pci-imx6.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 26087b3..639bb27 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -74,6 +74,7 @@ struct imx6_pcie {
 #define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
 
 /* PCIe Root Complex registers (memory-mapped) */
+#define PCIE_RC_IMX6_MSI_CAP			0x50
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
@@ -1071,6 +1073,14 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	if (pci_msi_enabled()) {
+		val = dw_pcie_readw_dbi(pci, PCIE_RC_IMX6_MSI_CAP +
+				PCI_MSI_FLAGS);
+		val |= PCI_MSI_FLAGS_ENABLE;
+		dw_pcie_writew_dbi(pci, PCIE_RC_MSI_IMX6_CAP +
+				PCI_MSI_FLAGS, val);
+	}
+
 	return 0;
 }
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
