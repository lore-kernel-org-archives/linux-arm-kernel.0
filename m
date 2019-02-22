Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4EFC10F0B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:54:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDF822075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GZT8Gigs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Tu5banMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF822075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=RZpazhYt9W4M8fYwkHwevp6obxxhul1ebO5Wj0A/44o=; b=GZT8Gigsmv38BT
	Cqyz+pV1Nfm8WnJ/kRJMGKfswolfa3cvHl4oWEIxyTq0bT1sJFpX9NSeVCDTWdVC1K6RdSBRu8QUk
	lTTbFnyaRo1d4pli6JMkiNMguth0JqlVpVFHt33xttor2odntJSO9gZGA4C1oodvAtBdvbVOQXfpN
	89g7+fN+M2KA5amoL0eJ8qu2D+8CBIpEpXhYvyihVDkZ1t+V9kRBvOT+3+LykqBCBuGM+KqqC8VEy
	XP5/HOa0mX+5/dyPmr+U8OLBjZOxHHFzmGg0ljLWPTIT4CVV+V+7k6a3yMX6t+j5lox0/fpyNAlpI
	t2DJNpKXWh6YbobukcSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxAKr-0007He-5e; Fri, 22 Feb 2019 12:53:49 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxAKd-00072E-Ct
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:53:37 +0000
Received: by mail-wr1-x442.google.com with SMTP id q1so2249343wrp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 04:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yTdyE4OiJcihsaiN1kttL78b5ay8J+Duvtcy07EGUfk=;
 b=Tu5banMRDDtlPyLWe88p9yIWwYonsz5x0mYsSuA17N5WBoGiRj1vrkMv/zOaZ8mbiY
 K5tP2hOpcPEdYPXLSmWECNR7PTwSOQJAnmXujZrViJWAnOLPZxMYFi1HCrfE2HJLLv/4
 KHQrhosGOdc+4DPZjNnIIfoS0ZeQ6bFOZbBkgN6SlrhRbttfOj+1c4VCuRH69TyJNfQX
 s3S+22nyCABj203DAdHMQ3iCdDg2oMQlAy98Q5kaYOLq3A8gouMm2kQXOrD3Y/zw9YU6
 1lwD/RF8vFGrC99MDVI5o36hoNcd03at/AjZeRp4exwegENG/KYluvN3VLtX3DYPtSB2
 c3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yTdyE4OiJcihsaiN1kttL78b5ay8J+Duvtcy07EGUfk=;
 b=IqbOxmJd308+TsV1Sj6+h8rZ1/RqlmaYZd97OI3AITENx03naGYOEHK7ZlbElzAPjJ
 NY7mN+dsrtCFH4XaRqw/crJpom0CulKx42cziwYOisNM4N2FyCFc2ZnCm0cHpPaulihi
 8JgNV+Wc5gJpFKUcpDP1qZeYpJzBVt8i3vjQzVZ9aU2ZYLKx9ISJYPZCjG4lQZufM0o5
 4Nqy0RpD1dfZ2HrdovMhzSZhw6oK0QmRNqUdO9zPajHGn/IRL+PfvHJ0WTY1Cvq4I7En
 R3vT8JTgPfSPuw3F0gcnD5BxQlpx5TlNSkFRRCQIFdJiX18q7sasSMOsc62+vxU790hm
 uhHQ==
X-Gm-Message-State: AHQUAuaZ0X0lGCjtfbAvPnbnyJhjef27f4r06+RTaUWSP0JXihqDEREX
 s3SzJP+lfuf24HXiXww4U5fRpg==
X-Google-Smtp-Source: AHgI3IYgvJEuUDeO3E9Up8/xaWGBXG29t1gzrvf/Z2pkqz38LV7bpaiegSpkMtPPtktz3keuogX01w==
X-Received: by 2002:a05:6000:92:: with SMTP id
 m18mr2858642wrx.258.1550840009608; 
 Fri, 22 Feb 2019 04:53:29 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
 by smtp.gmail.com with ESMTPSA id o14sm808209wrp.34.2019.02.22.04.53.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 04:53:28 -0800 (PST)
From: Andrey Konovalov <andreyknvl@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Shuah Khan <shuah@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 00/12] arm64: untag user pointers passed to the kernel
Date: Fri, 22 Feb 2019 13:53:12 +0100
Message-Id: <cover.1550839937.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_045335_475497_E5596D00 
X-CRM114-Status: GOOD (  23.64  )
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
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
 Chintan Pandya <cpandya@codeaurora.org>, Jacob Bramley <Jacob.Bramley@arm.com>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
 Andrey Konovalov <andreyknvl@google.com>, Lee Smith <Lee.Smith@arm.com>,
 Kostya Serebryany <kcc@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Dave Martin <Dave.Martin@arm.com>, Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patchset is meant to be merged together with "arm64 relaxed ABI" [1].

arm64 has a feature called Top Byte Ignore, which allows to embed pointer
tags into the top byte of each pointer. Userspace programs (such as
HWASan, a memory debugging tool [2]) might use this feature and pass
tagged user pointers to the kernel through syscalls or other interfaces.

Right now the kernel is already able to handle user faults with tagged
pointers, due to these patches:

1. 81cddd65 ("arm64: traps: fix userspace cache maintenance emulation on a
             tagged pointer")
2. 7dcd9dd8 ("arm64: hw_breakpoint: fix watchpoint matching for tagged
	      pointers")
3. 276e9327 ("arm64: entry: improve data abort handling of tagged
	      pointers")

This patchset extends tagged pointer support to syscall arguments.

For non-memory syscalls this is done by untaging user pointers when the
kernel performs pointer checking to find out whether the pointer comes
from userspace (most notably in access_ok). The untagging is done only
when the pointer is being checked, the tag is preserved as the pointer
makes its way through the kernel.

Since memory syscalls (mmap, mprotect, etc.) don't do memory accesses but
rather deal with memory ranges, untagged pointers are better suited to
describe memory ranges internally. Thus for memory syscalls we untag
pointers completely when they enter the kernel.

One of the alternative approaches to untagging that was considered is to
completely strip the pointer tag as the pointer enters the kernel with
some kind of a syscall wrapper, but that won't work with the countless
number of different ioctl calls. With this approach we would need a custom
wrapper for each ioctl variation, which doesn't seem practical.

The following testing approaches has been taken to find potential issues
with user pointer untagging:

1. Static testing (with sparse [3] and separately with a custom static
   analyzer based on Clang) to track casts of __user pointers to integer
   types to find places where untagging needs to be done.

2. Static testing with grep to find parts of the kernel that call
   find_vma() (and other similar functions) or directly compare against
   vm_start/vm_end fields of vma.

3. Static testing with grep to find parts of the kernel that compare
   user pointers with TASK_SIZE or other similar consts and macros.

4. Dynamic testing: adding BUG_ON(has_tag(addr)) to find_vma() and running
   a modified syzkaller version that passes tagged pointers to the kernel.

Based on the results of the testing the requried patches have been added
to the patchset.

This patchset has been merged into the Pixel 2 kernel tree and is now
being used to enable testing of Pixel 2 phones with HWASan.

This patchset is a prerequisite for ARM's memory tagging hardware feature
support [4].

Thanks!

[1] https://lkml.org/lkml/2018/12/10/402

[2] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html

[3] https://github.com/lucvoo/sparse-dev/commit/5f960cb10f56ec2017c128ef9d16060e0145f292

[4] https://community.arm.com/processors/b/blog/posts/arm-a-profile-architecture-2018-developments-armv85a

Changes in v10:
- Added "mm, arm64: untag user pointers passed to memory syscalls" back.
- New patch "fs, arm64: untag user pointers in fs/userfaultfd.c".
- New patch "net, arm64: untag user pointers in tcp_zerocopy_receive".
- New patch "kernel, arm64: untag user pointers in prctl_set_mm*".
- New patch "tracing, arm64: untag user pointers in seq_print_user_ip".

Changes in v9:
- Rebased onto 4.20-rc6.
- Used u64 instead of __u64 in type casts in the untagged_addr macro for
  arm64.
- Added braces around (addr) in the untagged_addr macro for other arches.

Changes in v8:
- Rebased onto 65102238 (4.20-rc1).
- Added a note to the cover letter on why syscall wrappers/shims that untag
  user pointers won't work.
- Added a note to the cover letter that this patchset has been merged into
  the Pixel 2 kernel tree.
- Documentation fixes, in particular added a list of syscalls that don't
  support tagged user pointers.

Changes in v7:
- Rebased onto 17b57b18 (4.19-rc6).
- Dropped the "arm64: untag user address in __do_user_fault" patch, since
  the existing patches already handle user faults properly.
- Dropped the "usb, arm64: untag user addresses in devio" patch, since the
  passed pointer must come from a vma and therefore be untagged.
- Dropped the "arm64: annotate user pointers casts detected by sparse"
  patch (see the discussion to the replies of the v6 of this patchset).
- Added more context to the cover letter.
- Updated Documentation/arm64/tagged-pointers.txt.

Changes in v6:
- Added annotations for user pointer casts found by sparse.
- Rebased onto 050cdc6c (4.19-rc1+).

Changes in v5:
- Added 3 new patches that add untagging to places found with static
  analysis.
- Rebased onto 44c929e1 (4.18-rc8).

Changes in v4:
- Added a selftest for checking that passing tagged pointers to the
  kernel succeeds.
- Rebased onto 81e97f013 (4.18-rc1+).

Changes in v3:
- Rebased onto e5c51f30 (4.17-rc6+).
- Added linux-arch@ to the list of recipients.

Changes in v2:
- Rebased onto 2d618bdf (4.17-rc3+).
- Removed excessive untagging in gup.c.
- Removed untagging pointers returned from __uaccess_mask_ptr.

Changes in v1:
- Rebased onto 4.17-rc1.

Changes in RFC v2:
- Added "#ifndef untagged_addr..." fallback in linux/uaccess.h instead of
  defining it for each arch individually.
- Updated Documentation/arm64/tagged-pointers.txt.
- Dropped "mm, arm64: untag user addresses in memory syscalls".
- Rebased onto 3eb2ce82 (4.16-rc7).

Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Andrey Konovalov (12):
  uaccess: add untagged_addr definition for other arches
  arm64: untag user pointers in access_ok and __uaccess_mask_ptr
  lib, arm64: untag user pointers in strn*_user
  mm, arm64: untag user pointers passed to memory syscalls
  mm, arm64: untag user pointers in mm/gup.c
  fs, arm64: untag user pointers in copy_mount_options
  fs, arm64: untag user pointers in fs/userfaultfd.c
  net, arm64: untag user pointers in tcp_zerocopy_receive
  kernel, arm64: untag user pointers in prctl_set_mm*
  tracing, arm64: untag user pointers in seq_print_user_ip
  arm64: update Documentation/arm64/tagged-pointers.txt
  selftests, arm64: add a selftest for passing tagged pointers to kernel

 Documentation/arm64/tagged-pointers.txt       | 25 +++++++++++--------
 arch/arm64/include/asm/uaccess.h              | 10 +++++---
 fs/namespace.c                                |  2 +-
 fs/userfaultfd.c                              |  5 ++++
 include/linux/memory.h                        |  4 +++
 ipc/shm.c                                     |  2 ++
 kernel/sys.c                                  | 14 +++++++++++
 kernel/trace/trace_output.c                   |  2 +-
 lib/strncpy_from_user.c                       |  2 ++
 lib/strnlen_user.c                            |  2 ++
 mm/gup.c                                      |  4 +++
 mm/madvise.c                                  |  2 ++
 mm/mempolicy.c                                |  5 ++++
 mm/migrate.c                                  |  1 +
 mm/mincore.c                                  |  2 ++
 mm/mlock.c                                    |  5 ++++
 mm/mmap.c                                     |  7 ++++++
 mm/mprotect.c                                 |  2 ++
 mm/mremap.c                                   |  2 ++
 mm/msync.c                                    |  2 ++
 net/ipv4/tcp.c                                |  2 ++
 tools/testing/selftests/arm64/.gitignore      |  1 +
 tools/testing/selftests/arm64/Makefile        | 11 ++++++++
 .../testing/selftests/arm64/run_tags_test.sh  | 12 +++++++++
 tools/testing/selftests/arm64/tags_test.c     | 19 ++++++++++++++
 25 files changed, 129 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/.gitignore
 create mode 100644 tools/testing/selftests/arm64/Makefile
 create mode 100755 tools/testing/selftests/arm64/run_tags_test.sh
 create mode 100644 tools/testing/selftests/arm64/tags_test.c

-- 
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
