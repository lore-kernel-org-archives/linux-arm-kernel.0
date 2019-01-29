Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C590AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:25:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90A312175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NS5piLDk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cncNNSPu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Iz/OJiAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A312175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kfXU5jH+a3IhY44YeJ4vK9vE8HK9wkONaXDF8rAsYSY=; b=NS5piLDko4BgQf
	3A8W/6vYRH5To3iEtu0Rf4gqmu8MqrPHZ4oz6OL0dpJuYxTfToCI7I6x0FuGChUtBGnxQs63Jdll0
	6TKkk47H+olvYCOCI4sBjUhR8YJT/AzpBOunEeyb26MZrhxq40wXQcl5L/uX1lYWJczzj//Y5pTcr
	YEHSoJSOZRsdjtWdxKG0xHbDOV/o3EC5MKzIQorZ6tjIK1/ditgK0UIefHE7ptEVAd/rGLXQ/IyrD
	zyvEimVLurV7fsNbKOqEFOVdeXagEZAKFxAj3gPYs080gAodyCkqYPYjFIqx0MthuMv4OujTgY1Oi
	+ajVlCEHGV7FymxfPdeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goOiA-0000mA-3E; Tue, 29 Jan 2019 08:25:38 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goOT4-0004si-5P
 for linux-arm-kernel@bombadil.infradead.org; Tue, 29 Jan 2019 08:10:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s2KL3lq8cGHB4T0MlDA0MHl8UFeRA6CA9YVP1gwvvPQ=; b=cncNNSPuA2Htkf3oXx3EVCfJ7N
 E35eZ69iQSXRTVBQMrOkEFkEUUUYYnxvlzSajzuuj50NfZYk7EhuACUf1yiiPGGcxqhEWIdTKp5Yc
 pH20acu0I318B8hw+//KqVEnlK4E9pLR12eTG7sn142KAbVzhJXHdKe0C6Y5bfL4d/4+MW77WmE0Z
 4LLnvPGPFl1NOigsz6oPXc1Z+KLTZ2RwuBuTuY+YWWBLZNDxbGmOX9UdySocjJfvOwfvXVm5bAbqL
 55MIHusu66mRbeQqRgP6rIbQXkU1YhPlfc+3d5b0iCovzOehCUwmmNqwv0JF78TOzPCergI5JUMMD
 JH6cNchw==;
Received: from mail-eopbgr70085.outbound.protection.outlook.com ([40.107.7.85]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goOSz-0007U6-9E
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 08:09:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2KL3lq8cGHB4T0MlDA0MHl8UFeRA6CA9YVP1gwvvPQ=;
 b=Iz/OJiAeo9XHcQ+Wm5Q5T7mkmWQFEaWEDIKr6TlfecIsG+FcWN4SZF+xvkLzpoq/P3Ek0igXwsMnj0yiYWT4HsHyqr+0XimceUW2l5JoHLHt8/FUxDatjpvvZworApM9DceTkxHgPQa04j3aDhZjpsszolNpcMjqos5vfEt6/GU=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4728.eurprd04.prod.outlook.com (20.177.32.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Tue, 29 Jan 2019 08:09:51 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:09:51 +0000
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
Subject: [PATCHv3 13/27] PCI: mobiveil: move irq chained handler setup out of
 DT parse
Thread-Topic: [PATCHv3 13/27] PCI: mobiveil: move irq chained handler setup
 out of DT parse
Thread-Index: AQHUt6oCmQwmtRffokSeu3VU1YDeTA==
Date: Tue, 29 Jan 2019 08:09:51 +0000
Message-ID: <20190129080926.36773-14-Zhiqiang.Hou@nxp.com>
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
 6:gUIOfcDRmx16FWpqG3GQKaSbvlKTixoCAX1DIh7qV40LeukJWSo6h7m52ET5dnj0aI6CDhHN6NEcr+L9WTsxTpLa9QSc5MTZPTjb0qDMp3ZsvZsHSj2TvlJjOuXar5a6QgIYQRKK69jA3og6YgracqiXc5o618PUNezp8TDDs1FneyNXzT/tIpBJ0OIOa0e5VUPseekaM/QSkwklTydUEg0p2VrLz2Pvn+Ou2yPd9HHXnS3h4mU47GeS45/RsRjVNQZDGw+XABxc19kapE54+BaNca37KgGRq6M5dJ9cx7u7MmcCw/nOF95VEW+LZ68wzLu1xfVEW44DKYzIHfPnahq0aOT+MZno0nJRSqoG1RNduV9gqA+0v5NpnId1rK7FGD3AEIUhv1CNdSaBGPK0BZ641SErh5+mOZ33ELW/+sZ5YuuHOZqQQ8TdrLyUXaC7FlBsemTsmziAPtb0JPxBwA==;
 5:cJ7wxmKRJQXzCp08KA8kMxVBLkULuYd4RKSqhG29NSnoKwVbHqmgs9UMIz4ykYlW7ali91XWFIyIaKqZfIwxH1JlzvWMH3eH3BY98lT8p/z4+u21CjHdwmqf4Qm3eXCwqHhUUDJumEf4yTX5Cw7q2CA14Dh5FZBMhzWYetva/JFgkOs993MknKpa/uWkHkCvzbXdznYqO1EglaMpC+GHCA==;
 7:NOgXrtwQeXiPEIydphQAPbHaZiwkzkqcaJrkvveQB4TT/J5cuAr/FkEgbf+JhNGbLE1BelMBDksBIiGdaRx0+/zuhVoBo8GoA7Z/gC9a9EYMDxh89uE7PVVH9XvwQvzFvZBrL2f0moJD4tMTC+CZwQ==
x-ms-office365-filtering-correlation-id: c6b9869e-4f86-4bdb-be48-08d685c12493
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4728; 
x-ms-traffictypediagnostic: AM6PR04MB4728:
x-microsoft-antispam-prvs: <AM6PR04MB4728D3C131232C75C619E7F384970@AM6PR04MB4728.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(366004)(396003)(39860400002)(346002)(376002)(189003)(199004)(3846002)(7416002)(4744005)(71190400001)(71200400001)(2201001)(36756003)(4326008)(316002)(6512007)(105586002)(53936002)(6116002)(6436002)(106356001)(6486002)(86362001)(1076003)(97736004)(81166006)(81156014)(476003)(2616005)(486006)(256004)(52116002)(446003)(68736007)(50226002)(478600001)(2501003)(14444005)(8936002)(8676002)(66066001)(6506007)(386003)(2906002)(11346002)(102836004)(110136005)(26005)(54906003)(76176011)(305945005)(186003)(7736002)(99286004)(25786009)(14454004)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4728;
 H:AM6PR04MB5781.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2MA8twzhiBzrqPy0ccMMQ/aDrp3qtEXfNvGKnWZxIxL6VPAUoVf7ILnGq91pASaAbWS80SmXL6UUbLHK4VUGwc824vgk0gpkqG/kPhsISxIQfE7rx+jYSsCVpfuK7fw8K0URpKtFxk2CU+YsjSsBv5Li21RU15cNJIk/laWxtwhZgnTXSrW8ZJz2CfSmf3nAmzymqs+OSboE8wJyVcUl8FiEVvh1JQSc78PwboMjNHeXluKazi2gY+8nAbB3dfZazoqT6s/TofXzLdTFZuF8I9BtpF+hr7i5bQGf867V1my38KwShnoJMv/1VehddUzKJ593OR7qXAfNuBWetutgsnZLqJ8noryxDvVFuch+F94G2qcRVfNnP6i3BTDOlYiheNJkp4N1QbT9PBMStVriC0z42wX4uWCLOKAmrzVfnco=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b9869e-4f86-4bdb-be48-08d685c12493
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:09:45.2253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4728
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_030957_380204_AB2EB208 
X-CRM114-Status: GOOD (  10.40  )
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

Move irq_set_chained_handler_and_data() out of DT parse function.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V3:
 - No change

 drivers/pci/controller/pcie-mobiveil.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index c2848c22b466..db7ecb021c63 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -460,8 +460,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
 		return -ENODEV;
 	}
 
-	irq_set_chained_handler_and_data(pcie->irq, mobiveil_pcie_isr, pcie);
-
 	return 0;
 }
 
@@ -902,6 +900,8 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
 		goto error;
 	}
 
+	irq_set_chained_handler_and_data(pcie->irq, mobiveil_pcie_isr, pcie);
+
 	ret = devm_request_pci_bus_resources(dev, &pcie->resources);
 	if (ret)
 		goto error;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
