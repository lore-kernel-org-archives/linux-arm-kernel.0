Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17EAC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:12:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A883B2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mHB77c5J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="so85RMrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A883B2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cS2Js/V1axCPjESKIKH6OekW+9nCPOKHdCOOvOt2blw=; b=mHB77c5J10CcJC
	sRXe7+CZgRCehDO04opT5bEfTnX6kGiq9st+z0Zhcq5ZL0uzuIKoJ6wh6Qnex1Vmhmn71dA42pOba
	Ui8lVapo6jOv1wfxyhdCOoQT4ZiWHkC2VOeJd8/OnJdaMO3AicSUAWiI2iJbWlyt1SWTkIOrHtZY8
	nABjgO/kWN7Raxcj0W/fIOHUQVxwtN1D69kj8HsLMJs4DdreXNrlH71dDLqiRiJhRvmmIThHpUfci
	8ZmybvTGBK0maeesWgo4utUM54Vi3IbiCTxT0Z6e6nxVj3+gD6asWTuPUrMRB4yplQZPqLL2wxvWs
	gkyKLGAT1W9W3rAHlmuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goOVF-0007zy-KI; Tue, 29 Jan 2019 08:12:17 +0000
Received: from mail-db3eur04on0604.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::604]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goOSe-0004Sn-9r
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 08:10:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXs1eY0JXgsUFYdVarct8m0g+545mZKC3TxcZS29uUs=;
 b=so85RMrYlkjblyXCYTfB3DqdU2+xoRRVaTK5ydyMFMEbLu/cHQZUg5wyzxPOILJHdEeX6WADgAZrxFPQ+VNzwfuCtMQTUB4BKDGvqa+v4ecZuvt5eNqvvDzdzyVZimaFDqWLmQXtyTGj/cONwm8ytTirgt2W6AthaWKwLgwCEY0=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5784.eurprd04.prod.outlook.com (20.179.2.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Tue, 29 Jan 2019 08:09:32 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:09:32 +0000
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
Subject: [PATCHv3 10/27] PCI: mobiveil: fix the INTx process error
Thread-Topic: [PATCHv3 10/27] PCI: mobiveil: fix the INTx process error
Thread-Index: AQHUt6n275W+OwpbVU6CNVNwAnWSvQ==
Date: Tue, 29 Jan 2019 08:09:32 +0000
Message-ID: <20190129080926.36773-11-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1; AM6PR04MB5784;
 6:lsqozMFvO8h8N/azT4Y8Sye3o//1TZJP23R+r5l3q+p5mVkY2uqeyXHbBWFVu6bLSYeo72mOqtwxrfiEXBNzTIjXcPxRylLCVdEjVpsoL2TCJBTJ9OKZyheBGASduzHFeWCL2TPHvQVVwm22AD6fWu68Xmfy0tvj0oSu4tBMSaaydEmBee4MJm3A2l2rNWAIheausuMKho4G3r14e32i6Ry5UH2ngsDJRoSujuFuAXEeOixqZ8zbNdv0h9pradOJlN/lPwyWxPxe+wuJTsnHevymjNzymWoX7mkvaHH68Yb+qy87vZgC0qC3dxzbwEiBL5A4kQ9ttE+9o3qIOX3ED2kF+82lMVW6kRiiTHOTpkv1Mzt+Y/BClCS3FVyDSkHqzBpV3v2JNZmu0WoWw0LbfhqduR5ha9skrx59HR+E2hxTTinluudk+jB8nKqQ6EvcJrvaYkhirQvSjB+OS1F75Q==;
 5:MW5GgaBYvDVZCQ7aTXdAR/zKCEogSkfzl0N9hDN4jd9ct0SgPnG/sOR2GS/p7/w6T9qH9AEx92PxbcROuUtEg8XZ3a85y3GTatjMpv9xwmbnt0u+9HOnVIx6HO31Dz1ctmLS16xm9GtMBNTASY/qjTxTbPio5rQMPOIkIjiITVqfug1CZlNLFUKS/PbF/0+GdCV+4dirbDfwitMqe61VqA==;
 7:EDqY3PrPPdWlzJKf5Ce4RdilJ+CxSNBHg2qkmZkLvImY7AYWxEWVFFk/Ii0CTjVeuBzsYkKQsweJ62dF6kja7XBmqsc6rdPAND+5+oclQu4dmxBQgOoWcsrkqNFF95MYlfxapO2F1P9EAjBfha+tjw==
x-ms-office365-filtering-correlation-id: 9035fb93-aefa-4732-4cf3-08d685c11945
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB5784; 
x-ms-traffictypediagnostic: AM6PR04MB5784:
x-microsoft-antispam-prvs: <AM6PR04MB57846DA3E9FF3A87210292D384970@AM6PR04MB5784.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(3846002)(105586002)(6506007)(386003)(71200400001)(71190400001)(26005)(305945005)(66066001)(7736002)(106356001)(4326008)(102836004)(68736007)(6116002)(2501003)(25786009)(8936002)(8676002)(81166006)(81156014)(50226002)(97736004)(486006)(256004)(476003)(99286004)(6436002)(186003)(6486002)(7416002)(2906002)(14454004)(110136005)(1076003)(2201001)(316002)(478600001)(86362001)(53936002)(446003)(36756003)(6512007)(54906003)(76176011)(2616005)(11346002)(52116002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB5784;
 H:AM6PR04MB5781.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nSJh4BsFTkalI82L0yM8l7fqcPTncZGqMhDDkAQgDpGZzg5tQYX2sopTVG5HinFumNbYDeeS39nFVJxocZFwyak2N4tNTO7KK+47hyocfYwJjMwZDtH6+b3DoyVeCpOZsCLTaOkhfbxx+9qDRU10w/Ec03sEOK1bLvybdLlNyZl6Axa6uqeVA/zrHdxe79K3K0AoWYmDbFx3pgtKRFg0t8x0fPuEBd8QNZ21JJpj/dbTYx6uNMSbNjzFBCCQl6rvAYyjVkzudtKmxbQgNJGrY1SfBfqwG/s/W/NkKp3mPiw/m+ItV1jlafnRXfLBTIM7bqB+yIizcS8fu63j2Nd7PpR2zqe80xJccGAw8g74uDvk9AaxMJFODQPcJ5swXhYzjv81loY3bs8kS5UJ6SMuVdFp15/RMSMoLqPjnSNulaw=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9035fb93-aefa-4732-4cf3-08d685c11945
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:09:26.2720 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5784
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_000937_212432_50FFE1FA 
X-CRM114-Status: GOOD (  11.04  )
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

In the loop block, there is not code change the loop key,
this patch updated the loop key by re-read the INTx status
register.

This patch also change to clear the handled INTx status.

Note: Need MV to test this fix.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host
Bridge IP driver")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V3:
 - No change

 drivers/pci/controller/pcie-mobiveil.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index 4ba458474e42..78e575e71f4d 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -361,6 +361,7 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 	/* Handle INTx */
 	if (intr_status & PAB_INTP_INTX_MASK) {
 		shifted_status = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
+		shifted_status &= PAB_INTP_INTX_MASK;
 		shifted_status >>= PAB_INTX_START;
 		do {
 			for_each_set_bit(bit, &shifted_status, PCI_NUM_INTX) {
@@ -372,12 +373,16 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 					dev_err_ratelimited(dev, "unexpected IRQ, INT%d\n",
 							    bit);
 
-				/* clear interrupt */
-				csr_writel(pcie,
-					   shifted_status << PAB_INTX_START,
+				/* clear interrupt handled */
+				csr_writel(pcie, 1 << (PAB_INTX_START + bit),
 					   PAB_INTP_AMBA_MISC_STAT);
 			}
-		} while ((shifted_status >> PAB_INTX_START) != 0);
+
+			shifted_status = csr_readl(pcie,
+						   PAB_INTP_AMBA_MISC_STAT);
+			shifted_status &= PAB_INTP_INTX_MASK;
+			shifted_status >>= PAB_INTX_START;
+		} while (shifted_status != 0);
 	}
 
 	/* read extra MSI status register */
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
