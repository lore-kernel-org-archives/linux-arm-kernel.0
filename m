Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B54C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:23:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3280A20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WYrqTiQD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qWdU2ONf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3280A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m87T76jQXWtacySRYg3OKPfw0FExNtO+Slq/UTZbzMc=; b=WYrqTiQDLt+deo
	bCK9b7yA1o/R/+0eAJgW+j2fvQ33mEPbo9XVb9YNrjCgAAco7ITLe3/vqrHfp6+q5NhAIn5UNGlg2
	+pwCPnIdHq510lE6aC3lFexe4n65WsKXtLrilkDVX73PyOy7mHUUk28KeHqkyEx/xqhoNBK3CMXSz
	XQZiutHWAnhAemBIdAvh7gO6pYSgDk6bBr81Er0IHbcIxb64iU+QH6FEFbwhKbD7dzrdQAlbMTnfU
	rDkVJ1Zj9aL/zvS1gAxzVOTn9yFEn4bCbvqTEoU2F+ZVoJX0Q+tvNl9Mr4jImSnF0Ai8bcakhqsqR
	YTUqWN2JNVnGZVVAGqew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghqDt-0000Iw-9y; Fri, 11 Jan 2019 06:23:17 +0000
Received: from mail-eopbgr40079.outbound.protection.outlook.com ([40.107.4.79]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghqDY-0008NM-M8
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 06:22:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XM/nfZ6PybOd0XAwGhp9tp7Z5xntz021mGBsxZ9pC2Q=;
 b=qWdU2ONfumIhzh0KHOt2th57vgwHtCvBNW5TuIBm4WOsnU9IRu9k6XR/tOnNagWu3U1l5BELHeMKWyexg1rSqY/maZVr3tQ0SEHYCNMHI91J+3YNHfUx5hylDPdA7yFCsAXuWX2LQS7V/qYTaXedcOHzHKTjFlsJv5i296T0Mqk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3788.eurprd04.prod.outlook.com (52.134.72.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Fri, 11 Jan 2019 06:22:55 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97%6]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 06:22:55 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V2 3/3] ARM: dts: imx7ulp: add sim node
Thread-Topic: [PATCH V2 3/3] ARM: dts: imx7ulp: add sim node
Thread-Index: AQHUqXYWg+51IO12n0K+7RQGwoV4PQ==
Date: Fri, 11 Jan 2019 06:22:55 +0000
Message-ID: <1547187469-14046-3-git-send-email-Anson.Huang@nxp.com>
References: <1547187469-14046-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1547187469-14046-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0090.apcprd04.prod.outlook.com
 (2603:1096:202:15::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB3PR0402MB3788;
 6:Fz4JrrWxlLg9VdRK06jcYNEMOxuG/OHScfFycAd577I4009HaCxQEKmulnG7SgDPiVEw55zjIx8g9EFp8xK9HHXNxXLgN4Ix1Uvt1JMbv9Qj4vQAZ2773DEmCMIc4+78/ZZvUL2oMUttSEjTFTXj3L5d+lcY8XLMJkQXgsWJFwppYJUCIZAvPazgW4lZjC9r539YbMKNbTpcluXfQ7i3AhmBpp5mUNPNalTQt3RbrDbeg/35LMRqIInUlIlGZ07OXKK6wnTlBds3saKnApx3gAttGp8D4n4dQAgFJevbOSA0DbjQ2N3tCiJgqG6xKJmWbOlxE8CyZFAtsLpUzXjsnXBtV1iVYai58VjBA1mNtxHbznV52MfTnfXJFcBh3TApGwiOzUTUi2I9B5o5Vv9nOqXMt8CQBAs1yV6po3Q/XHBQCdLNVl25KvFgSJAa+N8HZr9W7DyDcxEN1Eb44k7pVg==;
 5:nPdRl+Pfddcj+cE12yanciPe/UqkH0Dwpn74E0L+CfK49eWqkMmoOuCmDp97VoFUWO4GEK93RWEK2C3OvEhYa6A+xeRpeCjO497ySO2i2ririiLm4Dlx5CDGc3Xp5QjhmTKjOHSHMgs8YxXRtYn4oqC5lyF3BZjkRS8j9VH6LuWMbH8RaQiWrwhq3I0UN72JTqw4H6ON4r1cvJKXlfVMfw==;
 7:wvL+0cvxmq8IWPqe9avbpo6SSCb1MILrr9T/w8SpS7dEYyXWye/yS08OzanyYKbukoiRt/aQLa8FZ9EKp6IvN4NiJh9EBpdq9vhEkio90u9bv7laefgVMfl6FG0Jvhfpzlls5SEi11qx2agB3AKO7w==
x-ms-office365-filtering-correlation-id: 866d4191-bf4b-41a1-8de2-08d6778d38ba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3788; 
x-ms-traffictypediagnostic: DB3PR0402MB3788:
x-microsoft-antispam-prvs: <DB3PR0402MB3788F43CE6BAC52F996F4F5CF5850@DB3PR0402MB3788.eurprd04.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(376002)(346002)(136003)(396003)(39860400002)(189003)(199004)(4326008)(486006)(106356001)(105586002)(53936002)(316002)(2616005)(102836004)(2906002)(25786009)(4744005)(26005)(99286004)(186003)(386003)(6506007)(97736004)(6512007)(76176011)(6486002)(52116002)(71190400001)(71200400001)(256004)(2501003)(305945005)(478600001)(7736002)(446003)(36756003)(14454004)(11346002)(6436002)(6116002)(66066001)(476003)(3846002)(5660300001)(81156014)(68736007)(81166006)(8936002)(86362001)(8676002)(50226002)(110136005)(2201001)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3788;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vyBkHhGgD93yXgXHmSJmaI3BQWxh5npNZ3EYzPTy/xtyyS3Q9qXB43DEsw8SpJeuP4FMu4cQY70Dpw9Cl/UlIoQdn+Dw1522iCOccJ5gPiGZ/XNsVtWAcFeYQtt996BfMEpTWz9AuV0GC81Xc+KmuG84ZL3iZBDyXmzGPzz5TmD5Air9+MXAx/P07h9sXtTZQ4jaqMVbRPKo39A5Ng2CJ6ch2YrUn+z9AKqL2/mINX4BqSeQpiTUOyZ6ITRrRgYPqmVrDh45m164m+VtdgdLEWdkqz7o5I4DBWnxjyS2g5hOEtAdZEO8SvRcoL5GteyzxKC4yM3jBITXM4ysSbEG51AJVxRs3ZgktChfOaES5IbxLwRrny8N/5UO3cuMiK+9JXM8ZEB1ukwRGKzRnnMm3q0J2RdjWfR89wQhmeOZ0ak=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866d4191-bf4b-41a1-8de2-08d6778d38ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 06:22:50.5990 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3788
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_222256_772380_F5D8D1F2 
X-CRM114-Status: GOOD (  11.56  )
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
