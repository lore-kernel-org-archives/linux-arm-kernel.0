Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8BEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:03:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD6C20866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bQMKfdeO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y+A1yzQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD6C20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=VajP8AOI4ZE1+Uy2Jg2YmblmorYv/1raccR/EMEgqiU=; b=bQMKfdeOefM+6gUqGU8URgOaA+
	P4LiAfCdqQDbtFmnhjkXhw0OHJMOaio5u3KkxeUUp9tE+lYRKKM5MYk8Lht+2elWWcPcK1swH9VT5
	tPevrKIGUjPTLUFDE7kr0widAriL8C2TXgo/AIfEaP8KJAsq/GKaKqNwLfw/RlBqrXRN+jiI/sOUp
	i5FbZfgbeF6MEFy4TmNy+5CvM2TqSLhfqU2t/XF5VKX+/KSrWOIv78r4T2qI3R6qJxvBwMvgru2hv
	4ByxySbJYyPGXr9SVtYkHYu4RFk7yZyPT3Hr8lDvzLGczR13cnXlh8DDgGqNx7uhPgmILMnfBZhz+
	jKw4+i8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjPJO-0003fA-Po; Tue, 15 Jan 2019 14:03:26 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjPEv-0005uM-Ow
 for linux-arm-kernel@bombadil.infradead.org; Tue, 15 Jan 2019 13:58:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZT4DBP53odizrQMFob2m8QmVwEyNZWfBhQwjCEQfYPw=; b=Y+A1yzQKIGDxM+YhY7B5zl0Lx
 RQcgNEmu/C90USBDJ/mx5tnM4TaAk2Z4i80mTyTIUWVlX6I30bfTVekBJqv0sTt1tR6vLu3XnObg8
 rWgjWYbM2lnzVNNFb3Xe18wB339kDDHepNgmdksUuOElNXtMOgkbwssgSKqBzwz6P2pqM1fGMEv1k
 OuoCtw8XTbm+YimNEqAzC3Fb5tUKOvK4KLcyacCPmWow9EdVwLcLa7qE+ph06GAkuHUsTEWs3xFFb
 LIgAghVJ9+TqU8Aa6qCWz4hJEHO/fQkBSn12cZnhMvI/tqbgzC21aPN4AOxqMDfC3EffF6PI/v7Dm
 ggKvkwaCA==;
Received: from foss.arm.com ([217.140.101.70])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjPEs-0003pR-KM
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 13:58:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8425115AB;
 Tue, 15 Jan 2019 05:58:41 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B84943F70D;
 Tue, 15 Jan 2019 05:58:39 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/4] arm64: uaccess: Implement unsafe accessors
Date: Tue, 15 Jan 2019 13:58:27 +0000
Message-Id: <1547560709-56207-3-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_085846_841134_7D5C3F5F 
X-CRM114-Status: GOOD (  15.22  )
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
Cc: Julien Thierry <julien.thierry@arm.com>, peterz@infradead.org,
 catalin.marinas@arm.com, will.deacon@arm.com, mingo@redhat.com,
 james.morse@arm.com, hpa@zytor.com, valentin.schneider@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Current implementation of get/put_user_unsafe default to get/put_user
which toggle PAN before each access, despite having been told by the caller
that multiple accesses to user memory were about to happen.

Provide implementations for user_access_begin/end to turn PAN off/on and
implement unsafe accessors that assume PAN was already turned off.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>

---
 arch/arm64/include/asm/uaccess.h | 79 ++++++++++++++++++++++++++++++----------
 1 file changed, 59 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 8e40808..6a70c75 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -270,31 +270,26 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)

 #define __raw_get_user(x, ptr, err)					\
 do {									\
-	unsigned long __gu_val;						\
-	__chk_user_ptr(ptr);						\
-	uaccess_enable_not_uao();					\
 	switch (sizeof(*(ptr))) {					\
 	case 1:								\
-		__get_user_asm("ldrb", "ldtrb", "%w", __gu_val, (ptr),  \
+		__get_user_asm("ldrb", "ldtrb", "%w", (x), (ptr),	\
 			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	case 2:								\
-		__get_user_asm("ldrh", "ldtrh", "%w", __gu_val, (ptr),  \
+		__get_user_asm("ldrh", "ldtrh", "%w", (x), (ptr),	\
 			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	case 4:								\
-		__get_user_asm("ldr", "ldtr", "%w", __gu_val, (ptr),	\
+		__get_user_asm("ldr", "ldtr", "%w", (x), (ptr),		\
 			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	case 8:								\
-		__get_user_asm("ldr", "ldtr", "%x",  __gu_val, (ptr),	\
+		__get_user_asm("ldr", "ldtr", "%x",  (x), (ptr),	\
 			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
 	}								\
-	uaccess_disable_not_uao();					\
-	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
 } while (0)

 #define __get_user_error(x, ptr, err)					\
@@ -302,8 +297,13 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	__typeof__(*(ptr)) __user *__p = (ptr);				\
 	might_fault();							\
 	if (access_ok(__p, sizeof(*__p))) {				\
+		unsigned long __gu_val;					\
+		__chk_user_ptr(__p);					\
 		__p = uaccess_mask_ptr(__p);				\
-		__raw_get_user((x), __p, (err));			\
+		uaccess_enable_not_uao();				\
+		__raw_get_user(__gu_val, __p, (err));			\
+		uaccess_disable_not_uao();				\
+		(x) = (__force __typeof__(*__p)) __gu_val;		\
 	} else {							\
 		(x) = 0; (err) = -EFAULT;				\
 	}								\
@@ -334,30 +334,26 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)

 #define __raw_put_user(x, ptr, err)					\
 do {									\
-	__typeof__(*(ptr)) __pu_val = (x);				\
-	__chk_user_ptr(ptr);						\
-	uaccess_enable_not_uao();					\
 	switch (sizeof(*(ptr))) {					\
 	case 1:								\
-		__put_user_asm("strb", "sttrb", "%w", __pu_val, (ptr),	\
+		__put_user_asm("strb", "sttrb", "%w", (x), (ptr),	\
 			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	case 2:								\
-		__put_user_asm("strh", "sttrh", "%w", __pu_val, (ptr),	\
+		__put_user_asm("strh", "sttrh", "%w", (x), (ptr),	\
 			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	case 4:								\
-		__put_user_asm("str", "sttr", "%w", __pu_val, (ptr),	\
+		__put_user_asm("str", "sttr", "%w", (x), (ptr),		\
 			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	case 8:								\
-		__put_user_asm("str", "sttr", "%x", __pu_val, (ptr),	\
+		__put_user_asm("str", "sttr", "%x", (x), (ptr),		\
 			       (err), ARM64_HAS_UAO);			\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
 	}								\
-	uaccess_disable_not_uao();					\
 } while (0)

 #define __put_user_error(x, ptr, err)					\
@@ -365,9 +361,13 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	__typeof__(*(ptr)) __user *__p = (ptr);				\
 	might_fault();							\
 	if (access_ok(__p, sizeof(*__p))) {				\
+		__typeof__(*(ptr)) __pu_val = (x);			\
+		__chk_user_ptr(__p);					\
 		__p = uaccess_mask_ptr(__p);				\
-		__raw_put_user((x), __p, (err));			\
-	} else	{							\
+		uaccess_enable_not_uao();				\
+		__raw_put_user(__pu_val, __p, (err));			\
+		uaccess_disable_not_uao();				\
+	} else {							\
 		(err) = -EFAULT;					\
 	}								\
 } while (0)
@@ -381,6 +381,45 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)

 #define put_user	__put_user

+static __must_check inline bool user_access_begin(const void __user *ptr,
+						  size_t len)
+{
+	if (unlikely(!access_ok(ptr, len)))
+		return false;
+
+	uaccess_enable_not_uao();
+	return true;
+}
+#define user_access_begin(ptr, len)	user_access_begin(ptr, len)
+#define user_access_end()		uaccess_disable_not_uao()
+
+#define unsafe_get_user(x, ptr, err)					\
+do {									\
+	__typeof__(*(ptr)) __user *__p = (ptr);				\
+	unsigned long __gu_val;						\
+	int __gu_err = 0;						\
+	might_fault();							\
+	__chk_user_ptr(__p);						\
+	__p = uaccess_mask_ptr(__p);					\
+	__raw_get_user(__gu_val, __p, __gu_err);			\
+	(x) = (__force __typeof__(*__p)) __gu_val;			\
+	if (__gu_err != 0)						\
+		goto err;						\
+} while (0)
+
+#define unsafe_put_user(x, ptr, err)					\
+do {									\
+	__typeof__(*(ptr)) __user *__p = (ptr);				\
+	__typeof__(*(ptr)) __pu_val = (x);				\
+	int __pu_err = 0;						\
+	might_fault();							\
+	__chk_user_ptr(__p);						\
+	__p = uaccess_mask_ptr(__p);					\
+	__raw_put_user(__pu_val, __p, __pu_err);			\
+	if (__pu_err != 0)						\
+		goto err;						\
+} while (0)
+
 extern unsigned long __must_check __arch_copy_from_user(void *to, const void __user *from, unsigned long n);
 #define raw_copy_from_user(to, from, n)					\
 ({									\
--
1.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
