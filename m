Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2A5C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:58:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8F720855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h+b9Z6B4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="o94crt9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8F720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lVAxV6xCxDOzHorwk1b2WVEgBqASY3Q1jtcNg5gcsr0=; b=h+b9Z6B4ZoY5dP
	vKLAahh7Rfy0Z7iRpd9bvXOqwIjuzyVOlxdF0HyyIK9/5A141nhAWSMEuwX5wP3nkFRn+TKJOhWQh
	vjcdbQJluUo7L8ELXiN4vTV7enUHoWlCerWrW5L0sHPAb0B60IWtoYMHzaFrdhX5FkOu0ZSI1AqoO
	erRtMt8ev46J1uAg++1MrAleN1E6YuTW41pqJzqRWfcIR9lR5ZCZd/WKbfh0+v1r5MkMFPKpE68RQ
	HIMRd+UmOm6o3xNGE6v0f5y9+a2SNyvliugpI6oNJjvg07Z1ASlDufWLk/Os9usuFS3TQIKQne2gC
	rcyBBA+3eJFbjJYY6GgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWL8l-0004j5-TA; Mon, 10 Dec 2018 12:58:27 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWL1w-0001CH-8m
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 12:51:29 +0000
Received: by mail-wm1-x342.google.com with SMTP id c126so11082165wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 04:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O6AqR+kzU7DWQeNGwKtE5aEN5/daSSLGL2wqVNM1I1o=;
 b=o94crt9sdWRW+Hm+QmVzs2SQOfXkb5I8ZA1YUWGR/rhiyXLta3D09PlbP8iJAgQz4P
 AaMOg13WCXc/3V43uJSupLTElnHz42/Ee7IzHa1JjP6TjqWFlUNN//X23cnby2HTY/og
 axjylPN+XFavkTnP0oGFHln3ZwFe2/juKQ5sJAgtxYNAFtsVDFeYuPsBQ0hII0bfcLEK
 XiMERt9XLjpmq8N8DJ1YK866L0D0OEONbAo9KCgz28iqGOX3iPjmbwdb16LAY28Asm+R
 C/Nun82fTDPABrkfsixYhSu9EPH9yIADCvsKOyVMjDxIqyFwkkJ/ZzoNiySiBB50PDA4
 tGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O6AqR+kzU7DWQeNGwKtE5aEN5/daSSLGL2wqVNM1I1o=;
 b=ZS6br9AN0PKdGbLUxvSlmMXnpqfsIMzZwMJdkqAjC95lnRUUFm1ZTydLLhDoqUwlmm
 dmpX0yUBj6WEMNrAVhiGulr0zECyfKVu3SlKpBXVtu+xCRstYPuRrrB3YkcB6fApbVFb
 O6baVo+AoO9c3MBGkrbfrpZ5WmIXoiLHPDmdPWy8A4jJlRa+sywzWNXTPN/775Kkv6lw
 KsZadQq3enpZwgR3NyadVNZPEYzskGLBBwvxZxD92INmGEhZEwpUE71yvCrKfE1EkCw+
 apLXOzb0tQ7tTnZP2n4FxDBiAJLOLdBDSoxC4aZa6e4Fe4ZPef/c86ipGtjXLk3/H1g1
 VxyA==
X-Gm-Message-State: AA+aEWYa6hNx1B1yHvEzErzS7m0Jb8hWIyswqTZoMFZY5XxrcVuMgzjN
 DZRXYC7kza065NyQNLK2//An1A==
X-Google-Smtp-Source: AFSGD/Xve6So/1Ery1o5wmvM73iVMPQ4hP1b6ACBIixN+5CPW479nD99WkZw/3+pQqT8QAsR/mEorA==
X-Received: by 2002:a1c:570d:: with SMTP id l13mr11011978wmb.139.1544446275548; 
 Mon, 10 Dec 2018 04:51:15 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:10:3180:41f8:3010:ff61])
 by smtp.gmail.com with ESMTPSA id l197sm36893363wma.44.2018.12.10.04.51.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 04:51:14 -0800 (PST)
From: Andrey Konovalov <andreyknvl@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 4/8] mm, arm64: untag user addresses in mm/gup.c
Date: Mon, 10 Dec 2018 13:51:01 +0100
Message-Id: <f67011f11f676bf7b947bf819273e22b828b9b9b.1544445454.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <cover.1544445454.git.andreyknvl@google.com>
References: <cover.1544445454.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_045124_314189_2F3269C7 
X-CRM114-Status: GOOD (  13.53  )
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
Cc: Chintan Pandya <cpandya@codeaurora.org>,
 Jacob Bramley <Jacob.Bramley@arm.com>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Andrey Konovalov <andreyknvl@google.com>, Lee Smith <Lee.Smith@arm.com>,
 Kostya Serebryany <kcc@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Evgeniy Stepanov <eugenis@google.com>
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
index 8cb68a50dbdf..409aedb1e2d5 100644
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
2.20.0.rc2.403.gdbc3b29805-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
