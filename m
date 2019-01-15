Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82C7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:21:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3C6920656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u+FRoXaD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cCgQw5YK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C6920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=27kXNHklqGSquo4bpaWIckqmuR6cpfJTfjt6tt5j7rM=; b=u+FRoXaDja4sXL
	BnGIOLa+EeIK8FZ0dOpFb30OHHXa8wTbktR0nJ+xh8hHwK8CcuR8sGHC//9kOJ8oNWEUkukN0BfrX
	bKC+aLzsewZmN9NSUb9TWudHZNvkI1k3LGVL0fk0XznSPbrPdKSqyHXM6BoFeXn/ZuVA6zAwZQD7x
	/EhGOsqZK+ZTPJVfIQ6xe3f9H++cVjbMFlyAlq9k6w4kjC3e6BNCHvSPjc4GeTqwNAdn0tNyY2Rkq
	K2+92tSAE9Cl0ZBSdGvS04afwTL1dBcxHuE0SpA40OlTqxdIt+c+XNnWdcMumUOdOFSZkvETCXiA4
	31U9ZGoNIfq00O7jgUpg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjLqx-00045M-S3; Tue, 15 Jan 2019 10:21:51 +0000
Received: from mail-eopbgr130054.outbound.protection.outlook.com
 ([40.107.13.54] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjLbG-0003ow-RM; Tue, 15 Jan 2019 10:06:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnBg/3Zd/nOHZWiutsHzWXpvg1b8b3mX29x9+sBnDXY=;
 b=cCgQw5YKVz0GMGKJZNVxGBT+m2jFkOzQQV3F73d5+2mW0ulTgj3NetanjmTTafs+1j7QoNSdyqHWTetNf85xBtq+wZt6Uy4kqFFiTbefPkuZLRU3rWTKVMAhLAlgs+oTV6mXN2moSNfsZvDIXJaBusBnJ7ridN2KhxsVq3pEURk=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5822.eurprd04.prod.outlook.com (20.178.204.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Tue, 15 Jan 2019 10:05:35 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 10:05:35 +0000
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "marek.vasut@gmail.com"
 <marek.vasut@gmail.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v7 5/5] arm64: dts: lx2160a: update fspi node
Thread-Topic: [PATCH v7 5/5] arm64: dts: lx2160a: update fspi node
Thread-Index: AQHUrLnbWH3YDSF6OUOBVDSvHgkBWw==
Date: Tue, 15 Jan 2019 10:05:35 +0000
Message-ID: <1547546584-5254-6-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0123.apcprd06.prod.outlook.com
 (2603:1096:1:1d::25) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5822;
 6:As0kijqYpdLXyo/cdHf5tv3DukVLKJlSrelMt5fcIHXxo8so1vzga9pd7L9TSf+5Hc/A2UI6jdZGOcBjV6pLxbx5+r8YwqSM+gekE6uSeOEkC/7+yo0Vy/Gau3yjl0M4f31ksHN8IfjWH6kezA12rwjE5KHPoPToCeegDuGvT/r1Lv2vohK9g7nhybR3CPpB21Hy/IPwNcbN1DezAsXgtm3sYB+XyydpslvRBcFF6hVev9qrmXxChTkAV7hcWk8K1cJTx7QGPDWowijYBnzEcjxOE6l5ga/mmCUYxe0VmepUVPACimeh/Grfsz1gT+WwIMsplsee2DfJPu7ydeZAvBggPf9YJDLGJBvtpxzO0iQ8Zw0M9xJkrWGQXnm0VTW89+MPtJXW20oVN7BlmaRUwYBTH8n8hScKmBCrE2VnJnnwxYXn6mTYmABa2Orh4eCGc8LXHTNFmiPv0JZyYHzhmQ==;
 5:TBB8xsgEVQTEGXk4huBj41QUcQK5caVyFMfPbDFnsFqO1JSusOlpIk+Slo3Db1eJgX4pedZOQyYqShMPfP+uIeZsAKBL+r9lO5bPgcRH9vvC2xMpr5Vsf2cNhap/+Ijc37ShVhwCCRiYxH3jzR1jj1H6/1w6Rz5dTJ+dw+AsZ8yW/9+a6ajsLxyvLv/4Ko7LfiVJtXGhXvvCYiwAQzcriA==;
 7:5ul/OENiRKkVmyhobrfF4mxKmsfX/RxTZHZoa5QNASNeEN9RIZt9BBxwAkSTxSP8ewRP9XGxrn55/byg/brqOqgk45g/B2wBkDYigZWKaAzdccVBLVOVpJZF4cuCo9c0KyhqE9gjifD0RkgfVy0GRQ==
x-ms-office365-filtering-correlation-id: b6540173-c398-4d61-2c7e-08d67ad0fdeb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5822; 
x-ms-traffictypediagnostic: VI1PR04MB5822:
x-microsoft-antispam-prvs: <VI1PR04MB58229BC270402356EAAE0EF799810@VI1PR04MB5822.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(396003)(39860400002)(136003)(376002)(189003)(199004)(36756003)(305945005)(14454004)(6512007)(81166006)(486006)(446003)(2201001)(81156014)(2501003)(4326008)(105586002)(8936002)(386003)(7736002)(86362001)(102836004)(2616005)(26005)(186003)(6506007)(54906003)(50226002)(97736004)(316002)(5660300001)(110136005)(2906002)(6116002)(8676002)(256004)(71190400001)(6486002)(7416002)(66066001)(3846002)(99286004)(6436002)(106356001)(478600001)(76176011)(55236004)(71200400001)(78486014)(11346002)(39060400002)(53936002)(52116002)(68736007)(476003)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5822;
 H:VI1PR04MB5726.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YOjbCOhrN8U/RrqNzfxvLr/Md/UmthoOdzf6T9QkdDfr0jv8mdxkxbsnvrP4Q+FHhXp8Epk4HrSiUm9A69I4r5/wryGdn1NYv2dYei+W5LgBp2SAPue8ZHWIfXXRxgYIodlvMaUGY//Zto/y0KCr2ev5AXDvUBNB9DSPrdNlvP/zAYvHOBI5YgxjSW1iG1sKY8Y806wWEYi3Z5FJtAgVADdMDKGoTMQmmsYYNNlw1FjbX/LpV68MsyI6I0pelO1eoMdO8pLAV3n1s14/Mf/KQmnLMIlfaHfwQBNvGl7i/6zujE2y9rSY1pF+e56Qzts616xLbn9IbgQpO4VlsIbMTIdk/UDr20MvEG0erDt/RYxZyKAoeTYFd9ZNnFz+OZmyQHiuoKE0wNyBxxKHAYCoOUR5cCvKS/fdOQ9kSnlRvvs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6540173-c398-4d61-2c7e-08d67ad0fdeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 10:05:29.6493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5822
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_020539_552009_0C752B54 
X-CRM114-Status: GOOD (  10.27  )
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
 "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Flash mt35xu512aba connected to FlexSPI controller supports
1-1-8/1-8-8 protocol.
Added flag spi-rx-bus-width and spi-tx-bus-width with values as
8 and 8 respectively for both flashes connected at CS0 and CS1.

Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v6:
- Correct S-o-b tag with full author name as 'Yogesh Narayan Gaur'.
Changes for v5:
- None
Changes for v4:
- None
Changes for v3:
- None
Changes for v2:
- None
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 70658946fbbe..9df37b159415 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -60,6 +60,8 @@
 		m25p,fast-read;
 		spi-max-frequency = <50000000>;
 		reg = <0>;
+		spi-rx-bus-width = <8>;
+		spi-tx-bus-width = <8>;
 	};
 
 	mt35xu512aba1: flash@1 {
@@ -69,6 +71,8 @@
 		m25p,fast-read;
 		spi-max-frequency = <50000000>;
 		reg = <1>;
+		spi-rx-bus-width = <8>;
+		spi-tx-bus-width = <8>;
 	};
 };
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
