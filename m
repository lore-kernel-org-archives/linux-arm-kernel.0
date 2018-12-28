Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF138C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 09:29:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6551D2146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 09:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IBI0cVp4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NiE4igTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6551D2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bohlY3gnvbIt1zVCC6wjPPTfE986E0smMycmacI5cxg=; b=IBI0cVp4YxXMAe
	J+AxS/i2klbCslG4Fi+Haw0Oz8xawRphvjV7hsJ5jPYiOqQa+ToIh4qhTusMWXoy+cPiUQSZD88vE
	A6IV7YbbGM3i8gLQ768Oh7JkVpoRDjC+tcluEsYLIH6BxcEYvw54lmenEfRGnhhClZ/xVOQyiAonc
	uIgxqb5lAKswVZkgIvacS6gVlI23h8juk6vv7djH8ym+wkXehPpPwAxn4AM4t03NuOdPeNievpBPL
	7KIVgt2yfjoj2RhC33XgD0hkajP15JIoGSE3FNAkCwDXbbATSpDrW8G37fVhFeg2jGQIQ+Kc9G5u8
	ImtKYavjoTTgwnqvlRhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcoS3-00012d-Gf; Fri, 28 Dec 2018 09:29:07 +0000
Received: from mail-eopbgr10062.outbound.protection.outlook.com ([40.107.1.62]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcoRj-0000kM-Em
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 09:28:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ct2Z7gOeEF47cpWjsCYOvEMqDaftTv23dB8iSazGk6c=;
 b=NiE4igTqsKIBL28jC410zFXB5yxUmDOKL6v+/1onmZ54XcbHXGZe+vQnZVf8+JAe9GcCu7EDXbPUEzDBvLDW8ExJYfkuZqGurHtwrLWPEebeMDZDiU4zoSRuO/KKkyjkcv0NMkqTPw1tu8MYq0PM3igPNqUrPQ5Os65h85HmwNs=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.50.97) by
 VI1PR04MB4912.eurprd04.prod.outlook.com (20.177.49.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Fri, 28 Dec 2018 09:28:34 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::cd3d:ce97:132b:7148]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::cd3d:ce97:132b:7148%3]) with mapi id 15.20.1471.019; Fri, 28 Dec 2018
 09:28:34 +0000
From: BOUGH CHEN <haibo.chen@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: [PATCH 2/2] arm: dts: imx6sx/imx6ul: set the tuning step and start
 tap for usdhc
Thread-Topic: [PATCH 2/2] arm: dts: imx6sx/imx6ul: set the tuning step and
 start tap for usdhc
Thread-Index: AQHUno+0uj4J8tXh/0W32KhP7KgsqA==
Date: Fri, 28 Dec 2018 09:28:34 +0000
Message-ID: <20181228093558.18434-2-haibo.chen@nxp.com>
References: <20181228093558.18434-1-haibo.chen@nxp.com>
In-Reply-To: <20181228093558.18434-1-haibo.chen@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: HK2PR04CA0082.apcprd04.prod.outlook.com
 (2603:1096:202:15::26) To VI1PR04MB5040.eurprd04.prod.outlook.com
 (2603:10a6:803:59::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haibo.chen@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB4912;
 6:2gNngYsnkW7z6N34kbElKSSP05jGt78iDnOSlDSprxZdTk5/BZWoanb3myspv7AfgjFYZEkZh9Km9yKgQQgYV0qh6vC1XHTI9Wkq06QkzUlSiTbc7hvBkwr+1pBMO4yB2sNLTbMHaFIjqV99+dcFBB4OuJnVE4yDulqP98haax3Q5EyZ/Q7RLMhWOi0znghEO+o976DWum4v0Hycb3gniHfUEZvCWWCAOu0eHvQFemsKiy64div8FA2wXUsPGWqKVXcY4omy1eTclXFU6dIB2cQg96EufaAAoD2sgH/aOzcvFMLNZZIieLEKimMoJghdbTaB1T6augHpnt0NHUT5N+You+q0h9XGsSmQM8uAIk0qhCwbmDkhkG1qbK1y9qwmRqgouaPDqnhfw4XDkJEUFVfNN7zDtlRrqB3UWoyFLFpByzroLxm93SfesvDcU39Yn22rAAtDTriZucmNdBegcA==;
 5:5kW8ANFWI1RV49ptt8mtvxDWfirr5CMrbCf/iG6po6i+i7T+bpKLVHHQHVdVWzyt1vyy7Qifa4Urv544u5MZnd7VrCN5XmMAm0z/AMDPtIJrftEuL73BcPmMhw/PSp3d0Lbg1XWa4bO3phizgZsSOY7mtw41h1u/2/y3aLrvYYw=;
 7:xJ5GC34T5dG6/vPK0w8sHPWuSX4BKGYmd0HiJd+7Iv+GcXvq269zUTNCA4UBBpCOPY56SYKR9pygN5ag56vyLrVGDbBNkyNYXLpMbAAYikmjleT5R6gZOU1OIm4GBaHp0Yc9mSc00HsarUZFvTsjug==
x-ms-office365-filtering-correlation-id: d33f24aa-4134-4aac-6498-08d66ca6d6ae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4912; 
x-ms-traffictypediagnostic: VI1PR04MB4912:
x-microsoft-antispam-prvs: <VI1PR04MB4912E7461C130975D118092590B70@VI1PR04MB4912.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220051)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB4912; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB4912; 
x-forefront-prvs: 09007040D4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(2616005)(11346002)(99286004)(486006)(105586002)(66066001)(256004)(14444005)(5660300001)(102836004)(476003)(478600001)(25786009)(186003)(110136005)(14454004)(97736004)(36756003)(106356001)(316002)(446003)(6506007)(53346004)(1076003)(6486002)(53936002)(6436002)(26005)(6512007)(386003)(50226002)(7736002)(6116002)(3846002)(2906002)(2201001)(71190400001)(305945005)(86362001)(52116002)(2501003)(68736007)(76176011)(71200400001)(81156014)(8676002)(81166006)(8936002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4912;
 H:VI1PR04MB5040.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8NPRazkYLst2jDDIeRL9jNum5+32u3ucejacZdX6O5znWPkDecTcT1NoKHka1QTnxE84cA+JQIIb1ep9uIKNMl/drzdJSDNyapPM9swyFgBsdnKc9m9cap+eok8Q2Ji4REY/mr+Rb4+1PVda18SjjExRLTxPb5B/bgMSE8s5H2jzqdM7kzLq5Bu9JSviZN627ua9gLsMrwQcEAwJ7uNqeUx037wv64vc/Fki3qRMMV7L8Lz7KaKXsM5WNDceYyIgl9cBt0UNok/Wfysyh/1xnfaBlxaO0QV6x4iN+oBrXPd+wWn3Je5EIQWha3CCCjzk
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33f24aa-4134-4aac-6498-08d66ca6d6ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2018 09:28:34.5090 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4912
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_012847_494911_95B648C1 
X-CRM114-Status: GOOD (  12.65  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

i.MX uSDHC IP require that, to make the standard tuning logic work
normal, the tuning start tap need larger than 10.

This patch set the tuning start tap for 20, and set the tuning step
for 2, cover enough large range, make sure the standard tuning can
find a passing tuning delay cell.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 8 ++++++++
 arch/arm/boot/dts/imx6ul.dtsi | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 272ff6133ec1..dc00aee68582 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -936,6 +936,8 @@
 					 <&clks IMX6SX_CLK_USDHC1>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-step = <2>;
+				fsl,tuning-start-tap = <20>;
 				status = "disabled";
 			};
 
@@ -948,6 +950,8 @@
 					 <&clks IMX6SX_CLK_USDHC2>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-step = <2>;
+				fsl,tuning-start-tap = <20>;
 				status = "disabled";
 			};
 
@@ -960,6 +964,8 @@
 					 <&clks IMX6SX_CLK_USDHC3>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-step = <2>;
+				fsl,tuning-start-tap = <20>;
 				status = "disabled";
 			};
 
@@ -972,6 +978,8 @@
 					 <&clks IMX6SX_CLK_USDHC4>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-step = <2>;
+				fsl,tuning-start-tap = <20>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 62ed30c781ed..46dc1bc1f702 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -857,6 +857,8 @@
 					 <&clks IMX6UL_CLK_USDHC1>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-step = <2>;
+				fsl,tuning-start-tap = <20>;
 				status = "disabled";
 			};
 
@@ -869,6 +871,8 @@
 					 <&clks IMX6UL_CLK_USDHC2>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-step = <2>;
+				fsl,tuning-start-tap = <20>;
 				status = "disabled";
 			};
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
