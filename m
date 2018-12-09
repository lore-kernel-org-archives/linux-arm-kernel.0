Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A03C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:27:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0C7920672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RnKY4RUO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m8FrItid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C7920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OZWFY2pcGQYEzYO2fB4BhX/6IZhlDyL11h5AgXT+1oA=; b=RnKY4RUOW44osC
	8GACHqk8vtqZEbNkn5f06Y8M9cvzsSkSABH1fo2xNzTj0TxgRvid7aLa7jBTTaJGNo+Ha8TDoClqk
	Gd/tcFO3B5I3ZvQ1W6ST0wtmzww8t2y6HhL3OXlc8k6PinH6L5xN/Rf3JXCY5gQGsPyd2rdwHsWbz
	VyRt16UAoYgjt2vuCogXmQJb74jsu6tKOwItDqihFbMtZ53kUtoa05wntaQBr80yBa6HDVcmX9X86
	EgNWG84MRiw0j7ACBI6+2R2lDb6Tdb+86JctrSkoXmdIvRWQHg/XV1SaZVO8IWVZ8UQEaT23mpCh/
	wFZfEWW6HMyxpVBfXlkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gW03m-00038a-HD; Sun, 09 Dec 2018 14:27:54 +0000
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gW02Y-0001oS-Gg
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 14:26:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3OJ9aDDU//RpMYbfYhsuvu0QiMl574l+IQHNsr6WaA=;
 b=m8FrItidd6Z5SOiuvj3sDhHebDuR+eNVSKMLbKwqxCUqL9EDF2wY9tFDKQoanX7rj/4RqQxtIUd6cqNkN/guAABYdXEpiJn0SbwOvHO/TC5PRAlm4kmfUn6tX0bYTawN6AHPtoj7le4zh0oHEXuXLLRjQ+QmTUQA2q/6RVTx7kc=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3910.eurprd04.prod.outlook.com (52.133.29.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Sun, 9 Dec 2018 14:26:10 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d%4]) with mapi id 15.20.1404.025; Sun, 9 Dec 2018
 14:26:10 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Shawn Guo <shawnguo@kernel.org>, Rob
 Herring <robh@kernel.org>
Subject: [PATCH v5 5/6] arm64: dts: imx8mq: add watchdog devices
Thread-Topic: [PATCH v5 5/6] arm64: dts: imx8mq: add watchdog devices
Thread-Index: AQHUj8shDl9/dHaIwEebpIZj6ZXO1Q==
Date: Sun, 9 Dec 2018 14:26:10 +0000
Message-ID: <1544365552-30270-6-git-send-email-abel.vesa@nxp.com>
References: <1544365552-30270-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1544365552-30270-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0004.eurprd07.prod.outlook.com
 (2603:10a6:203:51::14) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR0402MB3910;
 6:/eE2iO6+MyytmwlfyTcMAr37eikT8GzJEKmyOvCVf6NAYr8TKToivxEZT3g9B0W8/lpA6SOupli99bhgS8vpHWWF3FMRfK2g32MIpfg6HzwS5j2FVJ5c/XvxpeoGy4FD0niI39KDtwIio/aTWgoLfpvurI8mojFFz77FjM8p8nHnPyCDAIk51Lyp4EVSRgQ9+XAp+qBrkidOVEC/fpHxZuPAyyQAqPtf1D2sjsj5ikbR9oJUWoLbr594auTn2bg2cWGRpJKDuKE2puakO4XwTI58wCH9wkuYk4ZRKVy7hhSvckC3ufjhrRoxCH2vHAnxD+zodvbFhcz6ljbU5cyzFOb8MMAGnLMgbFlF4vi2/W63MKnYra7LdiQbCRK6CatgqmN0VJrm4sVFMrOQC2ATvWayziFHuAEXMSUzV/5+Oik2gWdlbNAQpCZv2GsNqbULO/iX3tgpMQk6pZMsKSjTFQ==;
 5:MyqFYk8HhYhq4dytWA7sl4vMjeGxEsmeLLQhJJj0bpz9LZ3asNGBzWaWuC90iPruAG6+4Ww/gFA0fGaV1aTVNhn8XBQVeVjQ9Q9jCt4bdbZM4LghIgM1UseXEi3chAnVjI1HM+vlB2SsbuB81hLvma4kA3kVCdXvpVXYKfekGaQ=;
 7:8i4wvtj3JhUg7lhKi8Y4EoWURVcDhU1YBJwCGD6dZqDxvGWntCMl1zNaN9QhImFRKO1FRZKI+hatsGbs5ogUWkFYvAIFy2GUQHxr6L+Ep9bgC/hlddZpezpcHrgLlVDdMs/qhDj0Qv5Cbu7NfMlBfQ==
x-ms-office365-filtering-correlation-id: c1be5b68-d80e-49b5-926b-08d65de243ab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR0402MB3910; 
x-ms-traffictypediagnostic: AM6PR0402MB3910:
x-microsoft-antispam-prvs: <AM6PR0402MB391032501FFABD21356E2150F6A40@AM6PR0402MB3910.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501520)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:AM6PR0402MB3910; BCL:0; PCL:0; RULEID:; SRVR:AM6PR0402MB3910; 
x-forefront-prvs: 0881A7A935
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(376002)(396003)(39860400002)(136003)(346002)(189003)(199004)(26005)(446003)(5660300001)(25786009)(11346002)(71190400001)(2906002)(106356001)(105586002)(54906003)(3846002)(7736002)(44832011)(305945005)(2501003)(6116002)(476003)(486006)(2616005)(66066001)(97736004)(8676002)(4326008)(53936002)(99286004)(7416002)(6436002)(81166006)(110136005)(14444005)(6486002)(186003)(81156014)(68736007)(6512007)(386003)(6506007)(478600001)(86362001)(256004)(14454004)(36756003)(76176011)(71200400001)(102836004)(8936002)(52116002)(316002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR0402MB3910;
 H:AM6PR0402MB3654.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9N7f3h76DtgaFoAWTZb/8GtEmrPPWm82NwOK+FBPnmW5s1otVheKdunZtBmD4rxxz8ee1C/46KwOuki8JfPtmK1A6tWan5XSwV/OTXPx441g4u7FhO2B12OczAjbWNUjaZXlmWykgUfzpHQjFuf3Lg94+Dh8e+qJzTXOqurgMbhqQT43f5g3CL4D7ADx9cawPd/rpDQBRrn3lk5fElqzbUKYgzNxHmnLZh9mJlhy/minKfOlvS+VU+QRl00kw9gVEcWF6ZD9XBVgF0bHdzcW40vdRhdIODVbYHwkSIeNdAkeuYsW1rPf+cyQWU7TkVpN0gDRCCOsFH2rmVrA1TOyu8RQFN4YN4+LRHMe9vUfjQk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1be5b68-d80e-49b5-926b-08d65de243ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2018 14:26:10.1935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3910
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_062638_709888_9DDAF061 
X-CRM114-Status: GOOD (  11.40  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Baruch Siach <baruch@tkos.co.il>, Abel Vesa <abel.vesa@nxp.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
 Abel Vesa <abelvesa@linux.com>, dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Baruch Siach <baruch@tkos.co.il>

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 3703bca..8e9d6d5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -228,6 +228,30 @@
 				              "clk_ext1", "clk_ext2",
 				              "clk_ext3", "clk_ext4";
 			};
+
+			wdog1: watchdog@30280000 {
+				compatible = "fsl,imx8mq-wdt", "fsl,imx21-wdt";
+				reg = <0x30280000 0x10000>;
+				interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_WDOG1_ROOT>;
+				status = "disabled";
+			};
+
+			wdog2: watchdog@30290000 {
+				compatible = "fsl,imx8mq-wdt", "fsl,imx21-wdt";
+				reg = <0x30290000 0x10000>;
+				interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_WDOG2_ROOT>;
+				status = "disabled";
+			};
+
+			wdog3: watchdog@302a0000 {
+				compatible = "fsl,imx8mq-wdt", "fsl,imx21-wdt";
+				reg = <0x302a0000 0x10000>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_WDOG3_ROOT>;
+				status = "disabled";
+			};
 		};
 
 		bus@30400000 { /* AIPS2 */
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
