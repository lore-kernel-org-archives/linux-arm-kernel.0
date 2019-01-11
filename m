Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABA2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:47:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B998F204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qRvB5apT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="NEkMkJ+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B998F204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=uZGIpeWjv5p/Tb7acQNQmqmyHrVkvytnxRXIo9N+D4A=; b=qRvB5apT2qJ5/C
	mvEyXg5/pbvrfMxYfk03NW8jiqD+SJkfzuMcnteXncawHLA1zYHJz8QNkpx0inu+0LOnc3ZIKtPeK
	6pFKOUUKloG2Myacb8CAkgcNlb4OMVliso9ABb85us/BPmmcviFAMolNKW1DucpByDuGE0Ylsjb8m
	hN8sKDym6VLiLoYlirS7XHnLVcGTgP0zSdWyZLePclIjvp8NtP0GF9Dcza1crdhZkaBIcVkqCmtqO
	CuYTzko6P6Y9TwAASlV8yJrA+sMTGQlMmTKn/GQEQj8zVgoXjhhi1H8uevYGg4FXXyoAsHrh2mL25
	DPgPKpD8y5NdLPXc8hQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghxA9-0005tn-Qy; Fri, 11 Jan 2019 13:47:53 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghxA6-0005t3-Gq
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 13:47:51 +0000
Received: by mail-wr1-x442.google.com with SMTP id p4so15256812wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 05:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JfzJzGO9UGsoHAHmj51k1BlHyWbSStwDHYTwKhI57Y4=;
 b=NEkMkJ+mRpnXceIfKVHdidDME1rqbsVFFyuYNbksIGQ533359BmSQX2EilvvFPUN6D
 tGfDFrq2ukPIHlM36+5L0mDWXTb6Ve78GanvqRtToFr9dzd5KVM3wt9Pdl6siWpUfse4
 FM0lDfchKlAfLUl0AZ5gJk8fL7NW1qg+hR9XSoLfs+Z5XmjjckYgRkY/AkXKSzSCU91y
 J+sHFqQ8l26j7qabqmqE5gGX/GMMNOIuG3uKV4yyNrFVQmdFZgyrIK7bQhcGK3CrmYTF
 10lqjyd/OFB8ceEbDt1sdwwdIcMne/mU27opORNvTLOz9taoqsIXnKQtKou48XFVcVW8
 MQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JfzJzGO9UGsoHAHmj51k1BlHyWbSStwDHYTwKhI57Y4=;
 b=kCpjTdtF6ZN2UWMTdS5DJVyenbJLdfT6whUBlrzk12CBgoguqUS+jz/TKsu0Ds/PFn
 5C1pv7AYXwgk089eq+lC7TciTRLPAlOlk36LO/diIti1F+03wjSRUWI7XNye/Y2r7itP
 5YtdwA26pLK6yx7JqztGwWL2r4Gsekok9922r7RzZiiCMxO6KgwZEUlQLjmkFCa8x9FE
 UextJkEl5af9mhtusLWUqgoroLAhPubjMusZFFbsgvJSuQpm/axPgWny8JOdDoOm2Jut
 1V8SNfcLp26qSR7J4rVWqc0/z30lh/iy5uWmSK8Lv6Hbq+YviGVxIMq0dsrLtxxM5ZrS
 7Qcg==
X-Gm-Message-State: AJcUukcM0Rcy1smvQwS/Giv1A/+3Vv9CxkisdYjTRcca56eCYCswX/g7
 lzqaYhYSdG4YZJOL+sJUgcywIA==
X-Google-Smtp-Source: ALg8bN79o72/jOe8866Av4s1M/ZY2sXogUQzDJeTqtK3cI+i3sVXtdmXDxWwD/wEpFd113uizmdOkg==
X-Received: by 2002:a5d:454f:: with SMTP id p15mr14423289wrr.39.1547214464989; 
 Fri, 11 Jan 2019 05:47:44 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
 by smtp.gmail.com with ESMTPSA id 3sm22946971wmw.46.2019.01.11.05.47.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 05:47:43 -0800 (PST)
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
 Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sparse@vger.kernel.org,
 linux-mm@kvack.org, linux-kbuild@vger.kernel.org
Subject: [PATCH] kasan, arm64: remove redundant ARCH_SLAB_MINALIGN define
Date: Fri, 11 Jan 2019 14:47:40 +0100
Message-Id: <7f36be5fdf491259d6c8100232fa93ff40edf841.1547214440.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_054750_606956_21DD6358 
X-CRM114-Status: GOOD (  11.40  )
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

Defining ARCH_SLAB_MINALIGN in arch/arm64/include/asm/cache.h when KASAN
is off is not needed, as it is defined in defined in include/linux/slab.h
as ifndef.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/cache.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index eb43e09c1980..926434f413fa 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -60,8 +60,6 @@
 
 #ifdef CONFIG_KASAN_SW_TAGS
 #define ARCH_SLAB_MINALIGN	(1ULL << KASAN_SHADOW_SCALE_SHIFT)
-#else
-#define ARCH_SLAB_MINALIGN	__alignof__(unsigned long long)
 #endif
 
 #ifndef __ASSEMBLY__
-- 
2.20.1.97.g81188d93c3-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
