Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FD8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:37:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487F7218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D6AHuGYf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="GBABedig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487F7218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xMSdrKJSoSiX+21PwbXrH6sMAxBMxx2yTqvcAm8lSbs=; b=D6AHuGYfMgJzg1
	7BPIhQYIn0TTljWbg1gOGlj0gtIiHS2ONaiAkmVzptYS0i06ayn7vh59sU0HorUztLP14duoNh2Ne
	LltR05/oUi+sZdqqm/ZQEsJxSAG65P/tJ9s2sHVEiQRtykucDtvwtOWRFHF0vJCMfZMufxQp/VurR
	eyxnnXIYnIdqxpTPAlM/ZACfLlStpBWIP1dkbg3NDQo1U2N/nHPhpi/QuWMyOTJSJSy4p0IKrsXud
	O8M8vDFL1dtE//B5wLNxsF/PoPkrrJbNnQeJ+IKHtUkWFyOhCx4xZ8CtHOfOnVtjwNfNOX5bsbWRE
	UKGz+prXmdx5dkHGn+5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gekRr-0005xu-Hq; Wed, 02 Jan 2019 17:36:55 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gekRI-0005PV-M4
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 17:36:23 +0000
Received: by mail-wm1-x341.google.com with SMTP id t200so16303622wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 02 Jan 2019 09:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wqfuZcAjUCBtOLKWkS6SRZq/hte3EYpV7rEPQw3hkz8=;
 b=GBABedigx8sH5GFwpRqipEDZ14ymhRvEFULjEU8wLa/LptdTisVFf9skUy8ylEKwgj
 RF12pUwr344Vyvy3ZqJC4iKm1OZSWqoVLD5mJZkl91WIY/lo6o1i2e7+QvZjCRXC8gqD
 TalGJ7+keqs9g4ydv5W/68JCwOiEcJUrlW170vCsYKVKJdezXyBqilxWlN06NaZHYTDc
 QQgWpPrpqe6SqK7zrP/HpOaRELc378Wew1Pp2kpkP+K7TKwG3na64p2Wzdh2fIyKQxWR
 416+4i3iHDx7qlDktBw/RgIj4tv1H8OekGka2BVVugetEBDgCsmpkgmw/g7V3gWXuDyc
 OjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wqfuZcAjUCBtOLKWkS6SRZq/hte3EYpV7rEPQw3hkz8=;
 b=R3QZP/Rqyyk1Cx4NMYuRn6FSKYq8KBdSqrBmpA0dCkgJ7AgvNazniuWrBAKrAICqta
 bS+E0dz9HTAjtLMwHGmVHpKN2Ituc4H3/x8yOQxzLMBFcT5PPMpjcxvrWznAJJ00pTua
 VLilIALgOBMWhvWVrw2HbRdshG7Od95sd+A9nvnMbLoH+PuR51NlERcROUkpkZ5/L0go
 Pha6DFlX8OqanzcUUFp7zTkq+YSrgMq6gr4suVXLlFjx5NQxv/M7GKdLf0ugTjw9cHUe
 tUD+GpeLPm3sEhvKYXv+uW+npRDSofr+pl53U+d7DM+A2TKya7VDLUTUVt0oFyWzwEFK
 VJQg==
X-Gm-Message-State: AA+aEWY9SyaAI18oXM/Osczc2E7dZJwimZJKf0MAzv5L9ap7EXCH7oQL
 r3AZnLKLleK4R9fHUj0zsajc3g==
X-Google-Smtp-Source: AFSGD/W97uWDkFBwjy9qVKlmOmTQCuBOdfdQInnihelGax0GIIIDp5gYRmDwwP96Pfhda8t/d8RaVw==
X-Received: by 2002:a1c:4108:: with SMTP id o8mr34987293wma.91.1546450576552; 
 Wed, 02 Jan 2019 09:36:16 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
 by smtp.gmail.com with ESMTPSA id t4sm45987076wrm.6.2019.01.02.09.36.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Jan 2019 09:36:15 -0800 (PST)
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
Subject: [PATCH v2 2/3] kasan: make tag based mode work with
 CONFIG_HARDENED_USERCOPY
Date: Wed,  2 Jan 2019 18:36:07 +0100
Message-Id: <21de3c171438760a232d51cea56792c886bc9160.1546450432.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <cover.1546450432.git.andreyknvl@google.com>
References: <cover.1546450432.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_093620_719939_99726798 
X-CRM114-Status: GOOD (  12.80  )
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
