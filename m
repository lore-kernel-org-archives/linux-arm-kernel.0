Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65764C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:26:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE3F208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hT5KhD6j";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Pf39mxwR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE3F208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FSliVqV58/2nbbhh7rjlR7fOPEJa3a8HShIfOnTo/Pk=; b=hT5KhD6jx1bVx9
	2SDLSBKEyX2v58JnX5CNU15Id70pKmwUkxGaH4I04q+aUQYJMIsb0XWagBz9kDxtslWCZU+PKoIPH
	29Wr0n3upfxJpEb3WM1ehpe1YfzlTkuPwSpbj7OyBJrzrukgQXAVirt4icVgZP71JRiZBFrHNfKbR
	wly45aAl1Rrl/CkB9AlLAztjHc0zQdPVFB6+Mbp2Ke6/e7lj13AsktnJo/oRB7gLEc2ZoYSFzpuEy
	2HlWz9EvD2yxoqCf1OKI4Oot2EjuuqVSTLGiGCPT7/DeJtkuHtLbwYX+9z/pa8E4gSpTSB4Zhah1w
	A9q5AjsUWXTP5sMm3WCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUsjX-00050E-82; Thu, 06 Dec 2018 12:26:23 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUsiH-0002ZR-F2
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 12:25:09 +0000
Received: by mail-wr1-x444.google.com with SMTP id x10so281120wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 04:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Kn5CDDyDqdktmueSgYXSsO0zwDwfFFrMoSLJG2Ivw50=;
 b=Pf39mxwRcpa7KrX6UwoJEQfz3CfXq5RBMJ6m5aM5/gDD8ItWtZq5G1xjMawUGn+z+T
 dS+/sMDdEwBB6CM7bHAttpoCEIgFl/kBeGPn3lwT1LywZDgoWZOOLzWJ2RZ2yetGz9o9
 lMtnP1mE+kwTeKyEArzQjzOtctZLFx7BLRHSE0CEcCJLYjXIGKOCJ6xwLrKMHD6bes7C
 7uOYfXDimhdwWkbB2RWHOR+L5Z59vziD3aEiJFEdoJazqAi7fgF+yBbpulYxf79uEPLu
 6Lu2htdc0fEE4NHxlu9JEzcIxCl/CyyVSkHgAm7pbWxdsZHVrmTWKfD28vT5Pk9MVFVa
 +D/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Kn5CDDyDqdktmueSgYXSsO0zwDwfFFrMoSLJG2Ivw50=;
 b=k258d0pOgGssW4JAwCuDLOpahav8qfJq1iRpaRUrkkSj0Eqr0zNFu6AxsqQcmuCq0R
 O+JHEQU4vSSiOiRZ9TpSrDpdaSc06b7CkPw0+M4Sh+7rVPVkGdwKrDqp1x3yaLaULYmN
 kj2Cp7u7B+geMQfL0caGguwMM+X1BnC2c6n78IPsP2lZ3xWNG8anex20vea6EYVhTSkN
 Qo+dpto1hAjiEFNY1Ur4F8GGuTPnMU+HYUZbSrRVFejharfjd+SimvVNrhcOowY74VaX
 0lX+ab6s2HKUi29S1UMH4T14n3nTXugiUul10ikGVdDuLb3n7TcrfDc5bbjj3KKWP3PV
 AECA==
X-Gm-Message-State: AA+aEWY6iUr6ZCy5fzWeUG4z6GOMdgqrRLg3XATYchv9k3WizWyhkQ1D
 S4BBt6AkFi8gAABABsdBC4h0Kw==
X-Google-Smtp-Source: AFSGD/XqP2P/Wb4WdG1rKPMTei3wp8lKRgpVfvbDuVz/Yb1l+zYY35vzWOnd/pnfJMaPCW4EAswf3w==
X-Received: by 2002:a5d:4d11:: with SMTP id z17mr24026901wrt.209.1544099094073; 
 Thu, 06 Dec 2018 04:24:54 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:10:3180:41f8:3010:ff61])
 by smtp.gmail.com with ESMTPSA id j8sm339988wrt.40.2018.12.06.04.24.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 04:24:53 -0800 (PST)
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
Subject: [PATCH v13 04/25] kasan: rename source files to reflect the new
 naming scheme
Date: Thu,  6 Dec 2018 13:24:22 +0100
Message-Id: <88c6fd2a883e459e6242030497230e5fb0d44d44.1544099024.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <cover.1544099024.git.andreyknvl@google.com>
References: <cover.1544099024.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_042505_584116_12E75EDD 
X-CRM114-Status: GOOD (  11.94  )
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

We now have two KASAN modes: generic KASAN and tag-based KASAN. Rename
kasan.c to generic.c to reflect that. Also rename kasan_init.c to init.c
as it contains initialization code for both KASAN modes.

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/Makefile                 | 8 ++++----
 mm/kasan/{kasan.c => generic.c}   | 0
 mm/kasan/{kasan_init.c => init.c} | 0
 3 files changed, 4 insertions(+), 4 deletions(-)
 rename mm/kasan/{kasan.c => generic.c} (100%)
 rename mm/kasan/{kasan_init.c => init.c} (100%)

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index a6df14bffb6b..d643530b24aa 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -1,14 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
 KASAN_SANITIZE := n
 UBSAN_SANITIZE_common.o := n
-UBSAN_SANITIZE_kasan.o := n
+UBSAN_SANITIZE_generic.o := n
 KCOV_INSTRUMENT := n
 
-CFLAGS_REMOVE_kasan.o = -pg
+CFLAGS_REMOVE_generic.o = -pg
 # Function splitter causes unnecessary splits in __asan_load1/__asan_store1
 # see: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63533
 
 CFLAGS_common.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
-CFLAGS_kasan.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
+CFLAGS_generic.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 
-obj-y := common.o kasan.o report.o kasan_init.o quarantine.o
+obj-y := common.o generic.o report.o init.o quarantine.o
diff --git a/mm/kasan/kasan.c b/mm/kasan/generic.c
similarity index 100%
rename from mm/kasan/kasan.c
rename to mm/kasan/generic.c
diff --git a/mm/kasan/kasan_init.c b/mm/kasan/init.c
similarity index 100%
rename from mm/kasan/kasan_init.c
rename to mm/kasan/init.c
-- 
2.20.0.rc1.387.gf8505762e3-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
