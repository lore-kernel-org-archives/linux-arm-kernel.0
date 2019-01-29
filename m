Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC2AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:14:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A6C2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LxRr/iE9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FLKTYini"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A6C2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ATN9aJHuHLZcweuB1Pk7m9XhOq69obBAXAetfvDC3wY=; b=LxRr/iE9LqzM9q
	tqE/hHmr8T3QWwt7cu8AQhHa57ywS1PBqYw7weJqO2OTu9Qb38lOfyPKJ3MAqdnT+3kk38BNIQzZZ
	UOGvAir7hwjTZNbxsYrzWIjTRAUuOIIXdXOZ4X0cDJC690TCOUAHVYfwPi2FVFpQWXxNwaCEGjup7
	l6XWmxRwa7/oW+dFZhyMwNsZHy++/kFz40ZOd2MqmAf8pQ9XDqA17Zl+2FSbpH50fzhLXDQqYxuVy
	VOAP4dK7sP/lZqWhY1kKaaO/7nG1//OwVcD/Z3LzTG1bKoBqAISHXNP/5SESD1ZLi648KP7ScQtb1
	ecJ03uuRYdLuKQrOUssg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goOXe-0001qU-T3; Tue, 29 Jan 2019 08:14:46 +0000
Received: from mail-eopbgr130040.outbound.protection.outlook.com
 ([40.107.13.40] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goOTv-0006i1-Bt
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 08:11:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+tnkm0JpQRZ3iG5X2dYBgnyFYIjtyW90C35s/VTYPQ=;
 b=FLKTYinigm00iT7VRjSCVK9SCtjWw0IjTIosGCpd2yT2oDrode4RXCxy/LHGjot2P3DdzH4yl5mfWC4/FKwJ3lru5N/Wd4UA1V2yykLTAA560MJRZVMbb5YFEuYQDkSveMml3IRlLSuahNVBf/pLcosStc8IQ+6y2XrsADE/5GI=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5127.eurprd04.prod.outlook.com (20.177.34.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.23; Tue, 29 Jan 2019 08:10:18 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:10:18 +0000
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
Subject: [PATCHv3 17/27] PCI: mobiveil: fix the checking of valid device
Thread-Topic: [PATCHv3 17/27] PCI: mobiveil: fix the checking of valid device
Thread-Index: AQHUt6oS419VgGFb5EOSmkHnfUrSZg==
Date: Tue, 29 Jan 2019 08:10:17 +0000
Message-ID: <20190129080926.36773-18-Zhiqiang.Hou@nxp.com>
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
 6:o6Zntg9XVgJTXD5inO182Igzmfaf1066rJA0s39EaE1BhKwmaR6NvUrMlZHDP5QxIj+/t235kEIgWaKr8pQpahHU9d68QEZyc8xLeus6hV7Mon2Av4xw0YODGj9mHemgh2u06/ws2Z5KSvu+fMTvoeTg/kyaTCaVWJNLfwbkgTiumF60kd5ynBQv8J/5mdC6tKe0nQpMTbdI87FtF1YXBEKrlFWG7GWWWPduV95V0U5TNCQq82Yz1DmlPDab97IygAz6jaq5Nvxa9YyMgVXAzhcDWYtZTLSt0Z73BvTV2rGDi9N349gXIdrTfYXloC/Ga702UdCzCeaT+QZ+PhvalV+8P0CcmF9IPQO1kxZP1g9U3maWPoE28TN6LkfBk8LpIh8EzUdNTR+UY3FfGtPQlxxXCTG8iIhTOmaIF4tpjbpLpLC0Z+5FTHvoSukEbsw7PUg7lhG1eKz2ABGXeBh75w==;
 5:/MXUBOEalw6teUXoanm7J/rCDOhc0uTq7b7LCRUmpvDeC5cVKLOgLzzyMZPO36WHxTHLhKYSDLoqNZp25RE+asbB1FLAz4zYoyseA39iUM7djmyvc6ZCzyirMIrWOtvRkXLa+ZT49KBnc/HAPYqILZb/6qsvbHy67q8hKHL5wV+u35xxJHekYIMAqy/ZKD05KM98lGSYEIsbClz7+ogxgQ==;
 7:DU+fYyCxqWGF/Vz2+6Ltlf34AObB309AeJD/uuSFqAZzPIML0XthdC4s+q+EtqCxC1biNxjK0BHtqMlYJhvAYDDAEEzWI7e4Dd9xe7NGmKVY4WurXmbIKIldin7JYekec39CIuK0S89UYRwwqclBmw==
x-ms-office365-filtering-correlation-id: a75fd53f-5baa-4c50-73fa-08d685c13472
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB5127; 
x-ms-traffictypediagnostic: AM6PR04MB5127:
x-microsoft-antispam-prvs: <AM6PR04MB5127D6E3BA9E4E6C0D40E92C84970@AM6PR04MB5127.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(376002)(346002)(366004)(39860400002)(189003)(199004)(6512007)(8936002)(26005)(81166006)(99286004)(4326008)(486006)(52116002)(2501003)(186003)(97736004)(76176011)(105586002)(14454004)(478600001)(106356001)(6486002)(305945005)(54906003)(53936002)(50226002)(81156014)(6436002)(110136005)(8676002)(68736007)(476003)(71190400001)(36756003)(71200400001)(316002)(7416002)(256004)(386003)(2906002)(6506007)(446003)(11346002)(102836004)(66066001)(86362001)(5024004)(14444005)(1076003)(25786009)(7736002)(6116002)(3846002)(2201001)(2616005)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB5127;
 H:AM6PR04MB5781.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /BVj3CLcnGkk/ju45vEo90gmE+crwfVcDfBObadyIaRODXYWcHd9H00C/qw8ZQsXsBPK4CW43QftKujtY8J/5ds+K37Cc8a9rs7+Wxps0iDvYj56mrC1PWCn5K38zlmoZfE0OoLRddSakIGCKWEcz84Zlht38l8eeZQGbyrSs9p3mWOashlbradFit3RayemKtx+6KNe5bgH8G/9n+RGnSooheiBAacKgmBjUT/dVUOSTJZonk3hVWWH358l5KyOEF2QGOT62bXWR+2R6PDyddtW69ljNKZ+HDacSrNDioLn4WMdqFTGP04ZlOKsOur2oNjfN4EdNi3hwq3Bx76Qt9aUkH7/s8XjBD4onhO58jP0gP62GgAoSrd1jBsk2MI/PjLaEGJLLjlpzXckUPXdDbZt/4kPTUQKNCrnwWB/YkQ=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75fd53f-5baa-4c50-73fa-08d685c13472
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:10:11.7257 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5127
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_001056_014269_B2710277 
X-CRM114-Status: GOOD (  11.66  )
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

Avoid to issue CFG transactions to link partner when the PCIe
link is not up. And allow CFG transactions to all functions of
Endpoint implemented multiple functions.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host
Bridge IP driver")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V3:
 - No change

 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index dc5324d94466..1ae82e790562 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -29,6 +29,10 @@ static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 {
 	struct mobiveil_pcie *pcie = bus->sysdata;
 
+	/* If there is no link, then there is no device */
+	if (bus->number > pcie->rp.root_bus_nr && !mobiveil_pcie_link_up(pcie))
+		return false;
+
 	/* Only one device down on each root port */
 	if ((bus->number == pcie->rp.root_bus_nr) && (devfn > 0))
 		return false;
@@ -37,7 +41,7 @@ static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 	 * Do not read more than one device on the bus directly
 	 * attached to RC
 	 */
-	if ((bus->primary == pcie->rp.root_bus_nr) && (devfn > 0))
+	if ((bus->primary == pcie->rp.root_bus_nr) && (PCI_SLOT(devfn) > 0))
 		return false;
 
 	return true;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
