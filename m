Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2861AC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:32:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A022084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z702Mc/U";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="rZlxjvn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A022084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IvEVfc7NlVABqjbo7CqQwRjxjXS2EnjI3uuQq6XOO2k=; b=Z702Mc/UEwiXsg
	8DQZSTSZM8csormm33yFJvkiVsqrXw26jbO146Y11sCGdUq23PUPWCYSgmsgexoZszcLZO6XrbnEx
	dcnGYJcj7pMJDJqOnYx3Xl5GcHAHKPjzPgUOh9o6cE7WP0Uzbqg7HnqbkzXWu3koLDlONEdOLFZG/
	x2i1wvCaPsmm+HXVmJDMVcuNbOR0C3tD34rfIsaSij1vN0Ghr28BMwEESp8fEzYBUnYGFyGlHAGUf
	hU+platYxFBYt+UeDboPrxw7+b72dHwdhtMeROOtFORFsz5IkdELmovkP0D5U88Nfn3jVnCS13oyX
	26gYETLb29hw8qHLowbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX9IZ-0000Iq-6R; Wed, 12 Dec 2018 18:31:55 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX9IF-0008KN-Cm
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 18:31:38 +0000
X-IronPort-AV: E=Sophos;i="5.56,345,1539673200"; d="scan'208";a="24287645"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 12 Dec 2018 11:31:33 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 12 Dec 2018 11:31:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctqfoZCIhb89ULt1gVkwvsLapgJwdtOft8/Wu4yi4hc=;
 b=rZlxjvn+Trfj/QlCdBFeTZpmXAJ+8XMLItu8wl0cPe2bXgW0UcY4RmYKh3fjELRvAGaX0cqfRiU8a+sOU4EiQ2RlU7dzq0RCpp0Koit9QB68fTijqvgXpS4jdijkgvQssBOXOMil4hKa6mzxtpw/mhy2Td6ziYW7F04zg8gVLF8=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2241.namprd11.prod.outlook.com (10.174.113.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Wed, 12 Dec 2018 18:31:11 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838%3]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 18:31:11 +0000
From: <Andrei.Stefanescu@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
 <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>
Subject: [PATCH v5 2/3] MAINTAINERS: add maintainer for MCP16502 PMIC driver
Thread-Topic: [PATCH v5 2/3] MAINTAINERS: add maintainer for MCP16502 PMIC
 driver
Thread-Index: AQHUkkjbuhvMHhEt60qF4bGxywRF+g==
Date: Wed, 12 Dec 2018 18:31:11 +0000
Message-ID: <1544639447-17392-3-git-send-email-andrei.stefanescu@microchip.com>
References: <1544639447-17392-1-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1544639447-17392-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0012.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::24)
 To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [213.233.110.155]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR1101MB2241;
 6:OO6/u+l14o7RlqTffn8kRpcvX++bbu3J+UZ+x1GDZmBX33Kdz15N7AWymktNTPRVhtRogNDsDa2Rm5OWgbEhffc1kZh3YdgAAdaBxiiZ4xbxy4bOUUqTh23F0NnZ5f2DMJGdx1pRIpwN3oH09OTto/DmuOhYV7TilbImugG05rcUMkS2N9cvk24cI5yZx7FZgt+M+zNecwZsTyIsnw763XqUEtRoufeQStBNdEYCwP07KVenL06X3YVeMfocGMWdVH8Q2OkURjXLCJi9iBvK/LHko3BcyuudBvogxjeuQeIsBhLGZiv5S1YVHNdKIW2mMaPOHsHfe9DS7z+GjpuJiy/a5Ubb7+X9rvrfEl1uiXCAu/BeAErIlwR9G5tWpBpaWPN3euKINauEat9yS2IcXcdVZKwTC1W6noNuRLfCJYDI8IC2vAZ5e1G8549i+4CqC7gMeoLrxGcBePieQm+I1Q==;
 5:2bOIXYCxNXUmVv80D+gVx+p1I9wjJ+Av5Ae+JgquqeUK6dkJcjLBHFIR8UQ/i/EQDgPPt7sHKl0upF10I7SN0TwO1xG31qUHemPumnUPzf3khWqzALEBXw5/V07QdTP2mCQp4rWgTTaEEjCgFdKVPULF6pGYPrOa7HMsIxSY908=;
 7:l4DdDaLJWJe5Sk1RqNPL4d0KsrbLY6YTqxhU7UjJbkKyz5/mgYxgclu8hW/OXR/uACZ3KZWxUSFEu07nFQmLAwR2pc6EzSpA355Tn9EJoNfhjTcDTj/2El9Jx0OXFSl5N+LEdNZHi1DWUltgZxjnqw==
x-ms-office365-filtering-correlation-id: 1f314f7c-966d-41cf-f829-08d6605ffd6f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR1101MB2241; 
x-ms-traffictypediagnostic: BN6PR1101MB2241:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-microsoft-antispam-prvs: <BN6PR1101MB2241330E5F2AF7D0753ED907EDA70@BN6PR1101MB2241.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3231472)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:BN6PR1101MB2241; BCL:0; PCL:0; RULEID:; SRVR:BN6PR1101MB2241; 
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(39860400002)(366004)(396003)(136003)(199004)(189003)(66066001)(486006)(105586002)(25786009)(71200400001)(4326008)(446003)(106356001)(2906002)(476003)(71190400001)(305945005)(6512007)(2616005)(478600001)(53936002)(11346002)(26005)(76176011)(86362001)(386003)(6506007)(107886003)(72206003)(2201001)(186003)(52116002)(99286004)(110136005)(8936002)(316002)(6486002)(81166006)(256004)(39060400002)(54906003)(2501003)(102836004)(5660300001)(6436002)(6116002)(14454004)(68736007)(7736002)(81156014)(8676002)(3846002)(97736004)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1101MB2241;
 H:BN6PR1101MB2243.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XJqTHjEjUKS5h66Sq7lFWBbgg+lYTkLbzldPFqmyW9W5KbzCo3rZt75VR8b+AsG9fKHVFC74LaPXqjfId3so5o3R/9oHmwiDCXqF0W93IJoA7/VKmd/PfBtb9FeRzPnVmbBTT/c2I9EwXsBUqCjraBNSIfiJtX3SR6M5lc8ZrszD9uVGeaSxtnxycew3uYZriNXeb4fqNiRhxz3jSa1qAvKfrIPM4vv0zu/1cLhp0aMrXGQQbrUrxM037UAqMTHlyKBmGdxdSO2e5X9w8as+JbQ6OeibAgBIFwlIkUWy3/JIBk1YxVN0dVDW9cUnTtEi
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f314f7c-966d-41cf-f829-08d6605ffd6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 18:31:11.4636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2241
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_103136_091430_415D1880 
X-CRM114-Status: UNSURE (   9.60  )
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
 linux-kernel@vger.kernel.org, andr3i.stefanescu@gmail.com,
 Cristian.Birsan@microchip.com, Claudiu.Beznea@microchip.com,
 linux-arm-kernel@lists.infradead.org
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
