Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338B1C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:41:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0654C20659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fx34r2iw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="NTG/Ad64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0654C20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3//RBduZfstm8LjFWXhGz7T5KAtWALavG9XKnZN1tlc=; b=Fx34r2iwDxWIzY
	bP39sTSUDP/HoXUO/gUvJ2Xga6IbxghZE8VLbh6EfKnDTotXt2B2OtzbMBZXvKaQTmr3jdBnMMYLU
	EsbfA5FDQQX9efyglE0JKjQ9T2B+Nm1DA/yEuXIXT6TT89k7Vs6FdZD866B+R9QJm6BqW9JBX+L2o
	0yOIRKJNVQ5ifr/5wE1K45XFZsx/bTQaopLOWp1e5JZ/4WRxAqbPTqggnRaucOr4/gO5bjqqSI/4b
	F0Dw3FhtAENAtTm4tLdSu1Zq5sEOWbKNP8/O8hn/NAC5L+Co4+Kv8xHL5kZccunGSlo1Lb2vmFdJq
	ftcc7Xy1V9y9lKn+kugg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUEhK-0001aV-QW; Tue, 04 Dec 2018 17:41:26 +0000
Received: from mail-eopbgr150080.outbound.protection.outlook.com
 ([40.107.15.80] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUEhH-0001ZY-4k
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 17:41:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKaI+DcjRongm0bQvKdAFNmABj5N/hJf5GhgXKd8tGU=;
 b=NTG/Ad64tHUq4G3uV0APdpRaJx2ntvnDdgaS/7k0RVn1repCS31/YRn8r4ZzdBA9qIvzyZWr7+CY2H2iyJN6aQuI5+t5jDHbsWkymwMxB28qHBpTQ5BSFiVKKxEf9qmVuJRo41l8QQ2ZTF4saLEi+4Fd8d3lQ9IbhfLyM1dSQmI=
Received: from DB6PR0801MB1366.eurprd08.prod.outlook.com (10.168.11.142) by
 DB6PR0801MB1350.eurprd08.prod.outlook.com (10.168.11.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 17:41:07 +0000
Received: from DB6PR0801MB1366.eurprd08.prod.outlook.com
 ([fe80::8d10:1b0d:4dc1:cf07]) by DB6PR0801MB1366.eurprd08.prod.outlook.com
 ([fe80::8d10:1b0d:4dc1:cf07%7]) with mapi id 15.20.1382.023; Tue, 4 Dec 2018
 17:41:07 +0000
From: Steve Capper <Steve.Capper@arm.com>
To: Catalin Marinas <Catalin.Marinas@arm.com>
Subject: Re: [PATCH V3 4/5] arm64: mm: introduce 52-bit userspace support
Thread-Topic: [PATCH V3 4/5] arm64: mm: introduce 52-bit userspace support
Thread-Index: AQHUfB+DMSBw1jyaJESzhKxEumdPbaVotMWAgAZEAoA=
Date: Tue, 4 Dec 2018 17:41:07 +0000
Message-ID: <20181204174057.GA10602@capper-debian.cambridge.arm.com>
References: <20181114133920.7134-1-steve.capper@arm.com>
 <20181114133920.7134-5-steve.capper@arm.com>
 <20181130175956.GJ43329@arrakis.emea.arm.com>
In-Reply-To: <20181130175956.GJ43329@arrakis.emea.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [217.140.106.32]
x-clientproxiedby: DM5PR18CA0069.namprd18.prod.outlook.com
 (2603:10b6:3:22::31) To DB6PR0801MB1366.eurprd08.prod.outlook.com
 (2603:10a6:4:b::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.Capper@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB6PR0801MB1350;
 6:5/xCSfEf1/q1fIc7qgdxO+9BHr9/gp48xVHOHnnfy/HOHIjm/e3wboto/scDbDa2mlVaWWS7xYa4h3YGY0lCSnuhESiup+IVmxNZHEPD8IjMSFNmGvuo3unvNJ2V2YoyAn45sgyDTDjZ9/if3oOBnYId1OdJVgXDci6f/5d3aUt3Gr07y2oUQ2jTyJKGXG+es6LWApNaqgtBdZx+nZEpJXtOULIA73WelCfXtvJEYjbeyy/srfQsW0zSUTHzL/e/NhF8DouUPyrIcdCjrQpAN69vsPwN9qrSozOjih0hIbmBwP02s8WMVt0x/PkzyIT+wOsy17iV76F0x0VRX1AxElKB+X4ZwYxddKbOgHC3LtQ2Q6ZcuB0FPFgJRlOFtbFycY44mrKSbZfDAVqoFx+EO1J8ZoFxYgcv6Ki4aHglqQJiGTkbeWVs1KvhE159PSRHjWp5Ze5ov6cGexdLJ37GOQ==;
 5:+maYw9TrriS/FlYg3SsqQKdAQTTmmtooWrjlIb6O7vgNnn3LgPT1NrdNYp5B0lTGIZCdsfLIT0PjJ2Yz0CMVqHnALAF/C+okUnDT3bKq24Dm+lZZFWDcz/omXGAMWVUAb0MYm8zdVYxmO1/nCFCISAnx3VMrkQ4lgQMaKoM87c4=;
 7:F3hcuW1c0cYi+icm2WazDxY0+C1vYbLPWzALNniBdEfDfTlH0ahRHcnKNz3qa2N2gZ6hFEIw2PDiSi4Gx/11YxlClzyGKplt5AlXhnMJqxB1kJf+7FCDyngoWojhRl3Nnh/RtQqKqQCwEeWH3mhlJA==
x-ms-office365-filtering-correlation-id: 6c186369-e0f7-408f-ccfc-08d65a0fab86
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DB6PR0801MB1350; 
x-ms-traffictypediagnostic: DB6PR0801MB1350:
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB1350571E14008255E62C54B681AF0@DB6PR0801MB1350.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:DB6PR0801MB1350; BCL:0; PCL:0; RULEID:; SRVR:DB6PR0801MB1350; 
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(26005)(53936002)(81166006)(6512007)(72206003)(8676002)(6246003)(6862004)(33656002)(4326008)(106356001)(25786009)(105586002)(97736004)(81156014)(478600001)(8936002)(386003)(486006)(52116002)(71200400001)(14454004)(102836004)(71190400001)(44832011)(446003)(66066001)(68736007)(6506007)(476003)(6636002)(186003)(229853002)(6436002)(256004)(58126008)(7736002)(76176011)(316002)(305945005)(54906003)(86362001)(99286004)(2906002)(6486002)(5660300001)(1076002)(3846002)(6116002)(11346002)(18370500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB6PR0801MB1350;
 H:DB6PR0801MB1366.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Cb0PuhXIP8v82uzGXw+9dpqTkLoiSPjUc5NoABF/YGCIOia08/xJOhr2IaI6Qpavz40mLns+8P2P1BiLGpt2mDsnj+RFnPXXddrqglKYDQ7EBNFBOcf5LYqpKta7w5S85VDihcoqbkdxBHOKDgLo9XvuBAZg0RQnVceAqFgMhKI7OYZNu1WwjnAOlpYBbePbH/M6P0SYskUbIRLUJw3yVbtMxe50M0u4jtRjNpzzgad8GUSSB1hJqOC173F1ZYCSKLaYe+kKs/0HvH6z+axh8FMxTLOa2fueMNUzKA+ibJRE1evO1a5HyCcSXWPPEKID3JWndpTHkxibzr9oSmWfZz6Q1TX1Q4M7BiEtLO3eW1s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <D9E07313ADA61E488D3D4DCAB80FB5F3@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c186369-e0f7-408f-ccfc-08d65a0fab86
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 17:41:07.2124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1350
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_094123_230908_BDFE10E5 
X-CRM114-Status: GOOD (  19.29  )
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
Cc: "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "jcm@redhat.com" <jcm@redhat.com>, Will Deacon <Will.Deacon@arm.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, nd <nd@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 05:59:59PM +0000, Catalin Marinas wrote:
> On Wed, Nov 14, 2018 at 01:39:19PM +0000, Steve Capper wrote:
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > index 50b1ef8584c0..19736520b724 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -616,11 +616,21 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
> >  #define pgd_ERROR(pgd)		__pgd_error(__FILE__, __LINE__, pgd_val(pgd))
> >  
> >  /* to find an entry in a page-table-directory */
> > -#define pgd_index(addr)		(((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
> > +#define pgd_index(addr, ptrs)		(((addr) >> PGDIR_SHIFT) & ((ptrs) - 1))
> > +#define _pgd_offset_raw(pgd, addr, ptrs) ((pgd) + pgd_index(addr, ptrs))
> > +#define pgd_offset_raw(pgd, addr)	(_pgd_offset_raw(pgd, addr, PTRS_PER_PGD))
> >  
> > -#define pgd_offset_raw(pgd, addr)	((pgd) + pgd_index(addr))
> > +static inline pgd_t *pgd_offset(const struct mm_struct *mm, unsigned long addr)
> > +{
> > +	pgd_t *ret;
> > +
> > +	if (IS_ENABLED(CONFIG_ARM64_52BIT_VA) && (mm != &init_mm))
> > +		ret = _pgd_offset_raw(mm->pgd, addr, 1ULL << (vabits_user - PGDIR_SHIFT));
> 
> I think we can make this a constant since the additional 4 bits of the
> user address should be 0 on a 48-bit VA. Once we get the 52-bit kernel
> VA supported, we can probably revert back to a single macro.

Yeah, I see what you mean.

> 
> Another option is to change  PTRS_PER_PGD etc. to cover the whole
> 52-bit, including the swapper_pg_dir, but with offsetting the TTBR1_EL1
> setting to keep the 48-bit kernel VA (for the time being).
> 

I've got a 52-bit PTRS_PER_PGD working now. I will clean things up, run
more tests and then post.

Cheers,
-- 
Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
