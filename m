Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B90C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:11:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB019214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VxUJI6aq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KEQ3XvQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB019214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FlbG0cefU/DKy37NyhgumsxZH+LjnzkLzylekBlp3yI=; b=VxUJI6aqGZ7Ijb
	nJCD+Jk1V0fAKs9wcDaGLmjYgZXU7emumkb3dIFH9WVmyWncjR9gBjRu/fwzL3FvsskRDI0Xsvsd9
	bve1pu/ggiFG9gn1BfFD16wxtyvtmTRGPDNgZ9zVoKFcApYdQpHjRqgLUECPh7NmkaYrPDfPRKJ05
	QAzLDQNbmtKGdkNG3sVDX0zJ5UCOR2hvsu0dPY2Cu3/UkWhXFdogksBrIAJjPSzv2DAebLHAxajeB
	1lHsz6Oob9TYqH273TDmnMqzpbS9yYuVVVe/t2iiuvP9XsU9ubwroX9wmgvchijcd678XyA/7Y6PV
	LUCwzG2J+zVoX+J0oRoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goOUM-0007Ah-Kr; Tue, 29 Jan 2019 08:11:22 +0000
Received: from mail-eopbgr00072.outbound.protection.outlook.com ([40.107.0.72]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goOSR-0004G4-OJ
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 08:09:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4ngRKRTgC9o/7aAxbUCwbrWEu5yLuYKeQkwKN3n7SQ=;
 b=KEQ3XvQyLavSE14ASrj+VNok51S/m/WIhrPAAamf2mppiq3I0HW7IWf0c8zjOJ2Bk7R/ub5Z62nfj2HZEw/D73xd81vcWZf/pABEue4spiyBluwuakqVq7xpbdE7bFiHosD4GY29yTW3BIXLAj747Luvl4KkhiNH/XZoMUTTx0w=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4774.eurprd04.prod.outlook.com (20.177.32.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Tue, 29 Jan 2019 08:09:20 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:09:19 +0000
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
Subject: [PATCHv3 08/27] PCI: mobiveil: use the 1st inbound window for MEM
 inbound transactions
Thread-Topic: [PATCHv3 08/27] PCI: mobiveil: use the 1st inbound window for
 MEM inbound transactions
Thread-Index: AQHUt6nvuDhY+0ZVQ06tELcOKKSi+g==
Date: Tue, 29 Jan 2019 08:09:19 +0000
Message-ID: <20190129080926.36773-9-Zhiqiang.Hou@nxp.com>
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
 6:uYlnHcGa4bQS87XswrOkBjftzK/ZiKBvh08JT0WVPgi4x5Ag26QE0yw/Pk40okrtvAvAClAF85nteYq90ysgtzkKL+mDNEjD8EpsDw98VSW3kTDLHNhSm9N1ZvM76zINtY4wIDNYgVDS4Dl++tJVltCqBTAunAkP4X74MIXTsXOFOIZDN+8ZNFG+0dhkKzQeWU4VYAy59TH/iTDAOO8FwT+YZV9plkatf2jR3Fd6D1EZRC0Y4vx0kDz+PvrmI5PRxJ0syR51zH8iY+xOAqKbK5TuHAUyv6FLkzfya9KOhOYcK1URa2DRU/Y5Z2st8XyN3HyOnX4cbJfP67iFFR/ErI4dqpwDegMvHTLvNk+GX+D1H0ydTG6efvgLvkJccw1/VA2CR9fAMMBSE6Q3q2uoSu30nDwtXqQSwJUoUc6nJmgAZHbSA25TXXR5XNfmTNXE3Y4PcGx4alVEs5ihSOKhYg==;
 5:EW0yTd1eaGzhrZKgpj5sSqa/ROhj2mbuXuknVo1ur7PvwT1t9i5eWbus78Ma0OlYyscczTOriaXEq/bDgyVN2taTdB6AaubWPFmO6k43FI3vG9ZwzK77Az/H2eRUd3RfFJbzxNm1OYx145r8dlLxHhMBQT17WRpTOoV/CMs6EPh8/Qoa85OkID/29jwuUcPa/ChBQwfPoYdoCxct0ioBUg==;
 7:VSNVhX7k7hHDjoL/m13wlY/fgQQZtXNOVTf5xE+rB9f4Ejm2vmzCdUQ1usZLCEFhNXFI4cc6SPD28f7ldC9vMkC7T+fsns8C4o5dm/Tb8UvU4UAvAigZmY3NFhYYeZjxrPSlZQxTdXS50ChMezBwfg==
x-ms-office365-filtering-correlation-id: 49468156-6f9f-489c-2ad7-08d685c1118f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4774; 
x-ms-traffictypediagnostic: AM6PR04MB4774:
x-microsoft-antispam-prvs: <AM6PR04MB4774CD6457F3F8B601F2EA4F84970@AM6PR04MB4774.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(376002)(396003)(136003)(39860400002)(189003)(199004)(86362001)(2201001)(102836004)(4326008)(305945005)(186003)(478600001)(4744005)(26005)(7736002)(386003)(14444005)(76176011)(71200400001)(14454004)(25786009)(6506007)(446003)(53936002)(71190400001)(52116002)(1076003)(256004)(11346002)(7416002)(68736007)(81166006)(81156014)(8936002)(316002)(486006)(6436002)(2616005)(8676002)(110136005)(54906003)(3846002)(2501003)(6116002)(99286004)(2906002)(476003)(105586002)(97736004)(36756003)(50226002)(66066001)(6512007)(106356001)(6486002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4774;
 H:AM6PR04MB5781.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rt+M4Erdp5UbxmM/G6Pn1Cz7OXGX01xaS/mFGDDAfPqwP2z85WtUzYLEKwJQkATnwb+uLde+zvLZ8bZ5yZpiMThPeq6Wz6cmNTdzaX/hn1frcf9NIbTgCiXXOWJzZv2IuJ4HsxnbgyL/EyNrXUYGIaZLnJRV1Z+wPb6GBcr1tATmVRiZ7dqy5Ug0n2iI43Xs4GvioAXY+mEvXlFQFlByRlfjKZl8vNA930KrNE/fjumKykI+k9q8xiitKpEZsngAcVG925xWLUS4f7mkz35APtv8reRZNvVbT4K+Igo/cfmfuyq8IhwwaL17Ee3Egk0rEVTYZQ723urM8PfaMGLsNU1TJ0ik6UW9HMLVi6zFpgFb8NkjuJCtC7zUXTRx/Zhq/ACnWV82ejoOK9gAIn7qTnwu9daHoEe6eVErXQbMfe4=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49468156-6f9f-489c-2ad7-08d685c1118f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:09:13.3186 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4774
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_000924_365532_E1FFF6FE 
X-CRM114-Status: GOOD (  11.05  )
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

The inbound windows have different register set with outbound windows.
This patch change the MEM inbound window to the first one.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V3:
 - No change

 drivers/pci/controller/pcie-mobiveil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index df71c11b4810..e88afc792a5c 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -616,7 +616,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 			   CFG_WINDOW_TYPE, resource_size(pcie->ob_io_res));
 
 	/* memory inbound translation window */
-	program_ib_windows(pcie, WIN_NUM_1, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
+	program_ib_windows(pcie, WIN_NUM_0, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
 
 	/* Get the I/O and memory ranges from DT */
 	resource_list_for_each_entry(win, &pcie->resources) {
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
