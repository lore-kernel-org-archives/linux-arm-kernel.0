Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0DDC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:10:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 746C5222AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rp0E0uCy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YuAWwlKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746C5222AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=gZOZvrCp7pjC3IMkyf/v9Zum8DLhO2wa5J8to2fcMWo=; b=Rp0E0uCy0NHKtx
	xy4oV5Hc9SbJuJ2ZxYQIyMAGEpLzCw6wPYfJ07vMubSWLBxXmS4FkcP7kK0Buup4RtK5l9SyXjTLN
	3JfjLd5sUNWV+zDN78Gvm9xDsBXaqwR2/Ejigm+OnrW205fO5+HSBHTnznV92UdWxoIwYrBbrzk32
	L+Y0kdltrsQk1S0eH063bxd2gQLIn8e9jBb6sIszl088Q+9TRhlcRkMdbUTWBA1hxMpyL6BGNn9tL
	nwb0GeXAOEb5QI0ksnxHEvyesf6R2x4pCseiFLcIe2rCQHJoh5Y7yqjbsW8/rfOtLzNt8ARbmmIfv
	g93P9OOklNqQHR4TidAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gttMm-0006fy-Fi; Wed, 13 Feb 2019 12:10:16 +0000
Received: from mail-db3eur04on0608.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::608]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gttMj-0006fa-Kd
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 12:10:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X35KyRIsdWTohRaAcowIKh2JuCki4edw14W6k3lqQlw=;
 b=YuAWwlKQft3QBoJqfE0SaqtfT3q5AqP2E69uEmBcsKpbjxSZ19uFPtl27ZXlIi40uiFcFmqMrP97rZoVf7B9czIyHrgbEvezlNTyK8ANHzM8RGyqkKj0GdJeMGblOJ02yHF5M6ADN64ZxvnjIKD4FewxsYLyIb/On+mWVtyldEg=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.16) by
 DB7PR04MB4299.eurprd04.prod.outlook.com (52.135.131.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Wed, 13 Feb 2019 12:10:09 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::fd45:a391:7591:1aa5]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::fd45:a391:7591:1aa5%6]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 12:10:09 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "cpandya@codeaurora.org" <cpandya@codeaurora.org>, "yaojun8558363@gmail.com"
 <yaojun8558363@gmail.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>
Subject: [PATCH V2] arm64: mmu: drop paging_init comments
Thread-Topic: [PATCH V2] arm64: mmu: drop paging_init comments
Thread-Index: AQHUw5UQsSv+eAw+FkeXNqBn4eK4xw==
Date: Wed, 13 Feb 2019 12:10:09 +0000
Message-ID: <20190213122119.8454-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::18) To DB7PR04MB4490.eurprd04.prod.outlook.com
 (2603:10a6:5:35::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e87cc76-77da-45b8-0f70-08d691ac3258
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB7PR04MB4299; 
x-ms-traffictypediagnostic: DB7PR04MB4299:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; DB7PR04MB4299;
 23:ObxlcBNq1iT/AVSi8crQUArNLyFsMFHgiUagCHq?=
 =?iso-8859-1?Q?n3VP3pGiNqftbEHpiAqJDAiohT05367fSRbi30OLUfj24LPUuju1fZvO2H?=
 =?iso-8859-1?Q?soo6o3WtfNE729FJtaMgKxETx8syf4xS5ENjngMjj0xZ0trh1nAoNbqfuu?=
 =?iso-8859-1?Q?K4OJpw80IpPDAjEu6OE+/aOFmsMdm6vf2UFZM2eicl8FBklvIluSuXvQzb?=
 =?iso-8859-1?Q?YdveVwZKwAlzlCpzvQQSR9OYQ562S4bG9tQxhfVKJTPs7fvOtUc/q3IK9L?=
 =?iso-8859-1?Q?p2bO+gl9inlqRcoEsSPBixs2NZwgY6Ts3en64PKtDAEfGlNKU156n/JrsD?=
 =?iso-8859-1?Q?SHiDK8A94faiMAdssyCty9oP5hBOTadSceVNNBVy0AGwngyNdCfTGydmrK?=
 =?iso-8859-1?Q?DKfaN/bIpPzkQMx57S9fodFf6rMrGBc1OvnstxvrbcdJ7W/E4+2EqQeSwJ?=
 =?iso-8859-1?Q?kjavQ/YpDJbKvvV92uOWy/1zKdICWvkLaWUbTLhZ2sC/58j8Cc0lYJ+gYd?=
 =?iso-8859-1?Q?0yrIq2tAGTMypBNCAecv9XBFUefS1A+8Ak934ZvB4GGdW0yOvJxxFYF6Nb?=
 =?iso-8859-1?Q?A07v6epDbwLrajzeidMxajnpTzWnypdc+d1Bh3l5BqWpYERkBIZYxNBnFV?=
 =?iso-8859-1?Q?GQ5RUD/8UhkMxD/hqqg3UBVc4iBFF7NljGEt1ATRZyU+u+hcBhmYWdIo6O?=
 =?iso-8859-1?Q?IAFaWZQc5F2ma90kYCKiU4PdRRB5BT0FvqrrMpZiXyERsQD6woNrDx8miR?=
 =?iso-8859-1?Q?DreX70zlipN28RNDPT2keD6o10/hnoXFImRtTtLvDWrt5C/pDiae/l7bQX?=
 =?iso-8859-1?Q?6cadk77jCoEDjbTbQ5MvmoS5R5iPMn6LQigZTQljkATcGxmPif1dNdR/OD?=
 =?iso-8859-1?Q?nVAy2gSpkUya7BZ49gXHKh+iZzLyDXsnI0eij8lapgHY83j14OjXH07yVh?=
 =?iso-8859-1?Q?Wwhj5Vb6V/pFtTmLgNiD5JgdyTStHV4pA04JPj8X4WwA3xSIMMm36ifV6z?=
 =?iso-8859-1?Q?RXuWYJgRdRyszigETrVCAy+h6dFH+cLLaXuxWX3lQ1LBaU0+iWH4UHQPbc?=
 =?iso-8859-1?Q?3ew4dgtPlo5fzeI3U+pulDQhZEDvYpe0HcLUa10wACO7DI7P9hrDbYT0i/?=
 =?iso-8859-1?Q?pnKo+6k9H+P3VmuqdiOq5UGo3BWMPNlhdj1DmJosjuYALjJkvuofMUOWtq?=
 =?iso-8859-1?Q?4+kmK/uuxbNHNLZUsxQDsaubVZSv0WsV6VpiEf3Fo56hKoWoQrGya6jcml?=
 =?iso-8859-1?Q?seyUcCHPNy0g6gVebC4734MnKT1wn0gGkpZK2idilcmFz4Ibgl2bTd4wPp?=
 =?iso-8859-1?Q?GvvUZq6enGUmqoztsaaXDuE?=
x-microsoft-antispam-prvs: <DB7PR04MB4299B5D499F127DCFC9C807988660@DB7PR04MB4299.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(346002)(366004)(136003)(396003)(199004)(189003)(2201001)(71190400001)(71200400001)(256004)(14444005)(476003)(2616005)(36756003)(99286004)(44832011)(6486002)(26005)(102836004)(52116002)(53936002)(25786009)(4744005)(1076003)(486006)(106356001)(105586002)(3846002)(4326008)(6116002)(86362001)(316002)(110136005)(2906002)(81156014)(81166006)(966005)(478600001)(6512007)(6436002)(66066001)(54906003)(7416002)(50226002)(8676002)(8936002)(7736002)(14454004)(6506007)(68736007)(386003)(186003)(97736004)(2501003)(305945005)(6306002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR04MB4299;
 H:DB7PR04MB4490.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UZ3B8aMGGVDS21rt5+1l0Hl36VSREoAaf8L4dIRlhP4EGgpR20FztvkbZiWcZiIK1mz8mI+XGBVHK8P1IULWrpA6vE0sSFSPVQzhAocRbkaY6PHcY40tMvHxZv3rZjkHDZTm2/nIv+CqDF7RkV1mW4pss+q1W41TbrsrjZFjDRr4PQYJqtVED2koYVZBB5c2UZFsQMeeq9ORWsrcIaC23e6YkeEU6eRP/7VAjK4PphO+M5kqqHU7AUnlLXYWJ6ltjiMfS8sDHQpwHy24KfopozrB9FoXPKjpdF3XTiMfNyFee7KnCIuUE9DZo0YUGb1zGeaB1g2y/XSVrUIfrkk3M2otwjVY021VEsQ82s6mZ2pLaVR3ikeRxuK/c8taBENLNAunPHwZcHtRsvw3oJ7sFdG5hwtMFYFStkcNMrv/7BI=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e87cc76-77da-45b8-0f70-08d691ac3258
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 12:10:04.7751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4299
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_041013_679233_909F1545 
X-CRM114-Status: GOOD (  10.48  )
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
Cc: "van.freenix@gmail.com" <van.freenix@gmail.com>,
 Peng Fan <peng.fan@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The comments could not reflect the code, and it is easy to get
what this function does from a straight-line reading of the code.
So let's drop the comments

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---

V2:
 Drop comments.
 Add a-b
 update commit log.

V1:
 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1929643.html

 arch/arm64/mm/mmu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d6b6f1b169bb..402b6495ff58 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -654,10 +654,6 @@ static void __init map_kernel(pgd_t *pgdp)
 	kasan_copy_shadow(pgdp);
 }
 
-/*
- * paging_init() sets up the page tables, initialises the zone memory
- * maps and sets up the zero page.
- */
 void __init paging_init(void)
 {
 	pgd_t *pgdp = pgd_set_fixmap(__pa_symbol(swapper_pg_dir));
-- 
2.16.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
