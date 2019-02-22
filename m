Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F10C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:10:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 471A020823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lDtBBv1v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="K0XGkZ+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 471A020823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DimuaiAe3iod1ZciTjp5M8zYUQxMEG89KDPPL8ZgKF0=; b=lDtBBv1vEVCbYz
	T32PwrAs4vHkyCIvEotXTTJjHSR8T2VmvDMqXue05URMY2h47fmjhq/3uB2EDS1pONbOV3XvF6aO0
	b8JXsMeyM/FLppdF0oxcZMMFbjTgBYdBuvChpCh1OqdCc16C+gs+5OO/RKkl8QXH0N3HQqQTUDTpq
	FYZuiHEzU8ANhDnRTZF2FzlPg0Sg4aY2x0CyIP1sfyM6hE70+xRTQGt4T/C+JMGxBSUI37ZZn8yiR
	egf4hnHd8SQeKvB8hKsv0P1HZePwvGybxZD1wrK1ds9l1Nds/w76x5ecKUwADmZFE8WWiP9/MiVo1
	Kynu111LNG4Ktm22kyyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxDPI-00028R-NI; Fri, 22 Feb 2019 16:10:36 +0000
Received: from mail-eopbgr10044.outbound.protection.outlook.com ([40.107.1.44]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxDPE-00027v-8g
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 16:10:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwbmA6QUpC/PUB8yG4wMDwColQTEWt5sncKQ3NY5zp4=;
 b=K0XGkZ+AjjOSb4B6zIzrDhtxYmjGYNqKJb+MwySr1SWzrDNQdqFqufOvucPfWgxHvW/7UUFGG+A+NMDsIBontRENA31xnCXoAu9Y7thE+XMW0Z2KdGlqQgpRut+mE9qgPflKPYCyRMq8ORgd4FAGTeWYp4L8faOOY8Ec4x9pkJg=
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com (20.178.13.96) by
 VI1PR08MB4509.eurprd08.prod.outlook.com (20.179.27.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Fri, 22 Feb 2019 16:10:27 +0000
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::896c:c125:b2a3:2f52]) by VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::896c:c125:b2a3:2f52%6]) with mapi id 15.20.1622.021; Fri, 22 Feb 2019
 16:10:27 +0000
From: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v10 00/12] arm64: untag user pointers passed to the kernel
Thread-Topic: [PATCH v10 00/12] arm64: untag user pointers passed to the kernel
Thread-Index: AQHUyq2dD9o2nPb5w0GtvSKm/T3roaXr8zMAgAABaYCAAAg+gA==
Date: Fri, 22 Feb 2019 16:10:26 +0000
Message-ID: <96d1086c-ca82-d6d7-24c3-f6686d98d47a@arm.com>
References: <cover.1550839937.git.andreyknvl@google.com>
 <464111f3-e255-ad45-8964-58462d889e6f@arm.com>
 <CAAeHK+wCZK7F7T1k+Kg_HkK47J8R9ugtH1g1ciLYH_KJ22ZVjg@mail.gmail.com>
In-Reply-To: <CAAeHK+wCZK7F7T1k+Kg_HkK47J8R9ugtH1g1ciLYH_KJ22ZVjg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LO2P265CA0341.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::17) To VI1PR08MB4223.eurprd08.prod.outlook.com
 (2603:10a6:803:b5::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb16ba33-564f-43dc-10fc-08d698e041f3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR08MB4509; 
x-ms-traffictypediagnostic: VI1PR08MB4509:
x-ms-exchange-purlcount: 4
nodisclaimer: True
x-microsoft-exchange-diagnostics: 1; VI1PR08MB4509;
 20:JJ4KaMrCn5E6kxQBBr5uk88p0VWFA98UWb1OkobAMJW0dTHaTZ9iZm5Jc7sNivDMC3Hc410wXoDNxTHfwFt2w7qzNCiu78U0isfK98HINjcbCkszm1bvONP208ZgbTEP34B74bk2f6MTiyAURnsZ3+pGu/UyeEqrDswRrNVw5LM=
x-microsoft-antispam-prvs: <VI1PR08MB4509A42EC0E26A982E197BDCED7F0@VI1PR08MB4509.eurprd08.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(366004)(376002)(136003)(346002)(43544003)(199004)(189003)(36756003)(72206003)(44832011)(2906002)(26005)(476003)(316002)(229853002)(71200400001)(58126008)(6246003)(446003)(64126003)(2616005)(86362001)(486006)(5660300002)(966005)(6486002)(11346002)(31696002)(186003)(14444005)(71190400001)(256004)(54906003)(478600001)(6436002)(4326008)(6116002)(102836004)(65956001)(66066001)(386003)(53936002)(6306002)(65806001)(6512007)(6506007)(53546011)(305945005)(31686004)(6916009)(52116002)(3846002)(68736007)(81166006)(99286004)(8936002)(7736002)(106356001)(8676002)(25786009)(97736004)(105586002)(14454004)(81156014)(7416002)(65826007)(76176011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR08MB4509;
 H:VI1PR08MB4223.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S/7jbC9DALl99ZEkV/L8rHSikTvMX3uMx8qMcI8I+JyTPUlt/8shz9XEAFtbvp/OLp0gDyFgLrO08Q3W6fRV4ZYbNHwUyBscDQdOPegGQFO8J/L4hbSU7mQGJ18RfD6CKHBaQcg2HmrW+mJobexFWo7LbQO3BU2vfIF1XXEUNTDPLuiJAdka689a7Pc4Tt6Ep8tBrWuC4EGogDRkzVGH+qcqPnqnrCIf90SKJpOb+ghLNnKgpJPLcS2GzKp6DyH7nL4z9oOre5OUVE6W8F8fPwzt9UEILGJDc0Vc/6RDwsKVtIEJmy1VQxKRb7/0g4dUH+FOe5oWJP85Vq4pASs2M1vQkiZ9lbtny6bRy2plt/pSwQKVT440qDwruP0q3+qXcgGDOdiy4cFSKykiB1Wp+D48Nk6dmmvq+T8vzaa/jis=
Content-ID: <377964F0ADA85C4DA3F27A0A85288B86@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb16ba33-564f-43dc-10fc-08d698e041f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 16:10:25.5891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4509
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_081032_481066_4B5E14B6 
X-CRM114-Status: GOOD (  23.53  )
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
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 Chintan Pandya <cpandya@codeaurora.org>,
 Vincenzo Frascino <Vincenzo.Frascino@arm.com>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Jacob Bramley <Jacob.Bramley@arm.com>, Dmitry Vyukov <dvyukov@google.com>,
 Dave P Martin <Dave.Martin@arm.com>, Evgeniy Stepanov <eugenis@google.com>,
 Kevin Brodsky <Kevin.Brodsky@arm.com>, Kees Cook <keescook@chromium.org>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, nd <nd@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Kostya Serebryany <kcc@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Lee Smith <Lee.Smith@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Robin Murphy <Robin.Murphy@arm.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 22/02/2019 15:40, Andrey Konovalov wrote:
> On Fri, Feb 22, 2019 at 4:35 PM Szabolcs Nagy <Szabolcs.Nagy@arm.com> wrote:
>>
>> On 22/02/2019 12:53, Andrey Konovalov wrote:
>>> This patchset is meant to be merged together with "arm64 relaxed ABI" [1].
>>>
>>> arm64 has a feature called Top Byte Ignore, which allows to embed pointer
>>> tags into the top byte of each pointer. Userspace programs (such as
>>> HWASan, a memory debugging tool [2]) might use this feature and pass
>>> tagged user pointers to the kernel through syscalls or other interfaces.
>>>
>>> Right now the kernel is already able to handle user faults with tagged
>>> pointers, due to these patches:
>>>
>>> 1. 81cddd65 ("arm64: traps: fix userspace cache maintenance emulation on a
>>>              tagged pointer")
>>> 2. 7dcd9dd8 ("arm64: hw_breakpoint: fix watchpoint matching for tagged
>>>             pointers")
>>> 3. 276e9327 ("arm64: entry: improve data abort handling of tagged
>>>             pointers")
>>>
>>> This patchset extends tagged pointer support to syscall arguments.
>>>
>>> For non-memory syscalls this is done by untaging user pointers when the
>>> kernel performs pointer checking to find out whether the pointer comes
>>> from userspace (most notably in access_ok). The untagging is done only
>>> when the pointer is being checked, the tag is preserved as the pointer
>>> makes its way through the kernel.
>>>
>>> Since memory syscalls (mmap, mprotect, etc.) don't do memory accesses but
>>> rather deal with memory ranges, untagged pointers are better suited to
>>> describe memory ranges internally. Thus for memory syscalls we untag
>>> pointers completely when they enter the kernel.
>>
>> i think the same is true when user pointers are compared.
>>
>> e.g. i suspect there may be issues with tagged robust mutex
>> list pointers because the kernel does
>>
>> futex.c:3541:   while (entry != &head->list) {
>>
>> where entry is a user pointer that may be tagged, and
>> &head->list is probably not tagged.
> 
> You're right. I'll expand the cover letter in the next version to
> describe this more accurately. The patchset however contains "mm,
> arm64: untag user pointers in mm/gup.c" that should take care of futex
> pointers.

the robust mutex list pointer is not a futex pointer,
i'm not sure how the mm/gup.c patch helps.

>>
>>> One of the alternative approaches to untagging that was considered is to
>>> completely strip the pointer tag as the pointer enters the kernel with
>>> some kind of a syscall wrapper, but that won't work with the countless
>>> number of different ioctl calls. With this approach we would need a custom
>>> wrapper for each ioctl variation, which doesn't seem practical.
>>>
>>> The following testing approaches has been taken to find potential issues
>>> with user pointer untagging:
>>>
>>> 1. Static testing (with sparse [3] and separately with a custom static
>>>    analyzer based on Clang) to track casts of __user pointers to integer
>>>    types to find places where untagging needs to be done.
>>>
>>> 2. Static testing with grep to find parts of the kernel that call
>>>    find_vma() (and other similar functions) or directly compare against
>>>    vm_start/vm_end fields of vma.
>>>
>>> 3. Static testing with grep to find parts of the kernel that compare
>>>    user pointers with TASK_SIZE or other similar consts and macros.
>>>
>>> 4. Dynamic testing: adding BUG_ON(has_tag(addr)) to find_vma() and running
>>>    a modified syzkaller version that passes tagged pointers to the kernel.
>>>
>>> Based on the results of the testing the requried patches have been added
>>> to the patchset.
>>>
>>> This patchset has been merged into the Pixel 2 kernel tree and is now
>>> being used to enable testing of Pixel 2 phones with HWASan.
>>>
>>> This patchset is a prerequisite for ARM's memory tagging hardware feature
>>> support [4].
>>>
>>> Thanks!
>>>
>>> [1] https://lkml.org/lkml/2018/12/10/402
>>>
>>> [2] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html
>>>
>>> [3] https://github.com/lucvoo/sparse-dev/commit/5f960cb10f56ec2017c128ef9d16060e0145f292
>>>
>>> [4] https://community.arm.com/processors/b/blog/posts/arm-a-profile-architecture-2018-developments-armv85a
>>>
>>> Changes in v10:
>>> - Added "mm, arm64: untag user pointers passed to memory syscalls" back.
>>> - New patch "fs, arm64: untag user pointers in fs/userfaultfd.c".
>>> - New patch "net, arm64: untag user pointers in tcp_zerocopy_receive".
>>> - New patch "kernel, arm64: untag user pointers in prctl_set_mm*".
>>> - New patch "tracing, arm64: untag user pointers in seq_print_user_ip".
>>>
>>> Changes in v9:
>>> - Rebased onto 4.20-rc6.
>>> - Used u64 instead of __u64 in type casts in the untagged_addr macro for
>>>   arm64.
>>> - Added braces around (addr) in the untagged_addr macro for other arches.
>>>
>>> Changes in v8:
>>> - Rebased onto 65102238 (4.20-rc1).
>>> - Added a note to the cover letter on why syscall wrappers/shims that untag
>>>   user pointers won't work.
>>> - Added a note to the cover letter that this patchset has been merged into
>>>   the Pixel 2 kernel tree.
>>> - Documentation fixes, in particular added a list of syscalls that don't
>>>   support tagged user pointers.
>>>
>>> Changes in v7:
>>> - Rebased onto 17b57b18 (4.19-rc6).
>>> - Dropped the "arm64: untag user address in __do_user_fault" patch, since
>>>   the existing patches already handle user faults properly.
>>> - Dropped the "usb, arm64: untag user addresses in devio" patch, since the
>>>   passed pointer must come from a vma and therefore be untagged.
>>> - Dropped the "arm64: annotate user pointers casts detected by sparse"
>>>   patch (see the discussion to the replies of the v6 of this patchset).
>>> - Added more context to the cover letter.
>>> - Updated Documentation/arm64/tagged-pointers.txt.
>>>
>>> Changes in v6:
>>> - Added annotations for user pointer casts found by sparse.
>>> - Rebased onto 050cdc6c (4.19-rc1+).
>>>
>>> Changes in v5:
>>> - Added 3 new patches that add untagging to places found with static
>>>   analysis.
>>> - Rebased onto 44c929e1 (4.18-rc8).
>>>
>>> Changes in v4:
>>> - Added a selftest for checking that passing tagged pointers to the
>>>   kernel succeeds.
>>> - Rebased onto 81e97f013 (4.18-rc1+).
>>>
>>> Changes in v3:
>>> - Rebased onto e5c51f30 (4.17-rc6+).
>>> - Added linux-arch@ to the list of recipients.
>>>
>>> Changes in v2:
>>> - Rebased onto 2d618bdf (4.17-rc3+).
>>> - Removed excessive untagging in gup.c.
>>> - Removed untagging pointers returned from __uaccess_mask_ptr.
>>>
>>> Changes in v1:
>>> - Rebased onto 4.17-rc1.
>>>
>>> Changes in RFC v2:
>>> - Added "#ifndef untagged_addr..." fallback in linux/uaccess.h instead of
>>>   defining it for each arch individually.
>>> - Updated Documentation/arm64/tagged-pointers.txt.
>>> - Dropped "mm, arm64: untag user addresses in memory syscalls".
>>> - Rebased onto 3eb2ce82 (4.16-rc7).
>>>
>>> Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>>>
>>> Andrey Konovalov (12):
>>>   uaccess: add untagged_addr definition for other arches
>>>   arm64: untag user pointers in access_ok and __uaccess_mask_ptr
>>>   lib, arm64: untag user pointers in strn*_user
>>>   mm, arm64: untag user pointers passed to memory syscalls
>>>   mm, arm64: untag user pointers in mm/gup.c
>>>   fs, arm64: untag user pointers in copy_mount_options
>>>   fs, arm64: untag user pointers in fs/userfaultfd.c
>>>   net, arm64: untag user pointers in tcp_zerocopy_receive
>>>   kernel, arm64: untag user pointers in prctl_set_mm*
>>>   tracing, arm64: untag user pointers in seq_print_user_ip
>>>   arm64: update Documentation/arm64/tagged-pointers.txt
>>>   selftests, arm64: add a selftest for passing tagged pointers to kernel
>>>
>>>  Documentation/arm64/tagged-pointers.txt       | 25 +++++++++++--------
>>>  arch/arm64/include/asm/uaccess.h              | 10 +++++---
>>>  fs/namespace.c                                |  2 +-
>>>  fs/userfaultfd.c                              |  5 ++++
>>>  include/linux/memory.h                        |  4 +++
>>>  ipc/shm.c                                     |  2 ++
>>>  kernel/sys.c                                  | 14 +++++++++++
>>>  kernel/trace/trace_output.c                   |  2 +-
>>>  lib/strncpy_from_user.c                       |  2 ++
>>>  lib/strnlen_user.c                            |  2 ++
>>>  mm/gup.c                                      |  4 +++
>>>  mm/madvise.c                                  |  2 ++
>>>  mm/mempolicy.c                                |  5 ++++
>>>  mm/migrate.c                                  |  1 +
>>>  mm/mincore.c                                  |  2 ++
>>>  mm/mlock.c                                    |  5 ++++
>>>  mm/mmap.c                                     |  7 ++++++
>>>  mm/mprotect.c                                 |  2 ++
>>>  mm/mremap.c                                   |  2 ++
>>>  mm/msync.c                                    |  2 ++
>>>  net/ipv4/tcp.c                                |  2 ++
>>>  tools/testing/selftests/arm64/.gitignore      |  1 +
>>>  tools/testing/selftests/arm64/Makefile        | 11 ++++++++
>>>  .../testing/selftests/arm64/run_tags_test.sh  | 12 +++++++++
>>>  tools/testing/selftests/arm64/tags_test.c     | 19 ++++++++++++++
>>>  25 files changed, 129 insertions(+), 16 deletions(-)
>>>  create mode 100644 tools/testing/selftests/arm64/.gitignore
>>>  create mode 100644 tools/testing/selftests/arm64/Makefile
>>>  create mode 100755 tools/testing/selftests/arm64/run_tags_test.sh
>>>  create mode 100644 tools/testing/selftests/arm64/tags_test.c
>>>
>>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
