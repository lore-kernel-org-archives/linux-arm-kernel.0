Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9653BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:20:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C511217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YvkbWb/X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hb9R6Z1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C511217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VcH54SVlTELrU4RmqqB+HFk4kBX00lOYbWhcnEm3TSc=; b=YvkbWb/XRl8DS9
	B0gar8Ka2j1F7QSA7ha/p2NV6IvgNaGh1Sqjx5XPZWyFyY2GIHqb+wrUka0BH4ZQu+pc/U15kP9tz
	QM4fiIfgPcfkxHNQ3+0ex4/FCqITxfuXSRUU67l4cnQIczh7R/ygjdggh6S9cEyz0b2E17KNlDTj6
	C8MGNPgU+VD39uDHE7jqJeZZN4KEvYxYBy8gqvC3S14aK1h7/oZJh7I2qtQK/uK9zAmXYTf6xGRpM
	tKglBvzqaFnzXZyydbW6bzhCBMBUQT8TNipTyVDYoewdp7YAQE536rMrEAwy8pEL/im7y5vQOsAo5
	Q12RX/99x/eDfnXwe2DQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ6s5-0008SV-IG; Tue, 18 Dec 2018 04:20:41 +0000
Received: from mail-eopbgr60064.outbound.protection.outlook.com ([40.107.6.64]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ6rI-0006BQ-0W
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 04:19:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itSbUbwJO4gh1NyCHxixBJtwwWhH3T1namaQemAx6BM=;
 b=Hb9R6Z1/4O0SEaOGFjL/Gq+pOo9gHw7uBSLqaZ4jNY70we0vyo8UFM1N7A5bhAlntbTOxY6qcJhwrU9oBYG812oH2Xtjwny8ADHKxG8NIi4Um4wSdyNcbdpiPWlSExZaCK1HcJHC3i0wQQ7N7TQC+SnMEAS/FNkB8A7P4AG5VpU=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4102.eurprd04.prod.outlook.com (52.135.167.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Tue, 18 Dec 2018 04:19:43 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::4d2e:cf15:fcf7:56b2]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::4d2e:cf15:fcf7:56b2%5]) with mapi id 15.20.1446.015; Tue, 18 Dec 2018
 04:19:43 +0000
From: "Z.q. Hou" <zhiqiang.hou@nxp.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "shawnguo@kernel.org"
 <shawnguo@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "lorenzo.pieralisi@arm.com"
 <lorenzo.pieralisi@arm.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
 "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>, Leo Li
 <leoyang.li@nxp.com>
Subject: [PATCHv3 4/5] PCI: dwc: fix 4GiB outbound window size truncated to
 zero issue
Thread-Topic: [PATCHv3 4/5] PCI: dwc: fix 4GiB outbound window size truncated
 to zero issue
Thread-Index: AQHUlojmUkIA7a60GkSJjdnCHK63jw==
Date: Tue, 18 Dec 2018 04:19:43 +0000
Message-ID: <20181218041956.41809-5-Zhiqiang.Hou@nxp.com>
References: <20181218041956.41809-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181218041956.41809-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0075.apcprd03.prod.outlook.com
 (2603:1096:203:72::15) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR04MB4102;
 6:MFGbp92SPs559GwyiSY6WdBN1AA0ztUlkE9HZ0IUaC/Q9JpAHZbxBD7upGOy1qmYZRqoIbRVfrK7xCfv5ORIgmbrTAuMRPYgQFSH/da6imBcXdWsFTLvVCn6J0nnwK9OWK6kvPKbMopW7gciYX83e3nVjaROL/ygpZ7SGlYBrdLCFWaCD/3GOqIMVTOr/0euqoEp2YwvHcDxTjDMssfQ7n97xXhCfMnbPmGGog6sySnp9tGcKdTjFbup4qakkqml3gcDMBG681FT2CTLjwFh0kGNK5XEcci8ybMNhev6mAgOc61jCTpSZSp+WUIesMBacWV+cY3fjW6mrL8L8xTMrTYEagSduHN4MYU4H/F0gR35TEuHrFoE+UwzLyq+D1mgkbtR2ubmZCr2xpaI8FepKVtQqXJKolWRItykSLqUS0vCKYIlHs3FlpLZKzdZA89kMx2+vMNAURMEDrWuF5IY4Q==;
 5:hxUuVCyCX43spcalYaYhVhBQj1r87ywV7R4YQOe9OYxozjtFz0fySSu4/zqXPGMuyf/js7/PlpI/fTDw2E3ZDN60xi+Qg9cg9qPkopUxrkDL7LlkAbUYQIIQ//rEUNvnVRvELVMv+tIo9cCLXkJ+thMNAh/brsZbnNVXKPOiNMs=;
 7:pX9P3rmDnUoVss8Lxk/u6VXMNmy8T5ZScQUPhjBT66Xo4/uKneWX3hMBStetudpQ79yUjNuwEpY/SazT5qxuGNSfUVbISOz7G1pfoRUEQb3++LLl10Sx0MYFY8b79ZsGx9PH5lL/PMMQ2T4BWZfgUg==
x-ms-office365-filtering-correlation-id: feb3f5d1-5a56-419a-4748-08d664a00931
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4102; 
x-ms-traffictypediagnostic: AM6PR04MB4102:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-microsoft-antispam-prvs: <AM6PR04MB4102C1581596956F9336C9FF84BD0@AM6PR04MB4102.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:AM6PR04MB4102; BCL:0; PCL:0; RULEID:; SRVR:AM6PR04MB4102; 
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(52116002)(7736002)(97736004)(7416002)(68736007)(25786009)(4326008)(36756003)(316002)(106356001)(102836004)(6636002)(105586002)(99286004)(2616005)(71200400001)(486006)(305945005)(11346002)(186003)(6506007)(386003)(110136005)(54906003)(76176011)(6486002)(1076003)(5660300001)(71190400001)(446003)(476003)(26005)(2501003)(2906002)(2201001)(86362001)(575784001)(6436002)(256004)(3846002)(6116002)(39060400002)(81166006)(66066001)(8936002)(81156014)(8676002)(478600001)(6512007)(53936002)(14454004)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4102;
 H:AM6PR04MB5781.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LZaEiIP6v+WO0HBfYRyyNYyBDhVdnP2E/50D3C52Vf0cbj6A1bMqkvIyK/hErTX/S3DM+yKTXkqbBueKekrJV0k2C7m3+eAZCH5nkPdUg11f9BCGm8xG1zdlBoiAcWUg4bcarikvTpirfSQNnx2Ih3oraLn0gh5IWl1FQEninwkq1ICYYmnNPoGldAYADiG4bds1unMpMnklgkhVm9mdz8JNTWD7ewR7Nfyp3O79G2zBQTylOmUmRSZY+r6hWY9gwmpCsT3JeExrgZRzPm+GlhhWGyY7g0KTXdfzgd6efmFsmeTfvLUGqpd9/lhfRAie
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb3f5d1-5a56-419a-4748-08d664a00931
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 04:19:43.3775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4102
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_201952_088025_8CD9B807 
X-CRM114-Status: GOOD (  13.06  )
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
Cc: Roy Zang <roy.zang@nxp.com>, "Z.q. Hou" <zhiqiang.hou@nxp.com>,
 Mingkai Hu <mingkai.hu@nxp.com>, "M.h. Lian" <minghuan.lian@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The current type of mem_size is 'u32', so when resource_size()
return 4G it will be truncated to zero. This patch fix it by
changing its type to 'u64'.

Fixes: 340cba6092c2 ("pci: Add PCIe driver for Samsung Exynos")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
V3:
 - No change 

 drivers/pci/controller/dwc/pcie-designware.c | 4 ++--
 drivers/pci/controller/dwc/pcie-designware.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 2153956a0b20..7ac5989c23ef 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -106,7 +106,7 @@ static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg,
 
 static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,
 					     int type, u64 cpu_addr,
-					     u64 pci_addr, u32 size)
+					     u64 pci_addr, u64 size)
 {
 	u32 retries, val;
 
@@ -141,7 +141,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,
 }
 
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
-			       u64 cpu_addr, u64 pci_addr, u32 size)
+			       u64 cpu_addr, u64 pci_addr, u64 size)
 {
 	u32 retries, val;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 0989d880ac46..25604387d13e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -157,7 +157,7 @@ struct pcie_port {
 	u32			io_size;
 	u64			mem_base;
 	phys_addr_t		mem_bus_addr;
-	u32			mem_size;
+	u64			mem_size;
 	struct resource		*cfg;
 	struct resource		*io;
 	struct resource		*mem;
@@ -242,7 +242,7 @@ int dw_pcie_link_up(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
 			       int type, u64 cpu_addr, u64 pci_addr,
-			       u32 size);
+			       u64 size);
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int bar,
 			     u64 cpu_addr, enum dw_pcie_as_type as_type);
 void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
