Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25157C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:37:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9AB5218A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OzkCPoOG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YlCaNDfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9AB5218A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jSmK1pQNHOQRos7dF6uMcm/GNTLySQ1BJDZntFq5Lzw=; b=OzkCPoOG1ht9m8
	4MsRrG8UbIyLiLjFhGY+Ne2pwyevebwEKP1f8bUFhySFMXtzjvLopPwnPdshREQaGQlQ3uBFTd+4M
	EWg1/+Uxqimt5wvcfKoRBpAoH22djT4JsLLQAKaSCvObWHSxGdVTSiomauqAYlRJUAVPxYGMQbprs
	Cu6XTjqftxO4kAqespoXFsWTOApks4Y9v/P6oSYuiiywcnx6fj3OQsZ37ADOLIYZzDLc5EXlxUG6e
	fYjgd8natQT7blZtojd21ZiM9jvvrkW6EMdZ6DYWkRo1POW4isHJTN2tWqUaEDQsZ9HuoBCPrsZQa
	zMu0lK+CHOVnNt7+udbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gonF4-0005Gf-HY; Wed, 30 Jan 2019 10:37:14 +0000
Received: from mail-he1eur01on0630.outbound.protection.outlook.com
 ([2a01:111:f400:fe1e::630]
 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gonF0-0005GA-CD
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 10:37:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jvy9fgb8GuUMJ93GlZeRirkPv/PoMQG5cD8ammP8Y7o=;
 b=YlCaNDfALP8Mj/nKBv77Shw+rQxDBLYZq/zOZOBIZERSbOr9xTWDMUVMREG5wKZTikDMWPMLs/2xmO1XacoyZn1+6jS6ajcBLLrNcLdyXOqySI8jfdyk0p8xYHHgEllwfVZn7XkW+iMVav0Y5OSltdmM1ZDdbG7/eiv1hpu+0wc=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2351.eurprd04.prod.outlook.com (10.169.133.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Wed, 30 Jan 2019 10:37:03 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe%8]) with mapi id 15.20.1558.023; Wed, 30 Jan 2019
 10:37:03 +0000
From: Pankaj Bansal <pankaj.bansal@nxp.com>
To: Pankaj Bansal <pankaj.bansal@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Leo Li <leoyang.li@nxp.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>
Subject: RE: [PATCH] arm64: dts: lx2160aqds: Add mdio mux nodes
Thread-Topic: [PATCH] arm64: dts: lx2160aqds: Add mdio mux nodes
Thread-Index: AQHUfNxsajYtnIAKbkGB1ox72RwWdqXIEDkQ
Date: Wed, 30 Jan 2019 10:37:03 +0000
Message-ID: <VI1PR0401MB24968C7FA8CE3CEB291FDC94F1900@VI1PR0401MB2496.eurprd04.prod.outlook.com>
References: <20181115173752.22482-1-pankaj.bansal@nxp.com>
In-Reply-To: <20181115173752.22482-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0401MB2351;
 6:XqhLAW7aE/EtJEvFxGFgxRmjY6GFB7SY9et171YXnKVINtDDH+hRKo8m54v3VbRnhPPBcT7EFX5uETYd56uuF/CdYAEVcZr7w7M+OOyu5kU1wY7g6qvuf1A8BCNd39X6Ebpijeh9UfAwEGLgTYjCISgd+J+h/g3qMYY3U1OigJ56vY5kqA2g6XyCRUXdhHfqIMBzsudMsRLhSJYAh50+FsDgbPIZA4Eb62OHd0eUoYFr3vujmImpE0T+UNzntyL1JkQINADP/6sur8nkM+rV8yi2rsBM9g/UZdTDOUNnXMirJ8bfbQCGXo8SdryEZuu9eE9n/gi7RVEERX1Abl4sQPjCRAUDoMdhMoY8NQOoVSbELexqewD1dfhpkJuzWi1Nb4IpcO3YHzI9kjFADZft5dMDHKNfh+CAETe8Yj4snr1ZPfG82/kw1chgHVlFMbybJJBVjyX79l4iHXeNOSZUAQ==;
 5:7UTs64TCw9p7DIvwqlMwFmuaArVgCf+dVT0sBSc9QVunZOTGQOzpBqATu7T0LrQExJ/CNRBwrVmDYMdeAZsj5Xy+FWsORyPnvWC4IpTBtAHed+eRs1fBsSgjRedA3b/Ykigg/PBJAVSVQo+tejqi9kgMRUHG6zOSn1egr+1DNCfzW3EgYwysMsY8Q9ejce5F7exDbPm0bHLR9wbuPYWm7g==;
 7:X2owKK+rsOKBbOdhm4k56ugbFVI6YSYz+cL5nh68/mOPbnG6HhmQxRKWyKPDgDEQfRTe3zHmgliMilLVB6mYQD5HSmBP6J3hwyXTfhWHhTY1AV7/YKaUnrtlpMUrmkRv8YrKR+0PrvWmxUDBpwiwKg==
x-ms-office365-filtering-correlation-id: a14662c5-c4ff-44fd-f969-08d6869edf9e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0401MB2351; 
x-ms-traffictypediagnostic: VI1PR0401MB2351:
x-microsoft-antispam-prvs: <VI1PR0401MB235196263470B271B25C43E5F1900@VI1PR0401MB2351.eurprd04.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(39860400002)(346002)(396003)(136003)(366004)(13464003)(199004)(189003)(71190400001)(71200400001)(68736007)(11346002)(81156014)(99286004)(8676002)(8936002)(81166006)(486006)(33656002)(446003)(76176011)(105586002)(7696005)(305945005)(476003)(7736002)(26005)(110136005)(54906003)(316002)(186003)(6506007)(53936002)(53546011)(6116002)(3846002)(102836004)(106356001)(66066001)(229853002)(14454004)(2906002)(97736004)(6436002)(39060400002)(478600001)(6246003)(4326008)(25786009)(44832011)(74316002)(9686003)(86362001)(256004)(55016002)(6306002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB2351;
 H:VI1PR0401MB2496.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6a7Kst4iGK+n3K2l+7aUy6Ou7tbAk6kuqdzkwumzuLL6x2AwRP+LN0E7QDvgClH/JZJ6kdbdDDTW+S9r+ZeFy5AtAWbiNEa4lda93NsDN89YAV9JKHrmTt3ucmVR+ZTo0H/pRNhf0qsveYEHxU6335QT4FZ7EqLhtpGqb0HJQ2ImY8QirYy7DFfqh4nWyyWkieu1DHDJI0JWmbNmA2iae3SDipj8OjEfe+hx7X5C9HzboVYvAqBW+5p9RXfYqzD+xZZBaYB6BVH2fagtrAS/p3tiTPSSHojE8d0ZVCHIHl7Jidj3MEO3Tjr7J5OWMA99rb6MsYrzlk3e1nFIhvyZI2IDKypUPlNv+xW7SCjKknZDisH/E3OKF2VwctDG7W+T5w9EUQ8yxfqc1joE3zDjCc4ItA197OFZALspmJ3MFgE=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a14662c5-c4ff-44fd-f969-08d6869edf9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 10:37:03.3102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2351
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_023710_416693_DE75E206 
X-CRM114-Status: GOOD (  12.18  )
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
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

HI Shawn/Leo,

Can you please review this patch and include it in your tree ?

Regards,
Pankaj Bansal

-----Original Message-----
From: Pankaj Bansal [mailto:pankaj.bansal@nxp.com] 
Sent: Thursday, 15 November, 2018 05:42 PM
To: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Andrew Lunn <andrew@lunn.ch>; Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: [PATCH] arm64: dts: lx2160aqds: Add mdio mux nodes

The two external MDIO buses used to communicate with phy devices that are external to SOC are muxed in LX2160AQDS board.

These buses can be routed to any one of the eight IO slots on LX2160AQDS board depending on value in fpga register 0x54.

Additionally the external MDIO1 is used to communicate to the onboard RGMII phy devices.

The mdio1 is controlled by bits 4-7 of fpga register and mdio2 is controlled by bits 0-3 of fpga register.

Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
---

Notes:
    This patch depends on following patches:
    [1]https://patchwork.kernel.org/cover/10658863/
    [2]https://patchwork.codeaurora.org/patch/637861/

 .../boot/dts/freescale/fsl-lx2160a-qds.dts   | 116 +++++++++++++++++
 .../boot/dts/freescale/fsl-lx2160a.dtsi      |  23 ++++
 2 files changed, 139 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
index 8a0305a2b778..39aa2731ddfa 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
@@ -54,6 +54,121 @@
 &i2c0 {
 	status = "okay";
 
+	fpga@66 {
+		compatible = "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c";
+		reg = <0x66>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mdio-mux-1@54 {
+			mdio-parent-bus = <&emdio1>;
+			reg = <0x54>;		 /* BRDCFG4 */
+			mux-mask = <0xf8>;      /* EMI1_MDIO */
+			#address-cells=<1>;
+			#size-cells = <0>;
+
+			mdio@0 {
+				reg = <0x00>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio@40 {
+				reg = <0x40>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio@c0 {
+				reg = <0xc0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio@c8 {
+				reg = <0xc8>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio@d0 {
+				reg = <0xd0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio@d8 {
+				reg = <0xd8>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio@e0 {
+				reg = <0xe0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio@e8 {
+				reg = <0xe8>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio@f0 {
+				reg = <0xf0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio@f8 {
+				reg = <0xf8>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
+		mdio-mux-2@54 {
+			mdio-parent-bus = <&emdio2>;
+			reg = <0x54>;		 /* BRDCFG4 */
+			mux-mask = <0x07>;      /* EMI2_MDIO */
+			#address-cells=<1>;
+			#size-cells = <0>;
+
+			mdio@0 {
+				reg = <0x00>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio@1 {
+				reg = <0x01>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio@2 {
+				reg = <0x02>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio@3 {
+				reg = <0x03>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio@4 {
+				reg = <0x04>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio@5 {
+				reg = <0x05>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio@6 {
+				reg = <0x06>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			mdio@7 {
+				reg = <0x07>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+
 	i2c-mux@77 {
 		compatible = "nxp,pca9547";
 		reg = <0x77>;
@@ -118,3 +233,4 @@
 &usb1 {
 	status = "okay";
 };
+
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 6ce0677c3096..518882b05f03 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -780,5 +780,28 @@
 				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
 			dma-coherent;
 		};
+		/* TODO: WRIOP (CCSR?) */
+		/* WRIOP0: 0x8B8_0000, E-MDIO1: 0x1_6000 */
+		emdio1: mdio@0x8B96000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8B96000 0x0 0x1000>;
+			device_type = "mdio";	/* TODO: is this necessary? */
+			little-endian;	/* force the driver in LE mode */
+
+			/* Not necessary on the QDS, but needed on the RDB*/
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		/* WRIOP0: 0x8B8_0000, E-MDIO2: 0x1_7000 */
+		emdio2: mdio@0x8B97000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8B97000 0x0 0x1000>;
+			device_type = "mdio";	/* TODO: is this necessary? */
+			little-endian;	/* force the driver in LE mode */
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
 	};
 };
+
--
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
