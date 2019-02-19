Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F021FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:39:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD38220859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jespy2jT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="GUqSmhc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD38220859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aEKNcZCNa4SDS07Jo3NDYTytDnpJktoKqXJqN5p/idM=; b=jespy2jTZm1bUS
	eah2rnYNIV+qDdntCHRYB45Ex5P5jl2/rz6qWhbOmQ0Nns2YnhqdVCu9mQbzvuvxbchuc+G6DdgXN
	Nkcob1p9UMtB7ynvWpOuPyFtOBkX4pvCUthm59XX97kqjHv7CR86zybGSiF4yG5JuC58T7DIs+oEr
	NTccTlQw2O8z2HGuTaVpRvRSMhKtXxJDb7pKXmNK221iKHApkAePy8gawMUQXuQQJUlT/HCEYAteH
	HS27pQXktCnEXFG7sqh5saYR6O6cEuO1L66DSd2UG9rX1MdaM6bZR5bT825yP+hnIymtllz3loiP/
	eur3oHQ4iJoN6lJCeBZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwAIE-0003wj-Bg; Tue, 19 Feb 2019 18:38:58 +0000
Received: from mail-ve1eur02on0608.outbound.protection.outlook.com
 ([2a01:111:f400:fe06::608]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwAI6-0003va-Ck
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 18:38:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYlLzMG2PNPj3O81YCrCIulvZ0Gw13H105iKSt8GvGw=;
 b=GUqSmhc2n5XFdrGkeMSbOHTIKb5WZCMLhGvSK+9eRti3nHWLZH3hRp78djTijQOCkdFQerj0Zey0Ak5CZLE5FMEPJijeOOGl2WtKcz2JYb/ByL2+wVmGuHQ0zl4omsbhOlGDM9ir5mefPNGgxpkXHzioezei3Dow0/N7GXjpbo8=
Received: from DB7PR08MB4217.eurprd08.prod.outlook.com (20.178.47.91) by
 DB7PR08MB3484.eurprd08.prod.outlook.com (20.176.238.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Tue, 19 Feb 2019 18:38:31 +0000
Received: from DB7PR08MB4217.eurprd08.prod.outlook.com
 ([fe80::483e:afa9:c9f:9db8]) by DB7PR08MB4217.eurprd08.prod.outlook.com
 ([fe80::483e:afa9:c9f:9db8%4]) with mapi id 15.20.1622.018; Tue, 19 Feb 2019
 18:38:31 +0000
From: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To: Catalin Marinas <Catalin.Marinas@arm.com>, Evgenii Stepanov
 <eugenis@google.com>
Subject: Re: [RFC][PATCH 0/3] arm64 relaxed ABI
Thread-Topic: [RFC][PATCH 0/3] arm64 relaxed ABI
Thread-Index: AQHUyFD8LSHMwEYo7kaikjJNt8xTtqXnc/kA
Date: Tue, 19 Feb 2019 18:38:31 +0000
Message-ID: <ac8f4e3b-84b8-6067-6a7a-fac7dc48daea@arm.com>
References: <cover.1544445454.git.andreyknvl@google.com>
 <20181210143044.12714-1-vincenzo.frascino@arm.com>
 <CAAeHK+xPZ-Z9YUAq=3+hbjj4uyJk32qVaxZkhcSAHYC4mHAkvQ@mail.gmail.com>
 <20181212150230.GH65138@arrakis.emea.arm.com>
 <CAAeHK+zxYJDJ7DJuDAOuOMgGvckFwMAoVUTDJzb6MX3WsXhRTQ@mail.gmail.com>
 <20181218175938.GD20197@arrakis.emea.arm.com>
 <20181219125249.GB22067@e103592.cambridge.arm.com>
 <9bbacb1b-6237-f0bb-9bec-b4cf8d42bfc5@arm.com>
 <CAFKCwrhH5R3e5ntX0t-gxcE6zzbCNm06pzeFfYEN2K13c5WLTg@mail.gmail.com>
 <20190212180223.GD199333@arrakis.emea.arm.com>
In-Reply-To: <20190212180223.GD199333@arrakis.emea.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LO2P265CA0412.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::16) To DB7PR08MB4217.eurprd08.prod.outlook.com
 (2603:10a6:10:7d::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3accbe23-3152-4a43-2dba-08d69699721d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB7PR08MB3484; 
x-ms-traffictypediagnostic: DB7PR08MB3484:
nodisclaimer: True
x-microsoft-exchange-diagnostics: 1; DB7PR08MB3484;
 20:9Bej0nFFovYFcJcFVUiuDiv//aiNT46KfwhUSVSDIWQxMykDduOqsJ3i+UND2FX24/2chMACX/g7qc5761SVnrrQQZ4PJNMBu9W9JiCDp58ekIb+e8mwcWnWg+2hvVBhJ4mLYiBDCzRW8HDCnMxaj85TLv+OiMWqOGKXGfH57NM=
x-microsoft-antispam-prvs: <DB7PR08MB34848F48BEF9C64FA1D148DCED7C0@DB7PR08MB3484.eurprd08.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(39860400002)(366004)(346002)(376002)(396003)(136003)(199004)(189003)(478600001)(14454004)(3846002)(65826007)(106356001)(25786009)(105586002)(2906002)(68736007)(6116002)(7416002)(26005)(5660300002)(8936002)(6506007)(386003)(14444005)(186003)(72206003)(256004)(102836004)(30864003)(64126003)(6486002)(53546011)(229853002)(446003)(93886005)(97736004)(44832011)(11346002)(476003)(2616005)(81166006)(81156014)(8676002)(76176011)(305945005)(66066001)(52116002)(486006)(7736002)(110136005)(58126008)(65956001)(316002)(561944003)(65806001)(36756003)(6436002)(54906003)(99286004)(4326008)(31696002)(6512007)(31686004)(53936002)(71200400001)(6246003)(71190400001)(86362001)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR08MB3484;
 H:DB7PR08MB4217.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yjk0JL+f75i8Kv65h6t96hFo+Cupa6OpgM+2BIGOMYiS12A7BkuGNukrKdPxyZ6A/3rmxsKRZIEVvEJQRiFJVl3Hf9jKOJo9wSZm6E3taCoooiBC+qY1kwU7lb0vLngJIhfY6+yGVq1hi1/6i9ShywBU50n0ZaXRbQjN4jPIO30ZpmZkqGx7Txnp4uw2ujos9GVPb7zkHwiVtPifPmTGNFrZG9LwLF1YutINiIbOZns7sNGTmCHgUXfc8UpEJnb0xhm0BH/zi0C6cP90eMDeZ2m0yGCI332kO25dXzQybRrvr0lq8FwJSiSHsmJJpwtE/bT27A8LXYx7juwKZJHJSGtj8u2Lz+8RH5VDeCsD6SRKmIFVhwubBsy5+IUIjW+ADMhrP3l2Wg3k11AXjOnb2Xkm0KKaEdfd+HbBghuqGno=
Content-ID: <D09BD30AAA68A44CAF812C33404D843E@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3accbe23-3152-4a43-2dba-08d69699721d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 18:38:29.8254 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3484
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_103850_789131_D3356F73 
X-CRM114-Status: GOOD (  31.41  )
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
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Will Deacon <Will.Deacon@arm.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Chintan Pandya <cpandya@codeaurora.org>,
 Vincenzo Frascino <Vincenzo.Frascino@arm.com>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
 Jacob Bramley <Jacob.Bramley@arm.com>, Dmitry Vyukov <dvyukov@google.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Dave P Martin <Dave.Martin@arm.com>, Kees Cook <keescook@chromium.org>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Andrey Konovalov <andreyknvl@google.com>,
 Kevin Brodsky <Kevin.Brodsky@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, nd <nd@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Kostya Serebryany <kcc@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Lee Smith <Lee.Smith@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Robin Murphy <Robin.Murphy@arm.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/02/2019 18:02, Catalin Marinas wrote:
> On Mon, Feb 11, 2019 at 12:32:55PM -0800, Evgenii Stepanov wrote:
>> On Mon, Feb 11, 2019 at 9:28 AM Kevin Brodsky <kevin.brodsky@arm.com> wrote:
>>> On 19/12/2018 12:52, Dave Martin wrote:
>>>> Really, the kernel should do the expected thing with all "non-weird"
>>>> memory.
>>>>
>>>> In lieu of a proper definition of "non-weird", I think we should have
>>>> some lists of things that are explicitly included, and also excluded:
>>>>
>>>> OK:
>>>>       kernel-allocated process stack
>>>>       brk area
>>>>       MAP_ANONYMOUS | MAP_PRIVATE
>>>>       MAP_PRIVATE mappings of /dev/zero
>>>>
>>>> Not OK:
>>>>       MAP_SHARED
>>>>       mmaps of non-memory-like devices
>>>>       mmaps of anything that is not a regular file
>>>>       the VDSO
>>>>       ...
>>>>
>>>> In general, userspace can tag memory that it "owns", and we do not assume
>>>> a transfer of ownership except in the "OK" list above.  Otherwise, it's
>>>> the kernel's memory, or the owner is simply not well defined.
>>>
>>> Agreed on the general idea: a process should be able to pass tagged pointers at the
>>> syscall interface, as long as they point to memory privately owned by the process. I
>>> think it would be possible to simplify the definition of "non-weird" memory by using
>>> only this "OK" list:
>>> - mmap() done by the process itself, where either:
>>>    * flags = MAP_PRIVATE | MAP_ANONYMOUS
>>>    * flags = MAP_PRIVATE and fd refers to a regular file or a well-defined list of
>>> device files (like /dev/zero)
>>> - brk() done by the process itself
>>> - Any memory mapped by the kernel in the new process's address space during execve(),
>>> with the same restrictions as above ([vdso]/[vvar] are therefore excluded)
> 
> Sounds reasonable.

OK. this non-weird memory definition works for me too.

rule 1: if weird memory pointers are passed to the kernel
with top byte set then the behaviour is undefined.

>>>>   * When the kernel dereferences a pointer on userspace's behalf, it
>>>>     shall behave equivalently to userspace dereferencing the same pointer,
>>>>     including use of the same tag (where passed by userspace).
>>>>
>>>>   * Where the pointer tag affects pointer dereference behaviour (i.e.,
>>>>     with hardware memory colouring) the kernel makes no guarantee to
>>>>     honour pointer tags correctly for every location a buffer based on a
>>>>     pointer passed by userspace to the kernel.
>>>>
>>>>     (This means for example that for a read(fd, buf, size), we can check
>>>>     the tag for a single arbitrary location in *(char (*)[size])buf
>>>>     before passing the buffer to get_user_pages().  Hopefully this could
>>>>     be done in get_user_pages() itself rather than hunting call sites.
>>>>     For userspace, it means that you're on your own if you ask the
>>>>     kernel to operate on a buffer than spans multiple, independently-
>>>>     allocated objects, or a deliberately striped single object.)
>>>
>>> I think both points are reasonable. It is very valuable for the kernel to access
>>> userspace memory using the user-provided tag, because it enables kernel accesses to
>>> be checked in the same way as user accesses, allowing to detect bugs that are
>>> potentially hard to find. For instance, if a pointer to an object is passed to the
>>> kernel after it has been deallocated, this is invalid and should be detected.
>>> However, you are absolutely right that the kernel cannot *guarantee* that such a
>>> check is carried out for the entire memory range (or in fact at all); it should be a
>>> best-effort approach.
>>
>> It would also be valuable to narrow down the set of "relaxed" (i.e.
>> not tag-checking) syscalls as reasonably possible. We would want to
>> provide tag-checking userspace wrappers for any important calls that
>> are not checked in the kernel. Is it correct to assume that anything
>> that goes through copy_from_user  / copy_to_user is checked?
> 
> I lost track of the context of this thread but if it's just about
> relaxing the ABI for hwasan, the kernel has no idea of the compiler
> generated structures in user space, so nothing is checked.
> 
> If we talk about tags in the context of MTE, than yes, with the current
> proposal the tag would be checked by copy_*_user() functions.

rule 2: kernel derefs as if user derefs when non-weird memory
pointers are passed to the kernel.

note that the important bit is what happens on valid pointer
derefs, invalid pointer deref is usually undefined for user
programs, so what happens in case of mte tag failures is
more of a QoI issue than abi i think.

(e.g. EFAULT is not guaranteed by the kernel currently, i can
successfully do write(open("/dev/null",O_WRONLY), 0, 1), or
get a crash when passing invalid pointer to a vdso function,
so userspace should not rely on some strict EFAULT behaviour).

>>>>   * The kernel shall not extend the lifetime of user pointers in ways
>>>>     that are not clear from the specification of the syscall or
>>>>     interface to which the pointer is passed (and in any case shall not
>>>>     extend pointer lifetimes without good reason).
>>>>
>>>>     So no clever transparent caching between syscalls, unless it _really_
>>>>     is transparent in the presence of tags.
>>>
>>> Do you have any particular case in mind? If such caching is really valuable, it is
>>> always possible to access the object while ignoring the tag. For sure, the
>>> user-provided tag can only be used during the syscall handling itself, not
>>> asynchronously later on, unless otherwise specified.
>>
>> For aio* operations it would be nice if the tag was checked at the
>> time of the actual userspace read/write, either instead of or in
>> addition to at the time of the system call.
> 
> With aio* (and synchronous iovec-based syscalls), the kernel may access
> the memory while the corresponding user process is scheduled out. Given
> that such access is not done in the context of the user process (and
> using the user VA like copy_*_user), the kernel cannot handle potential
> tag faults. Moreover, the transfer may be done by DMA and the device
> does not understand tags.
> 
> I'd like to keep tags as a property of the pointer in a specific virtual
> address space. The moment you convert it to a different address space
> (e.g. kernel linear map, physical address), the tag property is stripped
> and I don't think we should re-build it (and have it checked).

OK.

i don't think the new abi needs special rules about
pointer lifetime.

>>>>   * For purposes other than dereference, the kernel shall accept any
>>>>     legitimately tagged pointer (according to the above rules) as
>>>>     identifying the associated memory location.
>>>>
>>>>     So, mprotect(some_page_aligned_object, ...); is valid irrespective
>>>>     of where page_aligned_object() came from.  There is no implicit
>>>>     derefence by the kernel here, hence no tag check.
>>>>
>>>>     The kernel does not guarantee to work correctly if the wrong tag
>>>>     is used, but there is not always a well-defined "right" tag, so
>>>>     we can't really guarantee to check it.  So a pointer derived by
>>>>     any reasonable means by userspace has to be treated as equally
>>>>     valid.
>>>
>>> This is a disputed point :) In my opinion, this is the the most reasonable approach.
>>
>> Yes, it would be nice if the kernel explicitly promised, ex.
>> mprotect() over a range of differently tagged pages to be allowed
>> (i.e. address tag should be unchecked).
> 
> I don't think mprotect() over differently tagged pages was ever a
> problem. I originally asked that mprotect() and friends do not accept
> tagged pointers since these functions deal with memory ranges rather
> than dereferencing such pointer (the reason being minimal kernel
> changes). However, given how complicated it is to specify an ABI, I came
> to the conclusion that a pointer passed to such function should be
> allowed to have non-zero top byte. It would be the kernel's
> responsibility to strip it out as appropriate.

OK.

rule 3: kernel accepts legitimately tagged non-weird memory
pointers and untags them before usage other than deref.

this is relevant if a syscall uses pointers for address range
specification, instead of deref. (mprotect, madvise,...)

i also propose:

rule 4: kernel keeps legitimate tags on non-weird memory
pointers that it returns to the user.

e.g. clone passes stack/arg/tls pointers on without dropping
tags, same for set/get_robust_list. i'm not sure if there
are pointer values observable in /proc etc but those should
keep tags too.

"legitimately tagged" may not always be obvious, but the
illegitimately tagged case can be left unspecified i think,
so dropping tags is ok, but not required if tbi is off and
mte is not used (i.e. tag is illegitimate).

i think these rules work for the cases i care about, a more
tricky question is when/how to check for the new syscall abi
and when/how the TCR_EL1.TBI0 setting may be turned off.
consider the following cases (tb == top byte):

binary 1: user tb = any, syscall tb = 0
  tbi is on, "legacy binary"

binary 2: user tb = any, syscall tb = any
  tbi is on, "new binary using tb"
  for backward compat it needs to check for new syscall abi.

binary 3: user tb = 0, syscall tb = 0
  tbi can be off, "new binary",
  binary is marked to indicate unused tb,
  kernel may turn tbi off: additional pac bits.

binary 4: user tb = mte, syscall tb = mte
  like binary 3, but with mte, "new binary using mte"
  does it have to check for new syscall abi?
  or MTE HWCAP would imply it?
  (is it possible to use mte without new syscall abi?)

in userspace we want most binaries to be like binary 3 and 4
eventually, i.e. marked as not-relying-on-tbi, if a dso is
loaded that is unmarked (legacy or new tb user), then either
the load fails (e.g. if mte is already used? or can we turn
mte off at runtime?) or tbi has to be enabled (prctl? does
this work with pac? or multi-threads?).

as for checking the new syscall abi: i don't see much semantic
difference between AT_HWCAP and AT_FLAGS (either way, the user
has to check a feature flag before using the feature of the
underlying system and it does not matter much if it's a syscall
abi feature or cpu feature), but i don't see anything wrong
with AT_FLAGS if the kernel prefers that.

the discussion here was mostly about binary 2, but for
me the open question is if we can make binary 3/4 work.
(which requires some elf binary marking, that is recognised
by the kernel and dynamic loader, and efficient handling of
the TBI0 bit, ..if it's not possible, then i don't see how
mte will be deployed).

and i guess on the kernel side the open question is if the
rules 1/2/3/4 can be made to work in corner cases e.g. when
pointers embedded into structs are passed down in ioctl.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
