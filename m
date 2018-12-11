Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E4CC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:10:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F05C2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="COuRGgNL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="O9Gbw9Ns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F05C2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IvEVfc7NlVABqjbo7CqQwRjxjXS2EnjI3uuQq6XOO2k=; b=COuRGgNLk0OOw/
	Ok3JeIS4F+TtBfcWxftMJdTh9PD6ohV9WRbz6tufyod8nNrzQUtsm6k9P89FRLmxWHKWW2yI7qggQ
	uPwfO0RHfEVFTw1cvwf3Xa3IXK9Ma8YWRsV5FDLOK+UcRpExQ16Ec+vRPWpZhGkQA4wXDZNKpHet7
	MVQF/c/hphOY/p3V3K1GYrF/04/Fbx1y+RHUWQMiUzKAaB8ByDmy0n2G55WIzUt+D8XvMr01NGfBn
	hsDj5CgEejl3rDWA/KzwwBCOOtrnJo33QnomOPJPj8BPPlnodJfNHzJoGB5UROfEon6MzNqJW1KYP
	TxbKWPqjWtPKtNvqjkuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWezR-0005Xq-Lh; Tue, 11 Dec 2018 10:10:09 +0000
Received: from esa1.microchip.iphmx.com ([68.232.147.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWeyj-0004Tl-Ce
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 10:09:28 +0000
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; d="scan'208";a="25097113"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 11 Dec 2018 03:09:12 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 11 Dec 2018 03:09:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctqfoZCIhb89ULt1gVkwvsLapgJwdtOft8/Wu4yi4hc=;
 b=O9Gbw9NseX4FwAx41FPF1vDCZ0RIyGutVHlhfwYBubOw3p255zFoA2VtIMJzwYhUbigO1R8/gt79CBQpaI6YpuH/eWqDUTRQCLEID/1ejGNxd+8ptONz/T8MUyC8Q55IAbvt8gO8sC9KKwuW0vUeUBzjPJVWhObsTEodRgcEm4k=
Received: from DM5PR1101MB2249.namprd11.prod.outlook.com (10.174.105.17) by
 DM5PR1101MB2123.namprd11.prod.outlook.com (10.174.104.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Tue, 11 Dec 2018 10:09:11 +0000
Received: from DM5PR1101MB2249.namprd11.prod.outlook.com
 ([fe80::3439:ab82:a10e:6bb]) by DM5PR1101MB2249.namprd11.prod.outlook.com
 ([fe80::3439:ab82:a10e:6bb%2]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 10:09:11 +0000
From: <Andrei.Stefanescu@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
 <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>
Subject: [RESEND PATCH v3 2/3] MAINTAINERS: add maintainer for MCP16502 PMIC
 driver
Thread-Topic: [RESEND PATCH v3 2/3] MAINTAINERS: add maintainer for MCP16502
 PMIC driver
Thread-Index: AQHUkTmPpOCYWu9VZkOCBK/g0N76cg==
Date: Tue, 11 Dec 2018 10:09:11 +0000
Message-ID: <1544522876-15967-3-git-send-email-andrei.stefanescu@microchip.com>
References: <1544522876-15967-1-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1544522876-15967-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0205.eurprd08.prod.outlook.com
 (2603:10a6:802:15::14) To DM5PR1101MB2249.namprd11.prod.outlook.com
 (2603:10b6:4:52::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR1101MB2123;
 6:fZNcCt05rznqV0h0xw3ePkVFlU2WgdzwVpI4RzFTIpXexG0y2onlSAX9WvCopH4BkgaQLFxSijS88DijNwHWKa5OdAMvOUw2tiIkzNjbBZSVCg7KaXxEKvEfa3q5R5p5sKgHh56SnaLKvbEiztPFPz1ZlFuXi3OKmbpvbXOK7sGaJqr6wHuzHFEkp2CL5VyVkRvERTgv3MFNo5kUOagO7J54yS05TSfkAutzacWnY9B5klRjM8nJ/dtEi/SZoLy61IwAAAtO2vKRU+GsQ5/nDcWB+ayETLMKLtoxucJFsk59gwDmbLVm4vfJesRmcagcVAj7fcw3XHfOB9SqGGC+g9jGqjYarbu6jsRETf9tyvDjjamgtNiwuIa8SGFqNDTlHtoxzpGlX1o3HMm4GP2YomI+DhG2oAWyyTfwr1iR5QHk6hEWOH1WmZxnfEwU2WXlYoShzbjzTfVKZC0Qs/hEfA==;
 5:EBnuUIjuZdL1L0b4A7jVnUi4q5O2Swa/KXLfG53HxR5L4Ykoeh4/ROkc3kkg4EqiOT7XKIAOv3HH41XBIvETqso6PW5msyuXo2gH9DY1LJn+gZ0bW7s6oacIu+tT5QiNSNTuDum32mamVNOCbsMw8XxAltYuM5MsO29Qx/Qd/yo=;
 7:vdy/5pRTnt+PE5ppM/PEfTLSYun1pAGsvfWdsGj3IL4PQccmrsftjSvK+2imK7wSoW4euW1m9Ga+htckK/9tyZCUdjK2A7nIjo2ZIy2+jzbvdYmblCnyXRv6n+5HoitK77OvMqRn7AHAsPZsgtQjvg==
x-ms-office365-filtering-correlation-id: a463a7ef-eaea-4b01-9d89-08d65f50b235
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:DM5PR1101MB2123; 
x-ms-traffictypediagnostic: DM5PR1101MB2123:
x-microsoft-antispam-prvs: <DM5PR1101MB2123398E2BEC1C98AB3D8BF3EDA60@DM5PR1101MB2123.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231455)(999002)(944501520)(52105112)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:DM5PR1101MB2123; BCL:0; PCL:0; RULEID:; SRVR:DM5PR1101MB2123; 
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(376002)(346002)(136003)(39860400002)(189003)(199004)(256004)(217873002)(486006)(97736004)(446003)(2906002)(81166006)(2501003)(8676002)(81156014)(11346002)(8936002)(71200400001)(71190400001)(86362001)(68736007)(72206003)(25786009)(36756003)(6512007)(2201001)(7736002)(53936002)(478600001)(6486002)(14454004)(316002)(54906003)(3846002)(76176011)(110136005)(66066001)(107886003)(106356001)(105586002)(305945005)(39060400002)(99286004)(2616005)(476003)(102836004)(5660300001)(386003)(6116002)(6436002)(186003)(6506007)(4326008)(52116002)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1101MB2123;
 H:DM5PR1101MB2249.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fEw+CeE7j7JjBcElNKZzYTr1eL2JBwixonRYtfj1iJg4kRc0u8p/QJB3+j0uPVcCpmC63N1GNKDD8yWvzy0OXkuSr6B36QKglTtrfeohCUMGF125hPwrAhZgsKsLRsSqAXMkap8dh8vv2JKEVb7Am7silptGD2FTmK+pSQ995oPae2Q6JEtI8C/Nv5c0XT4/VyIgHdv3PJi/zgfmzDV3zN0rAINAykDbiYtg5LnZHS/3kgHfOiuYgyl0gLOFeRwZ71dZ8F8D4zYlhSh73M3P7UZOvq8BXTchZL2eIuR//hxzRB2/f0wU+hIVY87zRV1K
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a463a7ef-eaea-4b01-9d89-08d65f50b235
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 10:09:11.5067 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2123
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_020925_667275_2CC25EC3 
X-CRM114-Status: UNSURE (   9.79  )
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
Cc: devicetree@vger.kernel.org, Andrei.Stefanescu@microchip.com,
 linux-kernel@vger.kernel.org, Cristian.Birsan@microchip.com,
 Claudiu.Beznea@microchip.com, linux-arm-kernel@lists.infradead.org
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
