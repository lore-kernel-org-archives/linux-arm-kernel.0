Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE61C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:37:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D70A218D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RVVUxK58";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="TNB2/8TB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D70A218D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:From:Subject:Mime-Version:Message-Id
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=jeJa5WFgU9ZiGk99C2sC93wJL2USlEtmhjHV0MARIj0=; b=RVVUxK58VuhHYY
	SwEw6m2Jerf9N1ZS4rwJAMe9nUgepcFFadkXtPK357BINyLIJ8oZ6/UPsphsrkPmanwoRw/2jXKgK
	iXHFBCz89H1cb0189LlQIb7Ir067lORUyi6TRdffNQPr0GjBw+g211fYtoNg2NrDPGTTJXLiiYFIM
	OtmYRjhFJTmRG+ELzeXrE51S+ehZlXOdw23o8Rd2feMdTcIYlb83Egbn2+F8iPhONC7cSN6Rj5lH5
	K6cIJFyVOHmmxj1AJov+t7jQMIrGfvZ70YniKDan9JNg/xNhKyl4L1qEci3ZPNGL5nnKq1rCIsCBR
	Yxaivne0Cdw8ZxAYnU4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtEZv-0004Ry-Bs; Mon, 11 Feb 2019 16:37:07 +0000
Received: from mail-qk1-x74a.google.com ([2607:f8b0:4864:20::74a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtEZr-0004R2-OK
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 16:37:05 +0000
Received: by mail-qk1-x74a.google.com with SMTP id w124so12740248qkc.14
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 08:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=ISun9MAS+KVytOd1BlrXoBr37mM1yAGSGTfHJEPM32s=;
 b=TNB2/8TBwxbKKd2i42i2M7UNYFPUuZ64UIeF/y5q0W/RWfGzDCpL9oAeLllxUgbpxu
 /cvhORcFHMuixNyvvXBi8swrgkc8NK8XFMtVDmmXKI0nooslZQcTJY2isSJJYk0ivgT6
 NFHfV11v8RgZMXI890RMntZksGTENB71Ubvb5F2UW0DQOw21cGSnNJJMtGlvKhZ7IvT9
 g/y9JC1+onhZf8pbSNO66gA2hh6rV2+5h6lrXNfNvRt7jdJKA28Djl/NGpsdi5rSc/+w
 p6/3NrHFkVMS+STFZSgm/kHncRU6QkrSNBTNSCTzprdYtg16aJQEVP/RE1fsbvxc+vjY
 bRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=ISun9MAS+KVytOd1BlrXoBr37mM1yAGSGTfHJEPM32s=;
 b=XIykbUxP17Ow/V3pzeFW/6Ig7ynvwHs2VPVAKhSm27q0rVubclmNogOT5mjIjyfZrw
 vSxBcD+3JJbLU1Cqjo7sOQ3LZDbCb3iW+3wfXB8vprfpB8+qKlX7F0Ee/9yJoZgsy7ps
 WpeDzIyIsM1NPQMT/X6WUP+8pcMO1m+iUISwmRR1kZdURaNU9HVWkkz9brhjBXSIvylm
 +v5txNO11evpm8Xxp8COPHL4hyVHIV096SXO7+ymqOY0BNEB2YuMnLOB7RVE+mLu1vSi
 qACrIiPAQpyPh+FnkE8E0ngXYB66M9c9dH81lpTurR6uNL25qy3TPxiGmxXrPHkCII/b
 t7Jw==
X-Gm-Message-State: AHQUAuat/3yH8gBoY512JF+d0BtBWWiaKEH1j/DYSCTu3F1300MYcOYM
 93kTNo8nrvTWi+BFQUbklUJLajydWw==
X-Google-Smtp-Source: AHgI3IbIpHNITiD/z7phI27+wkBpML0Qrk8afGSQ6mMM5RujSQsYB+1u3g69NuuKIR42OGBcaDSaC7fcxA==
X-Received: by 2002:a37:d150:: with SMTP id s77mr3319763qki.35.1549903021406; 
 Mon, 11 Feb 2019 08:37:01 -0800 (PST)
Date: Mon, 11 Feb 2019 17:36:53 +0100
Message-Id: <20190211163653.97742-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
Subject: [PATCH] mmap.2: describe the 5level paging hack
From: Jann Horn <jannh@google.com>
To: mtk.manpages@gmail.com, jannh@google.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_083703_843873_202F0867 
X-CRM114-Status: GOOD (  20.92  )
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
Cc: linux-arch@vger.kernel.org, linux-man@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
 Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will.deacon@arm.com>, linuxppc-dev@lists.ozlabs.org,
 Andy Lutomirski <luto@amacapital.net>, Dave Hansen <dave.hansen@intel.com>,
 Paul Mackerras <paulus@samba.org>, linux-arm-kernel@lists.infradead.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Morton <akpm@linux-foundation.org>, linux-api@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The manpage is missing information about the compatibility hack for
5-level paging that went in in 4.14, around commit ee00f4a32a76 ("x86/mm:
Allow userspace have mappings above 47-bit"). Add some information about
that.

While I don't think any hardware supporting this is shipping yet (?), I
think it's useful to try to write a manpage for this API, partly to
figure out how usable that API actually is, and partly because when this
hardware does ship, it'd be nice if distro manpages had information about
how to use it.

Signed-off-by: Jann Horn <jannh@google.com>
---
This patch goes on top of the patch "[PATCH] mmap.2: fix description of
treatment of the hint" that I just sent, but I'm not sending them in a
series because I want the first one to go in, and I think this one might
be a bit more controversial.

It would be nice if the architecture maintainers and mm folks could have
a look at this and check that what I wrote is right - I only looked at
the source for this, I haven't tried it.

 man2/mmap.2 | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/man2/mmap.2 b/man2/mmap.2
index 8556bbfeb..977782fa8 100644
--- a/man2/mmap.2
+++ b/man2/mmap.2
@@ -67,6 +67,8 @@ is NULL,
 then the kernel chooses the (page-aligned) address
 at which to create the mapping;
 this is the most portable method of creating a new mapping.
+On Linux, in this case, the kernel may limit the maximum address that can be
+used for allocations to a legacy limit for compatibility reasons.
 If
 .I addr
 is not NULL,
@@ -77,6 +79,19 @@ or equal to the value specified by
 and attempt to create the mapping there.
 If another mapping already exists there, the kernel picks a new
 address, independent of the hint.
+However, if a hint above the architecture's legacy address limit is provided
+(on x86-64: above 0x7ffffffff000, on arm64: above 0x1000000000000, on ppc64 with
+book3s: above 0x7fffffffffff or 0x3fffffffffff, depending on page size), the
+kernel is permitted to allocate mappings beyond the architecture's legacy
+address limit. The availability of such addresses is hardware-dependent.
+Therefore, if you want to be able to use the full virtual address space of
+hardware that supports addresses beyond the legacy range, you need to specify an
+address above that limit; however, for security reasons, you should avoid
+specifying a fixed valid address outside the compatibility range,
+since that would reduce the value of userspace address space layout
+randomization. Therefore, it is recommended to specify an address
+.I beyond
+the end of the userspace address space.
 .\" Before Linux 2.6.24, the address was rounded up to the next page
 .\" boundary; since 2.6.24, it is rounded down!
 The address of the new mapping is returned as the result of the call.
-- 
2.20.1.791.gb4d0f1c61a-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
