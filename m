Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF25CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:36:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A74420700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K0n1nIwa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="gIEpWEKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A74420700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zQ9374vGHw7/joUzC2IS7X766nedD8TeUJAcusPyed8=; b=K0n1nIwa2IHqd4
	eGkFU40D9ftpgL+iC/qGkhShWYFJseEsZ9KJXTGn+zGF1C5UXqfroZPhzYwvN2rtk8DXEulwIh483
	H333VjQLkK74oCuWQNgu4jNG7r7b+BlEHvxRBiBODChyI6fj7wBdXBAxAucfnztcfvlzW0YYNnktD
	PYfxRHwUP66PHN8xuQmdNjDCYOFsR+8mX3br6sVFYnglhhqDe9HV14E58XGOOPsfyanDI54axCOIA
	XAfdb70GEgohvaxXVQQa6Rie4dtJG7xrNSDg++rxWt+6pUn4R7lNhX9SATwbNf0U457jqMMZL6cD2
	iYH6FN4M2HrxZ+hW7TWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxCro-0005gH-CO; Fri, 22 Feb 2019 15:36:00 +0000
Received: from mail-eopbgr150047.outbound.protection.outlook.com
 ([40.107.15.47] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxCrk-0005f0-2i
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 15:35:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdAwO8uIP3NsdKEhCOqpTRThOTeSWorKOvbckf1ho+0=;
 b=gIEpWEKb6ylZNyX+FlBWEQy0yqhR+UAN8jOIjhqJvVDlAO5GUtN398kkuAIQCtIuK+EZ4MWUHICdiJn8/aSKb+FZ1iC75nLEEtmgbW6xDmPdAvs6YUZBD/PPxnxy1GVciNycpV2bTW1nxnpyhcQwKxxYlmnaE+xYFY3tahlVQ60=
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com (20.178.13.96) by
 VI1PR08MB0766.eurprd08.prod.outlook.com (10.164.93.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Fri, 22 Feb 2019 15:35:49 +0000
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::896c:c125:b2a3:2f52]) by VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::896c:c125:b2a3:2f52%6]) with mapi id 15.20.1622.021; Fri, 22 Feb 2019
 15:35:49 +0000
From: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To: Andrey Konovalov <andreyknvl@google.com>, Catalin Marinas
 <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Mark Rutland
 <Mark.Rutland@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, Kees Cook
 <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A .
 Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>,
 Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 00/12] arm64: untag user pointers passed to the kernel
Thread-Topic: [PATCH v10 00/12] arm64: untag user pointers passed to the kernel
Thread-Index: AQHUyq2dD9o2nPb5w0GtvSKm/T3roaXr8zMA
Date: Fri, 22 Feb 2019 15:35:48 +0000
Message-ID: <464111f3-e255-ad45-8964-58462d889e6f@arm.com>
References: <cover.1550839937.git.andreyknvl@google.com>
In-Reply-To: <cover.1550839937.git.andreyknvl@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LO2P265CA0475.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::31) To VI1PR08MB4223.eurprd08.prod.outlook.com
 (2603:10a6:803:b5::32)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4cba8019-b5cd-4f9e-970b-08d698db6b5d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR08MB0766; 
x-ms-traffictypediagnostic: VI1PR08MB0766:
x-ms-exchange-purlcount: 4
nodisclaimer: True
x-microsoft-exchange-diagnostics: 1; VI1PR08MB0766;
 20:cv68ELb5zWfc7mF+5WNJGa1kPyWGLYlzb8YDz4e6l82XcMG8kPaYg5indr1tl9Ixh0kiGJ06J6jNTN1E1lj2ZL6oW1APkshgV5iyBLs03jMTmbELiGgcZI9SmFNeN6RBV0s+UJ91iZXGdaVdeLhXFzIA2MscfJn40WlwI5sOW1A=
x-microsoft-antispam-prvs: <VI1PR08MB076666D747E327A913BD48B0ED7F0@VI1PR08MB0766.eurprd08.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(366004)(376002)(346002)(136003)(199004)(189003)(58126008)(2501003)(81156014)(54906003)(14444005)(81166006)(8676002)(256004)(4326008)(5660300002)(3846002)(386003)(6346003)(26005)(6506007)(53546011)(102836004)(6116002)(8936002)(71190400001)(65956001)(66066001)(966005)(65806001)(71200400001)(31696002)(86362001)(6246003)(2201001)(76176011)(316002)(14454004)(186003)(110136005)(25786009)(7416002)(11346002)(52116002)(65826007)(486006)(476003)(2616005)(72206003)(478600001)(97736004)(2906002)(44832011)(53936002)(446003)(31686004)(99286004)(105586002)(6512007)(64126003)(6486002)(305945005)(106356001)(7736002)(68736007)(229853002)(36756003)(6306002)(6436002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR08MB0766;
 H:VI1PR08MB4223.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HG3IjifQ3jFx0wQuui5wy+3URNR7OBWcojov90KtaTDGjxHppstPuy37VxowuOSoQ8ge+1OK52IrKk2No9z4rz8F0GNrP4MP2yTPOy9F2sreE1nMPpiIYU4vxIhn/3bdhL7RqauJw35Qv8MwQUvB9aF+KA8YlZHtfOp7YTNBwv2mRWVIrKIEeVyDLur1YCRsD8uOAyzhUHUOSo+lWVlWYmma6BH24OQZvYKQGZNRqfFMDDL3euBuTf0j8DgVPWZboG48Z3V8xBt2XfcdH/9frjwIb8xED2sF9RjuO9xhlWvAcU9mK+0vj/5J26AwL914u+jjCqcbxgNZqCX0io8uL9VEysQ3IOhIDR35XTpp1Ukw7dKuqQ3KFpE12McbvAbd+OoLvXXsXVIAqfiL9yrvTcpmizEatpem/lL6zGzP0hg=
Content-ID: <E07F0DA7F425EE419E984E8B46948B43@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cba8019-b5cd-4f9e-970b-08d698db6b5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 15:35:47.2379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB0766
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_073556_547352_6037034A 
X-CRM114-Status: GOOD (  29.82  )
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
Cc: Kevin Brodsky <Kevin.Brodsky@arm.com>,
 Chintan Pandya <cpandya@codeaurora.org>, Jacob Bramley <Jacob.Bramley@arm.com>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Lee Smith <Lee.Smith@arm.com>,
 Kostya Serebryany <kcc@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, nd <nd@arm.com>,
 Dave P Martin <Dave.Martin@arm.com>, Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 22/02/2019 12:53, Andrey Konovalov wrote:
> This patchset is meant to be merged together with "arm64 relaxed ABI" [1].
> 
> arm64 has a feature called Top Byte Ignore, which allows to embed pointer
> tags into the top byte of each pointer. Userspace programs (such as
> HWASan, a memory debugging tool [2]) might use this feature and pass
> tagged user pointers to the kernel through syscalls or other interfaces.
> 
> Right now the kernel is already able to handle user faults with tagged
> pointers, due to these patches:
> 
> 1. 81cddd65 ("arm64: traps: fix userspace cache maintenance emulation on a
>              tagged pointer")
> 2. 7dcd9dd8 ("arm64: hw_breakpoint: fix watchpoint matching for tagged
> 	      pointers")
> 3. 276e9327 ("arm64: entry: improve data abort handling of tagged
> 	      pointers")
> 
> This patchset extends tagged pointer support to syscall arguments.
> 
> For non-memory syscalls this is done by untaging user pointers when the
> kernel performs pointer checking to find out whether the pointer comes
> from userspace (most notably in access_ok). The untagging is done only
> when the pointer is being checked, the tag is preserved as the pointer
> makes its way through the kernel.
> 
> Since memory syscalls (mmap, mprotect, etc.) don't do memory accesses but
> rather deal with memory ranges, untagged pointers are better suited to
> describe memory ranges internally. Thus for memory syscalls we untag
> pointers completely when they enter the kernel.

i think the same is true when user pointers are compared.

e.g. i suspect there may be issues with tagged robust mutex
list pointers because the kernel does

futex.c:3541:	while (entry != &head->list) {

where entry is a user pointer that may be tagged, and
&head->list is probably not tagged.

> One of the alternative approaches to untagging that was considered is to
> completely strip the pointer tag as the pointer enters the kernel with
> some kind of a syscall wrapper, but that won't work with the countless
> number of different ioctl calls. With this approach we would need a custom
> wrapper for each ioctl variation, which doesn't seem practical.
> 
> The following testing approaches has been taken to find potential issues
> with user pointer untagging:
> 
> 1. Static testing (with sparse [3] and separately with a custom static
>    analyzer based on Clang) to track casts of __user pointers to integer
>    types to find places where untagging needs to be done.
> 
> 2. Static testing with grep to find parts of the kernel that call
>    find_vma() (and other similar functions) or directly compare against
>    vm_start/vm_end fields of vma.
> 
> 3. Static testing with grep to find parts of the kernel that compare
>    user pointers with TASK_SIZE or other similar consts and macros.
> 
> 4. Dynamic testing: adding BUG_ON(has_tag(addr)) to find_vma() and running
>    a modified syzkaller version that passes tagged pointers to the kernel.
> 
> Based on the results of the testing the requried patches have been added
> to the patchset.
> 
> This patchset has been merged into the Pixel 2 kernel tree and is now
> being used to enable testing of Pixel 2 phones with HWASan.
> 
> This patchset is a prerequisite for ARM's memory tagging hardware feature
> support [4].
> 
> Thanks!
> 
> [1] https://lkml.org/lkml/2018/12/10/402
> 
> [2] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html
> 
> [3] https://github.com/lucvoo/sparse-dev/commit/5f960cb10f56ec2017c128ef9d16060e0145f292
> 
> [4] https://community.arm.com/processors/b/blog/posts/arm-a-profile-architecture-2018-developments-armv85a
> 
> Changes in v10:
> - Added "mm, arm64: untag user pointers passed to memory syscalls" back.
> - New patch "fs, arm64: untag user pointers in fs/userfaultfd.c".
> - New patch "net, arm64: untag user pointers in tcp_zerocopy_receive".
> - New patch "kernel, arm64: untag user pointers in prctl_set_mm*".
> - New patch "tracing, arm64: untag user pointers in seq_print_user_ip".
> 
> Changes in v9:
> - Rebased onto 4.20-rc6.
> - Used u64 instead of __u64 in type casts in the untagged_addr macro for
>   arm64.
> - Added braces around (addr) in the untagged_addr macro for other arches.
> 
> Changes in v8:
> - Rebased onto 65102238 (4.20-rc1).
> - Added a note to the cover letter on why syscall wrappers/shims that untag
>   user pointers won't work.
> - Added a note to the cover letter that this patchset has been merged into
>   the Pixel 2 kernel tree.
> - Documentation fixes, in particular added a list of syscalls that don't
>   support tagged user pointers.
> 
> Changes in v7:
> - Rebased onto 17b57b18 (4.19-rc6).
> - Dropped the "arm64: untag user address in __do_user_fault" patch, since
>   the existing patches already handle user faults properly.
> - Dropped the "usb, arm64: untag user addresses in devio" patch, since the
>   passed pointer must come from a vma and therefore be untagged.
> - Dropped the "arm64: annotate user pointers casts detected by sparse"
>   patch (see the discussion to the replies of the v6 of this patchset).
> - Added more context to the cover letter.
> - Updated Documentation/arm64/tagged-pointers.txt.
> 
> Changes in v6:
> - Added annotations for user pointer casts found by sparse.
> - Rebased onto 050cdc6c (4.19-rc1+).
> 
> Changes in v5:
> - Added 3 new patches that add untagging to places found with static
>   analysis.
> - Rebased onto 44c929e1 (4.18-rc8).
> 
> Changes in v4:
> - Added a selftest for checking that passing tagged pointers to the
>   kernel succeeds.
> - Rebased onto 81e97f013 (4.18-rc1+).
> 
> Changes in v3:
> - Rebased onto e5c51f30 (4.17-rc6+).
> - Added linux-arch@ to the list of recipients.
> 
> Changes in v2:
> - Rebased onto 2d618bdf (4.17-rc3+).
> - Removed excessive untagging in gup.c.
> - Removed untagging pointers returned from __uaccess_mask_ptr.
> 
> Changes in v1:
> - Rebased onto 4.17-rc1.
> 
> Changes in RFC v2:
> - Added "#ifndef untagged_addr..." fallback in linux/uaccess.h instead of
>   defining it for each arch individually.
> - Updated Documentation/arm64/tagged-pointers.txt.
> - Dropped "mm, arm64: untag user addresses in memory syscalls".
> - Rebased onto 3eb2ce82 (4.16-rc7).
> 
> Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> 
> Andrey Konovalov (12):
>   uaccess: add untagged_addr definition for other arches
>   arm64: untag user pointers in access_ok and __uaccess_mask_ptr
>   lib, arm64: untag user pointers in strn*_user
>   mm, arm64: untag user pointers passed to memory syscalls
>   mm, arm64: untag user pointers in mm/gup.c
>   fs, arm64: untag user pointers in copy_mount_options
>   fs, arm64: untag user pointers in fs/userfaultfd.c
>   net, arm64: untag user pointers in tcp_zerocopy_receive
>   kernel, arm64: untag user pointers in prctl_set_mm*
>   tracing, arm64: untag user pointers in seq_print_user_ip
>   arm64: update Documentation/arm64/tagged-pointers.txt
>   selftests, arm64: add a selftest for passing tagged pointers to kernel
> 
>  Documentation/arm64/tagged-pointers.txt       | 25 +++++++++++--------
>  arch/arm64/include/asm/uaccess.h              | 10 +++++---
>  fs/namespace.c                                |  2 +-
>  fs/userfaultfd.c                              |  5 ++++
>  include/linux/memory.h                        |  4 +++
>  ipc/shm.c                                     |  2 ++
>  kernel/sys.c                                  | 14 +++++++++++
>  kernel/trace/trace_output.c                   |  2 +-
>  lib/strncpy_from_user.c                       |  2 ++
>  lib/strnlen_user.c                            |  2 ++
>  mm/gup.c                                      |  4 +++
>  mm/madvise.c                                  |  2 ++
>  mm/mempolicy.c                                |  5 ++++
>  mm/migrate.c                                  |  1 +
>  mm/mincore.c                                  |  2 ++
>  mm/mlock.c                                    |  5 ++++
>  mm/mmap.c                                     |  7 ++++++
>  mm/mprotect.c                                 |  2 ++
>  mm/mremap.c                                   |  2 ++
>  mm/msync.c                                    |  2 ++
>  net/ipv4/tcp.c                                |  2 ++
>  tools/testing/selftests/arm64/.gitignore      |  1 +
>  tools/testing/selftests/arm64/Makefile        | 11 ++++++++
>  .../testing/selftests/arm64/run_tags_test.sh  | 12 +++++++++
>  tools/testing/selftests/arm64/tags_test.c     | 19 ++++++++++++++
>  25 files changed, 129 insertions(+), 16 deletions(-)
>  create mode 100644 tools/testing/selftests/arm64/.gitignore
>  create mode 100644 tools/testing/selftests/arm64/Makefile
>  create mode 100755 tools/testing/selftests/arm64/run_tags_test.sh
>  create mode 100644 tools/testing/selftests/arm64/tags_test.c
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
