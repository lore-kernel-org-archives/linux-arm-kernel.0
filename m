Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C21EC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:20:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 353092082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d33S0YGy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="yHuBP9re"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353092082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dlUCwmzbfLFJ9EzvoC7+Xf4mE4f6q2rxb1qy4oOhSlY=; b=d33S0YGyNd7Y2o
	v0gfKq9hajxoaoT4mNVF0/IvyTg8T3tYP2T4GUJn8Jh1Zn0YNhfyRzAKM8YoMkmFBPJJQvq2NqIeH
	Rqdp0bSIdpgrbpW8Qv0GxEgIeSzg0DXYbtufJdnOxDiNPpSHqGSW2A752hS9zdmHnabRABmmlPBP+
	J0azLaNjC99Ui6kLJe9IEgsxdhAx2TVCEB7dZWKeUtYATxqRlWHRu4tDokuvzUU1ag6k8rLOWV2zd
	sm+/6uXu7PfmF52A/iItYAFJl9hjM0cDSkzSOu7dJLw5l1ocx1JOycyYxV+g9LgmCJjndfWPFeIqd
	hOhT3LOuTOJAJgrAYnXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUTMF-0004DA-Kn; Wed, 05 Dec 2018 09:20:39 +0000
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUTLp-0002Qf-Jc
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 09:20:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTLRCPcFmF8sxXONZxoqSr1ITPYwSWFsYuGMC43ip54=;
 b=yHuBP9reJyYgpV/kZg4Lnq7WQDmEtdrY17IoDE+oENVu8dSj40fvpzPEaoAbRyGxbV+0KCTpH+7iajaAVFApQejUqBzHKRg1usswFJ7iU+QzG+NBik6QwV8rs7Xw53VrPdD0wm2roe4ajngcjcxiMhZ+GoAW9QCKtyiMi/j1Ohc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3690.eurprd04.prod.outlook.com (52.134.70.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Wed, 5 Dec 2018 09:19:56 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 09:19:56 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] ARM: dts: imx6qdl-sabresd: add accelerometer sensor
 support
Thread-Topic: [PATCH 3/3] ARM: dts: imx6qdl-sabresd: add accelerometer sensor
 support
Thread-Index: AQHUjHuwETLJWJyX/Ea379CF6g7TSg==
Date: Wed, 5 Dec 2018 09:19:56 +0000
Message-ID: <1544001240-18622-3-git-send-email-Anson.Huang@nxp.com>
References: <1544001240-18622-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544001240-18622-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0049.apcprd03.prod.outlook.com
 (2603:1096:203:52::13) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB3PR0402MB3690;
 6:E6PsRysP4prXNgLFHPeRewnkBryd3EMmyZztfB7QNThYqkHD+YsZETQ2TejN4/L0MnFj2Bs+JoVutIt5p0Mt2uDw0fkcqeWfrozLn4QX3EE+FQIPrKeijG9qJrnk/JmsWQu/+HcRxyw8L93Nn39l3mkPp8Tz69DbdYLAtumqzvUdGSzKPWWcNCUVbVXaVfelzDYTWj+2Ugnx6QCrXPhsKVsMu4CudxXHO6W17+A5OTXfKJXdM/+sj0FxQvN9G9dLc/88PtcfuynnMEk7DYlpkI4I3jlEVl7kOObiDchqNwaLPAVcqKBXyX6M/5FhJAel0S0f4XROj3kiHNutYuqjJqBeB/G6S15oKphlNHuTUgdphqQ9Aj8ITb2qIMTMcBzKo87TgC2NjqnD7P3dGoNJbB7ga2e5cLZ7J031jV4W0WQ1tlMroUJwmU35rtFp9oDml5fjJQ7YjHx/R4sPyKz8Hw==;
 5:tvV+WVSomOa7Hb+HSA5Pif00jP7GhPir/2D9/sanstoPfdnW9NSoxncRRqL15KPDrmayYHmosuOeryzGTYdsYvipku+aNMFtpE4lvolPVmcOcKsH4L6xSSoOyS5wW0vhQg7kaGg5AnoOpG+rLBok7rWySSxxkturtJxp6lVhnBU=;
 7:e0mVXpAKFN5FgA1t+AfXEYCpEkVVKt5Aw6UNNHRQqkdqdomG26EtdMV1pBeqoz/PBXgPefTxGLwvgp47O1aMH3/SNDnmZ680u+Z91LTJ8hsri18QN6BrhrTNsF52whsPL1Zxjif0zvdiiQOL8VM8aA==
x-ms-office365-filtering-correlation-id: 818cfe30-c928-4bc5-c361-08d65a92d292
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3690; 
x-ms-traffictypediagnostic: DB3PR0402MB3690:
x-microsoft-antispam-prvs: <DB3PR0402MB36903E37F61E869A142C4BC5F5A80@DB3PR0402MB3690.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231455)(999002)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:DB3PR0402MB3690; BCL:0; PCL:0; RULEID:; SRVR:DB3PR0402MB3690; 
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(396003)(366004)(136003)(39860400002)(199004)(189003)(8676002)(102836004)(316002)(97736004)(81156014)(8936002)(2616005)(11346002)(446003)(6486002)(81166006)(106356001)(476003)(386003)(105586002)(6506007)(4326008)(99286004)(71200400001)(71190400001)(186003)(26005)(5660300001)(110136005)(50226002)(14454004)(2906002)(2501003)(36756003)(2201001)(6512007)(52116002)(6116002)(3846002)(7736002)(66066001)(86362001)(575784001)(68736007)(305945005)(76176011)(256004)(53936002)(25786009)(486006)(478600001)(6436002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3690;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uzUlDbKree0iT/kSkYJ80HLnZuP+I3nlIiKpmjfBBC/J3JVDx6wFQOi3U+F9nOlCthr4IDTKUSTbItLI8HhjSQlCQjEHQRwFa1xs59pAx3+X91C3fVfVx9FG9LvyDGEg/NiFbogwEtaBDiLJVcjKb/fPO3Xe9/q7JSiS5rSPHcE7LBidJrZOQ73jtZfJg9GBMlinviiQhA4i/8iQPW576DquLyWtn93dqkBT231Uk2JCFHk4PwRYJwDTfoIF7w5rdOqBkfIjOLHN2ZjhvoZ2JMzKEERk/hcpru9Uaby+5by0gABXu0jkVwwda2RkpTXBUVGl4Uisb7owknxYcbvOB28d6Z2gBgBQdQeLj5oBTbo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818cfe30-c928-4bc5-c361-08d65a92d292
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 09:19:56.8925 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3690
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_012013_999943_9489EE41 
X-CRM114-Status: GOOD (  11.74  )
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

Add accelerometer sensor mma8451 support on i2c1 bus.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 141550a..fd9127f 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -253,6 +253,15 @@
 		>;
 	};
 
+	accelerometer@1c {
+		compatible = "fsl,mma8451";
+		reg = <0x1c>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c1_mma8451_int>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
+	};
+
 	ov5642: camera@3c {
 		compatible = "ovti,ov5642";
 		pinctrl-names = "default";
@@ -532,6 +541,12 @@
 			>;
 		};
 
+		pinctrl_i2c1_mma8451_int: i2c1mma8451intgrp {
+			fsl,pins = <
+				MX6QDL_PAD_SD1_CMD__GPIO1_IO18		0xb0b1
+			>;
+		};
+
 		pinctrl_i2c2: i2c2grp {
 			fsl,pins = <
 				MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
