Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00CDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:31:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EBD821872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TF3jIDhB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="b6CeLxm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EBD821872
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GF7T7w6rbhIQwDOjerGPT/2bZR+QbvMUMU8hYG37dVI=; b=TF3jIDhBm/gIPe
	43wiS9N33zAdxGddGxEbLunHOTGOL7Ljo+PyW1zA8gIbgyF9oHQeQO9RM1+6zSstvbUWF9dx4v1EP
	laPltiRBAKNU8Y123M0Yr8wsAgrqKxAMaoVRSt2twsfBqJwpTQ1BWiZGVCUQFHK+xMSbtLlajnjbx
	n5ajvnS5r5KEVW5KMnikNlata6Qw7m+hfYstrMHasChBlNKiK3vVXE+XrHeH8PIR+/6wx1vts5gs2
	FxGUJoxNPxlYh951nfERVMFI5kLNQC8F0XIE8A5BeU26VIcP6AaFzIrbTCxbWQo560LG1FiBpWURQ
	3oaeA1LT++zlQ2MiRMJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZFSs-0008TE-E5; Tue, 18 Dec 2018 13:31:14 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZFSZ-0008E6-0n
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 13:31:01 +0000
Received: by mail-wm1-x341.google.com with SMTP id f188so2129694wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 05:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1DLr9hZIqfTBfQ8vZM5TVqGu/0wSU0e2RGylEo0U1xk=;
 b=b6CeLxm48QORSNimPysCsqnEvAwvbwCEMK3zZ2IeU55RUe8jfEaoKD7B2W5pu4GMVM
 ZMfAqk8UVGyjCZdWBu94z+/d06Nqhr39DI+oBkGQF6PQNRAP48V2nHE1nMmWB13EyfCm
 NtxsSWQvTBxTL+Fd0/UOOq7DzicVsxlDHD16s9b1lX0C6x/VSR5lAuzePhQ9L1d5Oul8
 VXrACEN0B09HGP6S1WtlkS87efzvH+4OfJy778AP3n08axpCT24ejrd+gQ8n9Wv0ZFss
 zNcku1rhZAk/DpR9yt64U57aTzC8whKP5MKSsmn/EKNweqDVHhOPHIVAgeVnlG4EPeY4
 Oa+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1DLr9hZIqfTBfQ8vZM5TVqGu/0wSU0e2RGylEo0U1xk=;
 b=ea27qv8DDqaNUxFA92RhHEA23e0M2r1D2XVyrMfiTu0zN4j/rBZAbXU9o7J5CSS1Qn
 MEwUtBimHZVGnxBD8vXJTxtujguURdecGh1Ivqxq9GtKYifq2UBZsjBZa+oR/1GOJRQR
 KKP4Zvdsmj46vuuZYekSWN3QezPrAl4b2Gmjufhf+YL4BoBAGg8CHprR+2odaq0NRIQT
 aX8Yd+TPvEvk18vRgVeEm4+qEHk6w81uedRuGioTiSonvqVfdhBx47LqYPdxo1KSshQw
 gwn+zwb6Fr+VltIjf+oIn5KqIroDhJuU7/g1yM+c2LvRkvMwJ+082H3+eWBxuYDYHU8g
 BJJg==
X-Gm-Message-State: AA+aEWZXDJuWO0DoTCVVQPfY8kuVNDrtyRyV+L5BSZPxRx1qVRLAB2iG
 GgBfdwWHJZJXgIG44JF84Ce1qw==
X-Google-Smtp-Source: AFSGD/Vk4dHI/WjETFO6q3mGOkSMUeOtBy8kBD/BEP66o/kq3hhOh6hYuClxgxsdrN7KcTWqc7mrIQ==
X-Received: by 2002:a1c:a104:: with SMTP id k4mr3226049wme.54.1545139839904;
 Tue, 18 Dec 2018 05:30:39 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:10:3180:41f8:3010:ff61])
 by smtp.gmail.com with ESMTPSA id g188sm1995927wmf.32.2018.12.18.05.30.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 05:30:38 -0800 (PST)
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
Subject: [PATCH mm] kasan,
 arm64: use ARCH_SLAB_MINALIGN instead of manual aligning
Date: Tue, 18 Dec 2018 14:30:33 +0100
Message-Id: <706da77adfceb0c324e824d03b52d58a752577ea.1545139710.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_053055_069144_0135AEB2 
X-CRM114-Status: GOOD (  12.11  )
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

Instead of changing cache->align to be aligned to KASAN_SHADOW_SCALE_SIZE
in kasan_cache_create() we can reuse the ARCH_SLAB_MINALIGN macro.

Suggested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/kasan.h | 4 ++++
 mm/kasan/common.c              | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasan.h
index b52aacd2c526..ba26150d578d 100644
--- a/arch/arm64/include/asm/kasan.h
+++ b/arch/arm64/include/asm/kasan.h
@@ -36,6 +36,10 @@
 #define KASAN_SHADOW_OFFSET     (KASAN_SHADOW_END - (1ULL << \
 					(64 - KASAN_SHADOW_SCALE_SHIFT)))
 
+#ifdef CONFIG_KASAN_SW_TAGS
+#define ARCH_SLAB_MINALIGN	(1ULL << KASAN_SHADOW_SCALE_SHIFT)
+#endif
+
 void kasan_init(void);
 void kasan_copy_shadow(pgd_t *pgdir);
 asmlinkage void kasan_early_init(void);
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 03d5d1374ca7..44390392d4c9 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -298,8 +298,6 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 		return;
 	}
 
-	cache->align = round_up(cache->align, KASAN_SHADOW_SCALE_SIZE);
-
 	*flags |= SLAB_KASAN;
 }
 
-- 
2.20.0.405.gbc1bbc6f85-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
