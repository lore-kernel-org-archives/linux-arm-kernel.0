Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92311C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:33:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61CBF20661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RCb1D2Gf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pJt+sxrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61CBF20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=hcNiXi7DGg4kJhv8/Y7KrMJc2/Fxc3xBcHiV6nRATSo=; b=RCb1D2GfPt8kPJ
	WMcUV53tjh8Bi1tRHgs8foHF4spy8w3w3XBLFxH/tAy5Dzo5MXMFCxBT8hfzPf1oKgqbxq+prkfmx
	PxE8gIbPKrnx96i8ZSMdhP8qw0u30LmncoEtnbZ20RUvjBpVCiEkAxpRIlnixNd/utO8QQgonfPtT
	quWDkbglcDwmAi9rPJf30Lk9iCFogoL6CyRwG/0cq63l9dhap4hF+SHHuBv4N+Fj5J9i0SBO1SPVc
	7Vhp/UTo2DoVmVcMYkyrHwzde4v1SZraJAqnnMd+m3RnMZ81vvLOpWXqQvxrxxaobGfZVnT3TjyHy
	sCTiAT7TDEaH1hBbR5Dw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUDdW-0000mx-F5; Tue, 04 Dec 2018 16:33:26 +0000
Received: from mail-eopbgr20073.outbound.protection.outlook.com ([40.107.2.73]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUDdS-0000jP-SR
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 16:33:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpzoRCaBgRoqmKDIAJm+f4X4BJqxuaSvIaYNVLNPxQI=;
 b=pJt+sxrlMTd/HxK4Bs2vqPuUG6+9vcYnVjObm0lg5jxKTod52kxrw9uMXNZ5ozxxNrlLxmOSVIVhYOSFZrNUcMtrVEsOLn38V2hzueG+AZp0FKwt1JhDYE19JtNmFIxze5ad0eWYOBa08lE268wOnwHV0ZmXLICxTXg6ThHkE08=
Received: from AM0PR04MB4994.eurprd04.prod.outlook.com (20.177.40.15) by
 AM0PR04MB4386.eurprd04.prod.outlook.com (52.135.148.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.21; Tue, 4 Dec 2018 16:33:06 +0000
Received: from AM0PR04MB4994.eurprd04.prod.outlook.com
 ([fe80::f53c:adef:eddb:4a2]) by AM0PR04MB4994.eurprd04.prod.outlook.com
 ([fe80::f53c:adef:eddb:4a2%4]) with mapi id 15.20.1404.016; Tue, 4 Dec 2018
 16:33:06 +0000
From: Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: [PATCH 1/2] arm64: dts: ls1088a: Move fsl-mc node
Thread-Topic: [PATCH 1/2] arm64: dts: ls1088a: Move fsl-mc node
Thread-Index: AQHUi+8IvrQ2gcpaXkmLZ1+Gz0neYA==
Date: Tue, 4 Dec 2018 16:33:06 +0000
Message-ID: <1543941180-5147-1-git-send-email-ruxandra.radulescu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0502CA0002.eurprd05.prod.outlook.com
 (2603:10a6:803:1::15) To AM0PR04MB4994.eurprd04.prod.outlook.com
 (2603:10a6:208:c7::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4386;
 6:c29F9OAiqPOjI+qWE4hXCZgu48U6UQxz4Xgp4qVDo90bTKxguw5hbKS1je8D9xvIf526pWM7DreNhwqpC1dI+rJfqcCxLGCivZrAR+dM4cG5z7fp8Irq4jfwkrlOYWdUvNczyt1VAzwf+QOchbT3/Tm8VF/goB3icFd/TQGjDg5qCZT9xByoI1xJ2l1GWoy6lzgwpiHuxgqY7c1NxmcMcr99e7WnqCiVklkx2KoM+pnetNQ4G51VlcyCAPWiqT3AJT/tOziozClAYjVmInIKjKQkFyTM2w/j39vEcXr6BQnanjpIuYBk3UANe1byfEOjXn4Uq8ZJhVeHBkPAVYwjBxCqzfJZihnNhD1l4jJBEk4dCejK8czfj5L8AnDkYMovs8J/iZhK+dWjgUjm/dn2sy5mEmElXWNJmP/TvRiJEajl/himIyCG5lejToLsmTcy3wOLUOCJLm+Ord0QTp/JVw==;
 5:FjcnG0ghl1OukIe3ZyQl8P/PHtan/Kvbjch4OMsrLR4dk3TQnZkQ9I8RaKY1yCUZ7TG0ZMlVuwJBIgik1DwqtYfDBnKX2LOKlOrHkiKAXP56wVirCoopApU+LD9/9elNlV5ILqqnrFT++MpKVYbpcGjr58u64myUaT0sNBjNpZA=;
 7:SkmkC5oE85SMSaNUdF7vGunlPeDB0xyLF5e7+YK3M1ltVu3Eeaw4yQ9xJFUi7f+l64O3iL6qWHKjhNpB2v+aIVt7IO5zEQoBhkc1x7peqc5kejXtbzOe3WCr6ZYLF2LFI/Djk+m5KTRgknfkF1dp+w==
x-ms-office365-filtering-correlation-id: 1ae4e94b-d27a-4b0a-a5e1-08d65a062b3c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4386; 
x-ms-traffictypediagnostic: AM0PR04MB4386:
x-microsoft-antispam-prvs: <AM0PR04MB43862CD241D15D80B05D46F494AF0@AM0PR04MB4386.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4386; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4386; 
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(136003)(346002)(39860400002)(366004)(396003)(199004)(189003)(8936002)(52116002)(97736004)(5660300001)(478600001)(53936002)(2351001)(2906002)(6436002)(6916009)(575784001)(14454004)(6116002)(68736007)(6486002)(305945005)(3846002)(256004)(316002)(4326008)(7736002)(54906003)(86362001)(6512007)(5640700003)(81166006)(25786009)(476003)(186003)(99286004)(102836004)(2616005)(1730700003)(8676002)(386003)(6506007)(26005)(36756003)(81156014)(66066001)(71190400001)(71200400001)(106356001)(105586002)(2501003)(486006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4386;
 H:AM0PR04MB4994.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vnoschHcPpedb0lSwBbIBKo8uiXZAtI+rRgRREcjItQtCFaIrjxlI89iW5CWIppa7kaL1AQpUmLk0iwa8Qdd6FWreilCSPNyno01fOGwU/TIOcUWNxLv3r2ESSJ2I8Lo5+RL4eZxiTlXfZFEEW5qf8n04himc5Qq1685gL9YrPrs3OVGMb6Tnc0qnhF47RqsEM+1SPG4pFhUHYhFPxpP8m8wwyAchyQqV9qdqXZnD4d/LgtNZfLohoqfD5KCgYFtzRJmbJi1k0S+59QbtpLPm9Dj1cwqS8RITkQBW4lIWYgCkbJitUh7PX2NSOQrr2sF3N/9kccZhPC0X84XUE0W412B4/gfSg5Uoct6bTIZ7PM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae4e94b-d27a-4b0a-a5e1-08d65a062b3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 16:33:06.4014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4386
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_083322_920865_BA45081F 
X-CRM114-Status: GOOD (  13.12  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The fsl-mc node should sit under the soc node, so move it to
its proper location.

Fixes: ac7c9ff741fb ("arm64: dts: ls1088a: add fsl-mc hardware resource manager node")

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 142 ++++++++++++-------------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index a07f612..ba5ce73 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -174,77 +174,6 @@
 			     <1 10 IRQ_TYPE_LEVEL_LOW>;/* Hypervisor PPI */
 	};
 
-	fsl_mc: fsl-mc@80c000000 {
-		compatible = "fsl,qoriq-mc";
-		reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
-		      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
-		msi-parent = <&its>;
-		#address-cells = <3>;
-		#size-cells = <1>;
-
-		/*
-		 * Region type 0x0 - MC portals
-		 * Region type 0x1 - QBMAN portals
-		 */
-		ranges = <0x0 0x0 0x0 0x8 0x0c000000 0x4000000
-			  0x1 0x0 0x0 0x8 0x18000000 0x8000000>;
-
-		dpmacs {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			dpmac1: dpmac@1 {
-				compatible = "fsl,qoriq-mc-dpmac";
-				reg = <1>;
-			};
-
-			dpmac2: dpmac@2 {
-				compatible = "fsl,qoriq-mc-dpmac";
-				reg = <2>;
-			};
-
-			dpmac3: dpmac@3 {
-				compatible = "fsl,qoriq-mc-dpmac";
-				reg = <3>;
-			};
-
-			dpmac4: dpmac@4 {
-				compatible = "fsl,qoriq-mc-dpmac";
-				reg = <4>;
-			};
-
-			dpmac5: dpmac@5 {
-				compatible = "fsl,qoriq-mc-dpmac";
-				reg = <5>;
-			};
-
-			dpmac6: dpmac@6 {
-				compatible = "fsl,qoriq-mc-dpmac";
-				reg = <6>;
-			};
-
-			dpmac7: dpmac@7 {
-				compatible = "fsl,qoriq-mc-dpmac";
-				reg = <7>;
-			};
-
-			dpmac8: dpmac@8 {
-				compatible = "fsl,qoriq-mc-dpmac";
-				reg = <8>;
-			};
-
-			dpmac9: dpmac@9 {
-				compatible = "fsl,qoriq-mc-dpmac";
-				reg = <9>;
-			};
-
-			dpmac10: dpmac@a {
-				compatible = "fsl,qoriq-mc-dpmac";
-				reg = <0xa>;
-			};
-		};
-	};
-
 	psci {
 		compatible = "arm,psci-0.2";
 		method = "smc";
@@ -638,6 +567,77 @@
 			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
 			clock-names = "apb_pclk", "wdog_clk";
 		};
+
+		fsl_mc: fsl-mc@80c000000 {
+			compatible = "fsl,qoriq-mc";
+			reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
+			      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
+			msi-parent = <&its>;
+			#address-cells = <3>;
+			#size-cells = <1>;
+
+			/*
+			 * Region type 0x0 - MC portals
+			 * Region type 0x1 - QBMAN portals
+			 */
+			ranges = <0x0 0x0 0x0 0x8 0x0c000000 0x4000000
+				  0x1 0x0 0x0 0x8 0x18000000 0x8000000>;
+
+			dpmacs {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				dpmac1: dpmac@1 {
+					compatible = "fsl,qoriq-mc-dpmac";
+					reg = <1>;
+				};
+
+				dpmac2: dpmac@2 {
+					compatible = "fsl,qoriq-mc-dpmac";
+					reg = <2>;
+				};
+
+				dpmac3: dpmac@3 {
+					compatible = "fsl,qoriq-mc-dpmac";
+					reg = <3>;
+				};
+
+				dpmac4: dpmac@4 {
+					compatible = "fsl,qoriq-mc-dpmac";
+					reg = <4>;
+				};
+
+				dpmac5: dpmac@5 {
+					compatible = "fsl,qoriq-mc-dpmac";
+					reg = <5>;
+				};
+
+				dpmac6: dpmac@6 {
+					compatible = "fsl,qoriq-mc-dpmac";
+					reg = <6>;
+				};
+
+				dpmac7: dpmac@7 {
+					compatible = "fsl,qoriq-mc-dpmac";
+					reg = <7>;
+				};
+
+				dpmac8: dpmac@8 {
+					compatible = "fsl,qoriq-mc-dpmac";
+					reg = <8>;
+				};
+
+				dpmac9: dpmac@9 {
+					compatible = "fsl,qoriq-mc-dpmac";
+					reg = <9>;
+				};
+
+				dpmac10: dpmac@a {
+					compatible = "fsl,qoriq-mc-dpmac";
+					reg = <0xa>;
+				};
+			};
+		};
 	};
 
 	firmware {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
