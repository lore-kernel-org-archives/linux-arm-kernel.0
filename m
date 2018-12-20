Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E09C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:50:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8DA42177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="guWFqk2f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K+1iHthW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DA42177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yEcfFuGYBB02bpLszPCzUeCQ4e9zT8KQskVI98wJGCQ=; b=guWFqk2fsqpt97
	HEd2tpdn0zpcwBLaDggenkDahiWfTj63aAQseQCcKnrKXmh99tmdS1Inpj0C1OG0RJdqIa3ob02P1
	Ptmd8hDdzQU4qs5RQAJIjwZJaokwS0g6K15o2pQ5L3VDSP2ggjye4/9rBzcwboMrtTl1YIFsiW6nY
	F1s1ZjgUbt+g8UcS/0HwmBcByAZkC5otmiDi7jAfX+s6E2O8QpveiDzDKOQgwy2D8TMIvoE3l4juI
	asFPG9fbetUNgrIP2K+g6HQ+ctSbWfddiCxF+aQ1ivg4m011p0ZR/qO+aCWj8yjlo0FioZKcXev/R
	NLLANR86lazwVXMrN+pw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZt6C-00028i-EO; Thu, 20 Dec 2018 07:50:28 +0000
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZt5r-0000Uc-JG
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 07:50:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Bycp1YZ8o0VPWLfotuzwbZYOoNfemcHZhKaClerHYc=;
 b=K+1iHthW7687Ks3MliZWLNTwh118yaK18hkYntKW0RchUiL9ByYV5CmdjsaVnw2n1RMK6YIe7CTDIGeSrX4U8ZqSbt0r+N7W0E743YGcSJdTmLYCb72xAw8H1xW/6glaK6/kStztS9FwTMRy0dROHCXEHgrG1j+U6dpCptwfqg8=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.50.97) by
 VI1PR04MB4319.eurprd04.prod.outlook.com (52.134.122.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Thu, 20 Dec 2018 07:49:55 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::cd3d:ce97:132b:7148]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::cd3d:ce97:132b:7148%3]) with mapi id 15.20.1446.018; Thu, 20 Dec 2018
 07:49:55 +0000
From: BOUGH CHEN <haibo.chen@nxp.com>
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, "adrian.hunter@intel.com"
 <adrian.hunter@intel.com>
Subject: [PATCH 3/3] ARM: dts: imx6ull: change to use new compatible
 "fsl,imx6ull-usdhc" for usdhc
Thread-Topic: [PATCH 3/3] ARM: dts: imx6ull: change to use new compatible
 "fsl,imx6ull-usdhc" for usdhc
Thread-Index: AQHUmDiZPrzcvBlVt0CVYqojn1jKlA==
Date: Thu, 20 Dec 2018 07:49:55 +0000
Message-ID: <1545292612-14471-3-git-send-email-haibo.chen@nxp.com>
References: <1545292612-14471-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1545292612-14471-1-git-send-email-haibo.chen@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR03CA0025.apcprd03.prod.outlook.com
 (2603:1096:203:2f::13) To VI1PR04MB5040.eurprd04.prod.outlook.com
 (2603:10a6:803:59::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haibo.chen@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB4319;
 6:FOJu7b81CS0AM1ukaTArTS67K2nA46dKlQbrE8u1DAMGOwUrhgmTkJgrr1V5HyZZwLRJivDm5OMxRSf9r2MeZVaEvnKsbYqPhL4Zfv9c34BU4DUQ4RyBm2whqi07MqFjXbYcnQpJ6pjPQeH1YZS40aru4KMPopdpRivCAYHYhvTwIg3HdRoCVI4H6jiQSl1TXhlXz4NUj4o65aKwA7hR9X7pOQZ73kwojrzx9/1OFGwIY0X5Lw/226zOBW6VIyRhJdz4U9W/Wbg1jaT/NsVuj6oZx/bnvOev8FCQJHTQovObfbgo45tcmjlX4Ns7fyGBe9bRZc+SW/6ELj8u6HUaaUOj87pveuWf+fLw2dLdEQR1qwArDBaFJTcmYkrgq0E+ZSHCM3sS7ril7wSF4gwLrs7aBGNV66x7+YvH3CmvbTpCQWxSQ+AL/1UAzNCbILEpotoTOMzgHf26tXHJiqVXpQ==;
 5:GifqAZf4eMceHCJyzQrBwKyS/HxEE8c4AO80RCU1G/KzfE8m79s1Rg5+ymER4FjQx57eQAU+UZryLyikIK2ZxsaeyrLeQKDtgioTDrDIB8yIJG8jE9udkNeLPeVKdeFRAfv2emCmi6sq4SqF6YnE1gfkB5igyBY8Exd2tSnlyc8=;
 7:wr/BgzhPE8UT6NkrIQ3dCHY3bJlb7mFflEwmBTwjdUu7l//YC0UyXoN7qoIMjtXuhVx7xSvk+zwP6TXCRt+BKFk6TsOy8AWIrKPaEEDWKE58hNINAw5Qsbev6wpBKoq4UXXY8ugdOTKwtnyaaGzN1g==
x-ms-office365-filtering-correlation-id: 73c603ce-4de7-4ae9-6505-08d6664fbb4a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4319; 
x-ms-traffictypediagnostic: VI1PR04MB4319:
x-microsoft-antispam-prvs: <VI1PR04MB431968086D891B8E1344365F90BF0@VI1PR04MB4319.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB4319; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB4319; 
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(396003)(366004)(39860400002)(376002)(136003)(199004)(189003)(305945005)(6436002)(6486002)(7416002)(105586002)(7736002)(106356001)(386003)(6506007)(2501003)(14444005)(76176011)(52116002)(3846002)(6116002)(102836004)(54906003)(110136005)(316002)(256004)(53936002)(53346004)(86362001)(446003)(8936002)(476003)(5660300001)(66066001)(478600001)(81166006)(99286004)(6512007)(2616005)(8676002)(11346002)(486006)(4326008)(81156014)(68736007)(71190400001)(97736004)(186003)(2201001)(26005)(71200400001)(50226002)(14454004)(2906002)(25786009)(36756003)(32563001)(142933001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4319;
 H:VI1PR04MB5040.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ILQf0rQEp8rlORbZSQ+KGmRw1GAzzDXwZuC2ydTbexwE2QpXOGtGu1NwP0t7Te7xKB6C3oBp/cwC4sGibG8GiyDTahvGCyJrG3HsmJ/mydByBpskPuOCAZSoCAhtnwZcl63iR5dZfTN2oexqFgBWVQR2+6gZCqwZ5JGwsVje9UUkNJZwrXnQLsA08MO7+jqpDJ0z7s2CDtwtM9hKg19Jv6/lZX9q4tNgBISc5RNHVQ28mSdJW2ESA4hcu5GpGGC354ZE5DptOCrToBAS72YrkOOKFSzD4amwDmLTvaYzh6lSsEoq2PMWUFcyFgnEWAr8
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c603ce-4de7-4ae9-6505-08d6664fbb4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 07:49:55.6162 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4319
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_235008_129377_675A34DD 
X-CRM114-Status: GOOD (  12.34  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

i.MX6ULL has errata ERR010450, there is I/O timing limitation,
for SDR mode, SD card clock can't exceed 150MHz, for DDR mode,
SD card clock can't exceed 45MHz. This patch change to use the
new compatible "fsl,imx6ull-usdhc" to follow this limitation.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm/boot/dts/imx6ull.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
index f3668fe..4ad5828 100644
--- a/arch/arm/boot/dts/imx6ull.dtsi
+++ b/arch/arm/boot/dts/imx6ull.dtsi
@@ -30,6 +30,14 @@
 	>;
 };
 
+&usdhc1 {
+	compatible = "fsl,imx6ull-usdhc", "fsl,imx6sx-usdhc";
+};
+
+&usdhc2 {
+	compatible = "fsl,imx6ull-usdhc", "fsl,imx6sx-usdhc";
+};
+
 / {
 	soc {
 		aips3: aips-bus@2200000 {
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
