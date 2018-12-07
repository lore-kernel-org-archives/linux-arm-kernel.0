Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC757C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:43:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8815C2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EH+CpwXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8815C2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=8DMA8yRICJlmFLNZ0jJZjc0EtJ1VJL7l4DI/Xd+ygXQ=; b=EH+CpwXVwDKye+Zq+mnmHARrjU
	KX99y9/a6diSyLCarxhywsr0/xQRrQoZX/HNOp2aKJChpNIxIlszBJZYwS2yNyL4XPPYzIXqFsl1s
	w30+D13mr+WelYLJkxtEGGFltsfYTcIUDnwbkSFk7LyZDsqEy8XAnK4EMjEiRcAFxphIbkvIGpFrS
	PqTEjDV/h5mlseORSs4jt2DSHdSjTZQue7KH9tIyvb6gqzWo1fQHmlCgZZeT2tviiLE5t7NSs4Eqr
	pYxCQQ+DhTwyfyuD4GpD5f466AXf9P/Vpk4Pe0wRgMCYx+XklZTtYXkhvurpOjXr4bN2wxk3a8blS
	rlqnNwdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVL6K-0008QE-6V; Fri, 07 Dec 2018 18:43:48 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVL3e-0005K1-84
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 18:41:48 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05B11165C;
 Fri,  7 Dec 2018 10:40:52 -0800 (PST)
Received: from moonbear.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E22BD3F5AF;
 Fri,  7 Dec 2018 10:40:48 -0800 (PST)
From: Kristina Martsenko <kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 13/13] arm64: docs: document pointer authentication
Date: Fri,  7 Dec 2018 18:39:31 +0000
Message-Id: <20181207183931.4285-14-kristina.martsenko@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181207183931.4285-1-kristina.martsenko@arm.com>
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_104103_446954_98006401 
X-CRM114-Status: GOOD (  19.86  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Jones <drjones@redhat.com>,
 Jacob Bramley <jacob.bramley@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Adam Wallis <awallis@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christoffer Dall <christoffer.dall@arm.com>, Will Deacon <will.deacon@arm.com>,
 kvmarm@lists.cs.columbia.edu, Cyrill Gorcunov <gorcunov@gmail.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Amit Kachhap <amit.kachhap@arm.com>, Dave P Martin <dave.martin@arm.com>,
 linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

Now that we've added code to support pointer authentication, add some
documentation so that people can figure out if/how to use it.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
Reviewed-by: Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
Cc: Andrew Jones <drjones@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 Documentation/arm64/booting.txt                |  8 +++
 Documentation/arm64/cpu-feature-registers.txt  |  8 +++
 Documentation/arm64/elf_hwcaps.txt             | 12 ++++
 Documentation/arm64/pointer-authentication.txt | 93 ++++++++++++++++++++++++++
 4 files changed, 121 insertions(+)
 create mode 100644 Documentation/arm64/pointer-authentication.txt

diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
index 8d0df62c3fe0..8df9f4658d6f 100644
--- a/Documentation/arm64/booting.txt
+++ b/Documentation/arm64/booting.txt
@@ -205,6 +205,14 @@ Before jumping into the kernel, the following conditions must be met:
     ICC_SRE_EL2.SRE (bit 0) must be initialised to 0b0.
   - The DT or ACPI tables must describe a GICv2 interrupt controller.
 
+  For CPUs with pointer authentication functionality:
+  - If EL3 is present:
+    SCR_EL3.APK (bit 16) must be initialised to 0b1
+    SCR_EL3.API (bit 17) must be initialised to 0b1
+  - If the kernel is entered at EL1:
+    HCR_EL2.APK (bit 40) must be initialised to 0b1
+    HCR_EL2.API (bit 41) must be initialised to 0b1
+
 The requirements described above for CPU mode, caches, MMUs, architected
 timers, coherency and system registers apply to all CPUs.  All CPUs must
 enter the kernel in the same exception level.
diff --git a/Documentation/arm64/cpu-feature-registers.txt b/Documentation/arm64/cpu-feature-registers.txt
index 7964f03846b1..d4b4dd1fe786 100644
--- a/Documentation/arm64/cpu-feature-registers.txt
+++ b/Documentation/arm64/cpu-feature-registers.txt
@@ -184,12 +184,20 @@ infrastructure:
      x--------------------------------------------------x
      | Name                         |  bits   | visible |
      |--------------------------------------------------|
+     | GPI                          | [31-28] |    y    |
+     |--------------------------------------------------|
+     | GPA                          | [27-24] |    y    |
+     |--------------------------------------------------|
      | LRCPC                        | [23-20] |    y    |
      |--------------------------------------------------|
      | FCMA                         | [19-16] |    y    |
      |--------------------------------------------------|
      | JSCVT                        | [15-12] |    y    |
      |--------------------------------------------------|
+     | API                          | [11-8]  |    y    |
+     |--------------------------------------------------|
+     | APA                          | [7-4]   |    y    |
+     |--------------------------------------------------|
      | DPB                          | [3-0]   |    y    |
      x--------------------------------------------------x
 
diff --git a/Documentation/arm64/elf_hwcaps.txt b/Documentation/arm64/elf_hwcaps.txt
index ea819ae024dd..13d6691b37be 100644
--- a/Documentation/arm64/elf_hwcaps.txt
+++ b/Documentation/arm64/elf_hwcaps.txt
@@ -182,3 +182,15 @@ HWCAP_FLAGM
 HWCAP_SSBS
 
     Functionality implied by ID_AA64PFR1_EL1.SSBS == 0b0010.
+
+HWCAP_PACA
+
+    Functionality implied by ID_AA64ISAR1_EL1.APA == 0b0001 or
+    ID_AA64ISAR1_EL1.API == 0b0001, as described by
+    Documentation/arm64/pointer-authentication.txt.
+
+HWCAP_PACG
+
+    Functionality implied by ID_AA64ISAR1_EL1.GPA == 0b0001 or
+    ID_AA64ISAR1_EL1.GPI == 0b0001, as described by
+    Documentation/arm64/pointer-authentication.txt.
diff --git a/Documentation/arm64/pointer-authentication.txt b/Documentation/arm64/pointer-authentication.txt
new file mode 100644
index 000000000000..5baca42ba146
--- /dev/null
+++ b/Documentation/arm64/pointer-authentication.txt
@@ -0,0 +1,93 @@
+Pointer authentication in AArch64 Linux
+=======================================
+
+Author: Mark Rutland <mark.rutland@arm.com>
+Date: 2017-07-19
+
+This document briefly describes the provision of pointer authentication
+functionality in AArch64 Linux.
+
+
+Architecture overview
+---------------------
+
+The ARMv8.3 Pointer Authentication extension adds primitives that can be
+used to mitigate certain classes of attack where an attacker can corrupt
+the contents of some memory (e.g. the stack).
+
+The extension uses a Pointer Authentication Code (PAC) to determine
+whether pointers have been modified unexpectedly. A PAC is derived from
+a pointer, another value (such as the stack pointer), and a secret key
+held in system registers.
+
+The extension adds instructions to insert a valid PAC into a pointer,
+and to verify/remove the PAC from a pointer. The PAC occupies a number
+of high-order bits of the pointer, which varies dependent on the
+configured virtual address size and whether pointer tagging is in use.
+
+A subset of these instructions have been allocated from the HINT
+encoding space. In the absence of the extension (or when disabled),
+these instructions behave as NOPs. Applications and libraries using
+these instructions operate correctly regardless of the presence of the
+extension.
+
+The extension provides five separate keys to generate PACs - two for
+instruction addresses (APIAKey, APIBKey), two for data addresses
+(APDAKey, APDBKey), and one for generic authentication (APGAKey).
+
+
+Basic support
+-------------
+
+When CONFIG_ARM64_PTR_AUTH is selected, and relevant HW support is
+present, the kernel will assign random key values to each process at
+exec*() time. The keys are shared by all threads within the process, and
+are preserved across fork().
+
+Presence of address authentication functionality is advertised via
+HWCAP_PACA, and generic authentication functionality via HWCAP_PACG.
+
+The number of bits that the PAC occupies in a pointer is 55 minus the
+virtual address size configured by the kernel. For example, with a
+virtual address size of 48, the PAC is 7 bits wide.
+
+Recent versions of GCC can compile code with APIAKey-based return
+address protection when passed the -msign-return-address option. This
+uses instructions in the HINT space (unless -march=armv8.3-a or higher
+is also passed), and such code can run on systems without the pointer
+authentication extension.
+
+In addition to exec(), keys can also be reinitialized to random values
+using the PR_PAC_RESET_KEYS prctl. A bitmask of PR_PAC_APIAKEY,
+PR_PAC_APIBKEY, PR_PAC_APDAKEY, PR_PAC_APDBKEY and PR_PAC_APGAKEY
+specifies which keys are to be reinitialized; specifying 0 means "all
+keys".
+
+
+Debugging
+---------
+
+When CONFIG_ARM64_PTR_AUTH is selected, and HW support for address
+authentication is present, the kernel will expose the position of TTBR0
+PAC bits in the NT_ARM_PAC_MASK regset (struct user_pac_mask), which
+userspace can acquire via PTRACE_GETREGSET.
+
+The regset is exposed only when HWCAP_PACA is set. Separate masks are
+exposed for data pointers and instruction pointers, as the set of PAC
+bits can vary between the two. Note that the masks apply to TTBR0
+addresses, and are not valid to apply to TTBR1 addresses (e.g. kernel
+pointers).
+
+Additionally, when CONFIG_CHECKPOINT_RESTORE is also set, the kernel
+will expose the NT_ARM_PACA_KEYS and NT_ARM_PACG_KEYS regsets (struct
+user_pac_address_keys and struct user_pac_generic_keys). These can be
+used to get and set the keys for a thread.
+
+
+Virtualization
+--------------
+
+Pointer authentication is not currently supported in KVM guests. KVM
+will mask the feature bits from ID_AA64ISAR1_EL1, and attempted use of
+the feature will result in an UNDEFINED exception being injected into
+the guest.
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
