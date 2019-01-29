Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D10C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:15:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9EF2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F2RD0JpZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d2tmSRsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9EF2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rTKbMAdhWLOUK6rKDuOQtEWZbPqhn/nm4ZDuW4Jve5o=; b=F2RD0JpZp4NrPZ
	7gsYV8nzGuOdco9RTg0djH0JwqUk6jgVaRhMP72x6ItPpbRAivKbaYVmBM93/eWGZ8OZdcBup17Bk
	pW1KzudIrS/2Vp3KaZ7uVVe5Rc53SKCrh8fQ9IqntTuUHjxTx2wjtR5+mH49hxz4yx5T0NX8tNOBc
	DpRW2LlntK9X2tYeL2tp1kDCni4OHjuPL/QR8iXuq1Bett4FZXcQqQZXfSDNK8QjZYE5IMtrIl86g
	rljL2pPtTmCyJRNZbOb+TEVnQD/bm3RebIpkOlhujiKuZ4frYpvt+tUAsUSlBERh3E2omH5n8uAWp
	1GSm+Ltopmb8VsloEaAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goOXy-00024N-6C; Tue, 29 Jan 2019 08:15:06 +0000
Received: from mail-he1eur01on0628.outbound.protection.outlook.com
 ([2a01:111:f400:fe1e::628]
 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goOUC-0005RP-Ku
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 08:11:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E170z12adGVC23PMJmo5C8pkb5fr/2T7EL28HPMQo0M=;
 b=d2tmSRsQcTKd9IknBgKWVCsCSZf2EnuCgTuarxMfVYLRq6qvngL/Yxl+a47C0OQSBkJjZovw3OJSKSSYR8vJxmZhqsKenPCCxaeF8yX3RBM/Y1JxLnr0h2WeK626RFxg38dsdvDMs9fqQeC4XcH16Q26lX1wFohpUw+0dhBHdn4=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5127.eurprd04.prod.outlook.com (20.177.34.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.23; Tue, 29 Jan 2019 08:10:24 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:10:24 +0000
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
Subject: [PATCHv3 18/27] PCI: mobiveil: continue to initialize the host upon
 no PCIe link
Thread-Topic: [PATCHv3 18/27] PCI: mobiveil: continue to initialize the host
 upon no PCIe link
Thread-Index: AQHUt6oV2BKtH99kI0CkMOwpS+vUFg==
Date: Tue, 29 Jan 2019 08:10:23 +0000
Message-ID: <20190129080926.36773-19-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1; AM6PR04MB5127;
 6:4mjdVniGZkKtoEETxeAW4Xs8jqo0H2CmtgLbowlUCnQmdAeuPq8iD8UO79/IQB7zEEINgeMa0GjYL81FSJKcLiuEePLksEFMmoR2Kg2zh8lWUFHK3i3f5JCi4nk5Udil2dJMEiScvSXShNuBcgzBvGStT4/IpmaSsHs80rDzhQsujBO6WXK1oeTlnGos/L5ysxjoS9AmyPrcdCV8Ip6o1DZaq63+f7Q1z1nBYYDJagezOlhgBkcTLVkc4Uj87im5efTzyAlvzYaqgVOtkDQhYGbba/CKis3lvwAdFBc2wRrF5dzeKKZlQElXPrNftDpwZuTMl23UsKGaY5lXgaZwofPwx/4bHyEeoomj5KngOsvPWmmMbgod016K3+B6EkfzM6bpUHyMEijnm8ZgR8S/Srd6M8O/azn2D8/FAKbvbWkBDjG7p67cHYojVeB3xq5pYJuD0hxxfS9UnJHRAWbU0w==;
 5:2LCece/6M6UB0RGZ+37Ze39Kb4g68fbLMlMN2b7mOcNQk3+/bdH57epswbmnvJlLGTj7xZVsHFwkEmbbM8qw+oWz1WFZkZpJT4ZrRDwsmqeHottII5/vDX1Ig30damANHb1/hL06FgmZZdz500E0ulggoHphFft0Y6f0oEwjM2s8NsJ4l/o9zxxK+56XvAPj4Y4YIvEwvstwoef7vSieJQ==;
 7:c6/Xiitehb1L2+d8cOiPW7v+uezyghJ+eE6wLj0JHbNX22C2xk10J1bEE8+pwdhXTOXGrxMHEM9o1DVTAjfVdi8IEQ2SjorQEsUEVOQaiWraAAbMjExWu7Kc3XfP8pcHjNwwXt5/0P+LPYebxHi+kQ==
x-ms-office365-filtering-correlation-id: 92daaf59-a17f-4042-869b-08d685c1382e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB5127; 
x-ms-traffictypediagnostic: AM6PR04MB5127:
x-microsoft-antispam-prvs: <AM6PR04MB5127FBB1F490722AA622A72484970@AM6PR04MB5127.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(376002)(346002)(366004)(39860400002)(189003)(199004)(6512007)(8936002)(26005)(81166006)(99286004)(4326008)(486006)(52116002)(2501003)(186003)(97736004)(76176011)(105586002)(14454004)(478600001)(106356001)(6486002)(305945005)(54906003)(53936002)(50226002)(81156014)(6436002)(110136005)(8676002)(68736007)(476003)(71190400001)(36756003)(71200400001)(316002)(7416002)(256004)(386003)(2906002)(6506007)(446003)(11346002)(102836004)(66066001)(86362001)(1076003)(25786009)(7736002)(6116002)(3846002)(2201001)(2616005)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB5127;
 H:AM6PR04MB5781.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5/Ntj+Id3MUJekOJqyiu4MH6HW4uaHsx2oVJSZRO51kX9rQFG8HjxNHVvL55J7XP1QVUMVBziuF7n39lHSxVPxWDGtMiVH84XeWtdDQxAKxIvdfkmo6+VHsk0okprz9vhaoC+c2T3TFJOVSXkFBLBtqAgKGfm2OMUaiARpQgG8Fb33i5toE6Bv/ZX07B9evANYpHUi2DbWLyGV2eCFtmTr5ZKKZjI5YsbUF/ums/P8Ho5efCTfWK4D2TKLPWwkdGSpyz4rCUXq4/5M7JTJkuUWslw5UwC6E3dFjDSYM+p8BGZPhfEbyIWQezHEfWldJ5/ceIsCeAtZtICHyzY+16KPtHLP/hIybF+n2ZiG8afaheg0R6mLwGiSL5CsGQSs7LiNHpbp2y1uG67uIPvrkPJiUYcVfH2SI894YhXzf7xEM=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92daaf59-a17f-4042-869b-08d685c1382e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:10:18.1321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5127
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_001113_407487_27955D46 
X-CRM114-Status: GOOD (  11.76  )
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

Sometimes there is not a PCIe Endpoint in the PCIe slot, so do
not exit when the PCIe link is not up. And degrade the print
level of link up info.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V3:
 - No change

 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 1 -
 drivers/pci/controller/mobiveil/pcie-mobiveil.c      | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index 1ae82e790562..d1765d572f44 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -596,7 +596,6 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
 	ret = mobiveil_bringup_link(pcie);
 	if (ret) {
 		dev_info(dev, "link bring-up failed\n");
-		goto error;
 	}
 
 	/* setup the kernel resources for the newly added PCIe root bus */
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.c b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
index ee678a60825d..370658d6546d 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
@@ -222,7 +222,7 @@ int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
 		usleep_range(LINK_WAIT_MIN, LINK_WAIT_MAX);
 	}
 
-	dev_err(&pcie->pdev->dev, "link never came up\n");
+	dev_info(&pcie->pdev->dev, "link never came up\n");
 
 	return -ETIMEDOUT;
 }
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
