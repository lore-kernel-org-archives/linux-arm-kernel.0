Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89F9C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:53:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A91A32082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LlnFVfHq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="QF/JCnTx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91A32082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IvEVfc7NlVABqjbo7CqQwRjxjXS2EnjI3uuQq6XOO2k=; b=LlnFVfHqpf6xcJ
	bphmWBbC+y0OBNAv1R1A4d0rhhAWIwtNCRoxYM7GiaI5TGL+EwHktMg+6pRfltrgNEkPlPAm82JRr
	KG3xnn4LPkUep2FkHnoEPToAwiAfC4FiM9zDM7MgdpYShLgJWC4vDvR8+AhDosLCprOQsBpV3RCs2
	xIKMh3Q1Hz3HnjRM68CtKKlb+5h/NI2sG2SKhQB/eiIsEthha86/QkA3OjZcqDyYeW5K9hkBXLCRc
	F3kKwwHtLIwy8MDICWpoNNuk8tnshZx+4zQnAendmzP0rNkbG6BQrvgWd8YeABL82Vdep6RRnv0/+
	oDQCmLZC+ZxQ0Iqgk8aA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU7O9-0006vY-LM; Tue, 04 Dec 2018 09:53:09 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU7Nt-0006Qu-6S
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:52:56 +0000
X-IronPort-AV: E=Sophos;i="5.56,313,1539673200"; d="scan'208";a="23959753"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 04 Dec 2018 02:52:40 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 4 Dec 2018 02:52:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctqfoZCIhb89ULt1gVkwvsLapgJwdtOft8/Wu4yi4hc=;
 b=QF/JCnTxm26kA9AZiEg9Xy1W21HF9io/jLh+rguJOhZC98l0CKQbhEkFQQV9KjGSxtOnvV7a0TazeOPFYzsUYzNFKPDx4+RKDkcnIDulIP/PnQ+3Ff83lwp+JDFj1kgqOx5SfdJrc9O1s16R/+e5KfOFew+X6XZSvyXZZT60mOU=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2083.namprd11.prod.outlook.com (10.174.112.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 09:52:36 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1%5]) with mapi id 15.20.1404.016; Tue, 4 Dec 2018
 09:52:36 +0000
From: <Andrei.Stefanescu@microchip.com>
To: <lgirdwood@gmail.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <gregkh@linuxfoundation.org>, <Nicolas.Ferre@microchip.com>,
 <Cristian.Birsan@microchip.com>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 2/3] MAINTAINERS: add maintainer for MCP16502 PMIC driver
Thread-Topic: [PATCH v3 2/3] MAINTAINERS: add maintainer for MCP16502 PMIC
 driver
Thread-Index: AQHUi7cVMzqpOg6K20iNC50saN5j1g==
Date: Tue, 4 Dec 2018 09:52:35 +0000
Message-ID: <1543917126-32572-3-git-send-email-andrei.stefanescu@microchip.com>
References: <1543917126-32572-1-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1543917126-32572-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0214.eurprd07.prod.outlook.com
 (2603:10a6:802:58::17) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR1101MB2083;
 6:T5vTClqxqee9jy02xF2U3+6NBGy80Rs08Rhs6XhZJvzpi5K2tm7M61yglrPhbwakT8JgXWqFZi8jfkNF5OM/YSONbGc7Q6TPohcezjKDKoFtDsBEH7KksLcgRZ6ISOPZ/LYG0Ddd3yyxut/DtTav6wgIGDhxccO30AI+c98kFo6laLlOwcmbLg4UHx78OwumeHfTY2cNZpYwOs8NNPwihgSxR8ciYltQBNCTcNejxut8nC3cdYNA7cyH8t8i3yB8XHBF+DkIvjHkBI1LURvq8zXoVG9yYm462pX3J6R4HM0m67jyOhQXoPbHpp+0a1/Zj33XqESad7sBj+jAyMpH4YwlvCtYwKjWgstfxZ2oEZoCJTFh64Ft8oEwgzTHbZnuGg+GW6HFLdqHsmfxLUZlM2diHsZ9TP6hf+VMKzCfeyR5JQDGKVEYdZPc2Ej8GaT8q3CXssxOa3VIDf1HsrOYwA==;
 5:P/9xEASqv2cKWQFLQYdVpgeYmSWeaOmA1oifSiUt0N3O0JRbu7D6OE8+OLZEsOpDlplQ0s6XaBBqfK7mdllFuriMaBRPEPxp1bwEBggDGaSHdxJCelkZzFcHTq6b78lGd0ZOo7/70gPa1YWMo095XUqcqNxPKFtw7m9wZrSxnws=;
 7:/jHQCNPXgPTxPkxEUXGRt4123MWKlmiy56flZSPAqEUw1yuT6qaP+tP3W++L3cFqBhiC3OaPZ4/VZFs2Jel9rwTsFm5FOKSAGStXsB3/2f4o78R+uvUhNXutnjzQCxeyE03YE37wNGsy/ConNrDjxA==
x-ms-office365-filtering-correlation-id: d36e2650-7920-48f0-a3a5-08d659ce35e5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR1101MB2083; 
x-ms-traffictypediagnostic: BN6PR1101MB2083:
x-microsoft-antispam-prvs: <BN6PR1101MB2083D760A3125BAEFE74B3ACEDAF0@BN6PR1101MB2083.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201703061421075)(201703161042150)(20161123560045)(20161123564045)(20161123558120)(6042181)(201708071742011)(7699051)(76991095);
 SRVR:BN6PR1101MB2083; BCL:0; PCL:0; RULEID:; SRVR:BN6PR1101MB2083; 
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(199004)(189003)(386003)(54906003)(186003)(2501003)(72206003)(498600001)(14454004)(446003)(110136005)(2616005)(107886003)(11346002)(26005)(102836004)(105586002)(106356001)(6506007)(4326008)(97736004)(39060400002)(36756003)(53936002)(68736007)(81166006)(7736002)(81156014)(6436002)(256004)(8936002)(8676002)(305945005)(6512007)(6636002)(66066001)(86362001)(25786009)(2906002)(476003)(76176011)(486006)(6116002)(99286004)(6486002)(71200400001)(52116002)(5660300001)(71190400001)(3846002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1101MB2083;
 H:BN6PR1101MB2243.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: b6Q+T25jI0NZLfMu7cIAqXqRMXFjpH1IxLl9FDn8DKseIHQzxLJfWzRPQY7tKU2im8yMsawSO/pVaMwCG+mX9QYx6BGkLrfR93NiFazsUfQU0pvSlgR2iuzS+dATjzoB59v77ZKzyZQW4TmYlGiqa+IFNeq21cZfDN537p7r+08cedBImu/napVUQNH5PcftN0yA8rR5c6vxp1XcihhD8iad8Eedu89FHaOpNc2Qg+kY6KxhMcaIGFYzyp5x4BVR5Ty2KTdI8DsqEtg/J1aKIG9USIzeZHp2uuO2CB0FxVUAH9KbLYGlDoiA+4UmsogTR5VE9zl2hbuSV5YivJXvkWMkn8cg+Gl5CM/xXPDTCYM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d36e2650-7920-48f0-a3a5-08d659ce35e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 09:52:35.3467 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2083
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_015254_378995_405CDA9E 
X-CRM114-Status: GOOD (  10.20  )
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
Cc: devicetree@vger.kernel.org, Andrei.Stefanescu@microchip.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds a maintainer for the MCP16502 PMIC
driver.

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b755a89..6a74a65 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9730,6 +9730,13 @@ M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 S:	Maintained
 F:	drivers/mmc/host/atmel-mci.c
 
+MICROCHIP MCP16502 PMIC DRIVER
+M:	Andrei Stefanescu <andrei.stefanescu@microchip.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
+F:	drivers/regulator/mcp16502.c
+
 MICROCHIP MCP3911 ADC DRIVER
 M:	Marcus Folkesson <marcus.folkesson@gmail.com>
 M:	Kent Gustavsson <kent@minoris.se>
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
