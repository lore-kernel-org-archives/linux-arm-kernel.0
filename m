Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8F6C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:47:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF507217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ts/6OVul";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="y4zJK6je"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF507217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gKGMJPBi5+lqyec7MtjMAgSRZRgH7zTXqoF1kWL2iS4=; b=Ts/6OVul2+zW8q
	xnHXwdrFzrp2K5yNuJrL4eVnpGNmBtyVfesMgFzK66+DLpzsBi7AF2GLbHU/QuaJLLkn5Phw5KmXV
	1c0mcMgOR714onkx3V/hpkS0B4PGOCx4Pfkgu66VglQ9GGNRYjdGQ6387UKV5FMED93CXJ898jO8U
	j00zh15jtI9oUPyhMcPii/XIiisQMKAwR0pWAXdBsFLTerPZ/5g0m0YWN93jSmVGivFIgqz2ASl4G
	PilF6vNfuOKltNjeWBNpiaQcXNKDZln+jFqWtjGxeL+65J6fv6FTX1XFrfyrRNrFnNJOJwMvIqXK9
	372ncuxGBOyrNkruU8aA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr2wF-0000Ah-Th; Tue, 05 Feb 2019 15:47:07 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr2tR-0004pU-B3; Tue, 05 Feb 2019 15:44:37 +0000
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; d="scan'208";a="26335556"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/AES128-SHA;
 05 Feb 2019 08:43:57 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Feb 2019 08:43:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJL2tcMdb3Wh+LX1moI1rIvzhnbFvdBbNiJ+NP+jTdg=;
 b=y4zJK6jeOnz5sIqYhfI7RiQ+zlRi5whjfyoWz7FOR22jB5ytso6Cdg8snbJJcPWHoV68BItgBcaCPfj5zqup8a8uRo7v39JJtn6ZvvS2zfh2ZcpnkQaEYzm4aFSU+eOAAIbj7KbbtYAZKzj3DVemWmF2SSX2er4Im5qPHHVZo+Q=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1235.namprd11.prod.outlook.com (10.173.26.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Tue, 5 Feb 2019 15:43:54 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 15:43:54 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
 <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
Subject: [PATCH v5 10/13] dt-bindings: spi: atmel-quadspi: make "pclk"
 mandatory
Thread-Topic: [PATCH v5 10/13] dt-bindings: spi: atmel-quadspi: make "pclk"
 mandatory
Thread-Index: AQHUvWmZxI5L2C0oQkuo4lo++dIp7w==
Date: Tue, 5 Feb 2019 15:43:54 +0000
Message-ID: <20190205154257.29529-11-tudor.ambarus@microchip.com>
References: <20190205154257.29529-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190205154257.29529-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::30) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1235;
 6:P+3zViMZpr+qlJS/ShjY75RD0CgkV+tx3F3tuO3h70Igrh3BoHvZI2NdTDKVRvZLQeGnBdToLd/FR2XUwguXbQzsWVaTGcMKyBZJ6k0/Sf/Vpcij4lualb20XbPJ6dAqB63k3ixDi9GFWs2LXFzFL9V/dfYuKfVlSRoJnVWqY/N6gYV6zH0LAa/XZgM2Lo7ytRSCJJLdSfy6ggRAbEFkTZLhbkSgIM5tLx1b8E0oIpiRemq/xYLi6sXb1zEYCYUt9yf8PtPnNOaROFfccaz6B2mjMdwmzE9GyQjSBHDxBR1N3zaLvT1lJVJ/Qsel4v7S50CjPWzkWfEhwHE5b/VrRGt1MMTaf8Ymi3k6Ibwz2E676Na6o0uFOtxHjtLpPWCfcDP3jl0bzHnWdhWUozmpMqrkD6u0m5fPrdKBvp9h2sjQ5c+G9WHY8SSg0+bmy7sRz4XJJcrjFdc+YsiFSbx1sQ==;
 5:3K3y9xODEFT+W3hnAPGia14mwUZPkclm8610lyMCAlG/AQP6dS/QZp04TWAGSp6YvTYXg+VBGZ7bloU8Tk9bby4Bz99BZoJfshVmB3CijbeZ/dVeltTRLh7/VoF/OnEPheYVMGm1UUo3aFgNZ+mS4rvNFP7YjOEyr4ntzKh7ZqxkSs2y9c/YvcdV7MksRAvF8mIp2IWyqJajp55C2WF/ww==;
 7:xpJ9lxgX5RDPwC402hw0FqvqrCsZOdDdnfAC/oGxM6R/+6hCNU60GEh20ETzYkixKd7oJDt08dfLvZE3swxGZYmtzxGr49hGHV2ArD1UWxaNo+EPcJdNZ3wCgUnZ1T0yoSd/g5CeG6M/4+5tK25JuA==
x-ms-office365-filtering-correlation-id: f1bf5253-9129-4f1b-f4db-08d68b80bba8
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1235; 
x-ms-traffictypediagnostic: BN6PR11MB1235:
x-microsoft-antispam-prvs: <BN6PR11MB1235B6ABF9540CDB2B828640F06E0@BN6PR11MB1235.namprd11.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(376002)(396003)(346002)(136003)(199004)(189003)(14454004)(7416002)(486006)(305945005)(11346002)(7736002)(2501003)(6506007)(186003)(102836004)(26005)(68736007)(71190400001)(2906002)(476003)(2616005)(106356001)(97736004)(105586002)(71200400001)(86362001)(54906003)(72206003)(446003)(36756003)(4326008)(6486002)(6436002)(386003)(478600001)(25786009)(1076003)(316002)(110136005)(8676002)(81156014)(52116002)(81166006)(8936002)(50226002)(66066001)(6512007)(256004)(53936002)(107886003)(99286004)(6116002)(3846002)(76176011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1235;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VirgvViGsQ1Ujkuj80IYoCNFtK8yqVjZWF/m+p2wvzM+409QW3QgMV5K6XATSPE732o9LLGQsTkttzrJ1GB2fGmVvH9Ir/XTXarxlG57OV3+ZdS2Cr9c9KkRTRp9pj/5JQS/ATul6gkOprgNwOSgruPC8GXy7t5vm9KlvMGsGYItGalnIQL+uI0hTlnOjzql5oIArnU3k6ewTuefbGxxh+kPB3AlzFsqMBtD78aK8nVNWgOTPiFRBTP3u1FcoUAfryEQjs18lNphUt9vTGs3QPVaEnA7u7XMA7WsIEe9+juKAUc7yxXNx8j/3UjjGA+pZBcYDEa+XtCd6SzyMK4oUe770AGdqQ1BUeeV6As41Xwjyjj12W1nqxY0keHyoWw4cUsQC/7rDz7DtpwOaeufCkxSRj0PpChfbiZYJcj0RPo=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bf5253-9129-4f1b-f4db-08d68b80bba8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 15:43:51.5950 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1235
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_074413_918258_129DE29E 
X-CRM114-Status: UNSURE (   7.00  )
X-CRM114-Notice: Please train this message.
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
Cc: devicetree@vger.kernel.org, Tudor.Ambarus@microchip.com,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Naming clocks is a good practice. Make "pclk" madatory even if
we support unnamed clock in the driver, to be backward compatible
with old DTs.

Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v5: no change
v4: add missing semicolon, collect R-b
v3: new patch

 Documentation/devicetree/bindings/spi/atmel-quadspi.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
index e9dae6264d89..50bd257e6826 100644
--- a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
+++ b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
@@ -9,6 +9,7 @@ Required properties:
                   - qspi_mmap: memory mapped address space
 - interrupts:     Should contain the interrupt for the device.
 - clocks:         The phandle of the clock needed by the QSPI controller.
+- clock-names:    Should contain "pclk" for the peripheral clock.
 - #address-cells: Should be <1>.
 - #size-cells:    Should be <0>.
 
@@ -20,6 +21,7 @@ spi@f0020000 {
 	reg-names = "qspi_base", "qspi_mmap";
 	interrupts = <52 IRQ_TYPE_LEVEL_HIGH 7>;
 	clocks = <&pmc PMC_TYPE_PERIPHERAL 52>;
+	clock-names = "pclk";
 	#address-cells = <1>;
 	#size-cells = <0>;
 	pinctrl-names = "default";
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
