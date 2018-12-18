Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7319CC43614
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:20:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3036A217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l2/KlS7v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XyPiFQs7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3036A217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6U1SSQO2Lf+X3wnF1OrcIs8p6329dKqjAQuxQYyQG/0=; b=l2/KlS7vjNtwUW
	33b165Ja/K5jqfhw4CjZ44jov4PKSzpWYFbXhN8NGg0C+bxO4V7TDiuCE5jMncjxswdd2xrmnM+ft
	eT3BTC0k7tORDsATeXlxk2rFj3FqUp9vWT+/ANAxbFYD2IO1LSmn+WUFVkG1UdB7mHdJ3xxuGztR9
	S5J0BJsy+PJsJXLzxfEFnwPjZJZrSho9j5wsFA028FPuoR41u+Wc0gVx3FlR05mY4LJdu/mthxif3
	LWpqumCqsyndzuspuqkMvPnFaueWgs++OFjHHHwE/USPun0de5JjKyyTHfJCLegQBotrjjDgt4BdH
	M7hzsAYoL1tv2DmpfbhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ6rp-0008A6-96; Tue, 18 Dec 2018 04:20:25 +0000
Received: from mail-eopbgr60064.outbound.protection.outlook.com ([40.107.6.64]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ6rF-0006BQ-79
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 04:19:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaarYOSHenwYGQmPvPX8P11jD19ca6sC4p7nSzWqk2A=;
 b=XyPiFQs7f8p/55D6Xx4RolH4g797ajW8gOtHbZGoA7QyCFWmNTiNFHFe0jnk12IO2KGLLmFhKY4khsrqPdu0BReFkMOMnBqrC0kKU+63syP4UP+vrwwHJTO6fSAmYpKlrspX0BiWILUPBoQ+D2jZ2UbL602caLEqKInmBY6VRlw=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4102.eurprd04.prod.outlook.com (52.135.167.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Tue, 18 Dec 2018 04:19:37 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::4d2e:cf15:fcf7:56b2]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::4d2e:cf15:fcf7:56b2%5]) with mapi id 15.20.1446.015; Tue, 18 Dec 2018
 04:19:37 +0000
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
Subject: [PATCHv3 3/5] PCI: dwc: fix potential memory leak
Thread-Topic: [PATCHv3 3/5] PCI: dwc: fix potential memory leak
Thread-Index: AQHUlojjRQR4wIQbqU6X3IfQXDLFig==
Date: Tue, 18 Dec 2018 04:19:37 +0000
Message-ID: <20181218041956.41809-4-Zhiqiang.Hou@nxp.com>
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
 6:cq/frfSD6DmuOpgYEuTf/AmrniiqYJIRAUnjbibIezhWi2L57jbXQOHbtj2402lDUrNW077LCmwEVv6+MlbONMaxEqzVsCogoObzfk940zJgpwJFvSafKxZC4O+3yA3i7YYhGyPzN5kQF8xwLHG6mFLLCKXay1QCSzZY9hEOfCBvEoBWQjA/e4YV3iADzDOYVdAdoeUuwsxUN9o2T3/wK9ecEdrywf4d1NyT6a7oDSw3G9Z0nZx0xq+ULgQFXoueF2TwOAgePoKtn+rDrftc8diym2xs1KyYvuYPSLb4u0umne+oQfhd/cvUxIy1X/aUgbosLgKNQx2GMKFOI819Luy4rNT1/eFoZRyTpsewSv5fOq3d6DL63m9mM803w3AB067qdzM6jBTVhqB/5JwpnzkkIN92w2DpiXV7dMMtjKifvxbul9DHE34kkDQT7e3lxGtVxAu8T2S8QRbzMRWmpA==;
 5:/iQcj46gWPgFhsohePq2o+2fA+3EjDHL5Afm41IyqBW694OUfyM1wUKBrg3i9LUJb0uIoNIGUfWhW7FtrqEXQyXVkXQhn57Qv6pwws8YvdUz/j1oY50qScCoK/CozEjsyDlHY3Fp4mCubYjLeITJ7zmNuuKdCALP/GHcMYO03IU=;
 7:r1w+ZeZRTIDGlqpwWWpk0gZ920Nhy2htH3YHvcFebXt50aV29rik8eEgId5ToyaEkzQ8+jBFuLyL7tylfjaa23wU06vwh5cVlm20wCM58ka//Vcy0GqV0tWgedHvy/0Yb7dNntDzbxkGAmdQCkm2yg==
x-ms-office365-filtering-correlation-id: f9f2d90d-d222-4485-5bf2-08d664a005cb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4102; 
x-ms-traffictypediagnostic: AM6PR04MB4102:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-microsoft-antispam-prvs: <AM6PR04MB4102F79D75D049494C9FCB3984BD0@AM6PR04MB4102.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:AM6PR04MB4102; BCL:0; PCL:0; RULEID:; SRVR:AM6PR04MB4102; 
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(52116002)(7736002)(97736004)(7416002)(68736007)(25786009)(4326008)(36756003)(316002)(106356001)(102836004)(6636002)(105586002)(99286004)(2616005)(71200400001)(486006)(305945005)(11346002)(186003)(6506007)(386003)(110136005)(54906003)(76176011)(6486002)(1076003)(5660300001)(71190400001)(446003)(476003)(26005)(2501003)(2906002)(2201001)(86362001)(6436002)(256004)(14444005)(3846002)(6116002)(39060400002)(81166006)(66066001)(8936002)(81156014)(8676002)(478600001)(6512007)(53936002)(14454004)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4102;
 H:AM6PR04MB5781.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zzm4wtj58tPQ01iUbw+h6eXAuL9/VKzlQs0UPha0ybXfMv0puZz66vGvc0cXw6S3X11zcn9HyvSGOMYAEhDcCPwT/dLhGl/ryE2hOe8t9EzbVGi2WjioiCEeMgLNQSrD4NmDe7MRovJ1wnHEg30Np/19DFCxaOw88L2vHkukxQAY5ujSv4SlGKsd1WhDLxpnL8IJiFDY1+EXF9Pxf1nlwTgPaJC85mDgEzKcTM3epO4ULtl/tV5oeQwGNDA5BDkp6spwhSlninxitE7+9O00GwpP+etuShTDORq0cNWzunMJknmFZ5vwSsp8BrseR9jC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f2d90d-d222-4485-5bf2-08d664a005cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 04:19:37.8585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4102
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_201949_507499_7E5B7F62 
X-CRM114-Status: GOOD (  14.14  )
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

To avoid memory leak on error return of the adjacent function
devm_of_pci_get_host_bridge_resources(), change to use
devm_pci_alloc_host_bridge() to allocate host bridge structure,
then it will be managed automatically.

Fixes: 295aeb98a322 ("PCI: designware: Convert PCI scan API to
pci_scan_root_bus_bridge()")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V3:
 - Changed to use devm_* to allocate host bridge. 
 - Added Fixes info.

 .../pci/controller/dwc/pcie-designware-host.c | 28 ++++++++-----------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 29a05759a294..33b5a3815d24 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -346,7 +346,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		dev_err(dev, "Missing *config* reg space\n");
 	}
 
-	bridge = pci_alloc_host_bridge(0);
+	bridge = devm_pci_alloc_host_bridge(dev, 0);
 	if (!bridge)
 		return -ENOMEM;
 
@@ -357,7 +357,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	ret = devm_request_pci_bus_resources(dev, &bridge->windows);
 	if (ret)
-		goto error;
+		return ret;
 
 	/* Get the I/O and memory ranges from DT */
 	resource_list_for_each_entry_safe(win, tmp, &bridge->windows) {
@@ -401,8 +401,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 						resource_size(pp->cfg));
 		if (!pci->dbi_base) {
 			dev_err(dev, "Error with ioremap\n");
-			ret = -ENOMEM;
-			goto error;
+			return -ENOMEM;
 		}
 	}
 
@@ -413,8 +412,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 					pp->cfg0_base, pp->cfg0_size);
 		if (!pp->va_cfg0_base) {
 			dev_err(dev, "Error with ioremap in function\n");
-			ret = -ENOMEM;
-			goto error;
+			return -ENOMEM;
 		}
 	}
 
@@ -424,8 +422,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 						pp->cfg1_size);
 		if (!pp->va_cfg1_base) {
 			dev_err(dev, "Error with ioremap\n");
-			ret = -ENOMEM;
-			goto error;
+			return -ENOMEM;
 		}
 	}
 
@@ -448,14 +445,14 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			    pp->num_vectors == 0) {
 				dev_err(dev,
 					"Invalid number of vectors\n");
-				goto error;
+				return -EINVAL;
 			}
 		}
 
 		if (!pp->ops->msi_host_init) {
 			ret = dw_pcie_allocate_domains(pp);
 			if (ret)
-				goto error;
+				return ret;
 
 			if (pp->msi_irq)
 				irq_set_chained_handler_and_data(pp->msi_irq,
@@ -464,14 +461,14 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		} else {
 			ret = pp->ops->msi_host_init(pp);
 			if (ret < 0)
-				goto error;
+				return ret;
 		}
 	}
 
 	if (pp->ops->host_init) {
 		ret = pp->ops->host_init(pp);
 		if (ret)
-			goto error;
+			return ret;
 	}
 
 	pp->root_bus_nr = pp->busn->start;
@@ -485,7 +482,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	ret = pci_scan_root_bus_bridge(bridge);
 	if (ret)
-		goto error;
+		return ret;
 
 	bus = bridge->bus;
 
@@ -499,11 +496,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		pcie_bus_configure_settings(child);
 
 	pci_bus_add_devices(bus);
-	return 0;
 
-error:
-	pci_free_host_bridge(bridge);
-	return ret;
+	return 0;
 }
 
 static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
