Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D883BC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:27:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A43272075D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ujwWRuWx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="p38WYivM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43272075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oxOFIHirvUNzfj32fRlFRX5o466aIbmzPxk++Vw20Nk=; b=ujwWRuWxccDQcW
	tFUvw6Q0WKa1TSWaYGNSk4pxefUeUB50IgXpDQBrox7zCxGl52q2vQlDl3o3zZF+rPX7LJAqGzAYL
	u9Neh3JPoWyIRvzsOK4O4XiiKhqJNUxZvi6DqkqFQfh3EmPcu0hMtu1+EVyonhpzCZ1g5At1rQmQw
	15ru46XwqggRdY+Eu48aC0wcSp33oidI8wlUVkfcXTWonJs/bJJu7/vsUkvSipRtx6dXZ/P4T9ri5
	jG1X9AGLlxeZD8ng3rWP9H0T3oAyNCsdtQ2mAK6YUeDctGe+E/5UUf///a3tZOQrIOkFuQC9N9IJ6
	iFeAjc1+/HxPfzxPW28A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqbTR-0001PR-4S; Mon, 04 Feb 2019 10:27:33 +0000
Received: from mail-eopbgr00089.outbound.protection.outlook.com ([40.107.0.89]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqbTN-0001Oz-2j
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 10:27:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVO1ugM2VAR4/7GJDgrDFKElwXZHsfqVk7QvyjCEyi8=;
 b=p38WYivM/jTPfOpE00oSJL/5w0wBYhGk26qf+dU/ySOH6yVzfixcWMPznIZ7h4bCLR9OCFr3ZdEMGzjF1r7XlCyFEpYynUf3Gnq0NsNTnm6IxyB0RLIz7vkqM4ttp8d8eSHET5uElZkdmirA2HuKFBhB5icf4Q5O7xTJpl4pKnc=
Received: from DB8PR08MB4105.eurprd08.prod.outlook.com (20.179.12.12) by
 DB8SPR01MB0003.eurprd08.prod.outlook.com (20.179.8.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Mon, 4 Feb 2019 10:27:24 +0000
Received: from DB8PR08MB4105.eurprd08.prod.outlook.com
 ([fe80::3d06:58c4:a969:554b]) by DB8PR08MB4105.eurprd08.prod.outlook.com
 ([fe80::3d06:58c4:a969:554b%3]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 10:27:24 +0000
From: Steve Capper <Steve.Capper@arm.com>
To: Qian Cai <cai@lca.pw>
Subject: Re: kernel_page_tables issue with CONFIG_ARM64_USER_VA_BITS_52=y
Thread-Topic: kernel_page_tables issue with CONFIG_ARM64_USER_VA_BITS_52=y
Thread-Index: AQHUueLfvk3wiqo4IEK25Z94vYKAOaXK9e+AgAB1awCABAlFgA==
Date: Mon, 4 Feb 2019 10:27:24 +0000
Message-ID: <20190204102715.GA11645@capper-debian.cambridge.arm.com>
References: <fe7fa86a-42ed-ee58-be26-4d8ae45fadab@lca.pw>
 <20190201134847.GC29903@fuggles.cambridge.arm.com>
 <1549054142.6911.25.camel@lca.pw>
In-Reply-To: <1549054142.6911.25.camel@lca.pw>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [217.140.106.32]
x-clientproxiedby: DM5PR18CA0067.namprd18.prod.outlook.com
 (2603:10b6:3:22::29) To DB8PR08MB4105.eurprd08.prod.outlook.com
 (2603:10a6:10:b0::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.Capper@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB8SPR01MB0003;
 6:AAG0zcYvsrM0MhAcrBymsf22vgq924qSnFy6+I8Gf7eZBNx10Nj2jLVLsvIQ75LESRAum/CLVG1WkDKfqXjUTGa/4ZPOzIcqsSdukE99za6InAV7KqOeuhRYOWUlqLo8umS5NPFnWmfG4+V5FtN5Jvlk7pfemT89X8n9kwUKrAWb3MT/hm9eJx7o92f4H/3p/4c+yh6KYb9cuz9pPpfaA5M3KiWyKt5XD7Pvfodk9veVb2xhfU/8rrfWXvnscKBcT3BNgSAJpAx+7cUfx+SAWfxa6YAmMkGjgr3XAZcLeaiiivLAzZrqmj0saXvOmhqPd9zA2GHx7dd1X35HKEf30zllQqv8+S8frvdCBVGY31MWVXYiyK6m/E33HrPHC1Qh4U4FzZpsj/MPRS7OF0QWyYXbqmekfByuecVatqsqAU/mc84qQNOlB3WHD+QuH8OLREJqqmkZpM8ROqFvKmavOg==;
 5:DIdkDssKxUlhPxr8YjMUwdC9MZzWh/oMO1xRBSSrZSc6Nl0wW6sKsO4l4FFX1d04EpJF9Oq2L89hYNhuenUjSryMRZ5poMajp+4ifw7ETVa/9EYBAz0osiOKvUFajtWMROjDxzrEHk8BPjPTHK9h6dJhcSkUTNpr+LohAZpwRQ9BgxDDH/uKWIbiZLyeVUA3cN97XmXN+l4Z9lGEoQwCMQ==;
 7:810dQXcGO1NOQeeolaxU6myiKtvsx/de3d+GP2AR0ezaX9eY53YnmoVCghgQLM5k9q8T/r76lFKC9mWUUT8ssiS8a8/pKUXxv64JrzD4rRlF+2YWLh4nofyFw7vsohTKjY/5AW+Q2tsMTF62M4MkSg==
x-ms-office365-filtering-correlation-id: 8aa65243-4dd1-4231-8bb4-08d68a8b5a33
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB8SPR01MB0003; 
x-ms-traffictypediagnostic: DB8SPR01MB0003:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB8SPR01MB000320DA7B6E3AE616AFE8CA816D0@DB8SPR01MB0003.eurprd08.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(376002)(366004)(39850400004)(396003)(346002)(199004)(189003)(6916009)(3846002)(105586002)(66066001)(58126008)(316002)(6486002)(54906003)(6436002)(229853002)(1076003)(256004)(6116002)(2906002)(6512007)(6246003)(25786009)(6506007)(386003)(4326008)(26005)(8936002)(76176011)(8676002)(52116002)(81156014)(81166006)(186003)(99286004)(71190400001)(71200400001)(53936002)(7736002)(102836004)(305945005)(486006)(86362001)(97736004)(106356001)(68736007)(33656002)(478600001)(72206003)(476003)(44832011)(14454004)(11346002)(446003)(18370500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB8SPR01MB0003;
 H:DB8PR08MB4105.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: juNvuFNwLL0pNgkkU1p8/tc6jQb/7oZHCxDESv9kSyf761mwjaBB23lVmf7+LpjKVs0YuFdH8W/Gj+IP9PE/tvWAPWFEG/FkKIF1d7bf/zB3H1+y5JVZA5BZ2hNOXDN7oNHtTu4fZxHg4FofDt7gcxCWnk8PxRaArR2mN/4IIn58dnK4miN74En6TLoBCmWVi6B5R87HjcdmbATuVoDx8EzzPYoxB98Hykt/zJoxrosQYX8KyZx9wM6b72sLlgo0U+HA3/JJebw5uMUl156lg8xvON+Kw/qNw1+rrhlPJfNkOc/lC2miL9gbZDN0+KZ0+eWjTWoJtRiGDZ1DRwkRpVyvxH+o+NOPT5HsSMxW4I9aL4ao5C1RJnXR2TRynlMcl7i1+g9eAxN7Regpiqv+Y0pYJ0icsU4DNHjBQPI9728=
Content-ID: <4F36AF25760EAA409820892C5CD27437@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa65243-4dd1-4231-8bb4-08d68a8b5a33
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 10:27:22.2177 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8SPR01MB0003
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_022729_121114_D0E56FFE 
X-CRM114-Status: GOOD (  11.99  )
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
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, nd <nd@arm.com>,
 Will Deacon <Will.Deacon@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 01, 2019 at 03:49:02PM -0500, Qian Cai wrote:
> On Fri, 2019-02-01 at 13:48 +0000, Will Deacon wrote:
> > Hi Qian Cai,

[...]

> Unfortunately, although this takes care of kernel_page_tables, it breaks
> efi_page_tables.
> =

> # cat /sys/kernel/debug/efi_page_tables
> BUG()
> =

> # ./scripts/faddr2line vmlinux walk_pgd+0x84/0x254
> walk_pgd+0x84/0x254:
> __read_once_size at include/linux/compiler.h:193 (discriminator 1)
> (inlined by) walk_pgd at arch/arm64/mm/dump.c:345 (discriminator 1)
> =

> 344:=A0=A0=A0=A0=A0=A0=A0=A0do {
> 345:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pgd_t pgd =3D READ_ON=
CE(*pgdp);
> 346:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0next =3D pgd_addr_end=
(addr, 0);
> =

> kernel BUG at arch/arm64/mm/dump.c:332!
> =

> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0} else {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0B=
UG_ON(pud_bad(pud));
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0w=
alk_pmd(st, pudp, addr, next);
>

Hi Qian Cai,
Apologies for missing the efi_page_tables.

Does the following (applied to Will's fix) help?

Cheers,
-- =

Steve

--->8

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index 00ca2adeb5ef..42ac8fd15e59 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -339,11 +339,12 @@ static void walk_pgd(struct pg_state *st, struct mm_s=
truct *mm,
 		     unsigned long start)
 {
 	unsigned long next, addr =3D start;
+	unsigned long end =3D (start < TASK_SIZE_64) ? TASK_SIZE_64 : 0;
 	pgd_t *pgdp =3D pgd_offset(mm, addr);
 =

 	do {
 		pgd_t pgd =3D READ_ONCE(*pgdp);
-		next =3D pgd_addr_end(addr, 0);
+		next =3D pgd_addr_end(addr, end);
 =

 		if (pgd_none(pgd)) {
 			note_page(st, addr, 1, pgd_val(pgd));
@@ -351,7 +352,7 @@ static void walk_pgd(struct pg_state *st, struct mm_str=
uct *mm,
 			BUG_ON(pgd_bad(pgd));
 			walk_pud(st, pgdp, addr, next);
 		}
-	} while (pgdp++, addr =3D next, addr);
+	} while (pgdp++, addr =3D next, addr !=3D end);
 }
 =

 void ptdump_walk_pgd(struct seq_file *m, struct ptdump_info *info)
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-=
runtime.c
index 23ea1ed409d1..16757966c3bf 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -38,7 +38,8 @@ static struct ptdump_info efi_ptdump_info =3D {
 	.mm		=3D &efi_mm,
 	.markers	=3D (struct addr_marker[]){
 		{ 0,		"UEFI runtime start" },
-		{ DEFAULT_MAP_WINDOW_64, "UEFI runtime end" }
+		{ DEFAULT_MAP_WINDOW_64, "UEFI runtime end" },
+		{ -1, NULL }
 	},
 	.base_addr	=3D 0,
 };

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
