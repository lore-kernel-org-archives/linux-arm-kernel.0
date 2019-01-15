Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1D3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:52:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2155720657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qrw/2xbj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bv1b5dRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2155720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+Wm4+x9Aphq/6ahqbuWtGNgQ6LvfHfZLQmOxAWh9Axo=; b=qrw/2xbjKLrUKY
	3JkXuNEXeBSPtropLvHEPCNCSzGIiRfKCIZwfOxLpLNsLZA3ba9rqLtI72cfqvkbsmqJjbFpcepmF
	6KZ129ZbHcAujhkmGDZTY5fmz3lj5CZ/iTc4N57xOHgBCsXGrITdl76Yy1OvrlTLUQ99OnsjaiEdY
	uHrQPYFd2OrRbr4jIbGUB10k571OP5/nYmzc9Qm5sFLCc/GWGPMytRJWq6cbiUL4xolqKR0WqHRCm
	AtmVQGyWuuKsiT3/YVzPl3RpETzcFXNp7A7aINtPo7j/s2t8hyu8s8kFWX662xudlbnb1ZVamrVtg
	q1qX8s+ndtlH4RxLQI2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjLOR-0006j2-62; Tue, 15 Jan 2019 09:52:23 +0000
Received: from mail-eopbgr150059.outbound.protection.outlook.com
 ([40.107.15.59] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjLNK-00053D-RW; Tue, 15 Jan 2019 09:52:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Io13e8ejQNP3RiZBaIGX5/D1h89WVl7okAyIb3+itRk=;
 b=bv1b5dRoWSqHWmN0Fs5EG3uHV6yeVK5ks6dE4+1n2nY7DDwCbZlUkoDsenUB+kCqkDKzdBQHuumW1YIlRZGvmBP1KTeUe3wyEa39ML/yivPJloRPbD9nxzhM3scg4yWeLrxlsRgYLanntBhuboaorU93EckjraVp6h5DkWLrmIo=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5086.eurprd04.prod.outlook.com (20.177.50.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Tue, 15 Jan 2019 09:50:40 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 09:50:40 +0000
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "linux-spi@vger.kernel.org"
 <linux-spi@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: [PATCH v7 3/5] arm64: dts: lx2160a: add FlexSPI node property
Thread-Topic: [PATCH v7 3/5] arm64: dts: lx2160a: add FlexSPI node property
Thread-Index: AQHUrLfGVpsvUOPDeUKA4b5cC0uPdQ==
Date: Tue, 15 Jan 2019 09:50:40 +0000
Message-ID: <1547545697-4042-4-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1547545697-4042-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1547545697-4042-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR0302CA0015.apcprd03.prod.outlook.com
 (2603:1096:3:2::25) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5086;
 6:NMASuBaOAv7cMHv8W6TM85TAGshHmFhyTugeOjgvqsInc3XjWnaJdJBAO4IO1ohLoxX0KtoLIIAYTnwmghlyiA+db7qY+SwhDrgPpK5+B4dwLBP006CQVXzoWwZ2Un09n5c1pEeNqJeJO2AaAS1weNJ1bMerOkEXT0INm94uUAZkxvnH75xT2RxYCXS4ps6ojWJPFwns7p7vs+4ZiTyjaLhhwp5i7isnPljLqzjgACiZ9kaPrrr3uIos0jnuunohUD1YeXMLTYbduSiSJnMPlKuQzqNKz77INnw5H7nWJvfj2KO32GKCooC1dfIvb0bEDLxl2Y+YQ6rygzSBJStgTQ1YfD2Hc95k5dFjuR6gceUF8FVIDmormHGZZSPWr3EowDTg6Ml5MZAk7mXs1nkX8oCpf/ZDEIdUTeadmnWfQfNDFDtNPGHXsZQKWxWJHRlArtD8Pf4NqOzWRngM+gZ38A==;
 5:KJ0FkRuTi2kfnS5dIgAgyosMvI2zNojIX7i9B1C1Zr8cxRKpRw9SevluWep7h+aAwyE64aBK9GHATBvkvcb5vjnhIxraE9F+pxOLnUTd1HF0Y2LpBeKX+eEYYHSfzyazY0xhmI9lgnDi5kBsYw9wJGUwh+un3x6XdcOWnfUF1xeUwgVWIJN/tu7Ccn22j2BPYZKK5Lb4qeEAJ9rsb8hpXg==;
 7:Pvi8X5nxny4/t0UbJjKTbPa2NOlRPgPuffrwvN1Ga7zrNkxwqZWsNMkZrAZI2k11zh1l9aExQZ7HssbvgdeYZ/N3GglUiUsAfOyAlqikmlA+oK9HwEjEDaBa4j5aTUIewHF6KrVhcBDXwNLEzhc3zw==
x-ms-office365-filtering-correlation-id: b7bf85fa-0da0-4c4d-cdc8-08d67acee849
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5086; 
x-ms-traffictypediagnostic: VI1PR04MB5086:
x-microsoft-antispam-prvs: <VI1PR04MB5086D1626F6441FD8C0ED8ED99810@VI1PR04MB5086.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(366004)(376002)(39860400002)(346002)(189003)(199004)(39060400002)(7736002)(305945005)(2501003)(110136005)(99286004)(66066001)(316002)(36756003)(50226002)(8936002)(25786009)(2906002)(486006)(4326008)(478600001)(14444005)(256004)(54906003)(86362001)(186003)(97736004)(2201001)(55236004)(102836004)(14454004)(26005)(3846002)(7416002)(6116002)(6506007)(386003)(52116002)(106356001)(76176011)(5660300001)(71200400001)(2616005)(78486014)(105586002)(71190400001)(68736007)(11346002)(446003)(6436002)(6486002)(81166006)(53936002)(6512007)(81156014)(8676002)(476003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5086;
 H:VI1PR04MB5726.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CpQMfTEHGqnScIDnUqAUaAuiR/hM4G80J2yexNicOBh6yKEZ0MsxbOXLXQy6VSi0x2wRHIK/z/PLffHdCucFmlo2x71qHn7jqT7hzSVpS9ER30u6LYLHTnWd/KoM9Y09LjV+Gfm3P3nnObCV5upwcl+SRrz0GBQ/GH7CRn79DiPWeDVxXrrde43rBmBd0rj/eGmgx4oqjypqVTyZgDAXXyTY5JYuJXyUznjksAIrE9qoPitjp2aeZ2v7yE4LscNo/TyHWjdHIl7gU9GpVA0PWge9MP4vBso+6NHJoTEjniBCnEqwPOoiyfoiH7QZ0Qt59eHLZlew1oKqd9Jhkzf33kSCyf9wc1mJmpY1Zg8rzq2WgG6F055jnKAf4nqCtr0APGZK9zeisDrDCbrfpeObph6AwxAIFiKYk0ZVKf4Gnyk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bf85fa-0da0-4c4d-cdc8-08d67acee849
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 09:50:34.0380 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5086
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_015115_297227_BD40A5BD 
X-CRM114-Status: GOOD (  12.22  )
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
