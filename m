Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277BCC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:27:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E00B720989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rwFzBNOT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Y2VohwGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00B720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EE48r4iQCt2yAidnHy3t+COVQYN7Ko6MO/AZXqhYNDY=; b=rwFzBNOTBoM/Sz
	HnpXXALhRuASC2St74TY4ZhzrOBpnEITqhTZVShDl+K1J9kumEMlVDl4nHQvx2I/LT5tjOTSyvjSz
	7U1/5zBamF7PeLoltHq65gr3IVMJRQrOm2Bt+qqaSK7UknDap9OGXiNToch5T1XlLkrjKYb9Cg0lg
	9NembWXdza7tVgkcu/xoUqFTAH/9hegw/EzyoAvBddQzSg6Fn2g0MHrKQ24ZJ5ex7tyTML41tN8BI
	Mz/Hhotn+0p6lwWZjI08kDgyqFQKBCrPSoS5jzEWdpiL2T3CY4ftu2t1Bkr0LWS//L0K3zgTYLiNE
	bM4hWP6nWx0eCONWM9cg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUsko-000663-Ti; Thu, 06 Dec 2018 12:27:42 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUsiP-00035K-17
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 12:25:16 +0000
Received: by mail-wm1-x344.google.com with SMTP id z18so788994wmc.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 04:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UqMDiL5pFL/+tkei1G/AIx7zwZMP99eD4KugQS7K55g=;
 b=Y2VohwGtLIqo6t/3aMQeakdW1sJ7UgqyXRDUNidOjVdD5M1bxlNFiaWPSn1bXLUyyF
 mCCWKClMkXpRl/CkEYHFhkecgRkp6UBK6sfIgjgkARPZuNzpSqHnINsuMeuueMsTmNvD
 Mb970K6ZZtXOqMs4Gaek4O18mqjDkafHoZWEvQa4fKAWweR9DbpR2Q7eZR4APBPmIkFH
 N3qGtFuiC24t7PZgMXta7ZPzCIcCq8Yl7LCg8wCFP5JpIj2RfyVIiKy7tRwzK6WESWKq
 SjD/5xD4Wzs6YWFY2xHp4H4kAcqBkIOdh05TJR5kuzLQ14sH63IMtTkNdNhpUY1CH8hi
 OqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UqMDiL5pFL/+tkei1G/AIx7zwZMP99eD4KugQS7K55g=;
 b=GNU4dLiS+reOFsbTv4OetHaSZtUUtw9EqQlkLGM2o5OsMf23Op9gGf4H2EH1tTnJh4
 qYRf7UcT2aVnKgcUqOoDF2wUsDFdklpvsgCE+0XItEm7EktBN9tXGHHhN1e++AuwtewI
 Asu7NX65Y32AuqNnDfEcA2C6sBAKsBI0Em0LCLlidwbxXFHntWIUfMOD0U64uIJ1VxT+
 xAEIDOM1uONtrSn+ueS9u36xu2wqhcaIg4limHFXjfgL13Ha7Okvvj1xUCDMGWJXbyUy
 UObKSVTWF+8xiajkYZqRf390JCPZpU71OjHVqFMX4gjr0oSgzGbfqM2Nbry9A4aMjXBv
 ZY/A==
X-Gm-Message-State: AA+aEWaoYwEJqgzjrqg7wtW7R4ZLQTO1zjqHZfSbf3g+toYvz5MbCi5f
 4dx/rKTcVq8wrRmnR/b1LmQ7Kg==
X-Google-Smtp-Source: AFSGD/UGniPFpytnR5EvX1mvUQCqi8xKkHyAIiafnkUS1yg6vUphxPqdq7r3o6WSEF+mrgSfvm3zrg==
X-Received: by 2002:a1c:2007:: with SMTP id g7mr18924469wmg.79.1544099106379; 
 Thu, 06 Dec 2018 04:25:06 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:10:3180:41f8:3010:ff61])
 by smtp.gmail.com with ESMTPSA id j8sm339988wrt.40.2018.12.06.04.25.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 04:25:05 -0800 (PST)
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
Subject: [PATCH v13 11/25] kasan, arm64: untag address in _virt_addr_is_linear
Date: Thu,  6 Dec 2018 13:24:29 +0100
Message-Id: <df73a37dd5ed37f4deaf77bc718e9f2e590e69b1.1544099024.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <cover.1544099024.git.andreyknvl@google.com>
References: <cover.1544099024.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_042513_523657_DF7909BD 
X-CRM114-Status: GOOD (  13.23  )
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

virt_addr_is_linear (which is used by virt_addr_valid) assumes that the
top byte of the address is 0xff, which isn't always the case with
tag-based KASAN.

This patch resets the tag in this macro.

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/memory.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 83c1366a1233..5fe2353f111b 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -322,9 +322,10 @@ static inline void *phys_to_virt(phys_addr_t x)
 #endif
 #endif
 
-#define _virt_addr_is_linear(kaddr)	(((u64)(kaddr)) >= PAGE_OFFSET)
-#define virt_addr_valid(kaddr)		(_virt_addr_is_linear(kaddr) && \
-					 _virt_addr_valid(kaddr))
+#define _virt_addr_is_linear(kaddr)	\
+	(__tag_reset((u64)(kaddr)) >= PAGE_OFFSET)
+#define virt_addr_valid(kaddr)		\
+	(_virt_addr_is_linear(kaddr) && _virt_addr_valid(kaddr))
 
 #include <asm-generic/memory_model.h>
 
-- 
2.20.0.rc1.387.gf8505762e3-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
