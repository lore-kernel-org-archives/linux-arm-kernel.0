Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDECC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:52:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D7F5217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ND3vKiHG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SWX11Wo0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7F5217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=OwHt4MQCuQJ+uMHrWDF6Hvs/PcZDe7+5r0+VJMpTaSg=; b=ND3vKiHGw7YjQo
	sXGDJajUiAETwGlYQxH51IdhTGf446u2ImvNnUrMOQ9a9+VUb6IhH3iHEg022oqmX3RnQJvTEDWxc
	3+VlU/sxAYTQkKxLqasmnciuP+Ytfo7KhkVCGFLvvlTmiWk2edNns5IpFMvyAQWAsJm7a9YiFnHd/
	09tMPJe8IIjc8ettQulMROIcYQxCedJKe3HdjCPSR1Hqgv8srzNOtXnQcfZqwEQzWkJHsRhMsh5n2
	0KzK8W7OIuSWfRx03SnHkCXS6Iu1indrPs/psVoX0++eGpTDBFI4HQKFM/tj2VEnw36Wx/VOLwdbD
	nNpusx036EZwPRLY5XrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqZzA-0005jk-Qj; Mon, 04 Feb 2019 08:52:12 +0000
Received: from mail-am5eur02on0602.outbound.protection.outlook.com
 ([2a01:111:f400:fe07::602]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqZz5-0005jA-RK
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 08:52:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwbxucyBKgwZtd8lUBCfPFCE1OVkX1FdDgQ6jLX0mrI=;
 b=SWX11Wo07K9cXuytI3sZAO0Lga27gUncUTxOWU/A4KYIXMMUuWaj47FfR+pqbsmFVI9RXbYGL1dZMvZ5mEQd5WnMJVMYwe/PRsjbuxaymdpBeWNgYI1eOcAWAcv9cq54NQP8nEFYrdvrMv0gqwKqOC8BP4TJJ9RXVvLI3+01VPo=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2224.eurprd04.prod.outlook.com (10.166.44.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Mon, 4 Feb 2019 08:51:57 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe%8]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 08:51:57 +0000
From: Pankaj Bansal <pankaj.bansal@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>, Andrew Lunn
 <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v2] arm64: dts: lx2160aqds: Add mdio mux nodes
Thread-Topic: [PATCH v2] arm64: dts: lx2160aqds: Add mdio mux nodes
Thread-Index: AQHUvGbiC8iYo4SL4Um4n0hI+dty1w==
Date: Mon, 4 Feb 2019 08:51:57 +0000
Message-ID: <20190204141641.18272-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR01CA0107.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::23)
 To VI1PR0401MB2496.eurprd04.prod.outlook.com
 (2603:10a6:800:56::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [92.120.1.69]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0401MB2224;
 6:rmLkiKqeWsQQfzuqghpv0Q5sC9Ei9dJhWxjNLU/jVyMTkWDuwJ52zVKv5ECcS5+dZqI/LL05ZuaWIV4hjg5hngJXUWz9BanXJwvftwrKas+rsjZC+FF0KlfRcNwtJCuzrFTCEf6HC7Ybu10TibWQH821azQ0yVRNpccOR//5FIzKgIw0hC3ycxi27XsXHXNm72kXgJX4Bz863Yw0Nc4vfHDf2FffmWT8DTumFvKCHN5YYGhlHm8Us5d2EHT5dKRKq4NQ6cmzyPbncvRxXi3NxqmV6DhNRHeb6k2FpE+bFy6OkOtPRi2be64LX6b1R1RbVNivB37Ym3f53UDjPrlZsm6wgieAYhcTbgM/aHoZVhXpabslLXETD1mqLOszx++ATf5E2F2eab5o4v0+pKQDmNemfRIkIsA2QGHbCXNV034edX4xNYQyTozZ2GMXFQvxYgXsWQ0P8ZFl7eRZ7hFfJg==;
 5:sle+7BVXIsNcGkxZiT91V/ZQHP3hwXx9znk+PmOy/25LNSpJptcWaRQuSjjlaJUJbToJGlQ8O3Y7gIPaqb/FGWRkDk/M7VncN/m77rTACz7lpqwB0gXI7BJvKK/38uP3dEm/E9N9J9cbxx/n3xdz9TqU6JqiKRNG4BZ9D/AA5yIaPMQML/M84YJJ2DYBgpOqoBlIhGRno92zUXbdRaDJmw==;
 7:PYL019zUX2b0K4TVU4I4l/hf8dK3LUAf5lV7NtPDzNeLKnhuhPhwFaY9LLhkejYrq+X3YvfngKcJNsTGaojssVNyQ3pzqzNRiJ/tTu/VECbm1ylx9UzE6IokKThQdYd3CyAZYB/ekShe2ihPw+GGrA==
x-ms-office365-filtering-correlation-id: 9cd6e18c-76ea-451c-4371-08d68a7e04e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0401MB2224; 
x-ms-traffictypediagnostic: VI1PR0401MB2224:
x-microsoft-antispam-prvs: <VI1PR0401MB2224CA6A853C47C237B68B78F16D0@VI1PR0401MB2224.eurprd04.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(366004)(136003)(346002)(376002)(199004)(189003)(2616005)(44832011)(71190400001)(99286004)(476003)(36756003)(6436002)(6486002)(486006)(7736002)(54906003)(110136005)(106356001)(105586002)(316002)(305945005)(8936002)(68736007)(97736004)(6506007)(386003)(81166006)(81156014)(50226002)(26005)(186003)(8676002)(102836004)(39060400002)(6512007)(53936002)(52116002)(6116002)(3846002)(25786009)(66066001)(14454004)(478600001)(4326008)(2906002)(1076003)(256004)(86362001)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB2224;
 H:VI1PR0401MB2496.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y3FdstiF3cUpy/DsvpqsmQA4xwzaIyHjrIVa8Qcecqt9Fb8/N7/hipFgcCxGyRH9omViUdOc7kkDFuNrHTdqVUbMxw8Kw+Us2kTkHKJw/giLDjYJ+tfIdvVNavLnNvha7nPw0SgOfSUuwZNLy+tpq2hGSPs+voV+jpFQ8CvKYRGX5wxs0e6ksomx1OqNAOqCudtnNMytWicd56bQdJoLjLe/1xCVZdbg+ERHam6gPq3IAriJ4JIZnNkbBR6WHTU1CSuoJ3Tyg0pK9b74QsOvHdIhBpWX9S3VCNkQH7JmouJHMNC9nXQb5YBY/sTkO6TAzxQThmdPQzlk4u3Nl2l798OUzO/Yd9s/Z0O4RxJLXP8y2LxGvuKUuL0IjGnIMcu2CZI8YhP2w5YiQt2pU25r8AHM0/RJf4lzQB2Weyb2Pyo=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd6e18c-76ea-451c-4371-08d68a7e04e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 08:51:55.8270 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2224
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_005207_975669_6F8A50D0 
X-CRM114-Status: GOOD (  10.55  )
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
    V2:
    - removed unnecassary TODO statements
    - removed device_type from mdio nodes
    - change the case of hex number to lowercase
    - removed board specific comments from soc file

 .../boot/dts/freescale/fsl-lx2160a-qds.dts   | 115 +++++++++++++++++
 .../boot/dts/freescale/fsl-lx2160a.dtsi      |  18 +++
 2 files changed, 133 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
index 99a22abbe725..2c3020a72d41 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
@@ -46,6 +46,121 @@
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
index a79f5c1ea56d..a74045ad22ad 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -762,5 +762,23 @@
 				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
 			dma-coherent;
 		};
+
+		/* WRIOP0: 0x8b8_0000, E-MDIO1: 0x1_6000 */
+		emdio1: mdio@8b96000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8b96000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			little-endian;	/* force the driver in LE mode */
+		};
+
+		/* WRIOP0: 0x8b8_0000, E-MDIO2: 0x1_7000 */
+		emdio2: mdio@8b97000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8b97000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			little-endian;	/* force the driver in LE mode */
+		};
 	};
 };
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
