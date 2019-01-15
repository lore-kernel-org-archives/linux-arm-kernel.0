Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFA5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:06:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A3B20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rlaquzW4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gVaNBa8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A3B20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eeJju5bllaWxUzGtQfQpwfQOjMSFU4j+yYcRxnFy/NE=; b=rlaquzW4NJFfP9
	Ned9RTKuW0DRZY0sIFgiLSwH+N8pK4ande587MF6Kb2wag2QsNxfXXMOZtKCZwxb6HXnybAM7TblB
	2hPsfD7YdkhYo9M71xj0QiUbsLaOobJfFdof6L1CVRu/9v8P8IbHyo8qHGuZPS7sJ8zTp2DWvWs0A
	QYC3SXXddSVS0yGBLqNLKC6gvNON6yB7u4WgUpXZOFBt5/5r64kPWOWuIbRzxPfw4yuMZYiEjVEZY
	lL3LAiCasSLmemW0xeAssaP7E5HrNArfNk6qEcJsd/XID4cjE3EsnIBfa234Dm60Rmwcyl7kVuVwY
	x9Coo5AidZwkjDw+QJqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjNTy-0005I9-0M; Tue, 15 Jan 2019 12:06:14 +0000
Received: from mail-eopbgr10056.outbound.protection.outlook.com ([40.107.1.56]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjNOh-0001E8-2G; Tue, 15 Jan 2019 12:01:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tr2xerPmKuB5CdcNPe6gcR9buYc6NwG3/39xDaeSUpE=;
 b=gVaNBa8Gcm+avBNYGLuhJfFqHiXQaUSMP5dATfXvcziQTrESPvuLr0vZFR5eWIlXstBx5uYDhYa8EqIvFGLsxxXujlgD4L+M6z9BlBVBf1LfYqHtC74IW5IxUOssnaxfVaH1aF7Kbe1qBsDLtWfK2FJGXXlVC3UJ08ObZoOMOM4=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4301.eurprd04.prod.outlook.com (52.134.31.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Tue, 15 Jan 2019 12:00:26 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 12:00:26 +0000
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "bbrezillon@kernel.org" <bbrezillon@kernel.org>, "marek.vasut@gmail.com"
 <marek.vasut@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v8 3/5] arm64: dts: lx2160a: add FlexSPI node property
Thread-Topic: [PATCH v8 3/5] arm64: dts: lx2160a: add FlexSPI node property
Thread-Index: AQHUrMnmG0R4tGWK7UOvqbFnAen7xQ==
Date: Tue, 15 Jan 2019 12:00:26 +0000
Message-ID: <1547553487-9936-4-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1547553487-9936-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1547553487-9936-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0096.apcprd06.prod.outlook.com
 (2603:1096:3:14::22) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB4301;
 6:TI3pTvm0Rpr7h2q7Y5KFGArHT4lQmDpPvAMPEmYl+BUbQvRAYXzYM5GVDYRPA7ZLAfSL6+K1aQ9GidxxvVTGreiwXju4/1k/jQUEtgT9aOgplRZh7oGX6UqLc3BD170/YDTWwiYRQtVMLJi1JeILm2UaqjVsSK93RRguGiHLdK3P4oudIb+WNJWBei6cmknvb2kf+kMXrdtLvzZNd03igvCEB12VAJJ+/r5nHBHM45HtHMVHDMi9jh8rHbNuFn9crp9AM4rscqeJLrGvVcY3ABcUeZxC2yaz8YMJk9YwE9yl9KbwNRVAFMuSm1eKzTMVMowbJCDost8KPVpOZQkcUlrTm9EYIqssTXF3tLsUzT/rbSh4nNB/RdUcN9wGnFGH/it1szV8ZWWoQ8+e9jiBYewTBOj3pGfPEVeuo0Ei8XHlzyRBGEgkHKTDUv11TFt8zCh7RaCVSsICPMUs0VhfKw==;
 5:xwSXufoudQccDgPdHJFSHl9CTMk7GJJwdSsxuJWfwSla+VhRgQRP/Y4Nh4Xqzq5e1DSBWK5Z7r+FSsGo4mVvjCszQpUGeoMRes+6wcBA/4sV3Nml52B+Qh04CFfwPEdMWNCE1Ey7xjQ9JuspB8aXUtm2bU1S0e1GpV5FR0rTlNXFak2NbvzZ9xXTZP4qmDOtYoZc/e6UHdHMR3lslf1GAg==;
 7:pHN6qNB2R+nrvdwhpBskU+TbU7ESzGntz5Jqy0XR5AFNCbxaX34FsHPQkWGoLdHHiIekrLI9an6ETEwBjcQr58zMpTKAkrWITC4SJJBrM52+6mp+/QMdSJtl+rM22hXx87lyQcVN9WEI/yQ4K7vgAA==
x-ms-office365-filtering-correlation-id: 27372150-6acb-476b-70f1-08d67ae1091e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4301; 
x-ms-traffictypediagnostic: VI1PR04MB4301:
x-microsoft-antispam-prvs: <VI1PR04MB4301C797E2BAF556F4915A7399810@VI1PR04MB4301.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(136003)(396003)(366004)(39860400002)(189003)(199004)(26005)(102836004)(6512007)(25786009)(4326008)(105586002)(2201001)(86362001)(478600001)(186003)(52116002)(6436002)(53936002)(476003)(14454004)(106356001)(50226002)(8676002)(81156014)(81166006)(8936002)(7736002)(305945005)(486006)(316002)(68736007)(36756003)(7416002)(110136005)(54906003)(3846002)(6116002)(97736004)(78486014)(2906002)(6486002)(256004)(14444005)(446003)(6506007)(386003)(11346002)(39060400002)(2616005)(2501003)(5660300001)(55236004)(76176011)(66066001)(71200400001)(71190400001)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4301;
 H:VI1PR04MB5726.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DG3mSoCBooPsRvimTezGXisjYmT6/7cXRMPIqxrX5/RJOyg4X2v8t5P4DbSYLVaFAatASpg0P01Fl1d5ozW3jc21UorbYpdQeBo8FFHl2lGTZhkye4FHaKD/yYFo3YcnmemdCG3IWw0K0IYaT7o60IkjzB9uJtA0bSXSOOuUF93sTdHc0O0hg0+ABCu2t33aOc0ABwaBPIb8B8HtmhhuHpg8X4wUBSHiKJ31L9LrPLiLFdWFhcS6qRRIJVyy4Mad6/UxLoapg7GlelbuAqSIKdyZFDDps0bLK7vL1hjyOtCiMH4ue9dJ1TNy5vH6f+QDy8FlRtYkoJPeudTCKO7WLA9WArBymfCE7hW36J3KH1C6zi8KpY+EFZkF6dt8rlpwt0VxZO5Ad/JyGrR0QxffFR/E2tRp98vyF2lsed8ObHs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27372150-6acb-476b-70f1-08d67ae1091e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 12:00:21.0598 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4301
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_040047_348770_8E988FF5 
X-CRM114-Status: GOOD (  12.63  )
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
 "robh@kernel.org" <robh@kernel.org>,
 Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add fspi node property for LX2160A SoC for FlexSPI driver.
Property added for the FlexSPI controller and for the connected
slave device for the LX2160ARDB target.
This is having two SPI-NOR flash device, mt35xu512aba, connected
at CS0 and CS1.

Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v8:
- None
Changes for v7:
- None
Changes for v6:
- None
Changes for v5:
- None
Changes for v4:
- Incorporated Rob review comments.
Changes for v3:
- None.
Changes for v2:
- Incorporated Shawn review comments.

 .../boot/dts/freescale/fsl-lx2160a-rdb.dts    | 22 +++++++++++++++++++
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 13 +++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 6481e5f20e69..70658946fbbe 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -50,6 +50,28 @@
 	status = "okay";
 };
 
+&fspi {
+	status = "okay";
+
+	mt35xu512aba0: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,m25p80";
+		m25p,fast-read;
+		spi-max-frequency = <50000000>;
+		reg = <0>;
+	};
+
+	mt35xu512aba1: flash@1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,m25p80";
+		m25p,fast-read;
+		spi-max-frequency = <50000000>;
+		reg = <1>;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index a79f5c1ea56d..e3ff86201f73 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -762,5 +762,18 @@
 				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
 			dma-coherent;
 		};
+
+		fspi: spi@20c0000 {
+			compatible = "nxp,lx2160a-fspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x20c0000 0x0 0x10000>,
+				<0x0 0x20000000 0x0 0x10000000>;
+			reg-names = "fspi_base", "fspi_mmap";
+			interrupts = <0 25 0x4>; /* Level high type */
+			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clock-names = "fspi_en", "fspi";
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
