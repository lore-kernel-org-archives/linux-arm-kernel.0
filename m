Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818C1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:30:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CCC8217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KAVzrGC7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="fGB9qN5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCC8217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8T1yF13zFzyNfRcQZSHy/Nx/cOK0OF96OjE6gsd/x+U=; b=KAVzrGC7IorGzQ
	jyN7mHMsKEOv71XeKtfw6aZ/IDrPySatr7uMXX1vISFx6Lr0rr7LTdTvS7DHjfkQXjJ4MHm9xxHWz
	OSIUOTYZnW8SEX9MkHO7/Tc1scZ3+XlQg2mRU4CU4rbVQiG6oO5IWCcx5d09bxJus8Ki+PHCRMKY1
	Qjqv29dMSn4oXqoWUxVEg3sxZx7X/W6TZN2M9Ir0Jz1PyJ1w8TmDi5VBpaN4b6S8i+s2j8Lc0ff9i
	qKV4appU8zfb8m0rfdZT4I48XUv7CIm9kc+fUj09ecEagu7RDvgoOCX+lQOSk3jbEIa1fT+SQn4fw
	4X7/+O3H4VYqIuKIVFOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gygZ3-0003fQ-Ak; Tue, 26 Feb 2019 17:30:45 +0000
Received: from mail-eopbgr60072.outbound.protection.outlook.com ([40.107.6.72]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gygYx-0003eg-QL
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 17:30:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSWSXpFYDO+2OduOKbzhHAwuOLzPXSbzF6h6HsZRPDA=;
 b=fGB9qN5CJ1UAPj9CxOICLHPfJL6dXP8eJqfUSDSa+jiiu+RZd0WPCbFTisPNSn0cSbK2ORGAMs+7dunZkKXOcfPVQXKDhq0Kunqmx4dVaUzZRE+1y0HULkBBRrGu7sWTuSl51g/a+lB4ePKkaIwdPKswPyCHZna4YOQ2LQUucIc=
Received: from DB8PR08MB4105.eurprd08.prod.outlook.com (20.179.12.12) by
 DB8PR08MB5098.eurprd08.prod.outlook.com (10.255.18.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 26 Feb 2019 17:30:21 +0000
Received: from DB8PR08MB4105.eurprd08.prod.outlook.com
 ([fe80::c84c:c3bf:a13e:423a]) by DB8PR08MB4105.eurprd08.prod.outlook.com
 ([fe80::c84c:c3bf:a13e:423a%4]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 17:30:21 +0000
From: Steve Capper <Steve.Capper@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 0/9] 52-bit kernel + user VAs
Thread-Topic: [PATCH 0/9] 52-bit kernel + user VAs
Thread-Index: AQHUx6w1oMh6myss70WSkOxz9gCxzKXnCbYAgAAJv4CAAAD2gIAAArwAgAAD2wCAAAuFAIAAJ5MAgAsUZgA=
Date: Tue, 26 Feb 2019 17:30:20 +0000
Message-ID: <20190226173007.GA1553@capper-debian.cambridge.arm.com>
References: <20190218170245.14915-1-steve.capper@arm.com>
 <CAKv+Gu_xOFXLwKsrFo-rBXdgk4O6zm6xPHB+tv1XjDjzyrjhEA@mail.gmail.com>
 <20190219124825.GH8501@fuggles.cambridge.arm.com>
 <CAKv+Gu-xp06XTvQfwNpCMNej4MLmPZ-borA6oq60+A9XXV6k_g@mail.gmail.com>
 <20190219130138.GI8501@fuggles.cambridge.arm.com>
 <CAKv+Gu9qLiGDfT+yC2-pLhzepYNOfvJ4Squjgmy6u-t3HCJrAw@mail.gmail.com>
 <20190219135640.GA15458@capper-debian.cambridge.arm.com>
 <CAKv+Gu82_vmeztgCe_y5+pXR27CRUzWBszk+ZEmxXZw9zpRNtA@mail.gmail.com>
In-Reply-To: <CAKv+Gu82_vmeztgCe_y5+pXR27CRUzWBszk+ZEmxXZw9zpRNtA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [217.140.96.140]
x-clientproxiedby: DM5PR18CA0054.namprd18.prod.outlook.com
 (2603:10b6:3:22::16) To DB8PR08MB4105.eurprd08.prod.outlook.com
 (2603:10a6:10:b0::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.Capper@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: adcac37b-6aee-4fda-e142-08d69c101473
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB8PR08MB5098; 
x-ms-traffictypediagnostic: DB8PR08MB5098:
x-ms-exchange-purlcount: 1
nodisclaimer: True
x-microsoft-exchange-diagnostics: 1; DB8PR08MB5098;
 20:kcbIhsvTdbKvRNidwgtOB38/s/+GFk0VCUQJC65EqBIggDIJQgk24zUdm/QuwFOGRVy4UsCPzR511rtJFkIPYvKOta3zwI0/494F7WRuxIsvp8L9OvxCID3jWotNd4waGAvuckGclZpzWYPpLkhQIv/UBiLl0cnnugIW16OAWf8=
x-microsoft-antispam-prvs: <DB8PR08MB50985819E6AA6E231678E04C817B0@DB8PR08MB5098.eurprd08.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(366004)(136003)(346002)(396003)(39860400002)(189003)(199004)(6246003)(53936002)(486006)(3846002)(6306002)(106356001)(4326008)(14454004)(5660300002)(6116002)(44832011)(86362001)(71190400001)(71200400001)(186003)(478600001)(105586002)(14444005)(68736007)(256004)(6512007)(8676002)(54906003)(6486002)(966005)(316002)(93886005)(2906002)(26005)(229853002)(58126008)(76176011)(102836004)(1076003)(6436002)(386003)(81166006)(476003)(81156014)(6506007)(446003)(72206003)(6916009)(305945005)(99286004)(25786009)(11346002)(97736004)(8936002)(33656002)(52116002)(7736002)(66066001)(18370500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB8PR08MB5098;
 H:DB8PR08MB4105.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +Pmme7eZ2oIqlzDXCZGHlAabpKh/JgJIltkp0FbP3+FEGWgVIps+2O4/oTLTkhs8uyVFLLMIaP3e7YrMnKw7851Fmov3pPoKC+2sn4g+FT4iK5nHpfsEqUIqE5vXHbWDqvm03JW2MFC77cLezdRX6E0QsQPBG5bwZLxwXxFvMBHDa70VxPYopkMWkCU7g0/jtbRfTvY4yMyvZ7qGwpRiZWQA06ZubeTyuRNCPVW4jbGHBDITUSIx5KxWjSbL6cedP4C4sAf1gxOpN0W/uEFvnBZgC2ArWiDKAKwpQKHHFeV3fB/5ldkNHYACM+VD96Bubx+3EcqIB269tcHQvCO1JVsRmGrd/8gi8FJH1HFya89HMz4dUuqSuXeszW+IVuhXrWGSvZwcExWJC0goAJmbaGEbHTEcSqXO43xtoGQUuLs=
Content-ID: <5FB56575E5C8B84B949A770FBD9BE3F0@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adcac37b-6aee-4fda-e142-08d69c101473
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 17:30:17.4526 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5098
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_093039_994779_F0745A0D 
X-CRM114-Status: GOOD (  44.39  )
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

On Tue, Feb 19, 2019 at 05:18:18PM +0100, Ard Biesheuvel wrote:
> On Tue, 19 Feb 2019 at 14:56, Steve Capper <Steve.Capper@arm.com> wrote:
> >
> > On Tue, Feb 19, 2019 at 02:15:26PM +0100, Ard Biesheuvel wrote:
> > > On Tue, 19 Feb 2019 at 14:01, Will Deacon <will.deacon@arm.com> wrote:
> > > >
> > > > On Tue, Feb 19, 2019 at 01:51:51PM +0100, Ard Biesheuvel wrote:
> > > > > On Tue, 19 Feb 2019 at 13:48, Will Deacon <will.deacon@arm.com> wrote:
> > > > > >
> > > > > > On Tue, Feb 19, 2019 at 01:13:32PM +0100, Ard Biesheuvel wrote:
> > > > > > > On Mon, 18 Feb 2019 at 18:05, Steve Capper <steve.capper@arm.com> wrote:
> > > > > > > >
> > > > > > > > This patch series adds support for 52-bit kernel VAs using some of the
> > > > > > > > machinery already introduced by the 52-bit userspace VA code in 5.0.
> > > > > > > >
> > > > > > > > As 52-bit virtual address support is an optional hardware feature,
> > > > > > > > software support for 52-bit kernel VAs needs to be deduced at early boot
> > > > > > > > time. If HW support is not available, the kernel falls back to 48-bit.
> > > > > > > >
> > > > > > > > A significant proportion of this series focuses on "de-constifying"
> > > > > > > > VA_BITS related constants.
> > > > > > > >
> > > > > > > > In order to allow for a KASAN shadow that changes size at boot time, one
> > > > > > > > must fix the KASAN_SHADOW_END for both 48 & 52-bit VAs and "grow" the
> > > > > > > > start address. Also, it is highly desirable to maintain the same
> > > > > > > > function addresses in the kernel .text between VA sizes. Both of these
> > > > > > > > requirements necessitate us to flip the kernel address space halves s.t.
> > > > > > > > the direct linear map occupies the lower addresses.
> > > > > > > >
> > > > > > > > One obvious omission is 52-bit kernel VA + 48-bit userspace VA which I
> > > > > > > > can add with some more #ifdef'ery if needed.
> > > > > > > >
> > > > > > >
> > > > > > > Hi Steve,
> > > > > > >
> > > > > > > Apologies if I am bringing up things that have been addressed
> > > > > > > internally already. We discussed the 52-bit kernel VA work at
> > > > > > > plumber's at some point, and IIUC, KASAN is the complicating factor
> > > > > > > when it comes to having compile time constants for VA_BITS_MIN,
> > > > > > > VA_BITS_MAX and PAGE_OFFSET, right?
> > > > > > >
> > > > > > > To clarify what I mean, please refer to the diagram below, which
> > > > > > > describes a hybrid 48/52 kernel VA arrangement that does not rely on
> > > > > > > runtime variable quantities. (VA_BITS_MIN == 48, VA_BITS_MAX == 52)
> > > > > > >
> > > > > > > +------------------- (~0) -------------------------+
> > > > > > > |                                                |
> > > > > > > |            PCI IO / fixmap spaces              |
> > > > > > > |                                                |
> > > > > > > +------------------------------------------------+
> > > > > > > |                                                |
> > > > > > > |             kernel/vmalloc space               |
> > > > > > > |                                                |
> > > > > > > +------------------------------------------------+
> > > > > > > |                                                |
> > > > > > > |                module space                    |
> > > > > > > |                                                |
> > > > > > > +------------------------------------------------+
> > > > > > > |                                                |
> > > > > > > |                BPF space                       |
> > > > > > > |                                                |
> > > > > > > +------------------------------------------------+
> > > > > > > |                                                |
> > > > > > > |                                                |
> > > > > > > |   vmemmap space (size based on VA_BITS_MAX)    |
> > > > > > > |                                                |
> > > > > > > |                                                |
> > > > > > > +-- linear/vmalloc split based on VA_BITS_MIN -- +
> > > > > > > |                                                |
> > > > > > > |    linear mapping (48 bit addressable region)  |
> > > > > > > |                                                |
> > > > > > > +------------------------------------------------+
> > > > > > > |                                                |
> > > > > > > |    linear mapping (52 bit addressable region)  |
> > > > > > > |                                                |
> > > > > > > +------ PAGE_OFFSET based on VA_BITS_MAX --------+
> > > > > > >
> > > > > > > Since KASAN is what is preventing this, would it be acceptable for
> > > > > > > KASAN to only be supported when you use a true 48 bit or a true 52 bit
> > > > > > > configuration, and disable it for the 48/52 hybrid configuration?
> > > > > > >
> > > > > > > Just thinking out loud (and in ASCII art :-))
> > > > > >
> > > > > > TBH, if we end up having support for 52-bit kernel VA, I'd be inclined to
> > > > > > drop the 48/52 configuration altogether. But Catalin's on holiday at the
> > > > > > moment, and may have a different opinion ;)
> > > > > >
> > > > >
> > > > > But that implies that you cannot have an image that supports 52-bit
> > > > > kernel VAs but can still boot on hardware that does not implement
> > > > > support for it. If that is acceptable, then none of this hoop jumping
> > > > > that Steve is doing in these patches is necessary to begin with,
> > > > > right?
> > > >
> > > > Sorry, I misunderstood what you meant by a "48/52 hybrid configuration". I
> > > > thought you were referring to the configuration where userspace is 52-bit
> > > > and the kernel is 48-bit, which is something I think we can drop if we gain
> > > > support for 52-bit kernel.
> > > >
> > > > Now that I understand what you mean, I think disabling KASAN would be fine
> > > > as long as it's a runtime thing and the kernel continues to work in every
> > > > other respect.
> > > >
> > >
> > > No, it would be a limitation of the 52-bit config which also supports
> > > 48-bit-VA-only-h/w that the address space is laid out in such a way
> > > that there is simply no room for the KASAN shadow region, since it
> > > would have to live in the 48-bit addressable area, but be big enough
> > > to cover 52 bits of VA, which is impossible.
> > >
> > > For the vmemmap space, we could live with sizing it statically to
> > > cover a 52-bit VA linear region, but the KASAN shadow region is simply
> > > too big.
> > >
> > > So if KASAN support in that configuration is a requirement, then I
> > > agree with Steve's approach, but it does imply that quite a number of
> > > formerly compile-time constants now get turned into runtime variables.
> > >
> > > Steve, do you have any idea what the impact of that is?
> >
> > Hi Guys,
> >
> > The KASAN region only really necessitates two things: 1) that we think
> > about the end address of the region (which is invariant) rather than the
> > start address; and that 2) we flip the kernel VA space. IIUC both these
> > changes have a neglible perf impact.
> >
> > As for VA_BITS_ACTUAL, we need this in a few places: KVM mapping
> > support, and the big one phys_to/from_virt. For phys_to/from_virt the
> > logic is changed s.t. we use a variable lookup for translation but this
> > is folded into a new variable physvirt_offset (before the patch we used
> > a single variable read too).
> >
> > Again IIUC there should be a minimal perf impact (unless one tries to do
> > cat /sys/kernel/debug/kernel_page_tables with KASAN enabled - but that
> > can be optimised later).
> >
> > I didn't have the patience for ASCII art ;-), but I have a picture of
> > what I think it looks like here:
> > https://s3.amazonaws.com/connect.linaro.org/yvr18/presentations/yvr18-119.pdf
> > What I've tried to do is have most parts of the kernel VA space
> > invariant between 48/52 bits. If it's helpful I can type this up into a
> > document/commit log message?
> >
> > For this series I have tried to introduce VA_BITS_MIN in its own patch
> > and also VA_BITS_ACTUAL into its own patch to make it easier to follow.
> >

Hi Ard,

Apologies for my late reply, I had been staring at this for a while.

> 
> OK, perhaps I am just rephrasing what you essentially implemented
> already, but let me try to explain a bit better what I mean:
> 
> - we flip the VA space in the way you suggest
> - we limit the size of the top half of the address space to 47 bits
> - KASAN region growns downwards from (~0) << 47
> - we define PAGE_OFFSET as (~0) << 52, regardless of whether the h/w
> supports LVA or not
> - however, we tweak the phys/virt translation so that memory appears
> in the 48-bit addressable part of the linear region on non-LVA
> hardware
> 
> The latter basically means that the KASAN shadow region will intersect
> the linear region, but whether we map memory or shadow pages there
> depends on the h/w config at runtime.
> 
> The heart of the matter is probably the different placement of the
> memory inside the linear region, depending on whether the h/w is LVA
> capable or not, which is also reflected in your physvirt_offset. I am
> just trying to figure out why we need VA_BITS_ACTUAL to be a runtime
> variable.

Currently the direct linear map between configurations does not overlap,
we have:

FFF00000_00000000 - Direct linear map start (52-bit)
FFF80000_00000000 - Direct linear map end (52-bit)
FFFF0000_00000000 - Direct linear map start (48-bit)
FFFF8000_00000000 - Direct linear map end (48-bit)

We *can* make PAGE_OFFSET a constant for both 48/52 bit VA_BITS, if we
offset it. vmemmap can then be adjusted on early boot to ensure that
everything points to the right place. However we will get overlap for
52-bit configurations between KASAN and the direct linear map.

The question is: are we okay with quite a large overlap?

The KASAN region begins on 0xFFFDA000_00000000 for 52-bit. If we wish to
employ a "full" 47-bit direct linear map on 48-bit systems we need a
PAGE_OFFSET of 0xFFF78000_00000000 in order to make the direct linear
map end addresses "match up" between 48/52 bit configurations.

This doesn't leave us with a lot of room for 52-bit configurations
though, if KASAN is enabled.

Cheers,
-- 
Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
