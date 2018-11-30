Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E61EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:00:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6265E2146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ScrdlvP8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qQUdXI4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6265E2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I1oGQ+cjicGvzdyETvBHHvXrSLv78hOQYZYs6FL8SOk=; b=ScrdlvP8qsve7D
	sZ3iH0kz1VqXezrpD8ol01iKfqsWaSAIw/2DLdpjWFaSeXgSAX0QRoxV80E5Z9nBPLFtjnuUV4M+7
	15qZGtB7qSyWVd12fws7HqXWhGQSbks5mnzTtVDkLA4y+9jmXRH1vAC5KChV9ngFd4DhwqQW942K0
	c0EaZgNshguag59blXKAs3QCA/InGVKGGF2h5lAL3NRg4ZuiehkhH2TmDosTzLRhks1u2GWwXkjwz
	zwBTc8bsjLerxUiMJ4PtDhP1XJGMmcJC6fEl/pnyADWxwwW0T6o/9adXxYx99V7MKc2lTHxZVgZWd
	lAHGqkJLuYqzGRQrorKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSn5O-0006zA-Kc; Fri, 30 Nov 2018 18:00:18 +0000
Received: from mail-eopbgr30087.outbound.protection.outlook.com ([40.107.3.87]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSn5J-0005ev-Ne
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 18:00:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1fYnj+NUjHme1VvcAaGdRPmL0mrcqfVwffV4z7Uy24=;
 b=qQUdXI4S+5YFtZvCO33Th5n3UCj382dcD4JbTpt1U9NQ0TRkQ9581qpSQwODpUigV4+p0oE4dNam4iZgd6aGOdZp7Zb6SzFd2hihr8N+O8Sk38BbPNCh3rnjVXyZt55UZAzEGEUAUfVUyrbFhdZx96ZUv24nVUetQaPUgdq3mDw=
Received: from DB7PR08MB3209.eurprd08.prod.outlook.com (52.134.110.159) by
 DB7PR08MB3067.eurprd08.prod.outlook.com (52.134.110.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 17:59:59 +0000
Received: from DB7PR08MB3209.eurprd08.prod.outlook.com
 ([fe80::dd06:f986:fcee:10f1]) by DB7PR08MB3209.eurprd08.prod.outlook.com
 ([fe80::dd06:f986:fcee:10f1%2]) with mapi id 15.20.1382.020; Fri, 30 Nov 2018
 17:59:59 +0000
From: Catalin Marinas <Catalin.Marinas@arm.com>
To: Steve Capper <Steve.Capper@arm.com>
Subject: Re: [PATCH V3 4/5] arm64: mm: introduce 52-bit userspace support
Thread-Topic: [PATCH V3 4/5] arm64: mm: introduce 52-bit userspace support
Thread-Index: AQHUfB+DVQD7LOHUykiMmpZH+DICTKVotMOA
Date: Fri, 30 Nov 2018 17:59:59 +0000
Message-ID: <20181130175956.GJ43329@arrakis.emea.arm.com>
References: <20181114133920.7134-1-steve.capper@arm.com>
 <20181114133920.7134-5-steve.capper@arm.com>
In-Reply-To: <20181114133920.7134-5-steve.capper@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LO2P265CA0317.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::17) To DB7PR08MB3209.eurprd08.prod.outlook.com
 (2603:10a6:5:1e::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Catalin.Marinas@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB7PR08MB3067;
 6:OhLvMSxiIgh0rwB6ogpMCfcOSoOS6PHR6+ZEe7RqRK0ZQ2ykE0zkM/VEHAYbHLMPt1UvvklGtt0OA2fErtm8bnxs2y3yp7V1Z5J51GiCNc/mgn1xXTSDoddJA40dItKiMv4e8lfSvy+5dN55QA0CO1/32kquijuu4VcdmUy8mtn1I4xxtjafVyH4MBRRRKU8WgFDeUObyjI52KNizWVb3Eem9lT2L3IEsWAw5WWKdrHd3I8gVPm5lyNknEAVZ6g2B1ll0IsogDXgmFFQ85N5HX6M+SdvTBumldIo8H8uRGeiFCe3nyRz4T5HHxcKEIaIKxsNsnTWO42vtlHtjXmJ57GnEacAL3gFh1mU3uFtzrhrIU6S15DtsUEVILvXS4gJgkwgjMMgmMrE8BdaL0mFgsO0qH0hqRXvTh1qtNJLf8Ari5WEMAdSYvealb+NYS05Ai0nU/xOcHjawc5H1f2a1A==;
 5:FcLPukWtA9UeDP5I3C2mxRD78iPWCZ+QvqiVzArBMrKgz6o3Fr+57n/MGA369khCm/6OZ2NKs4OkTpRpiUGT7WXbD7yinIRyY0d4ce4oidp+2kTBU1t+gXCBHjh9ca6SEabIJYtqPqMIGhRl7k7QMEFKdbA2MY6JNm3oRa0YZbw=;
 7:F2WQYpv54IzQvjrTdHWHA1cPqEu02ijUADOul884dIi7UQnyvtny8JM/kzr8PfgE5aBjO6IzKGtjzC/nSHxuWvAg6Cyyg5Iw1O/KCYyVnfTd+fjL0aAmQJdN5HbaSvaxCpOJOIIMg5+7wPuUICISlQ==
x-ms-office365-filtering-correlation-id: 54221fa1-708f-4cef-04ed-08d656eda4c6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB7PR08MB3067; 
x-ms-traffictypediagnostic: DB7PR08MB3067:
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-microsoft-antispam-prvs: <DB7PR08MB30674B9E0F71063D2E0764C1F2D30@DB7PR08MB3067.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231453)(999002)(944501410)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:DB7PR08MB3067; BCL:0; PCL:0; RULEID:; SRVR:DB7PR08MB3067; 
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(366004)(376002)(346002)(396003)(189003)(199004)(40434004)(102836004)(25786009)(106356001)(6512007)(81156014)(53936002)(97736004)(81166006)(99286004)(8936002)(8676002)(229853002)(5660300001)(14454004)(476003)(7736002)(4326008)(486006)(446003)(305945005)(11346002)(6862004)(1076002)(71190400001)(6246003)(71200400001)(44832011)(54906003)(386003)(33656002)(58126008)(6116002)(6636002)(3846002)(256004)(76176011)(6506007)(2906002)(6486002)(86362001)(72206003)(478600001)(5024004)(14444005)(316002)(52116002)(66066001)(26005)(186003)(68736007)(6436002)(105586002)(18370500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR08MB3067;
 H:DB7PR08MB3209.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eSuv19cTlEbL3p3tjqeCK56QnkpRWTjP19AWsZNmdADCUIDI5VMO9sULr5K5bOJIRidw56392l124a/QiEEpRM+DwHuYRzfk2f5hiOfoVb3MVjjHibDyvbjuy1A2hYQ1AgkpP+3sKT6oR/H3y6XmttIuhy1v5+n913KGuqle+etrMsLylG58ku08SaCsDHGYTUFU2dj5m8DCgu16KSrrUxETywkxoJ5LMofZCropKYeo5pei7+9xe7f4QXlW8I/JqnwLv61qDQ/zgl28RttFMF07pqimK2E7wyp/W9dYybeq9CzDfzTey0m/YINXo4vZqTqhdG9mg6zD7BlwI2Zx3T752s6J1tbYhhXewfi0lx4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <3BA8EACF337C7D42AD098D6042E872A6@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54221fa1-708f-4cef-04ed-08d656eda4c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 17:59:59.4307 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3067
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_100014_538812_CF3F12BC 
X-CRM114-Status: GOOD (  16.32  )
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
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 Will Deacon <Will.Deacon@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "jcm@redhat.com" <jcm@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 14, 2018 at 01:39:19PM +0000, Steve Capper wrote:
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 50b1ef8584c0..19736520b724 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -616,11 +616,21 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
>  #define pgd_ERROR(pgd)__pgd_error(__FILE__, __LINE__, pgd_val(pgd))
>
>  /* to find an entry in a page-table-directory */
> -#define pgd_index(addr)(((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
> +#define pgd_index(addr, ptrs)(((addr) >> PGDIR_SHIFT) & ((ptrs) - 1))
> +#define _pgd_offset_raw(pgd, addr, ptrs) ((pgd) + pgd_index(addr, ptrs))
> +#define pgd_offset_raw(pgd, addr)(_pgd_offset_raw(pgd, addr, PTRS_PER_PGD))
>
> -#define pgd_offset_raw(pgd, addr)((pgd) + pgd_index(addr))
> +static inline pgd_t *pgd_offset(const struct mm_struct *mm, unsigned long addr)
> +{
> +pgd_t *ret;
> +
> +if (IS_ENABLED(CONFIG_ARM64_52BIT_VA) && (mm != &init_mm))
> +ret = _pgd_offset_raw(mm->pgd, addr, 1ULL << (vabits_user - PGDIR_SHIFT));

I think we can make this a constant since the additional 4 bits of the
user address should be 0 on a 48-bit VA. Once we get the 52-bit kernel
VA supported, we can probably revert back to a single macro.

Another option is to change  PTRS_PER_PGD etc. to cover the whole
52-bit, including the swapper_pg_dir, but with offsetting the TTBR1_EL1
setting to keep the 48-bit kernel VA (for the time being).

--
Catalin
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
