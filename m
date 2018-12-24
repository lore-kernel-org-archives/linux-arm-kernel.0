Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3E8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 07:40:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE1C21736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 07:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SGjk/UvD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=live.com header.i=@live.com header.b="uZgrua8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE1C21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fox7mu0t3wwvanuKsTwimIkyinEwZCMKN6TX2K+3sSo=; b=SGjk/UvD0nZbrb
	qdwtRfiZS7XNZaA5TLevvln7Vr+fkt3lIvGw4WLVEBgGI3UtVSn/70Iw4AnNvRFzB9HAG3ZXVhmJ1
	UOmg0XMg56zZ3qnzchBJdlHQqH5I1i542pplakbM0wiD9Y2QTHDLuzEh/ctsbWHYo2P47udqCeVle
	vOOPwRFuAIrNNjkzpudoY0rkJ4JBhwh7XEUoQA4Scf1LO7PHOKV9Y3Xrwl0K4m3gLp3PLbXucarn1
	Cm0QBsXoXwM0tknG0Ys1+gdoSLKferWfezNQOwFLXHGnBoAVlP2PmI11bBO/pDOvF/RfMjdwWero/
	bRe7nW+uzli0MzFhLQyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbKqf-00060h-80; Mon, 24 Dec 2018 07:40:25 +0000
Received: from mail-oln040092003057.outbound.protection.outlook.com
 ([40.92.3.57] helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbKqb-0005YF-L6
 for linux-arm-kernel@lists.infradead.org; Mon, 24 Dec 2018 07:40:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fTIZfUTQRy7hKA8nbxTir2f0yMHRqr/CGCSc0vOrh0=;
 b=uZgrua8+8z7kFmRkFyxSs/AFn2yJqHutISExus3W8+WCrV69EDKIEPIOei0Ty7KYwgXsmUv9n48V6rLUSPUt3hcORiJCRgXLnk8zjZP/qTVuBU7L6LbchNsrJY91Z/EnnXGxyBhtYbINHK6xc5SU0ewsOz/bn0pOc8JxCd7hC34bMD+fy+++Zw3W9i6BcZBdxv+JGsb8XNiBDmWIeexcqjoryZIUza4AX+B4Rnk8Xw2xLFJoHCN6uT5ckvQYSwA0ZzxIlRIXuTOO4YhuvMoszxJbOgcF8UAbTnofFaWmVoiFLi4f2liy3nD4B4t2Cl7O+0rrBKRHHym3qzzDtO7uRQ==
Received: from SN1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (10.152.72.56) by SN1NAM02HT203.eop-nam02.prod.protection.outlook.com
 (10.152.72.91) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1471.13; Mon, 24 Dec
 2018 07:40:07 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com (10.152.72.53) by
 SN1NAM02FT034.mail.protection.outlook.com (10.152.72.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1471.13 via Frontend Transport; Mon, 24 Dec 2018 07:40:07 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::19ff:b7ea:dfaa:2ee3]) by BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::19ff:b7ea:dfaa:2ee3%2]) with mapi id 15.20.1471.018; Mon, 24 Dec 2018
 07:40:07 +0000
From: Yueyi Li <liyueyi@live.com>
To: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>
Subject: [PATCH] arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in linear
 region
Thread-Topic: [PATCH] arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in
 linear region
Thread-Index: AQHUm1vkcfAdS8kQrUSpqXhyNic5xw==
Date: Mon, 24 Dec 2018 07:40:07 +0000
Message-ID: <BLUPR13MB0289A32373545C7FBE3400CBDFBB0@BLUPR13MB0289.namprd13.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR0302CA0005.apcprd03.prod.outlook.com
 (2603:1096:202::15) To BLUPR13MB0289.namprd13.prod.outlook.com
 (2a01:111:e400:5951::22)
x-incomingtopheadermarker: OriginalChecksum:4EFE77640C80CD33279EF659EBDAFDC1C95E9DCDAF0F537FFF15560276981D29;
 UpperCasedChecksum:56AE35C92D0C2DF820DB43D24FD15C59BCA30A03B07CF0B71551E581164692CF;
 SizeAsReceived:7716; Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [1KRx/a/iUWbB0u1t3ZBHXfQmyLLOJ0gr]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; SN1NAM02HT203;
 6:eWIJtcjri+bQjIInk6Zh/N8HvGtDmWsytRSneoxEqXXMjee5Maj6t0TZx6eTfMN6Fls1pgfMCbOtZ6LG2CK36pSqTuzQpsJjXVceKMhCY0m3jyFr95Mh0zPV1yCa3aUegUnCTbYNMVEGS5Laqqtb1Qk7ahxveQjTffSLY7FoC77DwXa7n4LxRUt9OLeKVuMa4YTr02kobwTRPIpR270Biqd0jN8Qb5FZ8xgjGLBN+ClOCyTA2CjhC8N5544tlob3DOGj0zpw1EYTcUYUjzwFsliwPE/oO65J7qQNY5Sx9gLFxpANDIBGXCLi4dt8G45oMjvVw194MQnMSh3SSuPmHuSTh/+uGi9Aq5TP/qpUtjtOQ//92GED/mCE9BokPB+x3F5oan9GDXx/I6iQEWzdXQAtZP8kyvqvByZv8DXI0p4aUJVIL9iGeBy1eCLEU5BIcvpDiDI8NPHQI88A9n+8cw==;
 5:XOq6zTrjTQkRHq2vnxUSESUlIlWhpWLx+1gqYPobcqbueiHojsgRDPYkedQaXQrYpco4aTZg60MQ5S9tW8HPr9jpdxb0+GarK4qMxHeIIxMLSP//adqYgd5PKoC2Xe8EgX72Uv8WVs8g6met54/NsjT7lRYG0mDtbdFZ2jblZGM=;
 7:+eortijbhLtkzKWHFkwndXuAFZc4KE6pPQgba5+pm+JXotNNasfqR2F/JdhxE0dKLaMmhi2qYZ/UEDMmXlh4cJ9LqfqpDRWvZSHMctA6iGGfMxsqSu52BzzvS3tsjHupKfIrDTuRmR/Kcf7WCkgvhg==
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:SN1NAM02HT203; 
x-ms-traffictypediagnostic: SN1NAM02HT203:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:SN1NAM02HT203; BCL:0; PCL:0; RULEID:; SRVR:SN1NAM02HT203; 
x-microsoft-antispam-message-info: F6tI8UGNfG8+j6n3z8JmUkSV093+oQ+4SDuMV+PaMKuiD8Rncpite3O3ytV6B6ni
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cc479a-75b6-4754-f23d-08d6697305e3
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 07:40:07.0902 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1NAM02HT203
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_234021_780837_33438FEF 
X-CRM114-Status: GOOD (  13.86  )
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
Cc: "markus@oberhumer.com" <markus@oberhumer.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When KASLR enaled(CONFIG_RANDOMIZE_BASE=y), the top 4K virtual
address have chance to be mapped to physical address, but which
is expected to leave room for ERR_PTR.

Also, it might cause some other warparound issue when somewhere
use the last memory page but no overflow check. Such as the last
page compressed by LZO:

[ 2738.034508] Unable to handle kernel NULL pointer dereference at virtual address 00000009
[ 2738.034515] Mem abort info:
[ 2738.034518]   Exception class = DABT (current EL), IL = 32 bits
[ 2738.034520]   SET = 0, FnV = 0
[ 2738.034523]   EA = 0, S1PTW = 0
[ 2738.034524]   FSC = 5
[ 2738.034526] Data abort info:
[ 2738.034528]   ISV = 0, ISS = 0x00000005
[ 2738.034530]   CM = 0, WnR = 0
[ 2738.034533] user pgtable: 4k pages, 39-bit VAs, pgd = ffffffff94cee000
[ 2738.034535] [0000000000000009] *pgd=0000000000000000, *pud=0000000000000000
...
[ 2738.034592] pc : lzo1x_1_do_compress+0x198/0x610
[ 2738.034595] lr : lzo1x_1_compress+0x98/0x3d8
[ 2738.034597] sp : ffffff801caa3470 pstate : 00c00145
[ 2738.034598] x29: ffffff801caa3500 x28: 0000000000001000
[ 2738.034601] x27: 0000000000001000 x26: fffffffffffff000
[ 2738.034604] x25: ffffffff4ebc0000 x24: 0000000000000000
[ 2738.034607] x23: 000000000000004c x22: fffffffffffff7b8
[ 2738.034610] x21: ffffffff2e2ee0b3 x20: ffffffff2e2ee0bb
[ 2738.034612] x19: 0000000000000fcc x18: fffffffffffff84a
[ 2738.034615] x17: 00000000801b03d6 x16: 0000000000000782
[ 2738.034618] x15: ffffffff2e2ee0bf x14: fffffffffffffff0
[ 2738.034620] x13: 000000000000000f x12: 0000000000000020
[ 2738.034623] x11: 000000001824429d x10: ffffffffffffffec
[ 2738.034626] x9 : 0000000000000009 x8 : 0000000000000000
[ 2738.034628] x7 : 0000000000000868 x6 : 0000000000000434
[ 2738.034631] x5 : ffffffff4ebc0000 x4 : 0000000000000000
[ 2738.034633] x3 : ffffff801caa3510 x2 : ffffffff2e2ee000
[ 2738.034636] x1 : 0000000000000000 x0 : fffffffffffff000
...
[ 2738.034717] Process kworker/u16:1 (pid: 8705, stack limit = 0xffffff801caa0000)
[ 2738.034720] Call trace:
[ 2738.034722]  lzo1x_1_do_compress+0x198/0x610
[ 2738.034725]  lzo_compress+0x48/0x88
[ 2738.034729]  crypto_compress+0x14/0x20
[ 2738.034733]  zcomp_compress+0x2c/0x38
[ 2738.034736]  zram_bvec_rw+0x3d0/0x860
[ 2738.034738]  zram_rw_page+0x88/0xe0
[ 2738.034742]  bdev_write_page+0x70/0xc0
[ 2738.034745]  __swap_writepage+0x58/0x3f8
[ 2738.034747]  swap_writepage+0x40/0x50
[ 2738.034750]  shrink_page_list+0x4fc/0xe58
[ 2738.034753]  reclaim_pages_from_list+0xa0/0x150
[ 2738.034756]  reclaim_pte_range+0x18c/0x1f8
[ 2738.034759]  __walk_page_range+0xf8/0x1e0
[ 2738.034762]  walk_page_range+0xf8/0x130
[ 2738.034765]  reclaim_task_anon+0xcc/0x168
[ 2738.034767]  swap_fn+0x438/0x668
[ 2738.034771]  process_one_work+0x1fc/0x460
[ 2738.034773]  worker_thread+0x2d0/0x478
[ 2738.034775]  kthread+0x110/0x120
[ 2738.034778]  ret_from_fork+0x10/0x18
[ 2738.034781] Code: 3800167f 54ffffa8 d100066f 14000031 (b9400131)
[ 2738.034784] ---[ end trace 9b5cca106f0e54d1 ]---
[ 2738.035473] Kernel panic - not syncing: Fatal exception

in = 0xfffffffffffff000
in_len = 4096
ip = x9 = 0x0000000000000009 overflowed.

Always leave room the last size of ARM64_MEMSTART_ALIGN region
in linear region.

Signed-off-by: liyueyi <liyueyi@live.com>
---
 arch/arm64/mm/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 0340e45..20fe11e 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -439,7 +439,8 @@ void __init arm64_memblock_init(void)
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
 		extern u16 memstart_offset_seed;
 		u64 range = linear_region_size -
-			    (memblock_end_of_DRAM() - memblock_start_of_DRAM());
+			   (memblock_end_of_DRAM() - memblock_start_of_DRAM()) -
+			   ARM64_MEMSTART_ALIGN;
 
 		/*
 		 * If the size of the linear region exceeds, by a sufficient
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
