Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99906C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:51:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C8E520870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P1wZdjVM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="tvsXwVCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8E520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K3HZFVq+atwrMuW0B6RUG2QG1BqomrtzP3iAmsuAS4c=; b=P1wZdjVMRhaP0b
	wNJJtNqSL+f6hn2cmuJLKS1dfDSDIJZXlROL1aw4lJxew803SmZAqUIEYwon+3sZe2CIeyQf4b5Rn
	tgVAT92lO4GSGWAVKVVQZaMJieXmiBSdzYLFoMg3MUG6WJIJm8gEv6hSDaM3WUxX210YRv/ZBdzCx
	KrBD/GNFS5b3x100SeMfFUapXqldapN8dt4IRLkvg7cwf6lF0k5DRYaxze7Lh/+pUqGoXqMnlS+i0
	lLjFhn4VuENPZ5TNI+AFV/17RTWYMIqxhOTJCln+jELKardbpAuQO5LP0S+Kn5M4H+nRnNRIfjYVG
	wo7BXrGciPAbqe7nN0Pg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWL1w-0001EA-Tk; Mon, 10 Dec 2018 12:51:24 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWL1t-0001Bt-F9
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 12:51:23 +0000
Received: by mail-wr1-x441.google.com with SMTP id 96so10369174wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 04:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=spp1yx5uWvAgxErNR01vKeP4ipxAKNr5cbWijdqL/NI=;
 b=tvsXwVCKLmRdJsM+euD1t0rVUHOOn+/ZTTi3MnnQ9yebryAkbI4hvbPXubAR8j9xbT
 rSzx3Kyplc8mI1Q5cCWawts1mVwnbRT/UG0tp4Xvt5MDVVu5AjP34+MyjU+t6RTFt/1F
 GtjCSp16Bsb0olrw8ju4ga21oFPvQHFAjGiXj06kBSulY2fBvH1/8yimSxJdEzM0IjDe
 S2UHXqy/PlTnElD5PvCE/Ei8NOK6WhW4AzfjK1G4NAKHmzILpvArpdT0x23Ci7QVw1Jf
 siaqLTUGCqHPMIili1iJlbBGd6qfhARL0xDVAgzKR2wFfvkvY0Mi96XrFZLLMJ9KfrPg
 c6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=spp1yx5uWvAgxErNR01vKeP4ipxAKNr5cbWijdqL/NI=;
 b=jTk96L8WuVbdarFGR77V6VksLJJCjK3BRS8qx+hPx4/9IIhEgrs9jUoC1lL9Q7qWoZ
 JRD49fVP0qlXwo1n4TJY/WJGgzQQn9o2V7JOiJVNiI5gUAtgCGg+HAIjAy7Es5X/K1dH
 7Kqf68oLtvQTjHsC7jNRZfYP9Fv8b44zmFxji0OzBic67bykQ+mOIGqLjJi/HyBAP6Vv
 /bwed91QkHeowm5Vvd2yO0O6+MjoSZ6sJVtOCvF66TDcUW+hJQBEVP1QGakIEfP4eEq3
 Tk5zwsCreey06C6CYAe1BsAdjBicpHUKiopOZ/AfuhmU4+dCSqV2bdWATmmED8HoSGDj
 2Mqw==
X-Gm-Message-State: AA+aEWb+TFZF5B3DUkVeZRdtUJqSSK49upeaJZffG/Jmpgr91Iyyfqt8
 rF1RzkGwYRfKDrwco3OeuVhatg==
X-Google-Smtp-Source: AFSGD/WK6voMtzDjeOrD0p0dIVtqA5GSBJDXWoYR6ofaTs6wbsSMRcTZb/d4/4QZpcv/PkUOjr5HNQ==
X-Received: by 2002:a5d:684b:: with SMTP id o11mr9182121wrw.316.1544446274117; 
 Mon, 10 Dec 2018 04:51:14 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:10:3180:41f8:3010:ff61])
 by smtp.gmail.com with ESMTPSA id l197sm36893363wma.44.2018.12.10.04.51.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 04:51:13 -0800 (PST)
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
Subject: [PATCH v9 3/8] arm64: untag user addresses in access_ok and
 __uaccess_mask_ptr
Date: Mon, 10 Dec 2018 13:51:00 +0100
Message-Id: <674252952827b57f4259876cd4ddf802f3539356.1544445454.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <cover.1544445454.git.andreyknvl@google.com>
References: <cover.1544445454.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_045121_510609_67C26422 
X-CRM114-Status: GOOD (  14.51  )
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

copy_from_user (and a few other similar functions) are used to copy data
from user memory into the kernel memory or vice versa. Since a user can
provided a tagged pointer to one of the syscalls that use copy_from_user,
we need to correctly handle such pointers.

Do this by untagging user pointers in access_ok and in __uaccess_mask_ptr,
before performing access validity checks.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/uaccess.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 3c3864ba3cc1..d28c3b1314ce 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -104,7 +104,8 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
 #define untagged_addr(addr)		\
 	((__typeof__(addr))sign_extend64((u64)(addr), 55))
 
-#define access_ok(type, addr, size)	__range_ok(addr, size)
+#define access_ok(type, addr, size)	\
+	__range_ok(untagged_addr(addr), size)
 #define user_addr_max			get_fs
 
 #define _ASM_EXTABLE(from, to)						\
@@ -236,7 +237,8 @@ static inline void uaccess_enable_not_uao(void)
 
 /*
  * Sanitise a uaccess pointer such that it becomes NULL if above the
- * current addr_limit.
+ * current addr_limit. In case the pointer is tagged (has the top byte set),
+ * untag the pointer before checking.
  */
 #define uaccess_mask_ptr(ptr) (__typeof__(ptr))__uaccess_mask_ptr(ptr)
 static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
@@ -244,10 +246,11 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	void __user *safe_ptr;
 
 	asm volatile(
-	"	bics	xzr, %1, %2\n"
+	"	bics	xzr, %3, %2\n"
 	"	csel	%0, %1, xzr, eq\n"
 	: "=&r" (safe_ptr)
-	: "r" (ptr), "r" (current_thread_info()->addr_limit)
+	: "r" (ptr), "r" (current_thread_info()->addr_limit),
+	  "r" (untagged_addr(ptr))
 	: "cc");
 
 	csdb();
-- 
2.20.0.rc2.403.gdbc3b29805-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
