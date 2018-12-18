Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71147C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:19:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B23D21841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Utk2lFUs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bP/2+z8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B23D21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+X1ePlsY1MFCB/aO59Lc7UjnCl408GeXZxU9+OI+5MU=; b=Utk2lFUsrEmtCP
	bQ5ZDp6Sb7IIePimuYlpzLjA3RaaIdPkY7ecuJPDBzmTUS32IcZcUFeZvDMj+cY0n9GNh37K8lPKL
	Kgx6zI56T4T+LhqtspbmU5tFFl7m8THepaVhbWtPpp63oJE/7+sTzf3eTtfhf7JlIRXetpV/ySZBm
	PvKwJD29JBCNsslpYN9i7axvQnkKkzRwSAT4Bw0ZbdfETJyTR3H0EWflWhpEO3p5m7TWU8qu4c7n/
	gRCJ5cc/RkzP8Z/U7h0cCOCJIOj5XzNCHYV6PxjGo0/6bpAhV9E85aRlX+TjmeoRVdDb5qyNPfxC8
	0rHUmmCYu5onTGInVicA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ6rL-0006SG-Hx; Tue, 18 Dec 2018 04:19:55 +0000
Received: from mail-eopbgr60064.outbound.protection.outlook.com ([40.107.6.64]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ6r5-0006BQ-AU
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 04:19:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLaFn/5nWbwcR4KhCtZhN6G89jTJk0zh9QQ615G8x40=;
 b=bP/2+z8Ym6H8Olwr+MJEpjEXqEgxSOJUv9YhE8eUNpIBmzBXilQ038lwVKTD0cZzZ8l3agM65fdrenSn3SJ97dEbLv0TtT2km757adotN+50G1OOQvTFcEymzhpcYDrIdJbHB2/Lpyp2ehTqHltmxoe9CK9NoqQ2A1P+oh8vJJ4=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4102.eurprd04.prod.outlook.com (52.135.167.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Tue, 18 Dec 2018 04:19:26 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::4d2e:cf15:fcf7:56b2]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::4d2e:cf15:fcf7:56b2%5]) with mapi id 15.20.1446.015; Tue, 18 Dec 2018
 04:19:26 +0000
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
Subject: [PATCHv3 1/5] ARM: dts: ls1021a: add num-viewport property for PCIe
 DT nodes
Thread-Topic: [PATCHv3 1/5] ARM: dts: ls1021a: add num-viewport property for
 PCIe DT nodes
Thread-Index: AQHUlojcaP0IJPro20GOl/AtJzrryA==
Date: Tue, 18 Dec 2018 04:19:26 +0000
Message-ID: <20181218041956.41809-2-Zhiqiang.Hou@nxp.com>
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
 6:szRO7lCWL8Y4dk3rodhubZOuAzdjdpgRbltc4ZXDfLYIhU/iHjY3pXwodF7KyndFb9DWObiiMM5RoKoQFKJY9oWBSurhMkrK694Gf4a0y/Pm9BvgGUUkeYbuFd4R2Iw393Ly6s9U3V/68ieKdg8oAY/uiWOMJCQI1GQ3Fy01nPoiW2WgYLKyU96/lnSw5bcBoBBp9ErMdtO2LtsHCT8sJkoUi2oXLGL8+rqx6m6T4HGEUDvEe0+Pi14hjmcaPGrpXy1uxv1pB4zIZ6p6YVVR6blnfyJRm3WyHIJ45vLMie8/8ytz1939x0PrBTVFHtJoCJmPMhuR9BQkdNgUHIG2gyIDHYPKnqlZ/4v1uYB+vgUDesVxN4YjJZmLCRJM6+Gx3JlqKYHdQtbEJ1NaJlwiuEt4OlwsPTR1ELhFOngkZRrbgbKNe2/OLEV8/WcqN/TFyTZSGFanfBZTNXtxpzzloA==;
 5:iSpbjkw3yW9IM+CnIG95QPHlDxMjOnZjDIdDTzjl3ftynnSF4TnpJF3ZYp9bx8umnWSEODz4gWv1zbQqQRr91EFp0YZ/nwtT0E2BcsDRYRM/KYBkzhj5kvAsqIJ4Tc9yEEdUkihJWScX7MVg4TS0brpCB61zQHZPjqAISAK8Spw=;
 7:s76Puyx9HRPrHj6th61I0WQWRv2MX7HbLy8Flt4sinHR9grQXUqyHsGoyVNvWywNFCXuQO4bT8T4cXJ4WA/Rws1wepuW4SKdzL6uMwFc/O1n/CfFg7RLWGWCCaE32oIAbWgxFYSHCV9NjJ3Stfkk1g==
x-ms-office365-filtering-correlation-id: 41720138-a907-443a-f35b-08d6649ffee4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4102; 
x-ms-traffictypediagnostic: AM6PR04MB4102:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-microsoft-antispam-prvs: <AM6PR04MB4102DABE64DA37468AB50B8784BD0@AM6PR04MB4102.eurprd04.prod.outlook.com>
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
x-microsoft-antispam-message-info: 2SvgwclkNAostjIRNvI70+guik3bkOESmc5KNp4FCyUUXak2uEnkX4ztL0swk9Vj5UE3IyJSSop56LOFn0yIZSIrH2+IdyaI7aAUWQoU9wliWGyRrGWZZMy4+OAqw4wPxo2d5ByvnSKfdb3XHZ7hd0GGqpWTbTl7jNR5cTKUTF83IHmSfhqs0EklDCjX64Ba/eHH1e1TAaU44uKanN/liKOT5h4yeFq2vuEZH305YIpFRZtuGNmfKM5UQgrCjorhtyhOG2EEby23udHwEvaIlgoJh4I+lmCO4xy14qH0ZqmGmv618Ynd/88aRWmyItJS
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41720138-a907-443a-f35b-08d6649ffee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 04:19:26.6624 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4102
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_201939_364406_0ACE502F 
X-CRM114-Status: GOOD (  11.33  )
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

Add num-viewport property for PCIe DT nodes to specify how many
viewports are implemented.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V3:
 - New patch 

 arch/arm/boot/dts/ls1021a.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index b769e0e40553..b455acc7afb4 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -726,6 +726,7 @@
 			#size-cells = <2>;
 			device_type = "pci";
 			num-lanes = <4>;
+			num-viewport = <6>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
@@ -750,6 +751,7 @@
 			#size-cells = <2>;
 			device_type = "pci";
 			num-lanes = <4>;
+			num-viewport = <6>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x48 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
