Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3B7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:27:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04DF213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rZ0f76kq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c28tySfH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04DF213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4gw/cfm1sPI+rzG/6rlfgGt+6oPlmnM7UyJLMOntFwM=; b=rZ0f76kqyXZdo4
	Z3SlCwukefoogEnqcPJv2K08wLpeXUN0bEZxhPijINJijL4JMBjB50TYhX5KwPH+ujN4kEyL8RHlR
	9k7xhd0M2J+DtGDR/yPqCtHmYWKDZZOYhcx8iAqc7vDpK3x3ILCyeenIFJRP/tsvna1qqCDZZVcWn
	c/MyZzlAtWzVMrlVtf7qw/t19Ts8vdwaxbIPiw72LN8zKRAAg7XaAR/jGRI7riLXXRZHW/Ld2k3Oc
	C+vhH1M0iwlH86toQOUbCfEYXNlGaHP6VdSUqtLyyPWbjOqJo5jFr0l0slQzv6J6q485oTnpVZI/9
	sXZhYqK4drEM9S/Ukl5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyGI4-0004uP-2Z; Mon, 25 Feb 2019 13:27:28 +0000
Received: from mail-eopbgr80050.outbound.protection.outlook.com ([40.107.8.50]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyGHL-00040i-KM
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 13:26:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OX6q6lc+tbP1OZ3w/LXO0CGKRYLxDEuL2tCmm+8URqk=;
 b=c28tySfHqhNrh4S2HhpdLUYgaWLsG45xsS0fDXVunxqqtG2w774SbJktj2fTrif/7/dXZ/jQ74R7f95LwVs5ZppYSJCTf45u6p93r38mWp0SyDGCeeFJyiUtmcDW2wu5Zuab6FzkOejNwlolRjOz8eZyKNRXceQpCbat9J0c8sE=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2848.eurprd04.prod.outlook.com (10.175.23.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Mon, 25 Feb 2019 13:26:39 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 13:26:39 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: [PATCH 4/5 v2] arm64: dts: imx8qm: Enable SAI2 for wm8524 codec
Thread-Topic: [PATCH 4/5 v2] arm64: dts: imx8qm: Enable SAI2 for wm8524 codec
Thread-Index: AQHUzQ297yImCNxuE0SjFgDwYcA5Nw==
Date: Mon, 25 Feb 2019 13:26:39 +0000
Message-ID: <20190225132617.10987-5-daniel.baluta@nxp.com>
References: <20190225132617.10987-1-daniel.baluta@nxp.com>
In-Reply-To: <20190225132617.10987-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0192.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::22) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc0825b7-51db-4f30-c349-08d69b24df98
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB2848; 
x-ms-traffictypediagnostic: VI1PR0402MB2848:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR0402MB2848;
 23:2bqlfVPLcIm+oe9OxLQWdmRdaMyZ5ezxbIdk2?=
 =?iso-8859-1?Q?By9L4X+PHYmn/0KzwYSxEiH92DSz5/erGZ7yfSX1Uzm8EEe/jEZKcsuRxQ?=
 =?iso-8859-1?Q?l1/yy5DnEi5xhcihh3wmNvf1MUcHgj//FvAaqai/41nWoFxEVl9eYnIm06?=
 =?iso-8859-1?Q?Ug33iuW2Ktwn9tua4q8KZyxQvUzVCYBdhp9ynmcB99pyhStgrXQwMkzcFd?=
 =?iso-8859-1?Q?/yxvbocRv3sdTgui7M+g8HBk9xlUxR12jwoaGa7Eu6kfH8yauZ11pQa8ik?=
 =?iso-8859-1?Q?5whKKOUnj7mijn+obEj/IuV/bKTn/lJ9nUejpFSeFE/UvvqowOAD1UZPZq?=
 =?iso-8859-1?Q?BIONZv1YOZ4bNYS1SZZp6dkZuhnOQodqxIMA0zlWv0BDHEENAXU/ufc69n?=
 =?iso-8859-1?Q?kYffzM1fOlK4l7kCZwA8hvQW8xcXsWMRxn3T3z4iUMJsppbMFFpcEXcpoy?=
 =?iso-8859-1?Q?5rDMWI4+bPt97nWm52yd1u8a5YyN6Uq7CSBom5PLjbv1++HVccCPFWR2gF?=
 =?iso-8859-1?Q?Ru2eyf2Ie5upaFF3+NfhyuUl2Gq0e9H3pEIloFTa69TfWJzh/9qCEFfKwN?=
 =?iso-8859-1?Q?LfXB0bBTh4Dml6O0k47bFMC+WYATW5DaAdkxgLUHB/R6YkkdCw8oehBrkD?=
 =?iso-8859-1?Q?KwBARxOAY/5B403uulAAxI1Go1N0FVggTn75Q+9UOfaiIKss/t5dcjIq7B?=
 =?iso-8859-1?Q?lvkmOVslJMPUJYbStQwcCMGMTmq5vAWrhEUHaQFreuVyT9Vu8LRVDJhuij?=
 =?iso-8859-1?Q?+K1Fp8C0GUvRyPBnzpu8bsaylvqG+gT4aA/ny6hGTr8vs5UZT+GsJ5W/T2?=
 =?iso-8859-1?Q?z9cHO99QY/NHf7abLG8dRMgsF0EM+Zqxl4dDYDCzt91TKNNWg9tbebMGfB?=
 =?iso-8859-1?Q?y8QzOrxL2YaHzBd76VHEF9N3ZhikrxF6+A/XqxAaoOocFsgj92KHOQ4rx0?=
 =?iso-8859-1?Q?tL/+MeK+KrmWAH0fXbLE9E/Ijgo2V/EOt0hdtKLciFMjMmiqiWOWlZZ8XW?=
 =?iso-8859-1?Q?0t4/pqtLR4OVqBEeLZ8NhesFrdm7gid5wvrvYPIuCd6ipW7osct681PGwO?=
 =?iso-8859-1?Q?VUMuDxrSjn918k8NW+GRJP7ITivdrjQTO27MnzlSQSefak60t3X8xUrfa4?=
 =?iso-8859-1?Q?PL461EsafxJbPOFeBktCl+Hw9HWpYMttrMw6JRFwZ1GynTPRCmW4Gc6zcf?=
 =?iso-8859-1?Q?2ieisgcWzYU8T4ZpfAUnyMj0QGVXHi5HfN9ZteJkjTfd4+ZNSLjy8IJoSl?=
 =?iso-8859-1?Q?W6HPnGoAgREA5fPCKW/qUTgrof7iDMAqepdcQBOSYYpTIyYbck4UI3eQKP?=
 =?iso-8859-1?Q?eEZTak2gkSaF5xo7DpbB+9TnZyNV19O7S+JjJR6V8JdJFbKVhFshME7oBU?=
 =?iso-8859-1?Q?0f2Z+RSdxaCeZg7RyiME1yQQ7ngzOYcF0M0CqMdyw+cjIGgu8OxxduJJh4?=
 =?iso-8859-1?Q?kjTSzkxzduYIDZLP+CLkHInPRn9VXvzVkgR4AbUKQgGlnXdTEr4KYAImvr?=
 =?iso-8859-1?B?dz09?=
x-microsoft-antispam-prvs: <VI1PR0402MB28487F85963D6179F2E87FD0F97A0@VI1PR0402MB2848.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(366004)(346002)(136003)(376002)(199004)(189003)(6346003)(66066001)(4326008)(68736007)(76176011)(99286004)(6916009)(256004)(478600001)(7416002)(386003)(97736004)(25786009)(6486002)(2501003)(26005)(8936002)(6506007)(14454004)(52116002)(36756003)(186003)(4744005)(50226002)(102836004)(8676002)(81156014)(1730700003)(53936002)(2351001)(11346002)(106356001)(5660300002)(81166006)(316002)(86362001)(6512007)(7736002)(305945005)(71190400001)(2906002)(6116002)(14444005)(5640700003)(3846002)(6436002)(54906003)(1076003)(44832011)(486006)(446003)(105586002)(2616005)(476003)(71200400001)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB2848;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2C3qVw3ly5rhYyQLlNaP70G2IEqIhhK/cO1jvmYJQQrCHSBnUQS9GZrgk0xA4VALj/rME34IuUIIJTyBqM92+lTjGh56H8P4/g5rxa7f3t1sT+sy3RTkyFjEcJXJxf9Q/ZzWCLk5RJTTNESRz1Mheqc8G6vEX3xY7Ve4c+UQI54l4WALia+n3XvxnCdODUAwYABwLllPAxcS2LzwVAHI1v/E2zzblNTXTRkEAd0GGbdjWfcHNYFL//9M720LxCp7vjvN8weCG3Ebpce/Vy2CifzbjcmKX/N6OwnaiSnbhSgGBts3RC8FbpMzmeRHoQQGIoc2f5hWfRCQJOkRVnGfDS0swBriNlxm2NWEeHDnJi/gYiL4NpMWDtHAqAN0Er2b55NR/RvI2JjfrUeJth8MyDtYwi5B0LFTj36r/rJSpP8=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0825b7-51db-4f30-c349-08d69b24df98
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 13:26:38.4247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2848
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_052643_964674_81010CEC 
X-CRM114-Status: UNSURE (   9.93  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "baruch@tkos.co.il" <baruch@tkos.co.il>, Abel Vesa <abel.vesa@nxp.com>,
 "ccaione@baylibre.com" <ccaione@baylibre.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
 "angus@akkea.ca" <angus@akkea.ca>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Aisheng Dong <aisheng.dong@nxp.com>, "agx@sigxcpu.org" <agx@sigxcpu.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This enables SAI2 digital audio interface to be used with
wm8524 codec.

wm8524 works only in slave mode, so we make sure that IMX8MQ_CLK_SAI2
has an appropriate frequency in order to easily derive rates divisible
with 8000.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index d21ee2a5312c..58de4a3d6029 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -52,6 +52,15 @@
 	};
 };
 
+&sai2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai2>;
+	assigned-clocks = <&clk IMX8MQ_CLK_SAI2>;
+	assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	status = "okay";
+};
+
 &i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
