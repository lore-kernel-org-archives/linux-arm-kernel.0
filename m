Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6666FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:40:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C512081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PHQWagL3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UM6As4Zd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C512081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nn4elARdrpmQrTELQBIEE/oS1JVC5eZEKJ4AIdhNyoU=; b=PHQWagL3cbtyKM
	TZT742r2HB1TXmaBbEM/Of/drVziQTKIPR6toQBVfIUtzBlxKuKziqE+9k76xaAjGyP7YbsRPOJ3I
	iX4yGXhzlUmT/7aD2LR9Y/0fyM2pVEHDvRcUEi3GTuGajzJ5tdjFYJis0umfReZeLk6gwwU3ZFsFc
	/l1kqTMBgBXeMwM6V7i6RF0R5Ojh2t2DPT13xZpUlstK+lMH6n6QPm6x5/dmxTScwkJGdf80TUW8g
	Mo+ACG+824KHJSzM8NRLIClchn68jXqF3bCZxhFOqN8WrD09UdgI0kvIpUQDYmllxiVSIGUBnKbNb
	V2rSv+mgFocOvvKGd7tQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grJhD-0003dy-11; Wed, 06 Feb 2019 09:40:43 +0000
Received: from mail-db5eur01on060b.outbound.protection.outlook.com
 ([2a01:111:f400:fe02::60b]
 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grJh8-0003dV-FV
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 09:40:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NerbTGmjH3+SGQSFKtwUaqf5sZ7S1WEaNY1FPCEdqRc=;
 b=UM6As4ZdnUorMHrVxx4+wjV6wjNaIpHfP6DZPkDsg5CGckxpqMSU9QmQ0LIrWco8lYcYAD6EXR7vYEcyTvd5fMzxRvvwk9VU7B6O4VynBzlUhBglEccJmQeSIC8u2pTJlEQzJw/rj3ysqncgj3t3H+AO7Az++cokSka13qQo418=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2350.eurprd04.prod.outlook.com (10.169.133.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 09:40:33 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe%8]) with mapi id 15.20.1580.019; Wed, 6 Feb 2019
 09:40:33 +0000
From: Pankaj Bansal <pankaj.bansal@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>, Andrew Lunn
 <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v3] arm64: dts: lx2160aqds: Add mdio mux nodes
Thread-Topic: [PATCH v3] arm64: dts: lx2160aqds: Add mdio mux nodes
Thread-Index: AQHUvgABt0FSxwLfGkq2pK/QIZ0c6g==
Date: Wed, 6 Feb 2019 09:40:33 +0000
Message-ID: <20190206150520.9683-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::22) To VI1PR0401MB2496.eurprd04.prod.outlook.com
 (2603:10a6:800:56::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [92.120.1.69]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0401MB2350;
 6:akRWEbxJ0WSzl/vnWvn7JaeKBq5oLx1bLq4btk0kM7Y9zOJy5rKMKwZbVCaZhDEIDIjpgVoJmnk7b+xkknsL/PquTAbOyLBJ1pRX6PXGH6sB8udxvTrqPrsIZW/2C5Qi6MUW9lE3qL1Wh2MXxwimQqkeaxAwgfPxB1hV5jPJn6MwpV6PU0tg6gemE/yOqgZsiXRWtMuN5GkOrX/Wo2IIqcLScLFZ1z4YMjA43Ct7pk1CrLLP5UUIa1ribGyiN/1iDj+uCihe85x1L7KcVdt5HlfrXLsRBCw0Ynv+X5Xjd1zn7nODHiqyjiJ2mMPTCaaXyxQXcBY8WOgP/YvIvkxIQ6uUyr07KL6E/uiPiDitgK1ZRRPbCuDFpIHldxxoocouHL8wa4W9DXQMnNpVlb/3G4rrqqMpmaKVIHm1+9KdAUpZ0mNdYA6hTvu3bNeANrhRkOO8e5JlNkjpZ3e+ROpXIA==;
 5:OgjelriUrA7eT/dN5zy4/5hNE8NI1b0A2oxAleJf6QOgmDxmtWUjyn7i2EUaATZmSYWR+YoEl0weaN36vsAFDYsEgkhQBLds8nbK2VmfPjRuBPHAexOoQGNKq6zqGHg5RF5tjBgxwSanqOg1e4UoZBykv+Jafq9XMQHklfeT/9Ei21QXXIGQsyH7Gwxyl1hV/ZEmBui23L5YzHmhb8dhXQ==;
 7:8itc1256mX06dYHaG2BiCOg/AVAEpVMdCHphSreEZ0ZDUDZHBNX7w52xTv/REIHsqo782tK8ahCbu9Hs8iLeYVeUzS7Izqnv73QC048aOLhqowW1lsOYhWrkL3IVPBXj0wG9baoSaTkJYzKJ523ETw==
x-ms-office365-filtering-correlation-id: c5267393-b68f-484a-b821-08d68c17238c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0401MB2350; 
x-ms-traffictypediagnostic: VI1PR0401MB2350:
x-microsoft-antispam-prvs: <VI1PR0401MB2350B02C2B998437E8D088A6F16F0@VI1PR0401MB2350.eurprd04.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(366004)(39860400002)(136003)(396003)(189003)(199004)(81166006)(14444005)(6506007)(386003)(256004)(305945005)(25786009)(1076003)(106356001)(105586002)(7736002)(102836004)(68736007)(4326008)(14454004)(2906002)(86362001)(36756003)(6512007)(53936002)(66066001)(6436002)(6486002)(52116002)(81156014)(110136005)(99286004)(54906003)(3846002)(26005)(71200400001)(6116002)(44832011)(71190400001)(316002)(186003)(97736004)(478600001)(8936002)(476003)(486006)(2616005)(50226002)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB2350;
 H:VI1PR0401MB2496.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VY03uBkoWgcn8+PYuvVkB/JYpNaE5rwXs8zemBgP+NXKV/ZOuIRaH3tJjVaRmgfL+CFdZS2wXQWL4Dn9fDSdK0hcbx29X/sjJ+JsMm/RJA/dDZHKzR0Q0nXdYlP7N9/pQXIMbyXwqo5eyzQFQg8BeSpcaYyCbFKRPN/7+mmkBZFer+L5yjnIrhEMI9LN95PFgP7vJOqRBI8OxYfrX/a8AVAorIUXBI/pn5S/OCGB25tfyZRv48z+42szYzXRlsAth840c9u/rqthz68faxHbHczHxiaw/ClInHbZ6VCNY3M2freTuxBr+ZM1iWP40MEYM2mLWGuoxZCG7h0Voc2FSr/FCVqIuwDMgAuHDaO1FuyExQThcM//gqUpx4yxfxV3woretOyVgAbwQW276+f0W/8FYaLxoFbIFsfgBtF3JUg=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5267393-b68f-484a-b821-08d68c17238c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 09:40:31.2922 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2350
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_014038_898134_6A1A75D1 
X-CRM114-Status: GOOD (  11.48  )
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
 Pankaj Bansal <pankaj.bansal@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The two external MDIO buses used to communicate with phy devices that are
external to SOC are muxed in LX2160AQDS board.

These buses can be routed to any one of the eight IO slots on LX2160AQDS
board depending on value in fpga register 0x54.

Additionally the external MDIO1 is used to communicate to the onboard
RGMII phy devices.

The mdio1 is controlled by bits 4-7 of fpga register and mdio2 is
controlled by bits 0-3 of fpga register.

Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
---

Notes:
    V3:
    - Add status = disabled in soc file and status = okay in board file
      for external MDIO nodes
    - Add interrupts property in external mdio nodes in soc file
    V2:
    - removed unnecassary TODO statements
    - removed device_type from mdio nodes
    - change the case of hex number to lowercase
    - removed board specific comments from soc file

 .../boot/dts/freescale/fsl-lx2160a-qds.dts   | 123 +++++++++++++++++
 .../boot/dts/freescale/fsl-lx2160a.dtsi      |  22 +++
 2 files changed, 145 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
index 99a22abbe725..079264b391a2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
@@ -35,6 +35,14 @@
 	status = "okay";
 };
 
+&emdio1 {
+	status = "okay";
+};
+
+&emdio2 {
+	status = "okay";
+};
+
 &esdhc0 {
 	status = "okay";
 };
@@ -46,6 +54,121 @@
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
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index a79f5c1ea56d..7def5252ac1a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -762,5 +762,27 @@
 				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
 			dma-coherent;
 		};
+
+		/* WRIOP0: 0x8b8_0000, E-MDIO1: 0x1_6000 */
+		emdio1: mdio@8b96000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8b96000 0x0 0x1000>;
+			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			little-endian;	/* force the driver in LE mode */
+			status = "disabled";
+		};
+
+		/* WRIOP0: 0x8b8_0000, E-MDIO2: 0x1_7000 */
+		emdio2: mdio@8b97000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8b97000 0x0 0x1000>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			little-endian;	/* force the driver in LE mode */
+			status = "disabled";
+		};
 	};
 };
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
