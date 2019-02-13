Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F22C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:03:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27200222BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j+ikRPG6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="X24b8q/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27200222BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F031TNcEzw8mOaUMTks5tcMjdKOnW2JWCnZ72FXBAQ8=; b=j+ikRPG6CLLFeZ
	8XcJ3stQzhPxXd778FpgEQqT7SLROFZOSDddm91wLwB+8vX43LxDcMS0FVLV+RhxvJXCmPe8bNJIU
	Gp7KiXxqDP4Ii4GljC1rJ40LEkYszjr51B9aBCnW3CM7M21l2mENSRc48PGtlVKSTaNQK1S2PDwBU
	YGNHiJnA0Nkjfta/r4kGpgvleiKPY/xeIScnCqQNR+avqcvAgUkUEqi2y8Cstu1gc/tVkvhqgDO0A
	OsUIKQQOf+rLAdjbETe7R7QnvwzcoM8Crdk6N3g9AZKdtEwBg6YM7w/Pv5t0ZS10Sbkj+j4QtUoyl
	C33I9K1LcCIuET8V286w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtqRk-0002j9-Ui; Wed, 13 Feb 2019 09:03:12 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtqOy-0005Yt-4Q; Wed, 13 Feb 2019 09:01:00 +0000
X-IronPort-AV: E=Sophos;i="5.58,365,1544511600"; d="scan'208";a="23778162"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA;
 13 Feb 2019 02:00:19 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 13 Feb 2019 02:00:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfvSRjdfPYR59gKW1BzgBjSZaKSXcSVAPmXOnSBdk9w=;
 b=X24b8q/zr1PaYNV3zkTKqdl1kThdQDePHz2Hw6eZKovPv28IoB4s+BTsNNi5U0F6b4ebxuuSdetMT5kEoWTq0Ih9/cWfNOEFohMOsJOU1xsf/ZS7UURHem+mu3HiN8yHIARxdARG0fmIazjG0f0t0zdIMmCL22VbXFlIOAXdqqI=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB0002.namprd11.prod.outlook.com (10.161.152.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 09:00:14 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 09:00:14 +0000
From: <Tudor.Ambarus@microchip.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <dwmw2@infradead.org>,
 <computersforpeace@gmail.com>, <bbrezillon@kernel.org>,
 <marek.vasut@gmail.com>, <richard@nod.at>, <miquel.raynal@bootlin.com>,
 <lee.jones@linaro.org>
Subject: [PATCH 10/11] memory: atmel-ebi: switch to SPDX license identifiers
Thread-Topic: [PATCH 10/11] memory: atmel-ebi: switch to SPDX license
 identifiers
Thread-Index: AQHUw3qIVB2XFQX9qEiZejjebqbq6A==
Date: Wed, 13 Feb 2019 09:00:14 +0000
Message-ID: <20190213085930.31578-11-tudor.ambarus@microchip.com>
References: <20190213085930.31578-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190213085930.31578-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0085.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::11) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26b2d0e8-ee04-4d8f-5776-08d69191aac9
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB0002; 
x-ms-traffictypediagnostic: BN6PR11MB0002:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; BN6PR11MB0002;
 23:fL97miKXoojaIc2+QcjoAVmKgbk/0kMbH0tW4+Z?=
 =?iso-8859-1?Q?+zEp9ic+QkvlCLkRD64rxrIwfn0vl3GYnkBz/WR0eQUiWE2NoicpmrlpjH?=
 =?iso-8859-1?Q?NZgBgixO8ztrMtsyVL9tm8einRy9KCIhOwEgbUgQD85pLHjAfSbmZ3iOF8?=
 =?iso-8859-1?Q?kqN+uLemVuEvMCMaftRsEE5V6D/0A5wT0yxZisTMUmFU1YjwsgnrNLYcU7?=
 =?iso-8859-1?Q?iZ1/a2U4A35lDzLM6noqwKYZ8ClVg91QAKupCXSdvp/YYjOF5Ef4Z3m2Kc?=
 =?iso-8859-1?Q?3/qVaIbDPiFfjEPFFDye9DQ479kQP9g+sin83+qzzFhpA9QbgHSLrFfYJX?=
 =?iso-8859-1?Q?URZxNnVItvyJyTbT+Sd+1OakDG/UaBadvZw7tnP/UlzAeoKGA+IWaaacXo?=
 =?iso-8859-1?Q?TUMizMhBGhosdM/Vls+198iJkRUxc8F30ZfjeA+TNvcXcNaRY6B0WS/c36?=
 =?iso-8859-1?Q?V5ql+LIqxAvOVTnWLaFXcPQhxFzSFRJcBxkiLOMv2+D9cWKoLMLo8U8ECL?=
 =?iso-8859-1?Q?pfxkNvc4TAN8dFAay5wGoTy0BcC4jG/XsjZK8ykOYMljwZ6JOHi+z+WEOc?=
 =?iso-8859-1?Q?HPZ5ksqA5S/QdDscdfOTtW9LNuJDUMmSlFqmvGivDOouvhbzStLo0zeMLj?=
 =?iso-8859-1?Q?gQAp67eVbSa+A1xyc5zWEChpfoTtFSx3OAmDFwFQgQkqb2nAhFjCawiajv?=
 =?iso-8859-1?Q?GLwbFq+L35U4N87gQM7vDNBkTn+3PzQUOszbiFZ8rTJotazsLoV+TeDrJy?=
 =?iso-8859-1?Q?f3N7A/AQR6bQC8WpQBixY40MmyuloBRlNqHz5bprEvRSQeyLoNy1o2N4AC?=
 =?iso-8859-1?Q?EgPyTByPwHvm+9+tVkdLHECcJSqd10vW62et9haGQIrwOZ0bjPrcvC2xyV?=
 =?iso-8859-1?Q?+1s6JkIQrhChaOME+t9J1WulpLEUY5tzNAWRo+0lw7Tgko6kjajjiK2vEz?=
 =?iso-8859-1?Q?i7tyqipidDkMPOwaxLO6mPT+HtQFvcsRiaKMVJVGP39gx52KsKj9kSVtj9?=
 =?iso-8859-1?Q?1V0C7/eBY/j1NLvAuckOVF1DXHzvyOzuKanYIE1C19FG9yVlh2j2LzKzpQ?=
 =?iso-8859-1?Q?7yiZk16cruInUwcfke7mAdjGrccGLwzAcUVKT0qLHTaHbd0qIf4aBMl9Z0?=
 =?iso-8859-1?Q?1QW8hjgVRPcRcyHs5zEKRuuECfmHXI3pV+Zar63i259KVl4XGtUQ8VHaOw?=
 =?iso-8859-1?Q?Lfr5M9VH3EZ7alSb0dDrw14dpqkQxQtMaf97xEz3PdlMdjnCAvUSefLZGR?=
 =?iso-8859-1?Q?4UPfTOAx+e57Ig2fEtpwBjGY/7RPMX2+2Gr7hxQ7DUNJ1wp6bSD06soCOM?=
 =?iso-8859-1?Q?BRO3PKy3qFTUnotisQkh7Sln9I3QD3o1kWfjw1x7uyS+zA5JjAyXH2BWND?=
 =?iso-8859-1?Q?fDtH4/XPLJlOnh/rGHGtIAA2WA51Q?=
x-microsoft-antispam-prvs: <BN6PR11MB000293C13354F03086644E8BF0660@BN6PR11MB0002.namprd11.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(136003)(366004)(39860400002)(376002)(396003)(199004)(189003)(2501003)(110136005)(54906003)(2201001)(4744005)(86362001)(3846002)(25786009)(6116002)(105586002)(316002)(106356001)(52116002)(1076003)(97736004)(76176011)(102836004)(99286004)(2906002)(7416002)(36756003)(6506007)(386003)(305945005)(486006)(2616005)(71200400001)(71190400001)(6512007)(81166006)(478600001)(11346002)(446003)(50226002)(7736002)(53936002)(66066001)(26005)(107886003)(186003)(68736007)(256004)(72206003)(14454004)(476003)(6436002)(4326008)(6486002)(8936002)(81156014)(8676002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB0002;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lYxO8Lu4lB/Z77flbM3CZ1Sl9DaBGKqLXxxHsnoYwCzkUZUQM6/bFf37FoAKmw9SbtPrO1avCg+rmRj+cybfyyN/a3ZZzQ7LBSNJE0T83FQegfmCSMEqxHxdv2WNKS7DZfDBZw6U9A7aNJiCKvh+MzJYuBjrl9mskZ05M+BbNjLl5avB2qPuTuGOpDoLVjCDZGo16YIJAXPc3HGHhEPGz20CbOZalHR11UhfjNPTD/8MrJsf3FlFQQWV7qIsYGkyNK2bGT/2P/ss0ieKH2eWoYgBFj9aW9jRRfFFed82Swi93JjWSI+dZ37WcO7A+zA7IrCb+z9oyztsteCVCSizVgs3ItSkNvBulLPG34Ne8XoXmUuiE3uf102rtllvBrytltjprlJs+v8simVApNZ6863B8KLwI4Rv4EH+gRFsGrw=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b2d0e8-ee04-4d8f-5776-08d69191aac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 09:00:11.6310 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0002
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_010020_847683_1532D533 
X-CRM114-Status: UNSURE (   9.36  )
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
Cc: devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Tudor.Ambarus@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Adopt the SPDX license identifiers to ease license compliance
management.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/memory/atmel-ebi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index 8515196c2b03..14386d0b5f57 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * EBI driver for Atmel chips
  * inspired by the fsl weim bus driver
  *
  * Copyright (C) 2013 Jean-Jacques Hiblot <jjhiblot@traphandler.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/clk.h>
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
