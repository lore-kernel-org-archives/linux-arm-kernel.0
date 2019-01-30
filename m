Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92110C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:23:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E45620882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mbzDWLbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E45620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=1fJ6YAH05E5LR3z7BrZ8Ot2d5Af5oYV9G1ecWEgh6Cc=; b=mbz
	DWLbu3a77V0umItR+lgeVeyPBB0rVLuHsji3QK/INqCbVlH1pMG8y5KCuGOPacb62L/QVwM0Mfp6G
	aRWAMoFgs7NjS09EzcAAWpcE5KMlVySW9TeIzOLcOcYvmg4N/IokW7aGTw0Njmn0o94oCFHuyaXxg
	mhO3mUL+4LSV79vgX6wqUrlncRnYBEg2lIKuXoVOos+Iw2tbQP21qgQQvrPYmTW6DXsxcaqdLuGxU
	YvjaYPYs9UJsccHRZ7D1fEqMhDxGOUFJ/HNxqo62kqpqXqQjiFWSZKARfMk+zdIdm7Y+t7IE0Z4ok
	q6Go4IuHUCLEYSOku7/4pXXDPHaB8Gg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gootr-0002XA-W7; Wed, 30 Jan 2019 12:23:27 +0000
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gootn-0002W2-9e
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 12:23:25 +0000
Received: by mail-pf1-f193.google.com with SMTP id z9so11346600pfi.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 04:23:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=EZTRxABdX3lVjw3ovJQsgR1f2nADobDZJh5IGtwlrSM=;
 b=R5sTcNYFDXWa3pclWRdxzzEgra+Gx7YbZpcGeLiBUT/CQ0wcEV57r3nnf1IwPaW5/e
 kZ0yOBJG54E+zmz229+fvzTed+7mpLMaRXZLspQWJJA4vP5oJl4oOTNr9nBdaDqjCaq3
 0eVhhD+obCQR7Z+DLjdbGy6sFugJ3ukZMHJr53XowdbQeECylN3uieKmlnEC8Nkm7jp8
 azdHi5McAfLNJ1k4JDaQsOoDo/0G7IDLxLgzJZy7OEfXoNOoRW7Ic4WSx8JzSXrsRYjM
 +llBNOtyvk2vUnMmEajlhWM7UcwHWaKtutUK3+ihLgivUd4oYk2WJ9kPahfJkJ5H4ZRY
 8wog==
X-Gm-Message-State: AJcUukeO2J61WHDeQ/QiTVIJM5HTxBn23cCMkL+ipuLKKS2ugmyfkzfS
 U1BN7cJMvCcJfba3sKFd0YxFVOZX14A=
X-Google-Smtp-Source: ALg8bN7CJF4ueIu1h+H+z/yyS8yn+cTSMUdAZVWd5nPX5ddItO3N83TA1xSfPBp55I6NZB+QK3yFhg==
X-Received: by 2002:a63:1d59:: with SMTP id d25mr27852499pgm.180.1548851001877; 
 Wed, 30 Jan 2019 04:23:21 -0800 (PST)
Received: from localhost ([122.177.95.151])
 by smtp.gmail.com with ESMTPSA id v72sm4714079pfd.163.2019.01.30.04.23.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 04:23:20 -0800 (PST)
From: Bhupesh Sharma <bhsharma@redhat.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64,
 vmcoreinfo : Append 'MAX_USER_VA_BITS' and 'MAX_PHYSMEM_BITS' to
 vmcoreinfo
Date: Wed, 30 Jan 2019 17:53:11 +0530
Message-Id: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_042323_332028_D5DB94CC 
X-CRM114-Status: GOOD (  10.42  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, ard.biesheuvel@linaro.org,
 catalin.marinas@arm.com, bhsharma@redhat.com, kexec@lists.infradead.org,
 Will Deacon <will.deacon@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 James Morse <james.morse@arm.com>, bhupesh.linux@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

With ARMv8.2-LVA and LPA architecture extensions, arm64 hardware which
supports these extensions can support upto 52-bit virtual and 52-bit
physical addresses respectively.

Since at the moment we enable the support of these extensions via CONFIG
flags, e.g.
 - LPA via CONFIG_ARM64_PA_BITS_52

there are no clear mechanisms in user-space right now to
deteremine these CONFIG flag values and also determine the PARange and
VARange address values.

User-space tools like 'makedumpfile' and 'crash-utility' can instead
use the 'MAX_USER_VA_BITS' and 'MAX_PHYSMEM_BITS' values to determine
the maximum virtual address and physical address (respectively)
supported by underlying kernel.

A reference 'makedumpfile' implementation which uses this approach to
determining the maximum physical address is available in [0].

[0]. https://github.com/bhupesh-sharma/makedumpfile/blob/52-bit-pa-support-via-vmcore-v1/arch/arm64.c#L490

Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: James Morse <james.morse@arm.com>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 arch/arm64/kernel/crash_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
index ca4c3e12d8c5..ad231be5c0d8 100644
--- a/arch/arm64/kernel/crash_core.c
+++ b/arch/arm64/kernel/crash_core.c
@@ -10,6 +10,8 @@
 void arch_crash_save_vmcoreinfo(void)
 {
 	VMCOREINFO_NUMBER(VA_BITS);
+	VMCOREINFO_NUMBER(MAX_USER_VA_BITS);
+	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
 	/* Please note VMCOREINFO_NUMBER() uses "%d", not "%x" */
 	vmcoreinfo_append_str("NUMBER(kimage_voffset)=0x%llx\n",
 						kimage_voffset);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
