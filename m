Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A3AC6786C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:20:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD6502086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BMvfktau";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UfPULVOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6502086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=m87T76jQXWtacySRYg3OKPfw0FExNtO+Slq/UTZbzMc=; b=BMvfktaucHAqGq
	qKWCpO7aYgTJ+yKQelhj1RAqtKj25FV1IULZXi1/TdjyxdVUQjVKlSPSy4mae/DMtH5SoiiqHsSoz
	79ABOFkiMY3cRs0sLgOwaQZ3AzVPLPXeKzvwwvXGDeswiJJS+URYepUJNdz86bNd/+8pQytlkmcF2
	EQFMsD/kB7Z97jwF6eF/1Ikz9cx/mAD3Xxmx1MS/iKMIT0dUbv1XSYeRbUaRARMrGbrqguA3gZwLa
	zQ3KSRr4aS6BPFJI74zCGZRR7oV/wRoj5YcruFKBRYdAJwd/z1gWkZJeyCxz3yaZM1qFxVlsFzWI1
	eFvPJ1BEnpBwV59uDgnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXiiA-0002Zp-96; Fri, 14 Dec 2018 08:20:42 +0000
Received: from mail-db5eur01on0625.outbound.protection.outlook.com
 ([2a01:111:f400:fe02::625]
 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXii6-0002Xw-01
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 08:20:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XM/nfZ6PybOd0XAwGhp9tp7Z5xntz021mGBsxZ9pC2Q=;
 b=UfPULVOaZc0TdUMNVHXuCsD3RDd1slArWd9x0DdqP5s78ngqwg5BF6OxKh3yTNisJgGEvH5IW3JG5scTt1AGcOO3rmoVulNCHWUxK9ln58msriEfFV0Kky4HpF3Dw95ta9Y5KX9gj+1xFBkC6eQQ803nPXFrAr4WnknGIrfoULA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3740.eurprd04.prod.outlook.com (52.134.71.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Fri, 14 Dec 2018 08:20:22 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 08:20:22 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ARM: dts: imx7ulp: add sim node
Thread-Topic: [PATCH 1/2] ARM: dts: imx7ulp: add sim node
Thread-Index: AQHUk4Xbpx1GKPk9bkG4WDKn6lcg0w==
Date: Fri, 14 Dec 2018 08:20:22 +0000
Message-ID: <1544775260-25458-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0071.apcprd04.prod.outlook.com
 (2603:1096:202:15::15) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB3PR0402MB3740;
 6:6myagCO/cO8orbfSfEQZ9O1QYFMD8yOZRgxL1cvLcM6FZanVk2OIzQs9LbDjcuCbb+dJbrLxmi//r8iFOp70vJXOccrW+AmXdMtaH1TaE31ty3TNHFDv/5f/hcPq3kED9fxJ2kZAtOocbGVZLH+wxr5xuadPT+eRqXPTx4uS8Tke/qzeFZSnJAeMMpb4sc72MiDiLAa6ceGsruiVl4MtWXT1DHcD9f2rFHmMVovo74SyvRi22YrFDgxFCBheMEM8u2CtH55Ue/2WBTb7uW9+Cc6j5F6C7yYN/9YmcNHAxTsEtE/S9kA63A6F4SjJckP5EOUuSNCCPPWNeAXC6mwTpYnVgZbTKKDW0oZPiBE7PKtASuoD4eRFmrG7SvKUdLVbLN4VWSdYPH94xR/L4GT+qlRMKQuRb76p7PdRKDa3iCwTPqTiXHstTfk6r5u5CFCFmP0wrwWGaBGDYqtlZNBD4Q==;
 5:Q8ktsV1ifXBKBEXmN1eo8er6UqpkCgwgYhJP2yR3kCKo8zmnq3KOs4sIuNiffSvNAq5jyTfl7APfg5t2ZbwYpkbBjDZqPcfJAh0GZXFXlNXfYvJRAUXEOzrARJzPLbmyr5lIuD9JdS1C00n5dPsIqnCxYtVgllyFwSnwoJ+w7H0=;
 7:zxmM1txvdrNdCQjg6EUHBpwsd48/gV0BttxREII3VJazUjvYm4xdyiB9pEJcj16t4Q0V/+JxWM36qCzfOdDAns//a26jkSst8IfpTT7RwDPPqJAQeGSTYWaXTZIJFvj1u5etc+z75RWVmqVNJgp2qg==
x-ms-office365-filtering-correlation-id: 787845e5-59bf-4570-eec2-08d6619cfd75
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3740; 
x-ms-traffictypediagnostic: DB3PR0402MB3740:
x-microsoft-antispam-prvs: <DB3PR0402MB37404C3E9FDFCD63940D783DF5A10@DB3PR0402MB3740.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:DB3PR0402MB3740; BCL:0; PCL:0; RULEID:; SRVR:DB3PR0402MB3740; 
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(396003)(366004)(376002)(136003)(39860400002)(199004)(189003)(7736002)(476003)(305945005)(86362001)(66066001)(2201001)(486006)(2616005)(6116002)(3846002)(71190400001)(256004)(71200400001)(316002)(36756003)(110136005)(99286004)(8676002)(81156014)(81166006)(105586002)(50226002)(52116002)(6436002)(68736007)(53936002)(5660300001)(25786009)(386003)(102836004)(6506007)(186003)(106356001)(2906002)(26005)(8936002)(6486002)(14454004)(2501003)(478600001)(97736004)(6512007)(4326008)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3740;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AxqMl2MOuGSFpGxpxdV/9LOFZv21CP1wdsep9Q117st9KJhnGOifRl/nPpgybKHggMXC25LptprigyDpnKuT5XCbQp8hpDdqT2vhNfFycd852JWezdcYDuyRQfZCvYVDU9Ol0UG5pOrDY+q5BQxG5e+vU8SdaqFwyHZ+F7m1h2UI8AEHw0dU1OnMsVqECeMeQg2pqf5Q75dgDYh6vnmrHnMqjulFwV1Q0gad2IGQNzQpt/VUWmg1OvkCnQbKLzsllg+TCT7zymamanOrGRa6hcIJeUGhFFf8FL9XebiJtjY1lrMQZhrNZqESRcfeb5Cu
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787845e5-59bf-4570-eec2-08d6619cfd75
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 08:20:22.0725 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3740
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_002038_032444_C1E825EC 
X-CRM114-Status: GOOD (  11.04  )
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

i.MX7ULP SoC revision info is inside the SIM mode's JTAG_ID
register, add sim node to support SoC revision check.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7ulp.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dtsi
index b86daf7..fca6e50 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -347,4 +347,17 @@
 			gpio-ranges = <&iomuxc1 0 96 32>;
 		};
 	};
+
+	m4aips1: bus@41080000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x41080000 0x80000>;
+		ranges;
+
+		sim: sim@410a3000 {
+			compatible = "fsl,imx7ulp-sim", "syscon";
+			reg = <0x410a3000 0x1000>;
+		};
+	};
 };
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
