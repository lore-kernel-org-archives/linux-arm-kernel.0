Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBDBC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:28:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 138F820838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CVSpaXG5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Ujk3SHMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138F820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9HjXjps7JPAasT0bTeBoR/JuE3m/Qe0W+bHUOga6Puo=; b=CVSpaXG5UwDOX/
	NhEYJ6bpWwJpHaEykoWS/jqq4h/vn/T9ltbM2+1KZUXsvwzG+oAPQ9/GlMWer1OmziytjsMFS5G+W
	fLO8JyzFVX59h9fut6Iz+CHqJlYzH8TGhuPeqFS3fl1kex08HcyerEFE5HzYy/xzFyPRskCaKsngv
	P1LN8AgnTj/5qyAuVqTtTvKlckD1SbWicjJPLbePVYuVmWzK3HrCa53aV0ld5aoq84Ot+CeGSH0uH
	nSQP3XGAag4YyST3qfyiJzJ+9UAIee2PqWX+FDyF9sz64eXV6D282bUHhDbdio+60YdUsyvkkoFZK
	fvL1YmucuAMT0LJMJgRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUslY-0006oh-1y; Thu, 06 Dec 2018 12:28:28 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUsiS-0003cr-5C
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 12:25:18 +0000
Received: by mail-wr1-x441.google.com with SMTP id 96so320022wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 04:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fxqgizsGn0AaIQnRQ33dQkRGCaY8UuAWu0B6VsH5hUQ=;
 b=Ujk3SHMZqV7n0tte5Uw8nokkp/oH0FlKFLsFxzElZe9Z0slbPJEAJExlirmXwEUB/j
 qeFI1DE4ncGLA0+FkTusmS35oYv/U8UXI/jfcSKa3QRtSlDZ5L5lHaiWfjgmPd4nFF/+
 vGwiweNbXNO50gJDPLGhzJri8t+wJQe4o/ND+9KUuI2L26oBYQ8hULSaxQMaAnF/iqDX
 Hpv9wpz9cBx90ytQ87K72yusvxoLQs9ZuSGL0uO4fMjRQ9fR2bvdzrwnlroIA0fQeMGW
 0wXe8PTBJ4EYtsNFcnsc8WZUW2aYYzJizcPd8EFhPQh0QD0nyqeteBzhl8XYpy7aMdWS
 egGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fxqgizsGn0AaIQnRQ33dQkRGCaY8UuAWu0B6VsH5hUQ=;
 b=QP/hADQ+UDw2ioV8ohwZZmc2McT5UoTTAPI/dZDh0jqIMugjdx9JVsfcn8uZRdhXaA
 lavyuELzPwOP0krKgprdWsZ/X842ohUHJZ7JqldF6+dzJYM9Qp+lxg/pc0oxRmFv+GgL
 VT1jQcK0tJ7Qf1hrd/xHNPUWDGzSSch0oPxQOw8Kt3GhgJN7KhExC6zfUMNxhj1C3/sj
 v8QtabqV/YE19dKMn9omYa/5JnYH1jUNzP/y2zmMy96gJF1iglXsJLZcMLV0Zm/HOXOq
 IPODXFl7Jpx5eZRQi7uNLxG2xGlVUKBzG/vac61Qf3pXLDlAt4WBBf0Xkj7zkqLHJ6XE
 bhGw==
X-Gm-Message-State: AA+aEWaF1YPTM0JJ4GcCEIhBHbYnPPn3QyauC4j2xqIkIkyLBA3dEtf0
 f50XfaybnjPu11UnAkbrZKVebg==
X-Google-Smtp-Source: AFSGD/X/KL+bObt1e53j+RE7+vhNT1qCIPw5uSMB1tFkwSYT/Sx24y8tmABr3/CaYm5nM5Ne2TIj5Q==
X-Received: by 2002:adf:b783:: with SMTP id s3mr26257791wre.274.1544099113048; 
 Thu, 06 Dec 2018 04:25:13 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:10:3180:41f8:3010:ff61])
 by smtp.gmail.com with ESMTPSA id j8sm339988wrt.40.2018.12.06.04.25.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 04:25:12 -0800 (PST)
From: Andrey Konovalov <andreyknvl@google.com>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Christoph Lameter <cl@linux.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, kasan-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sparse@vger.kernel.org,
 linux-mm@kvack.org, linux-kbuild@vger.kernel.org
Subject: [PATCH v13 15/25] kasan,
 mm: perform untagged pointers comparison in krealloc
Date: Thu,  6 Dec 2018 13:24:33 +0100
Message-Id: <14f6190d7846186a3506cd66d82446646fe65090.1544099024.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <cover.1544099024.git.andreyknvl@google.com>
References: <cover.1544099024.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_042516_764852_644B552F 
X-CRM114-Status: GOOD (  14.31  )
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
Cc: Vishwath Mohan <vishwath@google.com>,
 Chintan Pandya <cpandya@codeaurora.org>, Jacob Bramley <Jacob.Bramley@arm.com>,
 Jann Horn <jannh@google.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Andrey Konovalov <andreyknvl@google.com>, Lee Smith <Lee.Smith@arm.com>,
 Kostya Serebryany <kcc@google.com>, Mark Brand <markbrand@google.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The krealloc function checks where the same buffer was reused or a new one
allocated by comparing kernel pointers. Tag-based KASAN changes memory tag
on the krealloc'ed chunk of memory and therefore also changes the pointer
tag of the returned pointer. Therefore we need to perform comparison on
untagged (with tags reset) pointers to check whether it's the same memory
region or not.

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/slab_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 5f3504e26d4c..5aabcbd32d82 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1534,7 +1534,7 @@ void *krealloc(const void *p, size_t new_size, gfp_t flags)
 	}
 
 	ret = __do_krealloc(p, new_size, flags);
-	if (ret && p != ret)
+	if (ret && kasan_reset_tag(p) != kasan_reset_tag(ret))
 		kfree(p);
 
 	return ret;
-- 
2.20.0.rc1.387.gf8505762e3-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
