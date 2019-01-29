Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50743C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:12:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 157832175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LmlIYCVB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y1gsAqUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157832175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z1Jj3O6JymY6DAdmT+XOZnIefpN9Xjzq0UJ5ATk8gqE=; b=LmlIYCVBK1Xoyb
	F3+JDd/eh97rrmBGhASeR5J/x6YoVVr+ucEON4tVsdGsMqyvME8ovRrX6qhP2mfbK3ic2mEKM3KU1
	46kFulqEOIRP2uOHfvJ011nRlXDnrKLWADNM+a0oGUKhGsOmZdidQmdUh/JWGM+rTxNUqbhIODhoa
	tPAgsfa039aBprLRUlpRJ9ekOE9CBYJr7tXC+YY162WDp+bzt61MzquCFyh89ES6g5XdWTDeR2dCP
	UQlt9QUOxXPHcT1Yt+xTFmeQVEokL+fCmG5nzYcJc9a1/6/turoG+8FDcL9hBDq8Whzvuovn8cH3O
	odOoewQOUFaDx+sLfyfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goOVZ-0008Jr-Al; Tue, 29 Jan 2019 08:12:37 +0000
Received: from mail-eopbgr00072.outbound.protection.outlook.com ([40.107.0.72]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goOT1-0004G4-GE
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 08:10:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pRlTG/hTHjG7NncY//Wh/e8nBhMaDygHgI02F1ibrU=;
 b=Y1gsAqUarnDRTmQo7B8qZtmKhdhrLvntXA55Ipf7hv7IvQX52vxShOqmN0Z6QgYMFnhHnM3wkBe5mixqjsaLeXl6bndKBTwUAtzVewed/r0dqZ6Q1AJckIo7Qkqf+cCTxFNY4Yh31GqoxSMoBCLmhw6rHGuz5L+cTp0yU7m9q2Y=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4774.eurprd04.prod.outlook.com (20.177.32.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Tue, 29 Jan 2019 08:09:38 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:09:38 +0000
From: "Z.q. Hou" <zhiqiang.hou@nxp.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "l.subrahmanya@mobiveil.co.in"
 <l.subrahmanya@mobiveil.co.in>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "lorenzo.pieralisi@arm.com"
 <lorenzo.pieralisi@arm.com>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>
Subject: [PATCHv3 11/27] PCI: mobiveil: only fix up the Class Code field
Thread-Topic: [PATCHv3 11/27] PCI: mobiveil: only fix up the Class Code field
Thread-Index: AQHUt6n6FgLtfR2uu0ORRlaW6wBtmg==
Date: Tue, 29 Jan 2019 08:09:38 +0000
Message-ID: <20190129080926.36773-12-Zhiqiang.Hou@nxp.com>
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:36::20) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR04MB4774;
 6:DHU1rjS6gYNBFBWt15b/8YfN9sBi1F1OEQf+o5lYjl7GP6y8PMlHlt8Duc/EXPtdvbQF+EPVhzyQhnRJ6FpsQarhmDeyoOSR+RYUxqLoNSV0gyNwj2AAzX4D3hkSbb36WY91PgM8dZuatC+qkw+E47MPX3v4qmQ0uHrvkKnzLUocnNNrKPsUvAvZ5E3gF467P2kX7UIMOO721lpBRb8uKonD7K7LuNK7MVrg8zOT17MUxqvJiIKjMZVgVjFQNZdA6mjnQHwuCAwEAb8GpQixj0I2kzkgoqMSiqKvLw5rGZgWanHclGTmuclr4oPulBrz7pqputUSjqdCGssL0AZ/P4AznIgrkROON+xp2z81bLmIlFVoSp2jo1wowO9GBU2UTbniFbcqAp0clVK8paWWlgazfxCmffldDqzxN4ioo25UA9AND2w5JbGO9eCpngt3Mi0BUbgM4tNdU5izvgWa1Q==;
 5:eefonoV71O84mDtcctMkBqpwvi5v+wNIw3KerrV4eFK0a9zUqlqv92JZ/DtxnBhDOaFXB+1ABnt07ii5Y1AJoVIJFp0gKs2OBIsqZW0BLT8dj1Y8YzaJOpv5EGm0QlWt0uEHpJ89Z4ivq5IcxULuJi2BcMlHc3E6DE5/QKYMgAYJ55+PhxhcVD7S7jKWdV1Hvnq1YeJMH3VUiuxg69wS2g==;
 7:jUo4huw0vBA2SzecXe26yC8l/Fwqd6DGyPyvcezVlefMLA2dJ1hFhSs0LaTqUtZX2ovJq2ewoA326B0xRnykLwWOyXZnnfhAgsicaVAQ4L6KxSO5FdLwwEQz/VxQ0fE/Zum+QPy1ntgpIfUwZSltUA==
x-ms-office365-filtering-correlation-id: 0d0da117-2c69-485d-7276-08d685c11d14
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4774; 
x-ms-traffictypediagnostic: AM6PR04MB4774:
x-microsoft-antispam-prvs: <AM6PR04MB477467A82AA6C090EAA7B6B584970@AM6PR04MB4774.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(376002)(396003)(136003)(39860400002)(189003)(199004)(86362001)(2201001)(102836004)(4326008)(305945005)(186003)(478600001)(26005)(7736002)(386003)(76176011)(71200400001)(14454004)(25786009)(6506007)(446003)(53936002)(71190400001)(52116002)(1076003)(256004)(11346002)(7416002)(68736007)(81166006)(81156014)(8936002)(316002)(486006)(6436002)(2616005)(8676002)(110136005)(54906003)(3846002)(2501003)(6116002)(99286004)(2906002)(476003)(105586002)(97736004)(36756003)(50226002)(66066001)(6512007)(106356001)(6486002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4774;
 H:AM6PR04MB5781.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LBUrZa7HQYjB69a6T0ib8WGaJPOZwgOKo2eWe7ZDPI22FuiuSLq0glkEveQRIUaLzObu9Rv2Ed4dwcFTXnVOqnsTjgv0ylg1OmyspU0Y/qag2g9U+ZWQvyHTGIgAMT1NGkv8DpTXvBmoI8jIO87WafxiBDHXJK+0Ej4GOXZxc8hCNEflkygIStensSvChdk9IB9GOWfEKIDA5CUmM1DVwPcfCX60se+dXTx3BGfjZ3NqcJX1aZi6QGc8tPsSddL530sHgzWZFx+wPvEQTV4HiaLuy4XG/8giWjTlYzliT2oqUWcp5MdwTomfLl7ioubWifcEzJPjaOlUTGz3qw7vbFLAFtgN2gBO86WDqgAokWFPfRCUmyxlWCgJlJa8ReBy8CcI1QlFsiL25gP4JuuuWQllfOfNTp9rx4YM0gUEPyA=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0da117-2c69-485d-7276-08d685c11d14
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:09:32.6470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4774
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_000959_932260_221A6E9E 
X-CRM114-Status: GOOD (  10.86  )
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
Cc: "M.h. Lian" <minghuan.lian@nxp.com>, "Z.q. Hou" <zhiqiang.hou@nxp.com>,
 Xiaowei Bao <xiaowei.bao@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Fix up the Class Code to PCI bridge, do not change the Revision ID.
And move the fixup to mobiveil_host_init function.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge
IP driver")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V3:
 - No change

 drivers/pci/controller/pcie-mobiveil.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index 78e575e71f4d..8eee1ab7ee24 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -653,6 +653,12 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 				   type, resource_size(win->res));
 	}
 
+	/* fixup for PCIe class register */
+	value = csr_readl(pcie, PAB_INTP_AXI_PIO_CLASS);
+	value &= 0xff;
+	value |= (PCI_CLASS_BRIDGE_PCI << 16);
+	csr_writel(pcie, value, PAB_INTP_AXI_PIO_CLASS);
+
 	/* setup MSI hardware registers */
 	mobiveil_pcie_enable_msi(pcie);
 
@@ -896,9 +902,6 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
 		goto error;
 	}
 
-	/* fixup for PCIe class register */
-	csr_writel(pcie, 0x060402ab, PAB_INTP_AXI_PIO_CLASS);
-
 	/* initialize the IRQ domains */
 	ret = mobiveil_pcie_init_irq_domain(pcie);
 	if (ret) {
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
