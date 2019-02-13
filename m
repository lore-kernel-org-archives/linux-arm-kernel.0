Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14A6C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:38:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B13CC21901
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iImvUTlH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rjK8siTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13CC21901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Dhbeu3+orfF3Z1itJe24azlfTUysh8GzSK/bqUohgGM=; b=iImvUTlHWLtJhC
	fJOX1xApy4ZzR1z5WJZmZGgH869AdMb7HpTBcq33BZZwi+meUxru/hAiSeINqv0arhvbTD3Mflkit
	LVaRcl7BtCds369Njwt96K3iedjipNQIl8FWwVKuJwtWE6AOm6a+kap3jYunxx9fWqN7AB4TsnmVd
	T8X19OqPUyfSktNRJWcazbXamifu3EBk6tY6M3E35zk7nEkDAyl+h6zIFOaGy9cGPRP+cd3gu1B/F
	gKZZVmeU0zCSGGIkgPEC7ECcv3tHw1kIVooiMgmD8fE9cPtggS2JeTgZg4mII4DTWc/wK75+FM8pH
	JE1mfOTBkv/JvVbT7TAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtqzN-0002gZ-SE; Wed, 13 Feb 2019 09:37:57 +0000
Received: from mail-eopbgr130085.outbound.protection.outlook.com
 ([40.107.13.85] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtqz8-0002LI-QY
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 09:37:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHY+UnclL6nMroYOgKgCycsfT7iOg0Cv6WyGM/vERMU=;
 b=rjK8siTZgySl54xE9iPLDnM7ng5P5OfZbyb1AuuAYUtzIxYCwhRWtDE2kDddA64yMAE27/oBEZOZgsfXMLGSRo0htONAptTMu0F0LeHeaVrM74pbSO+Y9otC8IOU2S7n2rwarAcUAX1uFGQrg82U0GKFzDsg5MdVbkTx4m27W2w=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.16) by
 DB7PR04MB5148.eurprd04.prod.outlook.com (20.176.235.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Wed, 13 Feb 2019 09:37:39 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::fd45:a391:7591:1aa5]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::fd45:a391:7591:1aa5%6]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 09:37:39 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "yaojun8558363@gmail.com" <yaojun8558363@gmail.com>, "cpandya@codeaurora.org"
 <cpandya@codeaurora.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>
Subject: [PATCH 3/3] arm64: mmu: pgd_pgtable_alloc: drop barrier
Thread-Topic: [PATCH 3/3] arm64: mmu: pgd_pgtable_alloc: drop barrier
Thread-Index: AQHUw3/CYobPCtINwEOlvcbOdnGfRg==
Date: Wed, 13 Feb 2019 09:37:38 +0000
Message-ID: <20190213094831.7292-3-peng.fan@nxp.com>
References: <20190213094831.7292-1-peng.fan@nxp.com>
In-Reply-To: <20190213094831.7292-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:203:36::25) To DB7PR04MB4490.eurprd04.prod.outlook.com
 (2603:10a6:5:35::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d774fe4-9005-4b02-3c44-08d69196e157
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB7PR04MB5148; 
x-ms-traffictypediagnostic: DB7PR04MB5148:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; DB7PR04MB5148;
 23:MccQVITMsZUfde4vgxei3PK4mQaGG75bWOgcHsj?=
 =?iso-8859-1?Q?I4kHtv8SkXaBJPdwuffOztuzyieJIMVl/28H3UxNGjjK3VDNWLpnnNKKay?=
 =?iso-8859-1?Q?G5NG7tfmyZvuEo4bILmBY6cPvbJnmHFFUaTEoDA1b/BJCjSPKNZm33+e1K?=
 =?iso-8859-1?Q?DdPlXeLARv7Rgwsw1qM3I+tZ0y//Qul7LYeDVALsLD98i9EpG8vG15rBkW?=
 =?iso-8859-1?Q?fjEkgqJXzsVasHLkpDF0/PTQsolMn9Hh2xYg1/fko+YZ7Zfx33bb1aOvn/?=
 =?iso-8859-1?Q?SFbgOlU++qvtWQAw9mJx4eR0n4Z4evY0R8ZZFKqR1UGcMFd2wVRvJnL29e?=
 =?iso-8859-1?Q?H1PA+rJ+cWpBurHjKz7MJcalbmW0m36UyB1v26j9rFB+EykqrK5gKWp/l3?=
 =?iso-8859-1?Q?BVcp89hchMedhbXAfi53uNED9044tUIaw+SmVe2On7Y5hUEBOOAHI90J8D?=
 =?iso-8859-1?Q?zXhMtoCKrAD0iRt8wbP/ttmaGOqpjGoaBX4lwXyzJPF8rn+SZiWE6rsPxD?=
 =?iso-8859-1?Q?skwV8JUJvrjT33u/h0YeUxfSIWXeuenmfFMFbWXEmsnPBXpiqKRhUIPvB0?=
 =?iso-8859-1?Q?ctNWQeHGuQZoU0NPnngEQD6d1YmZfnlq0OGKcqDn+T4VL4dPf9m8buSWVr?=
 =?iso-8859-1?Q?IW7NZwi+q2FsPDgrRi2k7Khrdh5Uf7ZzC4Ff4iZKHUIK7rdza7S1ti70gG?=
 =?iso-8859-1?Q?1qpewAk85eQoJ9UocwZinPGHJ3kZK/xx0FMYmL1nGnSCpnrm6vv7GzjbeI?=
 =?iso-8859-1?Q?lWtVTNDayziU9PFBMGsmrRKOw41JNA71KjcmfAFGWXW1V6VWi9snauQWXH?=
 =?iso-8859-1?Q?OCRPkTy2p49OPCv/moUlTjx+e6VcZ9fW7sVer/xBBIy57jfJieYVm6sOgx?=
 =?iso-8859-1?Q?V5H/25JG6WxUPdZFVO5dfW8B0M1k+engwS6TDFJWTEmUXx6fuV9pgLlCXf?=
 =?iso-8859-1?Q?B0bTGkUh32xe1YKcIP5pte4qltNtKUgqOXXencSrX5sJD4GDigyfuybVjp?=
 =?iso-8859-1?Q?lswy/vCmBzS348z7D0A/ikWgeTP67u9sBnvKz+zl9jvBg1AeP9ZOm1RH9H?=
 =?iso-8859-1?Q?CfkaNB17p8Ienz8vUYcYJVgB1rqfOe+9XYEhinXLE3SmPZHay0IY0KdbdY?=
 =?iso-8859-1?Q?MbnxlVewX58eQLPR7AsCA3kBVbrj4Tpal9eRH/3wF6jBESkyR4+BIlmidz?=
 =?iso-8859-1?Q?PAQ6Eck2Z9/IMtmwb0D7Hsdqk2kxxYLQ6h/3oBBFowR3A3lSfYL3yrMe9M?=
 =?iso-8859-1?Q?35bbc6wlsUJsI8vcJT5CYLOyzL22gLw4T2gzkaBY6MSI5otM1IAF7gU4B6?=
 =?iso-8859-1?Q?48ozWJNO+uVZRM8zHrrAMJV?=
x-microsoft-antispam-prvs: <DB7PR04MB5148DFF2598887B2BE6D00A588660@DB7PR04MB5148.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(366004)(396003)(346002)(136003)(39860400002)(199004)(189003)(105586002)(102836004)(50226002)(2906002)(6506007)(305945005)(52116002)(186003)(6436002)(76176011)(6486002)(478600001)(26005)(53936002)(106356001)(7736002)(68736007)(8676002)(81166006)(71200400001)(386003)(7416002)(6512007)(2501003)(14454004)(256004)(71190400001)(8936002)(81156014)(4326008)(4744005)(1076003)(25786009)(2616005)(476003)(11346002)(54906003)(316002)(2201001)(110136005)(486006)(446003)(86362001)(36756003)(66066001)(99286004)(3846002)(6116002)(44832011)(97736004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR04MB5148;
 H:DB7PR04MB4490.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cmWn6KbHSsfZN/LXGmvYr8MlPEN+I/oWp8NJwZUCZSTVfvIEkaTul0xDagFsoIjyyZTYxypla9HHGg/fYl17s5QF8EVn66VHzkLbFHy/3piq8fVuP0uOAmimr6LGbxH/mMLOoXecDgAnW6Nq1QAZzrCKeEgV77PH/jy+GWTSvIWQZTTYU3/xPuoSEdH9o5SSGHajsA+k/A9uq2qt51fPsvUWsyAlmzQxmbXAasKPmXVi2iS1XcN0wWpyJ/R0LjAEZvvaC4GP2CjiPlmJ0NRrgvxzjUbpYT4p1PSvURNRYqZ89VUR2j8bdUD6AbuGb4fve+FWrLYjFGYsmXDpytALpZy9COU+yYJjFQxV+pLMkbmHKTBlMn+HTWIbjGdinzEX7VcROUbbB2owtFnYIdScY8CJgxkcQTd3/XsV4w2aIzI=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d774fe4-9005-4b02-3c44-08d69196e157
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 09:37:29.3459 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5148
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_013742_886628_FBE94757 
X-CRM114-Status: GOOD (  12.38  )
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

The barriers are added for empty_zero_page, however the
empty zero page has been moved to bss area by
commit 5227cfa71f9e ("arm64: mm: place empty_zero_page in bss"),
and it alreay added "dsb     ishst" in head.S to make sure
the empty zero page visible to PTW.

pgd_pgtable_alloc is only called by __create_pgd_mapping, and
there are implicit barriers in __create_pgd_mapping, so we
could remove the barrier pgd_pgtable_alloc

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

Note: this patch tested on qemu-system-aarch64, not real hardware.

 arch/arm64/mm/mmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index f61fa7c8fd2e..04e3d4d070ce 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -371,8 +371,6 @@ static phys_addr_t pgd_pgtable_alloc(void)
 	if (!ptr || !pgtable_page_ctor(virt_to_page(ptr)))
 		BUG();
 
-	/* Ensure the zeroed page is visible to the page table walker */
-	dsb(ishst);
 	return __pa(ptr);
 }
 
-- 
2.16.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
