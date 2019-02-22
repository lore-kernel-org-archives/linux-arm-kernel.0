Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16CDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:54:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9854B20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YYvk020G";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="fnTgPPWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9854B20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Pw7R6Ygx0z/7UCIqi7yhvYz/g+IRo3t7qoX7hWSIkJs=; b=YYvk020GvbixMP
	Lp/mNmmqGbZcll7by/ddJL/sTzBDDQX5KHsbLbXX/nraK+iaeVl5VAH0tZ+5Sf87ab40wZ9QJkr2/
	TvgZp4mm24O5QoYGfa5V9dOT+eV1soWkEsmC77sMc5jKSU6n0LoT5l/oXnVwqEwo0PyDfzF41aVOz
	BTT0EQ6mHOLvdlo0cbETMnXAfGfXyA2EyL3Wjo9gYwS7g2W1j7x1AbeTZm10AxkRDr8F97qLVJGN7
	I1SUk+wEIEH3CqrBJ3nI/N0HYDhEw52pRgM+q2TwJZghpEeb/ceADB/WujK9hrMLJHVnFnTGUsErq
	G+zs08M8hio0NmRLyQjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxALX-000835-ML; Fri, 22 Feb 2019 12:54:31 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxAKj-00076d-7r
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:53:44 +0000
Received: by mail-wr1-x442.google.com with SMTP id w2so2232035wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 04:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uDDn0ivyVadTQonBIumHfFBd6mG/pAa/u+KuaaJi/B4=;
 b=fnTgPPWFbhryzIzggFc58E4JRsSfK1IU6Sw4LOT9BmgUYGkt3wEcfANoHsXQNUfzc9
 iq9GnYboQsHAKfaKEMrayX1hTXWMMzN/I+6xp02HRbDpZSbRDDjWtj8CtbTOO+dIfC18
 ltrqDIgvui1Exhs0Vsi5guo+6E3eT4Wtp8hwz3ZjUu7OWeuvZHwtR/+mz7N5pObt7Jyg
 o9MWPu/ZGZA22IZSghjyRMXWOy54fhII2IqGEsHjXbEZzuq4hcuupqXge221UVGDnEs4
 VFRnbwlpME12B1w6MdCak9Bm0Q10KMMEgKTJkafiFF5n0MsmyUqd2OoKz/ClD7ZF5Nsp
 o7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uDDn0ivyVadTQonBIumHfFBd6mG/pAa/u+KuaaJi/B4=;
 b=BjnyuWHq62R1mbMMDhLh7DlIPFaYau/xUsbWd6ohQjEbppDGo/vXCLavYRHiEjBVgV
 IMSyzywPonAQ1KBOWmrvXG4IVUqRf+rmzh6QfKg8LvNgLI3KJ0shpCncD6GIyrm+KLNV
 NTAbBIu03wZkRv8yHR0gAkSDNTLbGPJLZXLUOFv/RrWT9MpHMXun4W5YEUwBVhzjRHfL
 8RCCFeJN5ajfEvQb+GXfmvg6dJMY61EsxCRicfcEfpFq+v5nI0IKDoehybtwR0EJ7pFJ
 UoTNi0eHXhDQQYiTChSOxbSG6En+sTc4v/6S95G5mtb/CpjQFOB0VCFPogJGj9v/XXTh
 yt7Q==
X-Gm-Message-State: AHQUAuYYwGXqa3FmhW2BZH9VsSWAR3K2zb2Ztjchhgjg+pOqmXDZg1ys
 v/9+hmlrCCsFl93Y9IHzwL0F4Q==
X-Google-Smtp-Source: AHgI3IZUynwk0jQkzXh/fkOnLsB6yWgKr9nX+ibOmHPHqGghLVkrUAqVS0J+X+P7S91mSoisvLsmzA==
X-Received: by 2002:adf:e548:: with SMTP id z8mr2994894wrm.52.1550840019712;
 Fri, 22 Feb 2019 04:53:39 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
 by smtp.gmail.com with ESMTPSA id o14sm808209wrp.34.2019.02.22.04.53.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 04:53:38 -0800 (PST)
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
Subject: [PATCH v10 05/12] mm, arm64: untag user pointers in mm/gup.c
Date: Fri, 22 Feb 2019 13:53:17 +0100
Message-Id: <12759ef1c30887dd9fc7a04498f5a434a67f98d5.1550839937.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <cover.1550839937.git.andreyknvl@google.com>
References: <cover.1550839937.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_045341_599906_F3A8633E 
X-CRM114-Status: GOOD (  12.43  )
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

mm/gup.c provides a kernel interface that accepts user addresses and
manipulates user pages directly (for example get_user_pages, that is used
by the futex syscall). Since a user can provided tagged addresses, we need
to handle such case.

Add untagging to gup.c functions that use user addresses for vma lookup.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/gup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index 75029649baca..b6eda1608bea 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -683,6 +683,8 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 	if (!nr_pages)
 		return 0;
 
+	start = untagged_addr(start);
+
 	VM_BUG_ON(!!pages != !!(gup_flags & FOLL_GET));
 
 	/*
@@ -845,6 +847,8 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 	struct vm_area_struct *vma;
 	vm_fault_t ret, major = 0;
 
+	address = untagged_addr(address);
+
 	if (unlocked)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY;
 
-- 
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
