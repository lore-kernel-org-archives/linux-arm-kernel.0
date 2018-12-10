Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F115C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:31:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A1820851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MdoWkE4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A1820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=02i1AWNTGnEJgiQ+3xq/AvJVHnERyeM/qGRDI+BumbU=; b=MdoWkE4UuLygo0
	PDkryPI4PqG66nhfU4k6V1nelxEoUBGX/kSdkYwyzl+7U4+IYrd+sN6XaTpvhGsSCnQMzF91NLvK0
	KZb/7mP4L6aWLaqcx8mLicVDsfpRik3HTRi+Zy6oEfePJEqZ4xbLtXeBMh+krcuSaQ1kSFFMRVW8L
	imP3ggOa4gxJb745o08FYInLUblcmilJnJRS0rhSi1HhUiDwViu4p7AIy0ncY9uerj5sSeB3D7Xl+
	Bkari5Ylfw8om3wNLax+DzAIjkKFIudhXXBjfHpuCc9tTWtIqLRz95RrI2gtHK+1i/KcRfqTRsPtf
	5+TmeavnNEzYAbrM2M1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWMb6-0000xY-Pp; Mon, 10 Dec 2018 14:31:48 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWMaq-0000hm-2F
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 14:31:34 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A14D165C;
 Mon, 10 Dec 2018 06:31:29 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com
 [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA3393F575;
 Mon, 10 Dec 2018 06:31:24 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 2/3] arm64: Define Documentation/arm64/elf_at_flags.txt
Date: Mon, 10 Dec 2018 14:30:43 +0000
Message-Id: <20181210143044.12714-3-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210143044.12714-1-vincenzo.frascino@arm.com>
References: <cover.1544445454.git.andreyknvl@google.com>
 <20181210143044.12714-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_063132_122903_EE3D6803 
X-CRM114-Status: GOOD (  23.83  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Kostya Serebryany <kcc@google.com>, Chintan Pandya <cpandya@codeaurora.org>,
 Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Jacob Bramley <Jacob.Bramley@arm.com>, Evgeniy Stepanov <eugenis@google.com>,
 Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Andrey Konovalov <andreyknvl@google.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Dmitry Vyukov <dvyukov@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Lee Smith <Lee.Smith@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On arm64 the TCR_EL1.TBI0 bit has been set since Linux 3.x hence
the userspace (EL0) is allowed to set a non-zero value in the
top byte but the resulting pointers are not allowed at the
user-kernel syscall ABI boundary.

With the relaxed ABI proposed through this document, it is now possible
to pass tagged pointers to the syscalls, when these pointers are in
memory ranges obtained by an anonymous (MAP_ANONYMOUS) mmap() or brk().

This change in the ABI requires a mechanism to inform the userspace
that such an option is available.

This patch specifies and documents the way on which AT_FLAGS can be
used to advertise this feature to the userspace.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
CC: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 Documentation/arm64/elf_at_flags.txt | 111 +++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100644 Documentation/arm64/elf_at_flags.txt

diff --git a/Documentation/arm64/elf_at_flags.txt b/Documentation/arm64/elf_at_flags.txt
new file mode 100644
index 000000000000..153e657c058a
--- /dev/null
+++ b/Documentation/arm64/elf_at_flags.txt
@@ -0,0 +1,111 @@
+ARM64 ELF AT_FLAGS
+==================
+
+This document describes the usage and semantics of AT_FLAGS on arm64.
+
+1. Introduction
+---------------
+
+AT_FLAGS is part of the Auxiliary Vector, contains the flags and it
+is currently set to zero by the kernel on arm64.
+
+The auxiliary vector can be accessed by the userspace using the
+getauxval() API provided by the C library.
+getauxval() returns an unsigned long and when a flag is present in
+the AT_FLAGS, the corresponding bit in the returned value is set to 1.
+
+The AT_FLAGS with a "defined semantic" on arm64 are exposed to the
+userspace via user API (uapi/asm/atflags.h).
+The AT_FLAGS bits with "undefined semantics" are set to zero by default.
+This means that the AT_FLAGS bits to which this document does not assign
+an explicit meaning are to be intended reserved for future use.
+The kernel will populate all such bits with zero until meanings are
+assigned to them. If and when meanings are assigned, it is guaranteed
+that they will not impact the functional operation of existing userspace
+software. Userspace software should ignore any AT_FLAGS bit whose meaning
+is not defined when the software is written.
+
+The userspace software can test for features by acquiring the AT_FLAGS
+entry of the auxiliary vector, and testing whether a relevant flag
+is set.
+
+Example of a userspace test function:
+
+bool feature_x_is_present(void)
+{
+	unsigned long at_flags = getauxval(AT_FLAGS);
+	if (at_flags & FEATURE_X)
+		return true;
+
+	return false;
+}
+
+Where the software relies on a feature advertised by AT_FLAGS, it
+should check that the feature is present before attempting to
+use it.
+
+2. Features exposed via AT_FLAGS
+--------------------------------
+
+bit[0]: ARM64_AT_FLAGS_SYSCALL_TBI
+
+    On arm64 the TCR_EL1.TBI0 bit has been set since Linux 3.x hence
+    the userspace (EL0) is allowed to set a non-zero value in the top
+    byte but the resulting pointers are not allowed at the user-kernel
+    syscall ABI boundary.
+    When bit[0] is set to 1 the kernel is advertising to the userspace
+    that a relaxed ABI is supported hence this type of pointers are now
+    allowed to be passed to the syscalls, when these pointers are in
+    memory ranges obtained by anonymous (MAP_ANONYMOUS) mmap() or brk().
+    In these cases the tag is preserved as the pointer goes through the
+    kernel. Only when the kernel needs to check if a pointer is coming
+    from userspace (i.e. access_ok()) an untag operation is required.
+
+3. ARM64_AT_FLAGS_SYSCALL_TBI
+-----------------------------
+
+When ARM64_AT_FLAGS_SYSCALL_TBI is enabled every syscalls can accept tagged
+pointers, when these pointers are in memory ranges obtained by an anonymous
+(MAP_ANONYMOUS) mmap() or brk().
+
+A definition of the meaning of tagged pointers on arm64 can be found in:
+Documentation/arm64/tagged-pointers.txt.
+
+When a pointer does not are in a memory range obtained by an anonymous mmap()
+or brk(), this can not be passed to a syscall if it is tagged.
+
+To be more explicit: a syscall can accept pointers whose memory range is
+obtained by a non-anonymous mmap() or brk() if and only if the tag encoded in
+the top-byte is 0x00.
+
+When a new syscall is added, this can accept tagged pointers if and only if
+these pointers are in memory ranges obtained by an anonymous (MAP_ANONYMOUS)
+mmap() or brk(). In all the other cases, the tag encoded in the top-byte is
+expected to be 0x00.
+
+Example of correct usage (pseudo-code) for a userspace application:
+
+bool arm64_syscall_tbi_is_present(void)
+{
+	unsigned long at_flags = getauxval(AT_FLAGS);
+	if (at_flags & ARM64_AT_FLAGS_SYSCALL_TBI)
+			return true;
+
+	return false;
+}
+
+void main(void)
+{
+	char *addr = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
+			  MAP_ANONYMOUS, -1, 0);
+
+	/* Check if the relaxed ABI is supported */
+	if (arm64_syscall_tbi_is_present()) {
+		/* Add a tag to the pointer and to the memory */
+		addr = tag_pointer_and_memory(addr);
+	}
+
+	/* Write to memory */
+	strcpy("Hello World\n", addr);
+}
+
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
