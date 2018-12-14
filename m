Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75923C6786C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:07:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46C5021479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BsC3A9om";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=serialtek.onmicrosoft.com header.i=@serialtek.onmicrosoft.com header.b="sIg4KVJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C5021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=serialtek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=VD9AlYjhPtlxY+IrucT4fjmd9MnS2ZfMrPKUYw5Tzis=; b=BsC3A9omL1t6oy
	XbvHepKSV6xMgDaB2b7trJtVP0bKg57Mkn1/2+lOk7qRndkjMjM+KbKua7JDbYRNvYf7e6GRB0K4N
	Q+hHnG8JqXpqM4N0SXNElBjjDkjLK1Tqs8saqMPq8YGm3ShrVi+s+IAzDOfTZTnhSlsCFe+PloPXj
	6Vi/vbVj2wPXL8RL35kW69faGAGLtathaetYrEbq+fmzaks5/Uh/Kx1cGeIyf7g9e4nZKjbPbSwKb
	vTCD0DBE3GMHkpAPp7aDqpXwHBujn/A296zENlGdogk7JCLWQZ4JEEp+twyP964jgc5N4AFRAnPsa
	eTg+2JJ4xX/m1NgszHug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXmFY-0005vX-LQ; Fri, 14 Dec 2018 12:07:24 +0000
Received: from mail-eopbgr710058.outbound.protection.outlook.com
 ([40.107.71.58] helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXmFV-0005te-Hh
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 12:07:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=serialtek.onmicrosoft.com; s=selector1-serialtek-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8vyCXGXWDL8j/nv20+2VG5Kpysg1utbkZAxbVJVdY8=;
 b=sIg4KVJ+nM5BNA+sQar+m1+e51rGV/vdkYFHi3lpl0UR4mvisvU6upzw1BHbGXKYjKwitYnTgo8WoG3WEa4jifmgo6IQuveCXuR8rCDCjeVWBZIGTmud6P2SY7w82WIKwC8NPtmKarYGF/698QvjGVXX3sVfurUegXEJd8+aCCc=
Received: from DM3PR19MB0714.namprd19.prod.outlook.com (10.166.164.18) by
 DM3PR19MB0779.namprd19.prod.outlook.com (10.166.164.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Fri, 14 Dec 2018 12:07:07 +0000
Received: from DM3PR19MB0714.namprd19.prod.outlook.com
 ([fe80::255d:4f0e:90b:d362]) by DM3PR19MB0714.namprd19.prod.outlook.com
 ([fe80::255d:4f0e:90b:d362%2]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 12:07:07 +0000
From: Mark Walton <mark.walton@serialtek.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>
Subject: [PATCH] ARM: dts: aspeed: Add #interrupt-cells property to gpio
 controllers
Thread-Topic: [PATCH] ARM: dts: aspeed: Add #interrupt-cells property to gpio
 controllers
Thread-Index: AQHUk6WI/laRmU2C6kCoesOVbhjo7A==
Date: Fri, 14 Dec 2018 12:07:07 +0000
Message-ID: <20181214120423.3363-1-mark.walton@serialtek.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP123CA0080.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:5b::20) To DM3PR19MB0714.namprd19.prod.outlook.com
 (2603:10b6:0:19::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mark.walton@serialtek.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.95.179.50]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM3PR19MB0779;
 6:1fG1TECJSTPIMMGn4eXsBvA2MT863WiIA7znhATvY3CREvmRl/Io9MhgSSvYfn7JsJ7x+9RUYEmGgSmMXpnv6AiRYxqlY06JLFTG8ejA527uljdDGx5650xhaeIerP4NWsZ/G75POegwR0ukwA+Qkoq8cV9Y6ureJolY/t4JhNaD4HXLZy5PXq7bjz8iyMLgx4blAzbTwCleMFJ/Z101sAOJ4uKEgrahBIpAIuDcxEy09jIS/SlCbMzN50Yp9BVmCs9zU4iwI09Uq2EoMpiDPyVQ4/VVwl1I4GcX02FpJLmMfF8TgOtvwPbv8oVhFKqz0HwygG6GcbjhojHLgpOmAea7yUOllmmU+jlnpciL6BgXiPSTcrmOUmewPuHLGX62cAuw7ozbRS+o6v3Ca/Edmhevf3nkt2FbbkxmAWSJM9XJBZ2k+XNOEzCYjQd/pyqxaod12e4er+AEQdAiS6tjhQ==;
 5:8yIWnYdzCYuJRSNKFSMtWGZZRLT0BjHMqvrAtLAiUOvxuueGBq5BL74INW1hgz18vjrRHwFddo1HSnNxj9LAWWZMH6rIDOYt1Is3WhpbUXGVr1YGHuGaZ6OXU8Tg1hRUMrn6KQnkRTyveZZd6ayVp1xXn0bLC8svJD9PxWpXMV4=;
 7:OBO/295FEQpyl2JAhzbFa91YiWgygac7ATl34eUH7neTVzhQFZr2PL4I4570ZC68gs6Ny+B+QEUxqhA5dcIUWGhPkTguRL3J6B/9BzQxBLnMfUIWfvtDJbry70L3axyjpVEaVLKIcoQydY4w//1hOg==
x-ms-office365-filtering-correlation-id: 59e73399-0f78-468d-1e62-08d661bcab33
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:DM3PR19MB0779; 
x-ms-traffictypediagnostic: DM3PR19MB0779:
x-microsoft-antispam-prvs: <DM3PR19MB077980D71889A4954BA9D905FBA10@DM3PR19MB0779.namprd19.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(2016111802025)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);
 SRVR:DM3PR19MB0779; BCL:0; PCL:0; RULEID:; SRVR:DM3PR19MB0779; 
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(376002)(366004)(39830400003)(346002)(189003)(199004)(1076002)(8676002)(6512007)(97736004)(52116002)(102836004)(110136005)(99286004)(53936002)(4326008)(81156014)(6506007)(3846002)(478600001)(386003)(316002)(2616005)(6116002)(14454004)(476003)(71200400001)(107886003)(81166006)(486006)(25786009)(44832011)(71190400001)(8936002)(105586002)(6486002)(2906002)(186003)(68736007)(305945005)(2501003)(36756003)(106356001)(2201001)(86362001)(66066001)(256004)(7736002)(26005)(575784001)(5660300001)(6436002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM3PR19MB0779;
 H:DM3PR19MB0714.namprd19.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: serialtek.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tWDAC9N4WcqD43WmEpGB/uJ8tzvNA5uiIqS8KfbDTKTtKUb/ZavN3pvbceKAqwwJVitiRVb0R4qllyixFBAZMbJzMSSoOmioRPHoDXO2wjyycra0PC/hIaaJ3+Ljbt8cp7wb9Op9OvznbuB8qHpZj9MAEHxvRDlQ0P7RWiq5Lmmzl9JGV9rZfWedBz3Qjv9pv084+JHIiNe6CxI6+rNhzzygxW2i4v7cbv0XGjW65i9gZORuK73Byni5u698pVdlIrW5h/SPqnetCvHJ2CTuGpO+GhKqJumeTamoEk1g4OKyMrnJbsCsYhQfnuNM4Aim
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: serialtek.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e73399-0f78-468d-1e62-08d661bcab33
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 12:07:07.5847 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fc4624e3-7cc7-424a-9340-858bc44a78b5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR19MB0779
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_040721_631634_86EBA15C 
X-CRM114-Status: GOOD (  11.08  )
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
Cc: Mark Walton <mark.walton@serialtek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Allows the GPIO controller to be used as an interrupt parent.

of_irq_find_parent() skips interrupt controller nodes that do
not have the #interrupt-cells property.

Signed-off-by: Mark Walton <mark.walton@serialtek.com>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 1 +
 arch/arm/boot/dts/aspeed-g5.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 69f6b9d2e7e7..9549f867aa1e 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -197,6 +197,7 @@
 				gpio-ranges = <&pinctrl 0 0 220>;
 				clocks = <&syscon ASPEED_CLK_APB>;
 				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			timer: timer@1e782000 {
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index d107459fc0f8..a1999f3fe330 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -250,6 +250,7 @@
 				gpio-ranges = <&pinctrl 0 0 220>;
 				clocks = <&syscon ASPEED_CLK_APB>;
 				interrupt-controller;
+				#interrupt-cells = <2>;
 			};
 
 			timer: timer@1e782000 {
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
