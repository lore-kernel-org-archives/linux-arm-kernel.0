Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7A7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 10:01:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88FD22145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 10:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mJXDDPeJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="yGvMjzi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88FD22145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=MEOwqHU8eLFM7E8t0YTGVulkEXW7BJXVSQq7lihQ7AA=; b=mJXDDPeJGsUAUK
	FcogLEupmodWOqK1ABHHzcq8TSBg7lsPfipHrA0821kCluMl8/YccKUgRsEVAvZjRzDttIa7rX2Br
	5w9pFto/CHN5e7XZWNva5SgydsajqVuys3u3Jhsf4mryP4EoEsdQaio6NEJdmjVT27iQTrnPynGeN
	lbG+wqiwBCjTCODi7B3fyC1PFy5jhBJK+Zy59cJTx0qHeZ52DjS+RVCpdzioJYrfBTeQba4HGWa6u
	RtwdtdOn/tMTkKKSRSVH+Dysx0C+NWZrZZm6M28NV23ktH0P49807v4rDUBmXslAJSQoQ0uHpTB3D
	ywSTq9PZW+nl8OYB8u0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdBR6-0000yE-NA; Sat, 29 Dec 2018 10:01:40 +0000
Received: from mail-he1eur01on0615.outbound.protection.outlook.com
 ([2a01:111:f400:fe1e::615]
 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdBR2-0000xS-Rg
 for linux-arm-kernel@lists.infradead.org; Sat, 29 Dec 2018 10:01:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoYuskcfItn/z4BRBd6u/iZItta1e2RPqWg73psIzBY=;
 b=yGvMjzi7T14Jzk5tMOWO6I6Hx36Z1v+jTFtNvYJOHlct9aCsgjJSlyIGy8pTY+HEIQLggTW/GrcQA+4LU9UgnTZQR1fuO6V/+lyASFR/U4Nc7sST3w58+KMHbSGiWSW8Ij2l3C17r76kjj3xJBvZq0IexFUfV/gR+lDOTwI5FAw=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3560.eurprd04.prod.outlook.com (52.133.19.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Sat, 29 Dec 2018 10:01:19 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::e0f7:5b3f:bb6b:759f]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::e0f7:5b3f:bb6b:759f%3]) with mapi id 15.20.1471.019; Sat, 29 Dec 2018
 10:01:18 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: dts: imx6sx: correct backward compatible of gpt
Thread-Topic: [PATCH] ARM: dts: imx6sx: correct backward compatible of gpt
Thread-Index: AQHUn11xze44rhB2CEeG3+TNL+BIWQ==
Date: Sat, 29 Dec 2018 10:01:18 +0000
Message-ID: <1546077384-5343-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0038.apcprd03.prod.outlook.com
 (2603:1096:203:2f::26) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR0402MB3560;
 6:HGglVRivzdKTWpC8Bgy+Ucx2gp8pNyGOU36o9S52IzyBE4eG6HbkOt2DUvcihDhOy2Z12YtSExBDjGZDfpzi+hQzDu8PkFP+/75ITc1/9uyvNf29zWPiqv5n1iM2ZzMYTlZCBXyuTUztUgYarPY/0PzdCFxCbqz7cYuZ0crgL6Jssu4cuI0OhZxOGcgBrybHHlxEWOdI9zQ97JuAcPqmdoOid+DdUmoNGD78NPMF6mjO9pA92VfQI01PDUJzvesfcsl149PhoCp1KWKOV5uAuhbfUdCS/U8oPa8jLQKvhcrWsa8yUe0KPCU2sEYnB4xtfL6gJxIef+BOdm7Lggl0gHmKeFYVqOgwz8NQ97CpntzLXfK5Zun5BaiI4UpUz5kQkqYlbVV74m1RiVc0UAJcNlhesi3zFb4TUc7b8TAd3qdIKy34l1sReGc9bcMKS9CZd+Xtcq8MC3MGiP63SZIKQw==;
 5:/kGXkBHi+9yPbxXuWs+c+4iq1uS3ed93vgRAKNFroU2OIJlor6owM6tgkg0SHpth59SfQsR1LvOCEsykXTyWsIgOBCeo/80Qd8fs4LPA+fQDjkFootapxwFXXxpHcnPs6u54YX2uxP9raDZ61ZiyQ6MM+0f9QPHSqQJXr24s08M=;
 7:Ee+F3fsZdW4jj7C8HsXN3kquAH14o67I84BMZxAU6MKWufIKvFJfKRBaEDNe82TbTmX+a6vKc15cbARbbCZCTxSBI4ahYqFHJkn2+UBTbNvvud6Ls3yZtpsnt7jhrQ5Z7BlQyoCk1JtG+Qq7B0hViA==
x-ms-office365-filtering-correlation-id: c7de50f7-4aac-40ef-6563-08d66d7493e8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR0402MB3560; 
x-ms-traffictypediagnostic: AM6PR0402MB3560:
x-microsoft-antispam-prvs: <AM6PR0402MB35602E3714B669D0AA3AB296F5B00@AM6PR0402MB3560.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220055)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:AM6PR0402MB3560; BCL:0; PCL:0; RULEID:; SRVR:AM6PR0402MB3560; 
x-forefront-prvs: 09011458FC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(136003)(366004)(39860400002)(376002)(396003)(189003)(199004)(105586002)(2906002)(106356001)(6116002)(6486002)(478600001)(14454004)(25786009)(3846002)(4326008)(6436002)(68736007)(2616005)(186003)(53936002)(102836004)(26005)(6506007)(7736002)(52116002)(476003)(97736004)(8676002)(81156014)(486006)(8936002)(81166006)(386003)(50226002)(99286004)(36756003)(14444005)(66066001)(256004)(71200400001)(86362001)(71190400001)(2501003)(110136005)(316002)(5660300001)(305945005)(2201001)(6512007)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR0402MB3560;
 H:AM6PR0402MB3911.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Vj9HNPVFuglk7tNE3CD8H+XK0cW64SOeqB2v/Cu5pL3jRu/RkPiYA9se2oJeb+PV2TqBGRto9fqm9gDQjN8o3K8TaZLEHV+7vmQjfadGqCZ7ZSYqiOHwut+lweeqt8ObU3XX2pvOQR0TL+HwqKVFzNrQdDTOGhc7V7KJKmfW6EnmtI8yziGVjPUlb1+iY3XNd1wD9P9ylHmDYQbH7ab9phpGQsS4bgJZmyMsGxhloZnJF/na/W8aB8kvqJ0mVtL3ZrPXboBVWqRuBo8tIKWK0UzF7KxR8XOUaAbGlEgxXet73+p/JP+pRyoqRjLQeVNi
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7de50f7-4aac-40ef-6563-08d66d7493e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2018 10:01:18.9306 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3560
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181229_020136_898571_A7EBAD7F 
X-CRM114-Status: GOOD (  13.50  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

i.MX6SX has same GPT type as i.MX6DL, in GPT driver, it uses
below TIMER_OF_DECLARE, so the backward compatible should be
"fsl,imx6dl-gpt", correct it.

TIMER_OF_DECLARE(imx6sx_timer, "fsl,imx6sx-gpt", imx6dl_timer_init_dt);

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 272ff61..d1375d3 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -467,7 +467,7 @@
 			};
 
 			gpt: gpt@2098000 {
-				compatible = "fsl,imx6sx-gpt", "fsl,imx31-gpt";
+				compatible = "fsl,imx6sx-gpt", "fsl,imx6dl-gpt";
 				reg = <0x02098000 0x4000>;
 				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SX_CLK_GPT_BUS>,
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
