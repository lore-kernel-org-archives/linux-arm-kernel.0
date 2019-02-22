Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF355C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:56:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66F072075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EVmOcAE2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="mN2rwWcX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F072075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9Ke0VwbQ0JM3NSUCyOUsVE1/GahSyRGlJwJBYJbus1s=; b=EVmOcAE27VA6FD
	A/YQ6s7n1wuWZWGz0G9Hgl6N3Rhw7FR57ozu2oWiIzaPwphkC2MLW7zm0xKUB8nwTfbL0ii1XIeME
	NGYiwqZRXJGZhl7eGedy7u9VLWmO7ABvjXmV2IUaL4LUhvwsWjM2PLJdBDpZWnabUcXXDLSvrI/+X
	e3H6DU2SihMQEnOfZRo78sRMGygWRcROI2PNgyz9Hq8W+KAdravqJyJNIcxlHSh3RCILDp6Au6oJ8
	f+w+w9ZVYuzTv3C2lFBPZuAIrhaGN5LbvFuRjnpxwjZR/xgqYHM2Yfu5ev8Tf1e++ai1McBPXfLJk
	0OML/KV5NP2+3ByCgG6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxANA-0002N1-0L; Fri, 22 Feb 2019 12:56:12 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxAKf-00072t-BU
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:53:38 +0000
Received: by mail-wr1-x444.google.com with SMTP id n2so2246550wrw.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 04:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Cci7ZilHiWLbA64Mc6AMOu/bLCyx/LwY/bSfReud1WI=;
 b=mN2rwWcXbmXv4T54C8g+dQZceONkqeqfDnfFBkdS/1z2f+11756LZtilFVL9vmN8Ub
 asXmJYdmjDVQkCK9dtCydjOWxr+KWTUU0EEaMipiA+1WfFsqs10CUXUyp5B+yuljcBc1
 0C0tywzNl+KEsDi5E1V9a1Ws2dGSyCYbuw6oXbdAfIH3UZ7l6SUpfEF4GcTbMbPCNeeB
 Ot4+ZahceUY35FVe2YDPYC6Ax0ARG1yKOQgJNw51FBiolm56hh/XyUho+qccTDZViTri
 rRytDOGFcggeSEQD/tMlfRQXS2V8i4wpp47+jYCO3tkhuGYSljzEFFfYn0oW2evDAak3
 2ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Cci7ZilHiWLbA64Mc6AMOu/bLCyx/LwY/bSfReud1WI=;
 b=fekZLtX5LcvwFLQ/whfChilWsH+/7OZb3zgcmbbg/Q2ciJivxldMmzyX8zIFN37ABB
 IoOiQeUwrDOolLGJQL/OJ/PBnFJIVznDG0pafRTXC25L/hWnRS1Se+jpocSY23XB2Ble
 4cN1XglEc8TYQOBFCsZe3HUiruI9pN6Auuqbw903KEhPGe4VEBgRSWR0tnNpvdNZu8rs
 yiMaKH1AmIVwJ24Vtcw8GZ6CWjZ7U//iiSdLMh61Gj7P4kQRbdbqR3/VrP1xd0kfsAUz
 6DqrRR5LNe26Svdb3lrH2t67Bsv3pjzILb/+c0vQVEurFa0v8/5u1zLjINDmMMhKjMuo
 sB3w==
X-Gm-Message-State: AHQUAubBteHosI9tiAttKhsekYGBRFP1x89C35qK7tX7rNI+EmoV+/1R
 TfDd9CNNO9ufQVMtoOAZt0lJZQ==
X-Google-Smtp-Source: AHgI3IYNE5YTD6dA2Rm0c87bwvFj8qPgC6wZI8wCmOm2tGxzmyo49L1MzMubdg2VCbScaD+W4rhlpw==
X-Received: by 2002:adf:f6ca:: with SMTP id y10mr2869999wrp.148.1550840011806; 
 Fri, 22 Feb 2019 04:53:31 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
 by smtp.gmail.com with ESMTPSA id o14sm808209wrp.34.2019.02.22.04.53.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 04:53:30 -0800 (PST)
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
Subject: [PATCH v10 01/12] uaccess: add untagged_addr definition for other
 arches
Date: Fri, 22 Feb 2019 13:53:13 +0100
Message-Id: <2b5a5d7d7a36a75a2a796f0c2b9b30669d81d470.1550839937.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <cover.1550839937.git.andreyknvl@google.com>
References: <cover.1550839937.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_045337_569316_438C38D1 
X-CRM114-Status: GOOD (  12.15  )
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

To allow arm64 syscalls to accept tagged pointers from userspace, we must
untag them when they are passed to the kernel. Since untagging is done in
generic parts of the kernel, the untagged_addr macro needs to be defined
for all architectures.

Define it as a noop for architectures other than arm64.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/memory.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/memory.h b/include/linux/memory.h
index a6ddefc60517..fc383bc39ab8 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -21,6 +21,10 @@
 #include <linux/mutex.h>
 #include <linux/notifier.h>
 
+#ifndef untagged_addr
+#define untagged_addr(addr) (addr)
+#endif
+
 #define MIN_MEMORY_BLOCK_SIZE     (1UL << SECTION_SIZE_BITS)
 
 struct memory_block {
-- 
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
