Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B7FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:27:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2AB221479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WIc6ZOzn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="D6HM9yYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2AB221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P43hOcjN3DiLJAXmnosCZ/dE4+Ae7QytmFqohRbSH6E=; b=WIc6ZOznQLubaL
	an6fD/2xi9SRCIt2O8aWf2SFpx/x7V8yczlE+37+L0stu2XfSOU/eN7on5eVog6w2iEbk1YU/pYjU
	UXfZnYvsFFXs2dQHmYUcOCeI/ClCHOaBdyzJ3erts94Nh4M2L4JB3FriVthrFYlWEU+B7Ul52awYt
	FkZ/r18yvjbPQKXjxxUzTPrU4riOQdstb2p8vZwT9CChEN5AkAwzngCS36uGlQJNcI2+8uao1P0Kr
	efHp7z/PjTuu965oFa0SBpM97WnUdXvkD+OjPIYSRuXxeJ1UcSlZZ5kN670BkmgwytYrBVVZceqA7
	4647YN+uHk3QOd3455tA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvkp6-0005mE-ST; Mon, 18 Feb 2019 15:27:12 +0000
Received: from mail-eopbgr40070.outbound.protection.outlook.com ([40.107.4.70]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvkp1-0005ka-O0; Mon, 18 Feb 2019 15:27:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBNNvMr4A9ZscKEXQ5u1lWvUhkmJTbirrB2dSdr4jG8=;
 b=D6HM9yYdPEwNd8pZCTjjH46JixVG7jTMQzDctfzhRqgREe3MrXSuZJaI6uZFMqNqdEuJPpuuYHTSWwhgB149RXtH6GiJ9WozYcSjDtrSGkjy7BwKUE+B9AJo0l1S3H17zG6TxXzVlx+RnKFjDlYaX2oLGU3zJnGihwK1E0g7bKQ=
Received: from DB8PR08MB4105.eurprd08.prod.outlook.com (20.179.12.12) by
 DB8PR08MB5068.eurprd08.prod.outlook.com (10.255.18.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Mon, 18 Feb 2019 15:27:03 +0000
Received: from DB8PR08MB4105.eurprd08.prod.outlook.com
 ([fe80::c84c:c3bf:a13e:423a]) by DB8PR08MB4105.eurprd08.prod.outlook.com
 ([fe80::c84c:c3bf:a13e:423a%4]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 15:27:03 +0000
From: Steve Capper <Steve.Capper@arm.com>
To: Bhupesh Sharma <bhsharma@redhat.com>
Subject: Re: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
Thread-Topic: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
Thread-Index: AQHUuJahSFlYFKLyuEi/l1PNbTSCP6XInNAAgAc4pYCAC9sFgIAAXhqAgACbCQCAADN4gIAAzLMAgAB3JICAABkhAIAC/hkAgAAHwACABIuqgA==
Date: Mon, 18 Feb 2019 15:27:03 +0000
Message-ID: <20190218152651.GA14091@capper-debian.cambridge.arm.com>
References: <4AE2DC15AC0B8543882A74EA0D43DBEC03567AA3@BPXM09GP.gisp.nec.co.jp>
 <d7d50b5a-3577-448e-d928-7898016a38fb@redhat.com>
 <20190212104407.GA17022@dhcp-128-65.nay.redhat.com>
 <CACi5LpOAADU8s+3e6=fO7FT+VtAmWYNeZN9COF+4Gt6twLWYaA@mail.gmail.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035683DB@BPXM09GP.gisp.nec.co.jp>
 <20190213111552.GA8265@dhcp-128-65.nay.redhat.com>
 <bed51e6e-3dcb-8e07-1d31-9d81bfca20e5@arm.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03568504@BPXM09GP.gisp.nec.co.jp>
 <37ed4c14-e4b9-49c0-4816-c289ce65fd76@arm.com>
 <CACi5LpN6gVy4gCTYLGRiWW1VNGrVc-+Ykn919LKsO2bP-v1NHw@mail.gmail.com>
In-Reply-To: <CACi5LpN6gVy4gCTYLGRiWW1VNGrVc-+Ykn919LKsO2bP-v1NHw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [217.140.106.32]
x-clientproxiedby: DM5PR18CA0049.namprd18.prod.outlook.com
 (2603:10b6:3:22::11) To DB8PR08MB4105.eurprd08.prod.outlook.com
 (2603:10a6:10:b0::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.Capper@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02a6d022-c062-49f8-5255-08d695b58862
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB8PR08MB5068; 
x-ms-traffictypediagnostic: DB8PR08MB5068:
x-ms-exchange-purlcount: 2
nodisclaimer: True
x-microsoft-exchange-diagnostics: 1; DB8PR08MB5068;
 20:BIUVYUDle8IM17uFSdwz/5WjkEO1e9U+NbXEhH3296GF995rMJxuTR4ockWLxEaebGQOupOEj/Qu5DJdHjVKXqpFL7EPb6EV6Fmy3GU8bwqY/2Ahir58e5fRiBaQHL9y6BSv63lvjXzSLQIaUNh9LtJxsMSPXEc2KYDYd9cwcxA=
x-microsoft-antispam-prvs: <DB8PR08MB50680FDD259F2AE6C533536181630@DB8PR08MB5068.eurprd08.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(346002)(136003)(396003)(366004)(376002)(189003)(199004)(99286004)(186003)(7416002)(316002)(5660300002)(102836004)(54906003)(1076003)(6506007)(966005)(93886005)(58126008)(53546011)(97736004)(71200400001)(33656002)(106356001)(6436002)(68736007)(72206003)(256004)(478600001)(71190400001)(105586002)(26005)(2906002)(76176011)(8936002)(8676002)(14454004)(386003)(25786009)(44832011)(81166006)(446003)(6246003)(6486002)(486006)(6916009)(66066001)(7736002)(3846002)(52116002)(81156014)(476003)(53936002)(6116002)(14444005)(6306002)(4326008)(229853002)(11346002)(6512007)(305945005)(86362001)(18370500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB8PR08MB5068;
 H:DB8PR08MB4105.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LAoMkwzMScJwLRsbAa0Gy7pZA2WyIAwNWtcXCNpNeakXaGGhVDj7EJDnzIKfmEJRSm6y1KcSv9MelUcVyu13gDfD3LjfXWz/LTTVhfaVcDNbV2K3Ew8KWArIsvpa8C4WJSVqSF0zSqE/2IkDeTzIWaE1WNsAniX/CAoYbRt+kHRdlqEG4QBYQuSOFrLbjLwYUD8Xa2/EZXziU7VK9BGCIkG7HM7lIz+7q+dS7q4hkHRkv50GDT1utI9GS/jlPpC+kuAKJ1x5UtqaJLEHye8sPV++KI8WtQ+nmepv4QGsugzFBt97dS24Of4QVBryCmUxywTMZrcfWMIrGQSsiBCIq/SoSfbtE1O6J42qr3aHmnrJEMP6xzgzj5Pm/VXfkS2UtSB79IXFyfZhGo0+aW9H3haRFHYCylnvlLmnQq3qIxU=
Content-ID: <FDAF38E61CCFD64599C4C56FFB25E15D@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a6d022-c062-49f8-5255-08d695b58862
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 15:26:58.5848 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5068
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_072708_093792_535E76A5 
X-CRM114-Status: GOOD (  37.76  )
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
 "lijiang@redhat.com" <lijiang@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 Will Deacon <Will.Deacon@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 James Morse <James.Morse@arm.com>,
 Kristina Martsenko <Kristina.Martsenko@arm.com>,
 Borislav Petkov <bp@alien8.de>, "anderson@redhat.com" <anderson@redhat.com>,
 nd <nd@arm.com>, Dave Young <dyoung@redhat.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Bhupesh,

Sorry for joining this thread late...

On Fri, Feb 15, 2019 at 11:31:56PM +0530, Bhupesh Sharma wrote:
> Hi James,
> 
> On Fri, Feb 15, 2019 at 11:04 PM James Morse <james.morse@arm.com> wrote:
> >
> > Hi guys,
> >
> > (CC: +Steve, +Kristina) "What's the best way of letting user-space know the MMU
> > config when 52-bit VA and pointer-auth may be in use?"
> >
> > On 13/02/2019 19:52, Kazuhito Hagio wrote:
> > > On 2/13/2019 1:22 PM, James Morse wrote:
> > >> On 13/02/2019 11:15, Dave Young wrote:
> > >>> On 02/12/19 at 11:03pm, Kazuhito Hagio wrote:
> > >>>> On 2/12/2019 2:59 PM, Bhupesh Sharma wrote:
> > >>>>> BTW, in the makedumpfile enablement patch thread for ARMv8.2 LVA
> > >>>>> (which I sent out for 52-bit User space VA enablement) (see [0]), Kazu
> > >>>>> mentioned that the changes look necessary.
> > >>>>>
> > >>>>> [0]. http://lists.infradead.org/pipermail/kexec/2019-February/022431.html
> > >>>>
> > >>>>>>> The increased 'PTRS_PER_PGD' value for such cases needs to be then
> > >>>>>>> calculated as is done by the underlying kernel
> > >>
> > >> Aha! Nothing to do with which-bits-are-pfn in the tables...
> > >>
> > >> You need to know if the top level PGD is 512bytes or bigger. As we use a
> > >> kmem-cache the adjacent data could be some else's page tables.
> > >>
> > >> Is this really a problem though? You can't pull the user-space pgd pointers out
> > >> of no-where, you must have walked some task_struct and struct_mm's to find them.
> > >> In which case you would have the VMAs on hand to tell you if its in the mapped
> > >> user range.
> > >>
> > >> It would be good to avoid putting something arch-specific in here if we can at
> > >> all help it.
> >
> > >>>>>>> (see
> > >>>>>>> 'arch/arm64/include/asm/pgtable-hwdef.h' for details):
> > >>>>>>>
> > >>>>>>> #define PTRS_PER_PGD          (1 << (MAX_USER_VA_BITS - PGDIR_SHIFT))
> > >>>>
> > >>>> Yes, this is the reason why makedumpfile needs the MAX_USER_VA_BITS.
> > >>>> It is used for pgd_index() also in makedumpfile to walk page tables.
> > >>>>
> > >>>> /* to find an entry in a page-table-directory */
> > >>>> #define pgd_index(addr)         (((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
> > >>>
> > >>> Since Dave mentioned crash tool does not need it, but crash should also
> > >>> travel the pg tables.
> > >
> > > The crash utility is always invoked with vmlinux, so it can read the
> > > vabits_user variable directly from vmcore, but makedumpfile can not.
> >
> > (This sounds fragile. That symbol's name may change, it may disappear
> > completely! ... but I guess crash changes with every kernel release anyway)
> >
> >
> > >>> If this is really necessary it would be good to describe what will
> > >>> happen without the patch, eg. some user visible error from an actual test etc.
> > >>
> > >> Yes please, it would really help if there was a specific example we could discuss.
> > >
> > > With 52-bit user space and 48-bit kernel space configuration,
> > > makedumpfile will not be able to convert a virtual kernel address
> > > to a physical address, and fail to capture a dumpfile, because the
> > > pgd_index() will return a wrong index.
> >
> > Got it, thanks!
> > (all this user stuff had me thinking it was user-space you were trying to walk).
> >
> > Yes, this is because of commit e842dfb5a2d3 ("arm64: mm: Offset TTBR1 to allow
> > 52-bit PTRS_PER_PGD"). The kernel has offset the ttbr1 value, if you try and
> > walk it without knowing the offset you get junk.
> >
> > Ideally we tell you the offset with some 'ttbr1_offset=' in vmcoreinfo, but if
> > the offsetting code disappears, the kernel would still have to provide
> > 'ttbr1_offset=0' for user-space to keep working.
> >
> > I'd like to find something future-proof that always has an unambiguous meaning,
> > and isn't a problem if the kernel variable/symbol/kconfig names change.
> >
> > With pointer-auth in use too you can't guess which bits are address and which
> > bits are data.
> >
> > Taking arch-specific to its extreme, we could expose TCR_EL1, but this is a
> > problem if we ever switch that per task (some new bits may turn up with a new
> > feature). Some of those bits vary per cpu too, so we'd have to mask them out in
> > case user-space tries to conclude something from them.
> >
> >
> > My current best suggestion is to export:
> > from core code:
> > * USER_MMAP_END, the maximum value a user-space can try and mmap().
> > This would normally be TASK_SIZE, but x86 and powerpc also have support for
> > larger VA space, and its plumbed into mm slightly differently. We should have
> > one arch-independent property that covers all these. On arm64 this would be the
> > runtime va bits for user-space's TTBR. (This assumes the value isn't per-task)
> >
> > arch specific:
> > * ARM64_TCR.T1SZ, the va bits mapped by the kernel's TTBR. (We can assume we'll
> > never flip user/kernel space). This has to be arch specific, it will always have
> > a value and its meaning comes from the ARM-ARM (so linux can't change it in the
> > future). It should be the same on every CPU.
> > * ARM64_TTBR1.BADDR, the pa of the kernel page tables, which implicitly has the
> > offset. Again this always has a value, and its meaning comes from the ARM-ARM.
> > If we ever get clever with different page-tables/TCR values on different CPUs,
> > these two should come from the same CPU.
> >
> >
> > I think this gives you what you need if user/kernel may both be using
> > pointer-auth and both may be using 52-bit va. I'm pretty sure the 48:52 bits can
> > be picked at boot time depending on the kernel kconfig and the hardware support.
> >
> > Does anyone have a better idea? (or a corner where this won't work?)
> 
> I am not sure you got a chance to look at the two regression cases I
> reported here:
> <http://lists.infradead.org/pipermail/kexec/2019-February/022449.html>
> 
> Unfortunately the above suggestion doesn't provide any fix for
> ARMv8.2-LPA regression (see text under heading '
> (1). Regression Case 1 (ARMv8.2-LPA enabled kernel)')
> 
> After going through the regression reports, I think exporting
> 'MAX_USER_VA_BITS' and 'MAX_PHYSMEM_BITS' to vmcoreinfo is sufficient
> for the above regressions (without over-complicating the stuff) as
> ARM64_TCR.T1SZ and friends seem to arch specific as compared to
> VA_BITS + 'MAX_USER_VA_BITS' .
> 

For MAX_USER_VA_BITS, IIUC you are just after a value of PTRS_PER_PGD?
Why not just add PTRS_PER_PGD to the vmcoreinfo?

FWIW it is possible in vaddr_to_paddr_arm64 to detect a zero pgd entry
then try again with another ptrs_per_pgd value (granted this is a little
hacky).

Cheers,
-- 
Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
