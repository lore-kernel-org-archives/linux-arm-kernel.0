Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFFBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:45:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D19692184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uynXCdd4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Ba8p1LN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19692184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xMSdrKJSoSiX+21PwbXrH6sMAxBMxx2yTqvcAm8lSbs=; b=uynXCdd4p/Zz5/
	cYJhY1VA16ACSL7bUOwsb3yL3r5W1xgU9rb38ai0mIDEljjig7q28Ox5SF+Ob7UKAfS3sL1Fn7PMl
	uqFS8FGwXl5X7jJWgrUMvrVzmNbZ8pTH1THBRk5Fu2BVJIqBL8WRWUUihH1h4veKvPt6dEmL5bLLU
	+XYk5gYBy/5YitcoO9qAoJ5laUS73dX3/va/qMfsW0vkQcTNLh5OXjYU5RWFdD3gPJ78PeX+GEGIj
	F+3n4AyK5HkIag1g8BysDiZn3eFeuaVgjYkwLeFb3Bjp2vrWL0PsoSgIfSmGJZVAXD/kkG/wZp2bA
	L2bySOwBGAGrdO+nNS3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf7zx-0007Fl-1J; Thu, 03 Jan 2019 18:45:41 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf7zm-000759-D1
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 18:45:31 +0000
Received: by mail-wr1-x442.google.com with SMTP id 96so34538302wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 10:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wqfuZcAjUCBtOLKWkS6SRZq/hte3EYpV7rEPQw3hkz8=;
 b=Ba8p1LN6oK3Pi0Fl7zZMXYDUR1uRcqSUKMdpT1Q7mAQ6syoy5qLvkHGMUj6j/vGuB2
 mPO5FuGEoA96YcXVqzSpSwHEKELmv7R+EvR+inn+PIduuMt4TwXWHgaGeZc0ky7vvm86
 yH9L4u9oYTTxmMJbx5HQX1aqZm017enJlCtGAbNGdHs15wOBu7Y61tXbAM6zeVySF49T
 mmuEIvLHrEZb5taS7g9ooF90sN5EBjH7gGfduXn1VTHmhUOpSR2P22jZqk1x1eBZqFiP
 sH2YY6VeZEfqquy8gfHxRd99KsANe2ythZVkjVH7ZxaZekAiskkZhF+Vg3IKqAONrIV4
 HEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wqfuZcAjUCBtOLKWkS6SRZq/hte3EYpV7rEPQw3hkz8=;
 b=AcyK3OlUpvs8MNvJRZ+xUd+fUsDu+ifkvhQhp2jQkaCUCE5RJpQ4Yt/RcBIuhmOIub
 BvjPZS1J/xSlTl/W7Xl8+mzmyMbsNRP4l9yjdRZXA3lQS9oUH4KzHUBDt3N2ecwfgY6n
 CS1ut10CuJ4HF4gGRpCOdCmQ211UpUHcM06OoOdFcj02wP2EB2nHRFIaVoIws+S9x1gK
 VBsC+szc6f19QeCN9RVwz2vruDGjzmpdEw7zuMkeW6tQtUavs8uka6vaR//nBKh14s0D
 Z6lfCSNsTJCM/nUBPTwlpg6l7fLSNRvHsqOrQv/frY/lK2gK0p7dy8Xd60w4Y4cwD+3G
 AILw==
X-Gm-Message-State: AJcUukeQlA9QLqSuwgjatiBKz8N9XEU/cgpTg91UTae9sm3/hZ2m3dd8
 NATytrZrJeZ8GA4xMowLjs5KtA==
X-Google-Smtp-Source: ALg8bN4LFcO01Vv4WTRKcuv5YTd1wsOefh/eH/jXvbvXe+jy9rGwknH3ImOWsoQ1UvdKBEe2ffL9iQ==
X-Received: by 2002:a05:6000:f:: with SMTP id
 h15mr40972842wrx.248.1546541128878; 
 Thu, 03 Jan 2019 10:45:28 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
 by smtp.gmail.com with ESMTPSA id t12sm52236944wrr.65.2019.01.03.10.45.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Jan 2019 10:45:27 -0800 (PST)
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
Subject: [PATCH v3 2/3] kasan: make tag based mode work with
 CONFIG_HARDENED_USERCOPY
Date: Thu,  3 Jan 2019 19:45:20 +0100
Message-Id: <7e756a298d514c4482f52aea6151db34818d395d.1546540962.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <cover.1546540962.git.andreyknvl@google.com>
References: <cover.1546540962.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_104530_437178_3E58B7A5 
X-CRM114-Status: GOOD (  12.74  )
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

With CONFIG_HARDENED_USERCOPY enabled __check_heap_object() compares and
then subtracts a potentially tagged pointer with a non-tagged address of
the page that this pointer belongs to, which leads to unexpected behavior.

Untag the pointer in __check_heap_object() before doing any of these
operations.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/slub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 36c0befeebd8..1e3d0ec4e200 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3846,6 +3846,8 @@ void __check_heap_object(const void *ptr, unsigned long n, struct page *page,
 	unsigned int offset;
 	size_t object_size;
 
+	ptr = kasan_reset_tag(ptr);
+
 	/* Find object and usable object size. */
 	s = page->slab_cache;
 
-- 
2.20.1.415.g653613c723-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
