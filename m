Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E87C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:14:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B02CD2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aitplfSK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rQptscbi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lgsh2r26"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02CD2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x03uug/ihOOyOitquiKgIe5tLeKpkjI2wiEO8Ykpnok=; b=aitplfSKSDd5me
	5UUE3I4B1e9wo3KL5lCJ9yQjf9Q9q7W0Sl21Pp++u8or/iwHirNROnxm8hM/do9KO+s55ytlr2QcP
	F06Bo6IkK70MvXiXdl9Hz1bQc+eILYE24mcKu2FX3LoioRYXjK7Oy3gUqM1doI5GD9/PKXHBpPMJd
	4lRicXzE4+b450dq2/nY31quf9pvPP0q5m5ynsEQXBfGj9qsWGIoNb8ShTVaSYzQXsvDUrg7BDkRB
	wa2U7Vb+cZDVVWiyzd/AE5fSxlfvw9v4+n0rD+VhZf+c1paauA1j35u0/DAMjI8EDHh1ywC1cY2GZ
	pyVMmuuv+J/ZSaMEU1CA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goOX2-0001Gt-Pz; Tue, 29 Jan 2019 08:14:08 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goOTq-0006fa-71
 for linux-arm-kernel@bombadil.infradead.org; Tue, 29 Jan 2019 08:10:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yswwHhxY3CmA5odLLO+DpwEYMpJo6mlvclSAye3x2g0=; b=rQptscbitGMi8ZWFShXl3MtOFU
 PCodm7EyneufgkivItEkj+AeCMpRnyWnsQ3Nauv84eVQAGq/rfomt7zF4MipfxM/ugxgmU0NhgO0W
 z5irZ3MqUahzZ9Hu/THzWVMWKef/T6a8u17oN8a1vZSwoq1RhoHdN5KezdD/075GVItD02YzuLFyi
 SAEfPE/HevWlTIV8LXanpZAPXvGbcCMchn5LdH1jbYuGAjCNUi6NerZI7UPWhMKzC8wkI/ohsog2X
 zHpJJjiwcjw+gX/0Lw1hsU/JfHXNtpLEWX8bP4l9bUPNLqc3j5UmhFN1ahzNGNZWV0yX28h4J+tbE
 rH8obxQw==;
Received: from mail-he1eur04on0625.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::625]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goOTn-0007Xj-5P
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 08:10:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yswwHhxY3CmA5odLLO+DpwEYMpJo6mlvclSAye3x2g0=;
 b=lgsh2r26WnDzk8ABe+1mSf4TyQkJSoWSkquWsZjDfQUuonvdfw9JCaEilo2m9afdPf8MXISsRHTyy9rwZ41kWITBVtk6SKh6dPyD5qx3ZzPkNwZrYvHhAnj+Jql+ypLMJ9hEaPxmwEr2oDLaO57lZoJImheXsYfIPx5MocCSkoo=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4728.eurprd04.prod.outlook.com (20.177.32.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Tue, 29 Jan 2019 08:10:43 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:10:43 +0000
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
Subject: [PATCHv3 21/27] PCI: mobiveil: make mobiveil_host_init can be used to
 re-init host
Thread-Topic: [PATCHv3 21/27] PCI: mobiveil: make mobiveil_host_init can be
 used to re-init host
Thread-Index: AQHUt6ohojgx1Yze4UypyOz4JWt69w==
Date: Tue, 29 Jan 2019 08:10:42 +0000
Message-ID: <20190129080926.36773-22-Zhiqiang.Hou@nxp.com>
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
x-microsoft-exchange-diagnostics: 1; AM6PR04MB4728;
 6:ahBt7z8yvQIj0BxqwfhxnLeFSB2yf7md9Ra/0F0hNCkvxXyEklm6i4zZ9/FXm6XCBd+u9HiJw3LbUn5wUlZ0074nPP99MRPFW3gESkq5DOJaxvVhVXQT5fjLdI+2/JdLIImtf+dJlrzsycIDDo2vU02dT1wGWfEZjrgAancgmrYNZpJ0nHXj/cQYOAUUs4XYexFonKsoq55vlBi9ORW+9dMMgUvpVJE4MtRF2ZJe6y6eTCCPOn9q8dAcpRMEmgEpMtOmHPCZ0dLFbdH874XsDskdokk4m7jrU6lvBif2OhqNDBpLKx4S+M7NwuvAAGLBn3dYeunOpAApAKgfCYPPFfG6H5nZfEodVHxrNDtNOXKw9eMUbQFOzFDNOaM9IqKbkb8BPdtzcK4upevhRxs1KVcq5jpkhvY4AgEAovL0l97HSxvVXVOggWwfnASYPHth3Zc1sgh9DJrjPSjFNBTmag==;
 5:nH57VSL0RO7qwMnelXiVMhT6ClqjdqfNW8bRT6v0N6bSHjpQ52YSrBtjhnDNLKBMDnbrLsrXfhkf2UdNEA5r0Zb60pkt5nWUVIzXw9ANmdFL6Ed54Ayj/v3YB6UfK0mxo6Zno79O6LkuSZTsnYs2bXQQNOzMf8XzCh2UyKu4Wx3pzS8XumYCMqBXZvH6x4+s1xMTAUpVd2Z/Eb0Pfkm4Lg==;
 7:JaX0rahzDq5b3NaUdlvxfXLIscpI0FSUT4yibCQy4XQvGVyj5/nT/6afCW+ZRFxCnEOp6oSi4cIZbfHT+Ca+aDOI9W+hLJHQohELRV21uFdNEwJX1RuJsHSlxfe2Q3CYnuZCUwUC/BS7lu6Byo+Aog==
x-ms-office365-filtering-correlation-id: 270c9557-7076-4b62-343f-08d685c14359
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4728; 
x-ms-traffictypediagnostic: AM6PR04MB4728:
x-microsoft-antispam-prvs: <AM6PR04MB47286772F45E7052F831F67B84970@AM6PR04MB4728.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(366004)(396003)(39860400002)(346002)(376002)(189003)(199004)(3846002)(7416002)(71190400001)(71200400001)(2201001)(36756003)(4326008)(316002)(6512007)(105586002)(53936002)(6116002)(6436002)(106356001)(6486002)(86362001)(1076003)(97736004)(81166006)(81156014)(476003)(2616005)(486006)(256004)(52116002)(446003)(68736007)(50226002)(478600001)(2501003)(14444005)(8936002)(8676002)(66066001)(6506007)(386003)(2906002)(11346002)(102836004)(110136005)(26005)(54906003)(76176011)(305945005)(186003)(7736002)(99286004)(25786009)(14454004)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4728;
 H:AM6PR04MB5781.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HzNbQtwRanj6ULymwgzmb9sxenkKldORt08448TJ0GmAnYzo6oqK+KGrWwSnXoscKjgG0td/maxPLJQiZV39P1Dxx7dJXqIvZXFfEgkW6PKdaBU3d9J6OPMubsu2RLZINPz7hFPZY/gVl8hhK3DfWx7D3/+a6xGChQ3CKAPMUt9yElCS4jtARdKoZ9lV0TRBHmIajhXcGWMh8d28m/KELu/CcrjTmDdmupxtNfD7eqmqGyEW/Nti+NdGXQpnqk2ZgogT4JQhCIcuYSr4mAXvl31QkD7JVg+CycsySmR84b/Y48ywSfUXIFLdQdjRrfLcnLk3gocMnfcnv9nMSqXg6nwcqPZiiKV6YTFLzTjXUqu+5BxoNjJcdjvVJ0kqKyAarbvdKFeu+7wpa97f1LrYK0vxpBEBnKoNTiTKMjvMHoU=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270c9557-7076-4b62-343f-08d685c14359
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:10:36.8511 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4728
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_031047_236463_E660AD73 
X-CRM114-Status: GOOD (  17.93  )
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

Make the mobiveil_host_init function can be used to re-init
host controller's PAB and GPEX CSR register block, as NXP
integrated Mobiveil IP has to reset and then re-init the PAB
and GPEX CSR registers upon Hot-reset.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V3:
 - Removed the duplicated free opteration of pcie->resources.

 .../controller/mobiveil/pcie-mobiveil-host.c  | 41 ++++++++++---------
 .../pci/controller/mobiveil/pcie-mobiveil.h   |  3 +-
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index d028cdf31d0e..e8d0c4989013 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -217,7 +217,7 @@ static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
 	writel_relaxed(1, pcie->apb_csr_base + MSI_ENABLE_OFFSET);
 }
 
-static int mobiveil_host_init(struct mobiveil_pcie *pcie)
+int mobiveil_host_init(struct mobiveil_pcie *pcie, bool reinit)
 {
 	u32 value, pab_ctrl, type;
 	struct resource_entry *win;
@@ -229,11 +229,16 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 	for (i = 0; i < pcie->ppio_wins; i++)
 		mobiveil_pcie_disable_ib_win(pcie, i);
 
-	/* setup bus numbers */
-	value = csr_readl(pcie, PCI_PRIMARY_BUS);
-	value &= 0xff000000;
-	value |= 0x00ff0100;
-	csr_writel(pcie, value, PCI_PRIMARY_BUS);
+	pcie->ib_wins_configured = 0;
+	pcie->ob_wins_configured = 0;
+
+	if (!reinit) {
+		/* setup bus numbers */
+		value = csr_readl(pcie, PCI_PRIMARY_BUS);
+		value &= 0xff000000;
+		value |= 0x00ff0100;
+		csr_writel(pcie, value, PCI_PRIMARY_BUS);
+	}
 
 	/*
 	 * program Bus Master Enable Bit in Command Register in PAB Config
@@ -279,7 +284,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 	program_ib_windows(pcie, WIN_NUM_0, 0, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
 
 	/* Get the I/O and memory ranges from DT */
-	resource_list_for_each_entry(win, &pcie->resources) {
+	resource_list_for_each_entry(win, pcie->resources) {
 		if (resource_type(win->res) == IORESOURCE_MEM) {
 			type = MEM_WINDOW_TYPE;
 		} else if (resource_type(win->res) == IORESOURCE_IO) {
@@ -550,8 +555,6 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
 	resource_size_t iobase;
 	int ret;
 
-	INIT_LIST_HEAD(&pcie->resources);
-
 	ret = mobiveil_pcie_parse_dt(pcie);
 	if (ret) {
 		dev_err(dev, "Parsing DT failed, ret: %x\n", ret);
@@ -565,34 +568,35 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
 
 	/* parse the host bridge base addresses from the device tree file */
 	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
-						    &pcie->resources, &iobase);
+						    &bridge->windows, &iobase);
 	if (ret) {
 		dev_err(dev, "Getting bridge resources failed\n");
 		return ret;
 	}
 
+	pcie->resources = &bridge->windows;
+
 	/*
 	 * configure all inbound and outbound windows and prepare the RC for
 	 * config access
 	 */
-	ret = mobiveil_host_init(pcie);
+	ret = mobiveil_host_init(pcie, false);
 	if (ret) {
 		dev_err(dev, "Failed to initialize host\n");
-		goto error;
+		return ret;
 	}
 
 	ret = mobiveil_pcie_interrupt_init(pcie);
 	if (ret) {
 		dev_err(dev, "Interrupt init failed\n");
-		goto error;
+		return ret;
 	}
 
-	ret = devm_request_pci_bus_resources(dev, &pcie->resources);
+	ret = devm_request_pci_bus_resources(dev, pcie->resources);
 	if (ret)
-		goto error;
+		return ret;
 
 	/* Initialize bridge */
-	list_splice_init(&pcie->resources, &bridge->windows);
 	bridge->dev.parent = dev;
 	bridge->sysdata = pcie;
 	bridge->busnr = pcie->rp.root_bus_nr;
@@ -608,7 +612,7 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
 	/* setup the kernel resources for the newly added PCIe root bus */
 	ret = pci_scan_root_bus_bridge(bridge);
 	if (ret)
-		goto error;
+		return ret;
 
 	bus = bridge->bus;
 
@@ -618,7 +622,4 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
 	pci_bus_add_devices(bus);
 
 	return 0;
-error:
-	pci_free_resource_list(&pcie->resources);
-	return ret;
 }
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
index 933c2f34bc52..0f5303962e88 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -152,7 +152,7 @@ struct mobiveil_pab_ops {
 
 struct mobiveil_pcie {
 	struct platform_device *pdev;
-	struct list_head resources;
+	struct list_head *resources;
 	void __iomem *csr_axi_slave_base;	/* PAB registers base */
 	phys_addr_t pcie_reg_base;	/* Physical PCIe Controller Base */
 	void __iomem *apb_csr_base;	/* MSI register base */
@@ -165,6 +165,7 @@ struct mobiveil_pcie {
 };
 
 int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie);
+int mobiveil_host_init(struct mobiveil_pcie *pcie, bool reinit);
 bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie);
 int mobiveil_bringup_link(struct mobiveil_pcie *pcie);
 void program_ob_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_addr,
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
