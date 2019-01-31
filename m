Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13806C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:16:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D52792086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KGOr3P6G";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DuQdJVqR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HVWA+2+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52792086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ofRRCo3HEn9cfy4qLxgpefNdDkUtPj6ElaxtZnda+A4=; b=KGOr3P6GgQfAXT
	pR+15xk86V2xCq7h1AXmFbb3lJSeTEv1xo2QxZ6L98pBhd2VLDi0SO91U/kViwU/uHYGyeJMH2mcc
	vqma8LN4SGrkdc9PNWXvhThpyGx32t/iLUFWvXiyTFfBge1Ljga6wUc5UNTpeYW6y7rOp3vM4By/U
	CmMy2uRVl0vyK9Ah/oRMHcIYjCv9q0XS4VmVSxnPwqfasnaEMg+9XxCKVMCiqPSvbMQ/vtJvNS2KD
	jjqiI/OFBwFFVlQ+en/2mmxTk2q8mN/Ap1zK0ia8HEw3iChr9+VGdaaPyhqivU17RiCUnohkhruQV
	XJfwqpcFW1VeQShoPkOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpE57-0001f5-Vd; Thu, 31 Jan 2019 15:16:46 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpE4l-0001D5-8r
 for linux-arm-kernel@bombadil.infradead.org; Thu, 31 Jan 2019 15:16:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MuQOZWGsRr7rS+oYAqGc+QrgYSxz3R3vO2uWvbsVWUM=; b=DuQdJVqROpmRPngW/VKhfXdpWd
 /v20aPBpEVW7JTYj6ZrdLJKYsdg8Ek4Dy9sQVwa8WmAdHM2iyRzkclPdprLbTZySLc3tV+sP24G29
 yW4NIsErfifmjCLZx1qBUWmM6tn2NvUPQ8k+Epyy0QV28QHiCWD+laUmp9+JL+F9Jo+XJ2dT+kz+D
 GXOg+gEJMOE5gNIGEFc+bKNivGQHIl2G/1usQh0q7ODvVQadZwSn2cBSEh21MqxyiSmMwEVaJM1e5
 lmXal2frfXBJq0WH5Sn5kfeXL3XqV+7hpQzEtNVHzSQtGR/eRpl5qZoXdvkj9LXU6VHTiVyGh1xIm
 f/L+JYsw==;
Received: from mail-am5eur02on060a.outbound.protection.outlook.com
 ([2a01:111:f400:fe07::60a]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpDqG-0008Pl-Vk
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 15:01:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuQOZWGsRr7rS+oYAqGc+QrgYSxz3R3vO2uWvbsVWUM=;
 b=HVWA+2+xuJhsO8EvylaIsBeCmpa3JMKsm1x0nYm0wZMhnGfRZ3SlPOkg+fqCx+GZEHt4hULHbrXHEF2G71ZhqyDqH30L6DMZnGmI05IKzvXl6zGh85nPdY6LshCrbDPbyy1gu+0J5dKw0QYRhQi4cgALSagcJWPAc9qe+0FAUEU=
Received: from VI1PR04MB5008.eurprd04.prod.outlook.com (20.177.49.225) by
 VI1PR04MB6270.eurprd04.prod.outlook.com (20.179.26.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Thu, 31 Jan 2019 15:01:22 +0000
Received: from VI1PR04MB5008.eurprd04.prod.outlook.com
 ([fe80::2d2c:455a:16e9:cd4f]) by VI1PR04MB5008.eurprd04.prod.outlook.com
 ([fe80::2d2c:455a:16e9:cd4f%2]) with mapi id 15.20.1558.025; Thu, 31 Jan 2019
 15:01:22 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio
 Estevam <fabio.estevam@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, Baruch
 Siach <baruch@tkos.co.il>
Subject: [PATCH] arm64: dts: imx8mq: Add RTC support
Thread-Topic: [PATCH] arm64: dts: imx8mq: Add RTC support
Thread-Index: AQHUuXXUGM4Vx5l/AUqyV5hWGw71pA==
Date: Thu, 31 Jan 2019 15:01:22 +0000
Message-ID: <1548946870-29037-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR10CA0049.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:80::26) To VI1PR04MB5008.eurprd04.prod.outlook.com
 (2603:10a6:803:57::33)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB6270;
 6:MfrPFZQk4idghzeJIk+XoHJTGWJHJ/ys0l5xN9xJJ7ofqKTpbop0EEbPVg4PqK2Am5CALHfs4ge8CU5filt0P4E/Fg5SDDnYrqaUFI7gElcc87nRhR0rVO3JCdjUNJvB4LSnULZe92V3vSVpk+eYGPBMsCe2NQ4scFdWsATQCk6opS489c89PNOvsz2vnJgbDzJBQhJ9eArRC0J0BoBPglpQC3G5hu8ugphHATSMY7RfyTNqWaVu2WKAjoxifjyuS1rsT0cPyfBp6lYyKmbvdyBWxxNfQFlf2ocPEnKJ8LUt24CMzYDI2jyZTdTxsCEmtHckqXteTuaqLv//wlKrGcn/87/MwGPn9VPeIU5RBNvTPn/BVdBvprW3NkW7n1yb8Glh8IZ7jyECD+eN2cnP7eJm1AsZdjpXjgOMRUNuLIa35IYy2WjxOR6XU8KXL0PKsN/D9HxrtHTNg6wZ2JR5Yw==;
 5:KQeMKQ/IeZnLbayhIQNDPWLxr0Xv3mFULRxEsIsELPN3XbBGFxpCtPW72gYWedfVgDFBx0gpDzHlBL+Bb7Jq5RZs43sGNIt4i96FOGNpLXJunmIID0qT0B9B4uwsK/8vixp1P1L+QAzl43p8FRNILN0ZHxFerBvqZThi38Do69r6D3A/jDUqkxB0H93UUsdyruk+VSV/MzLadPgKmVhR7Q==;
 7:uEQDZZn8m6mqe1DbHtU/nzv0xlxrbzCg2z7M5ernTxbXwwG0XI71yT0fXdyC0XyqPcoUdQPdxpkRxNsqun3GOzhdswOWKQkcF9Da5v4eSMOLaNF1/hxj5OQUib3U+zy9R0C6ZKyUoKUU5nd/kvCm5A==
x-ms-office365-filtering-correlation-id: 5ceeadc9-1af2-49be-61a0-08d6878cf689
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB6270; 
x-ms-traffictypediagnostic: VI1PR04MB6270:
x-microsoft-antispam-prvs: <VI1PR04MB627031B238CA00E9927798CDF6910@VI1PR04MB6270.eurprd04.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(136003)(366004)(396003)(346002)(199004)(189003)(186003)(14454004)(6436002)(386003)(105586002)(476003)(26005)(4744005)(106356001)(44832011)(68736007)(86362001)(71190400001)(102836004)(486006)(71200400001)(6512007)(53936002)(97736004)(256004)(2616005)(110136005)(6116002)(25786009)(7736002)(81156014)(316002)(3846002)(305945005)(6506007)(54906003)(50226002)(6486002)(81166006)(8936002)(66066001)(4326008)(2906002)(478600001)(99286004)(36756003)(7416002)(52116002)(8676002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB6270;
 H:VI1PR04MB5008.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FWiyzVRj/LuOsln3/ywbIgiAC1WNE04br5b2TSGdK1VWQfNesM4w89sBsEgamnhfQ/JVJaZe97pJ2JuEwF9nN8T6bF9Ei5ZpesMdBxUQwr8lfl9w2eGe0NJXswpwHh8jpyX9DTT5YxA2tpJFBEob4PLsMhpRXq4eFImC+yG0I0cN8t15HfQzO0c73Iw2smeEowLWfm2s937iTFVxJczspkptG+etbjLC2hA+uqF55bWgTegiqN9BFtMrmAl4Ar2EBT7cotCCknafSkKqO4jxd059wbsleB7ipGZ+7VoLPt3o+pvz/MPjhwEKWo0LRxpOM+lViL3mO+gRG0lzcJ7pb18j3Regix/E+HbJ9y1fnws4c2nUm1MxMWfcUSgjCL5Zbl1p6BjfHgog8bNwsubb4M3mnJTWSCzUK3lbFp50WGE=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ceeadc9-1af2-49be-61a0-08d6878cf689
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 15:01:21.1029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6270
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_150125_135127_E9CEF672 
X-CRM114-Status: GOOD (  12.58  )
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
 Abel Vesa <abel.vesa@nxp.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Abel Vesa <abelvesa@linux.com>, dl-linux-imx <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add RTC support for i.MX8MQ.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 892063a..49b14af 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -240,6 +240,20 @@
 				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
+			snvs: snvs@30370000 {
+				compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
+				reg = <0x30370000 0x10000>;
+
+				snvs_rtc: snvs-rtc-lp{
+					compatible = "fsl,sec-v4.0-mon-rtc-lp";
+					regmap =<&snvs>;
+					offset = <0x34>;
+					interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+						<GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+			};
+
 			clk: clock-controller@30380000 {
 				compatible = "fsl,imx8mq-ccm";
 				reg = <0x30380000 0x10000>;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
