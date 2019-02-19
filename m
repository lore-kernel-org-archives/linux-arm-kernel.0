Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B4BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:57:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A80812146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d2uEWjVd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="k5F965Yi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80812146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/BwlXPBo17SzFQCsapelZTR40iGFpi2ykFxlXgCAINs=; b=d2uEWjVdrV8IH7
	16BH0QstC/AWiGwnNlPrK5YFAomQ3/RMX4eLP/sYlgzNMEofxxIPpsNB6IphA7dPRMLgFjgibeDGj
	RyjKdAfmmKmQ9byfffpJbrMgq/kILKWJcyMMYDsQhDgwAnFTH3VjywAqKpqpDwgQcZ70LEWBA94+E
	QLPtkOu0oHhlyBZvj/i87wZYxP+N+omaCrQoaGEO7yzGFsrSSr8w787ZXDgFRKhteoRC4ClS1e/oK
	GQlLXeu71v+L7v7kJxpAjn5KK2y/9JGcfPuGtN3+ds+4xFp6dcB012ZRQMqqbt7mutW07kup296Hw
	Hwn1qpShVO7s/prceevg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw5tK-0003BL-Gc; Tue, 19 Feb 2019 13:56:58 +0000
Received: from mail-eopbgr30069.outbound.protection.outlook.com ([40.107.3.69]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw5tF-0003Ax-JO
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 13:56:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAiKa2tYqxhMnXLt9/A5ztJnmE79c2N2WL1P74e2jSc=;
 b=k5F965Yi2jv0AiIzLOd/E4J08IMEI/ETwsFkYU5DeKEsAmC/jJmOY2+lloyRvp/2If+ZG15zCZ2yVpbF+bHXFdzGVm42AaxU6KwQlGVX6bZPqEojhlyTrjTXqfQpU3/bc7Zi/vgv30+3zx6asATBRdgtIyJ4trUZ/zO290geKCE=
Received: from DB8PR08MB4105.eurprd08.prod.outlook.com (20.179.12.12) by
 DB8PR08MB4057.eurprd08.prod.outlook.com (20.179.9.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Tue, 19 Feb 2019 13:56:49 +0000
Received: from DB8PR08MB4105.eurprd08.prod.outlook.com
 ([fe80::c84c:c3bf:a13e:423a]) by DB8PR08MB4105.eurprd08.prod.outlook.com
 ([fe80::c84c:c3bf:a13e:423a%4]) with mapi id 15.20.1622.018; Tue, 19 Feb 2019
 13:56:49 +0000
From: Steve Capper <Steve.Capper@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 0/9] 52-bit kernel + user VAs
Thread-Topic: [PATCH 0/9] 52-bit kernel + user VAs
Thread-Index: AQHUx6w1oMh6myss70WSkOxz9gCxzKXnCbYAgAAJv4CAAAD2gIAAArwAgAAD2wCAAAuFAA==
Date: Tue, 19 Feb 2019 13:56:49 +0000
Message-ID: <20190219135640.GA15458@capper-debian.cambridge.arm.com>
References: <20190218170245.14915-1-steve.capper@arm.com>
 <CAKv+Gu_xOFXLwKsrFo-rBXdgk4O6zm6xPHB+tv1XjDjzyrjhEA@mail.gmail.com>
 <20190219124825.GH8501@fuggles.cambridge.arm.com>
 <CAKv+Gu-xp06XTvQfwNpCMNej4MLmPZ-borA6oq60+A9XXV6k_g@mail.gmail.com>
 <20190219130138.GI8501@fuggles.cambridge.arm.com>
 <CAKv+Gu9qLiGDfT+yC2-pLhzepYNOfvJ4Squjgmy6u-t3HCJrAw@mail.gmail.com>
In-Reply-To: <CAKv+Gu9qLiGDfT+yC2-pLhzepYNOfvJ4Squjgmy6u-t3HCJrAw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [217.140.106.32]
x-clientproxiedby: DM5PR18CA0060.namprd18.prod.outlook.com
 (2603:10b6:3:22::22) To DB8PR08MB4105.eurprd08.prod.outlook.com
 (2603:10a6:10:b0::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.Capper@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 409996f1-170f-4794-940d-08d6967217f6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DB8PR08MB4057; 
x-ms-traffictypediagnostic: DB8PR08MB4057:
x-ms-exchange-purlcount: 1
nodisclaimer: True
x-microsoft-exchange-diagnostics: 1; DB8PR08MB4057;
 20:+VeSP/upWu2CQ4Jj42Y1ZczGd/9jx/wt7L82URSiNciMce/79TzrXIqb2FiFI7bnxDbkEfF7LjVN/5EnIBIqBxTySivKAL7jbmY8XxAZwuFLfn2R1pmzNYq8f1LG2ZWHBMHaTqxOJhp4UfOxYYVT2502orkqA08w5DEuKOGn0To=
x-microsoft-antispam-prvs: <DB8PR08MB4057B417BD35A915BA30C2E3817C0@DB8PR08MB4057.eurprd08.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(366004)(346002)(39860400002)(136003)(376002)(189003)(199004)(26005)(1076003)(81166006)(7736002)(14454004)(8676002)(186003)(6916009)(25786009)(99286004)(476003)(68736007)(52116002)(102836004)(6246003)(66066001)(2906002)(72206003)(966005)(4326008)(44832011)(478600001)(81156014)(86362001)(305945005)(446003)(58126008)(76176011)(8936002)(53936002)(316002)(6306002)(486006)(386003)(54906003)(6436002)(97736004)(33656002)(14444005)(256004)(71190400001)(71200400001)(6486002)(105586002)(3846002)(6116002)(106356001)(6512007)(11346002)(229853002)(93886005)(5660300002)(6506007)(18370500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB8PR08MB4057;
 H:DB8PR08MB4105.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fP3P8aqDQ+DEGOsjrufXO3dgGzhPUrJgze+1H+BrQQBjwr0BWeMu2yvpbHX13GoW4SyL6dH+egmBl9E5jayjaOLXAljdEfjdhtBziuPIC8rKH9vDzn8koiU+62y4zC3cWv6DLsdm1qlBruY5KcVVPRoN+cvcaKz73+X3/Dox+S0ewDVNXZp79DIRYGrhxj+btFFwrKqGrF8lbg3wbDv5+gAQUmeWLjEPycLtEpK80iy9QAFuhmtZW+1hKqRuz7mlZL/qGhBHrTpYFhGHhsd4WzCpwE7xSHtDTFPTuRKEHBEX1/wwvz4H4IB+Rm0rxYoRD8fTzlViBIxt6NUflFunqnqbmMrs5AAeqdrUmMk+jREVXeCSRKe3OAyimukmpGIJ1tzeb8+YoKsbzJY7E58supT49GWt3SVa4YShWUYxmyc=
Content-ID: <DDB91A3C3BC3C44E8E658FA5D46674F6@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409996f1-170f-4794-940d-08d6967217f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 13:56:47.1292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4057
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_055653_683983_EC6734B7 
X-CRM114-Status: GOOD (  40.23  )
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
Cc: "crecklin@redhat.com" <crecklin@redhat.com>,
 Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>,
 Will Deacon <Will.Deacon@arm.com>, nd <nd@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 19, 2019 at 02:15:26PM +0100, Ard Biesheuvel wrote:
> On Tue, 19 Feb 2019 at 14:01, Will Deacon <will.deacon@arm.com> wrote:
> >
> > On Tue, Feb 19, 2019 at 01:51:51PM +0100, Ard Biesheuvel wrote:
> > > On Tue, 19 Feb 2019 at 13:48, Will Deacon <will.deacon@arm.com> wrote:
> > > >
> > > > On Tue, Feb 19, 2019 at 01:13:32PM +0100, Ard Biesheuvel wrote:
> > > > > On Mon, 18 Feb 2019 at 18:05, Steve Capper <steve.capper@arm.com> wrote:
> > > > > >
> > > > > > This patch series adds support for 52-bit kernel VAs using some of the
> > > > > > machinery already introduced by the 52-bit userspace VA code in 5.0.
> > > > > >
> > > > > > As 52-bit virtual address support is an optional hardware feature,
> > > > > > software support for 52-bit kernel VAs needs to be deduced at early boot
> > > > > > time. If HW support is not available, the kernel falls back to 48-bit.
> > > > > >
> > > > > > A significant proportion of this series focuses on "de-constifying"
> > > > > > VA_BITS related constants.
> > > > > >
> > > > > > In order to allow for a KASAN shadow that changes size at boot time, one
> > > > > > must fix the KASAN_SHADOW_END for both 48 & 52-bit VAs and "grow" the
> > > > > > start address. Also, it is highly desirable to maintain the same
> > > > > > function addresses in the kernel .text between VA sizes. Both of these
> > > > > > requirements necessitate us to flip the kernel address space halves s.t.
> > > > > > the direct linear map occupies the lower addresses.
> > > > > >
> > > > > > One obvious omission is 52-bit kernel VA + 48-bit userspace VA which I
> > > > > > can add with some more #ifdef'ery if needed.
> > > > > >
> > > > >
> > > > > Hi Steve,
> > > > >
> > > > > Apologies if I am bringing up things that have been addressed
> > > > > internally already. We discussed the 52-bit kernel VA work at
> > > > > plumber's at some point, and IIUC, KASAN is the complicating factor
> > > > > when it comes to having compile time constants for VA_BITS_MIN,
> > > > > VA_BITS_MAX and PAGE_OFFSET, right?
> > > > >
> > > > > To clarify what I mean, please refer to the diagram below, which
> > > > > describes a hybrid 48/52 kernel VA arrangement that does not rely on
> > > > > runtime variable quantities. (VA_BITS_MIN == 48, VA_BITS_MAX == 52)
> > > > >
> > > > > +------------------- (~0) -------------------------+
> > > > > |                                                |
> > > > > |            PCI IO / fixmap spaces              |
> > > > > |                                                |
> > > > > +------------------------------------------------+
> > > > > |                                                |
> > > > > |             kernel/vmalloc space               |
> > > > > |                                                |
> > > > > +------------------------------------------------+
> > > > > |                                                |
> > > > > |                module space                    |
> > > > > |                                                |
> > > > > +------------------------------------------------+
> > > > > |                                                |
> > > > > |                BPF space                       |
> > > > > |                                                |
> > > > > +------------------------------------------------+
> > > > > |                                                |
> > > > > |                                                |
> > > > > |   vmemmap space (size based on VA_BITS_MAX)    |
> > > > > |                                                |
> > > > > |                                                |
> > > > > +-- linear/vmalloc split based on VA_BITS_MIN -- +
> > > > > |                                                |
> > > > > |    linear mapping (48 bit addressable region)  |
> > > > > |                                                |
> > > > > +------------------------------------------------+
> > > > > |                                                |
> > > > > |    linear mapping (52 bit addressable region)  |
> > > > > |                                                |
> > > > > +------ PAGE_OFFSET based on VA_BITS_MAX --------+
> > > > >
> > > > > Since KASAN is what is preventing this, would it be acceptable for
> > > > > KASAN to only be supported when you use a true 48 bit or a true 52 bit
> > > > > configuration, and disable it for the 48/52 hybrid configuration?
> > > > >
> > > > > Just thinking out loud (and in ASCII art :-))
> > > >
> > > > TBH, if we end up having support for 52-bit kernel VA, I'd be inclined to
> > > > drop the 48/52 configuration altogether. But Catalin's on holiday at the
> > > > moment, and may have a different opinion ;)
> > > >
> > >
> > > But that implies that you cannot have an image that supports 52-bit
> > > kernel VAs but can still boot on hardware that does not implement
> > > support for it. If that is acceptable, then none of this hoop jumping
> > > that Steve is doing in these patches is necessary to begin with,
> > > right?
> >
> > Sorry, I misunderstood what you meant by a "48/52 hybrid configuration". I
> > thought you were referring to the configuration where userspace is 52-bit
> > and the kernel is 48-bit, which is something I think we can drop if we gain
> > support for 52-bit kernel.
> >
> > Now that I understand what you mean, I think disabling KASAN would be fine
> > as long as it's a runtime thing and the kernel continues to work in every
> > other respect.
> >
> 
> No, it would be a limitation of the 52-bit config which also supports
> 48-bit-VA-only-h/w that the address space is laid out in such a way
> that there is simply no room for the KASAN shadow region, since it
> would have to live in the 48-bit addressable area, but be big enough
> to cover 52 bits of VA, which is impossible.
> 
> For the vmemmap space, we could live with sizing it statically to
> cover a 52-bit VA linear region, but the KASAN shadow region is simply
> too big.
> 
> So if KASAN support in that configuration is a requirement, then I
> agree with Steve's approach, but it does imply that quite a number of
> formerly compile-time constants now get turned into runtime variables.
> 
> Steve, do you have any idea what the impact of that is?

Hi Guys,

The KASAN region only really necessitates two things: 1) that we think
about the end address of the region (which is invariant) rather than the
start address; and that 2) we flip the kernel VA space. IIUC both these
changes have a neglible perf impact.

As for VA_BITS_ACTUAL, we need this in a few places: KVM mapping
support, and the big one phys_to/from_virt. For phys_to/from_virt the
logic is changed s.t. we use a variable lookup for translation but this
is folded into a new variable physvirt_offset (before the patch we used
a single variable read too).

Again IIUC there should be a minimal perf impact (unless one tries to do
cat /sys/kernel/debug/kernel_page_tables with KASAN enabled - but that
can be optimised later).

I didn't have the patience for ASCII art ;-), but I have a picture of
what I think it looks like here:
https://s3.amazonaws.com/connect.linaro.org/yvr18/presentations/yvr18-119.pdf
What I've tried to do is have most parts of the kernel VA space
invariant between 48/52 bits. If it's helpful I can type this up into a
document/commit log message?

For this series I have tried to introduce VA_BITS_MIN in its own patch
and also VA_BITS_ACTUAL into its own patch to make it easier to follow.

If I've overlooked something, please let me know.

Cheers,
-- 
Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
