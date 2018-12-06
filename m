Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897EAC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:28:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44B2520838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VGUZ83Ps";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="VAlGzqot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B2520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/TKl4UtVpMXtCBzf/SQJ7V8Zkj7jqbZ0ReKaYJ3E84o=; b=VGUZ83PsqLXD5v
	m3hChS2reojUwDlCUs8xctcTIQBfwioSPeFlaoaMrpJVgNPZMstIChcn7EFP91xW1RLKYsgv6GYdx
	PZUqFoqCm9e1kqknBAB8iLZsBNF9tgbLSJYH6kMUjEAO+1BCuK71zXLtKfgoHG4Tr2q9mo1EC4RBt
	t9NVVrHTuNOZGiepbp3Feq8DS5/MyP1VK2S8vrZ6ti8GAh9o4LOxmOGdbk+npZ2I62BwH8M8kMIQI
	+Uj61Uj3ObuxdtxQeY23574D2hFw8Z2jHlCthdKfO4bR2z98AneUjQiPNTTKIrE21EUosTGyadEYh
	5HVbjOU9jwdtokEb0h+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUsl3-0006L8-ED; Thu, 06 Dec 2018 12:27:57 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUsiL-0002nw-HB
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 12:25:17 +0000
Received: by mail-wr1-x443.google.com with SMTP id p4so287077wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 04:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=F/Rs74E1jKAK3ACh/wE42WMWNbPFeAMFJIPcMbt9WD4=;
 b=VAlGzqot4KggH/2lBiRkMM4lITHs5IpRZ4p+F4SbO+qt098Hg0g4wlLA22lQa2+sgu
 1ZO/pc5wB2nDiSRi5FFQsNwlSmKERZzC6+C1bm7VRPFwLoKQrSId434VtYvpzCsk7c3i
 /vH7cIfPKbr+V1Dilr9fKTxodHnjd41ZTfyz597HV372In0cpd9mvAmlNFP+HJxA+AQ+
 mzStQ2w6DGPYRDzykQjqYtFlASCb4Bva887fDY6JzKFwMetT4nD71IbFlWztZ4E/AIat
 lVr7320saaRT4uROOn2botn655EPyWEYbn4KMSnBzLpXEAJMIWiYQJli7yQdCgLhi50x
 ffvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=F/Rs74E1jKAK3ACh/wE42WMWNbPFeAMFJIPcMbt9WD4=;
 b=MRQBP5G+EhsAyC/8tXgJB4j5jMwSJO9rAIm0cuaQPkBcG2+7bDABpl+MU9LNCYcglN
 YrHdQWtu5ljCDLCZxvkKSDBWSbRfjmdarO8vbwSlXEeZnDiOO5m/ZAQ0HDFtD3OMhyYE
 0r7ADtrU6h4BtVvBwuP3NJquE57i0zuZDr+Y1hqQxh1Bt7/484RqVVPZtikdcUKX+vre
 MDQ82/EsvWQj6NKD0q0WEPPRAJPLCMXpJoA5wduwmVEWCzKlYODCSEWKSGYFVQrxHj2B
 CPi8BK9rFXAabPwfRLlbwiWkwMkZm8oZ9O8yMXDwyRNXPPUYp7h4k7Lh/AypS0F1IjxF
 Tdbw==
X-Gm-Message-State: AA+aEWa7NqfMvQN6ISwleqA7cogwPChM6bmORA7kh72GCtJYPFQpAkTB
 QwdWwQlQDkl4AgNhFH5i4MxlmQ==
X-Google-Smtp-Source: AFSGD/XTYTqzsshlDGi9NHkEBAbQ2NsOtZrsn1Z0Y2zjYz0lfHZbxea+X0lOoDWgzEFhq8Dhw9ARjA==
X-Received: by 2002:adf:b783:: with SMTP id s3mr26257157wre.274.1544099102810; 
 Thu, 06 Dec 2018 04:25:02 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:10:3180:41f8:3010:ff61])
 by smtp.gmail.com with ESMTPSA id j8sm339988wrt.40.2018.12.06.04.25.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 04:25:01 -0800 (PST)
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
Subject: [PATCH v13 09/25] arm64: move untagged_addr macro from uaccess.h to
 memory.h
Date: Thu,  6 Dec 2018 13:24:27 +0100
Message-Id: <2e9ef8d2ed594106eca514b268365b5419113f6a.1544099024.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <cover.1544099024.git.andreyknvl@google.com>
References: <cover.1544099024.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_042509_869888_7FAE78DF 
X-CRM114-Status: GOOD (  13.59  )
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

Move the untagged_addr() macro from arch/arm64/include/asm/uaccess.h
to arch/arm64/include/asm/memory.h to be later reused by KASAN.

Also make the untagged_addr() macro accept all kinds of address types
(void *, unsigned long, etc.). This allows not to specify type casts in
each place where the macro is used. This is done by using __typeof__.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/memory.h  | 8 ++++++++
 arch/arm64/include/asm/uaccess.h | 7 -------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 05fbc7ffcd31..e2c9857157f2 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -211,6 +211,14 @@ static inline unsigned long kaslr_offset(void)
  */
 #define PHYS_PFN_OFFSET	(PHYS_OFFSET >> PAGE_SHIFT)
 
+/*
+ * When dealing with data aborts, watchpoints, or instruction traps we may end
+ * up with a tagged userland pointer. Clear the tag to get a sane pointer to
+ * pass on to access_ok(), for instance.
+ */
+#define untagged_addr(addr)	\
+	((__typeof__(addr))sign_extend64((u64)(addr), 55))
+
 /*
  * Physical vs virtual RAM address space conversion.  These are
  * private definitions which should NOT be used outside memory.h
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 07c34087bd5e..281a1e47263d 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -96,13 +96,6 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
 	return ret;
 }
 
-/*
- * When dealing with data aborts, watchpoints, or instruction traps we may end
- * up with a tagged userland pointer. Clear the tag to get a sane pointer to
- * pass on to access_ok(), for instance.
- */
-#define untagged_addr(addr)		sign_extend64(addr, 55)
-
 #define access_ok(type, addr, size)	__range_ok(addr, size)
 #define user_addr_max			get_fs
 
-- 
2.20.0.rc1.387.gf8505762e3-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
