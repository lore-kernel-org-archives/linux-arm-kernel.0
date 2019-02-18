Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8954CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:09:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C422176F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="puGl+/Nq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AIcNWw/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C422176F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=BBunDsjrDhO264puZJ5BFzA21ffFjpn7Z3o64UE83uw=; b=puGl+/NqvBc45h
	yKNclDWRS/wy5svTGeshFzK5ReinaJZOnQJk6/k5RT17u2HsttvbQI/yUUn+whuUtzLlqNDN83pi7
	KAbnVdaEv24/3nvIMwY8kvy09OH5w6sgrC8boJkKuXkBlZSGkaJBbH3L+1tax3vvb83q4mMp3QQEg
	UsVSffNaONTBGM75fKEkAePCEzNCvCVBdzMIo3O8GQ822W6JITl/EdzeiSVqAcvsREY2c2EpfjZEf
	34Icj1OvuNvIufzTvrB5J2Zs9EAZki73oK6Bc0Q+5I+TAguG57WbCjobJqXkgIZiZrZjvNJbMQ8Hr
	/RANO9CV+QO5gdaK4eNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvs1y-00072z-Ic; Mon, 18 Feb 2019 23:08:58 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvs1u-00072L-NF
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 23:08:56 +0000
Received: by mail-wr1-x444.google.com with SMTP id d17so5716224wre.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 15:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EP+WFPDRsonbIe4RHBPZCD+zNiL1GGOxakU9E0tXC64=;
 b=AIcNWw/FmPm4ydB5rsbLSvvlOZQgbCXrkv8mKUnWJ9s2j8zVw907kZmnYMS1yamLfh
 f6KrYrqxMfQp8lnXkkNWXvMmWiMDpbUODEq0CLOIR+uTK8CwgctpBuhdP7nR/WRlAfOK
 Eyvwf+GfGwP9LBJcZH4JGfDwHoKIiFMxeUsCR5hWoFQnzbd72XOQjuo/1lQNgllz/v2f
 KnZTI3+LbZ4FobUuZ0qCbeAGS2kZgwlh/6euNipKEsIFl6cOXGBXCUjpgUK/g6WILX8O
 qJwo/2AyIiqte4s2FvyGRlB1Ebyh7PnAea4bbSB1BmRtf49PH4b1Zf5AglG0Sa/tF2gC
 ih/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EP+WFPDRsonbIe4RHBPZCD+zNiL1GGOxakU9E0tXC64=;
 b=NNqNJidUQZXQ8InriiCtSGqFhbsG+tbR5JfB71t5bAVY1qSjFm/EGatxDPd9Qw74FF
 cZXiZgJPBpXmI8ThPYumAyycFJtJva8IeziAEoQsY01b/tQKYDSEuAORRYQWiLpxwTRu
 Oe1Z8pG1jqTVDBZdiRFtjd7xPwcqecRVbsNjEzzrhPVQJ/azp8L8A8cRr1jy0dSl0tHu
 rexrV3YqMV16S100cfMixaiJv9Zmf6USnmrHnXXJqKqrp2+Z6sZdOde2HTn4ORDki3Ye
 r6n2nasHLn1v8M4zZOAgt2s1uOU2uR0jV2U/YX0e38GPRgnaR5Vsr9ELzFM7OCt19kXh
 hy0Q==
X-Gm-Message-State: AHQUAubiaOSJrDHhweXQBggwBaIoO2Ci8PnuKwTdAfuV1GnJnlawqLfp
 6iJXqRWUP0RFZLMHNcZULvfzVxYuj9Q=
X-Google-Smtp-Source: AHgI3IbqjkogDZHuVUD5uAtDWygWrixKjf0JCR5m3qr6gzm8sZyPrefTmyQsNGoGbzK9c2oid8epMg==
X-Received: by 2002:a5d:434f:: with SMTP id u15mr17427892wrr.174.1550531330461; 
 Mon, 18 Feb 2019 15:08:50 -0800 (PST)
Received: from sudo.home ([2a01:cb1d:112:6f00:4165:624e:307c:25e9])
 by smtp.gmail.com with ESMTPSA id m16sm12290983wro.78.2019.02.18.15.08.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 15:08:49 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: do_csum: implement accelerated scalar version
Date: Tue, 19 Feb 2019 00:08:42 +0100
Message-Id: <20190218230842.11448-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_150854_764841_BC721484 
X-CRM114-Status: GOOD (  19.74  )
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, netdev@vger.kernel.org,
 ilias.apalodimas@linaro.org, will.deacon@arm.com,
 "huanglingyan \(A\)" <huanglingyan2@huawei.com>, steve.capper@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

It turns out that the IP checksumming code is still exercised often,
even though one might expect that modern NICs with checksum offload
have no use for it. However, as Lingyan points out, there are
combinations of features where the network stack may still fall back
to software checksumming, and so it makes sense to provide an
optimized implementation in software as well.

So provide an implementation of do_csum() in scalar assembler, which,
unlike C, gives direct access to the carry flag, making the code run
substantially faster. The routine uses overlapping 64 byte loads for
all input size > 64 bytes, in order to reduce the number of branches
and improve performance on cores with deep pipelines.

On Cortex-A57, this implementation is on par with Lingyan's NEON
implementation, and roughly 7x as fast as the generic C code.

Cc: "huanglingyan (A)" <huanglingyan2@huawei.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
Test code after the patch.

 arch/arm64/include/asm/checksum.h |   3 +
 arch/arm64/lib/Makefile           |   2 +-
 arch/arm64/lib/csum.S             | 127 ++++++++++++++++++++
 3 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/checksum.h b/arch/arm64/include/asm/checksum.h
index 0b6f5a7d4027..e906b956c1fc 100644
--- a/arch/arm64/include/asm/checksum.h
+++ b/arch/arm64/include/asm/checksum.h
@@ -46,6 +46,9 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 }
 #define ip_fast_csum ip_fast_csum
 
+extern unsigned int do_csum(const unsigned char *buff, int len);
+#define do_csum do_csum
+
 #include <asm-generic/checksum.h>
 
 #endif	/* __ASM_CHECKSUM_H */
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 5540a1638baf..a7606007a749 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -3,7 +3,7 @@ lib-y		:= clear_user.o delay.o copy_from_user.o		\
 		   copy_to_user.o copy_in_user.o copy_page.o		\
 		   clear_page.o memchr.o memcpy.o memmove.o memset.o	\
 		   memcmp.o strcmp.o strncmp.o strlen.o strnlen.o	\
-		   strchr.o strrchr.o tishift.o
+		   strchr.o strrchr.o tishift.o csum.o
 
 ifeq ($(CONFIG_KERNEL_MODE_NEON), y)
 obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
diff --git a/arch/arm64/lib/csum.S b/arch/arm64/lib/csum.S
new file mode 100644
index 000000000000..534e2ebdc426
--- /dev/null
+++ b/arch/arm64/lib/csum.S
@@ -0,0 +1,127 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Linaro, Ltd. <ard.biesheuvel@linaro.org>
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+ENTRY(do_csum)
+	adds		x2, xzr, xzr		// clear x2 and C flag
+
+	// 64 bytes at a time
+	lsr		x3, x1, #6
+	and		x1, x1, #63
+	cbz		x3, 1f
+
+	// Eight 64-bit adds per iteration
+0:	ldp		x4, x5, [x0], #64
+	ldp		x6, x7, [x0, #-48]
+	ldp		x8, x9, [x0, #-32]
+	ldp		x10, x11, [x0, #-16]
+	adcs		x2, x2, x4
+	sub		x3, x3, #1
+	adcs		x2, x2, x5
+	adcs		x2, x2, x6
+	adcs		x2, x2, x7
+	adcs		x2, x2, x8
+	adcs		x2, x2, x9
+	adcs		x2, x2, x10
+	adcs		x2, x2, x11
+	cbnz		x3, 0b
+	adc		x2, x2, xzr
+
+	cbz		x1, 7f
+	bic		x3, x1, #1
+	add		x12, x0, x1
+	add		x0, x0, x3
+	neg		x3, x3
+	add		x3, x3, #64
+	lsl		x3, x3, #3
+
+	// Handle remaining 63 bytes or less using an overlapping 64-byte load
+	// and a branchless code path to complete the calculation
+	ldp		x4, x5, [x0, #-64]
+	ldp		x6, x7, [x0, #-48]
+	ldp		x8, x9, [x0, #-32]
+	ldp		x10, x11, [x0, #-16]
+	ldrb		w12, [x12, #-1]
+
+	.irp		reg, x4, x5, x6, x7, x8, x9, x10, x11
+	cmp		x3, #64
+	csel		\reg, \reg, xzr, lt
+	ccmp		x3, xzr, #0, lt
+	csel		x13, x3, xzr, gt
+	sub		x3, x3, #64
+CPU_LE(	lsr		\reg, \reg, x13		)
+CPU_BE(	lsl		\reg, \reg, x13		)
+	.endr
+
+	adds		x2, x2, x4
+	adcs		x2, x2, x5
+	adcs		x2, x2, x6
+	adcs		x2, x2, x7
+	adcs		x2, x2, x8
+	adcs		x2, x2, x9
+	adcs		x2, x2, x10
+	adcs		x2, x2, x11
+	adc		x2, x2, xzr
+
+CPU_LE(	adds		x12, x2, x12		)
+CPU_BE(	adds		x12, x2, x12, lsl #8	)
+	adc		x12, x12, xzr
+	tst		x1, #1
+	csel		x2, x2, x12, eq
+
+7:	lsr		x1, x2, #32
+	adds		w2, w2, w1
+	adc		w2, w2, wzr
+
+	lsr		w1, w2, #16
+	uxth		w2, w2
+	add		w2, w2, w1
+
+	lsr		w1, w2, #16		// handle the carry by hand
+	add		w2, w2, w1
+
+	uxth		w0, w2
+	ret
+
+	// Handle 63 bytes or less
+1:	tbz		x1, #5, 2f
+	ldp		x4, x5, [x0], #32
+	ldp		x6, x7, [x0, #-16]
+	adds		x2, x2, x4
+	adcs		x2, x2, x5
+	adcs		x2, x2, x6
+	adcs		x2, x2, x7
+	adc		x2, x2, xzr
+
+2:	tbz		x1, #4, 3f
+	ldp		x4, x5, [x0], #16
+	adds		x2, x2, x4
+	adcs		x2, x2, x5
+	adc		x2, x2, xzr
+
+3:	tbz		x1, #3, 4f
+	ldr		x4, [x0], #8
+	adds		x2, x2, x4
+	adc		x2, x2, xzr
+
+4:	tbz		x1, #2, 5f
+	ldr		w4, [x0], #4
+	adds		x2, x2, x4
+	adc		x2, x2, xzr
+
+5:	tbz		x1, #1, 6f
+	ldrh		w4, [x0], #2
+	adds		x2, x2, x4
+	adc		x2, x2, xzr
+
+6:	tbz		x1, #0, 7b
+	ldrb		w4, [x0]
+CPU_LE(	adds		x2, x2, x4		)
+CPU_BE(	adds		x2, x2, x4, lsl #8	)
+	adc		x2, x2, xzr
+	b		7b
+ENDPROC(do_csum)
-- 
2.20.1

  diff --git a/lib/checksum.c b/lib/checksum.c
  index d3ec93f9e5f3..7711f1186f71 100644
  --- a/lib/checksum.c
  +++ b/lib/checksum.c
  @@ -37,7 +37,7 @@
   
   #include <asm/byteorder.h>
   
  -#ifndef do_csum
  +#if 1 //ndef do_csum
   static inline unsigned short from32to16(unsigned int x)
   {
          /* add up 16-bit and 16-bit for 16+c bit */
  @@ -47,7 +47,7 @@ static inline unsigned short from32to16(unsigned int x)
          return x;
   }
   
  -static unsigned int do_csum(const unsigned char *buff, int len)
  +static unsigned int __do_csum(const unsigned char *buff, int len)
   {
          int odd;
          unsigned int result = 0;
  @@ -206,3 +206,23 @@ __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
   }
   EXPORT_SYMBOL(csum_tcpudp_nofold);
   #endif
  +
  +extern u8 crypto_ft_tab[];
  +
  +static int __init do_selftest(void)
  +{
  +       int i, j;
  +       u16 c1, c2;
  +
  +       for (i = 0; i < 1024; i++) {
  +               for (j = i + 1; j <= 1024; j++) {
  +                       c1 = __do_csum(crypto_ft_tab + i, j - i);
  +                       c2 = do_csum(crypto_ft_tab + i, j - i);
  +
  +                       if (c1 != c2)
  +                               pr_err("######### %d %d %x %x\n", i, j, c1, c2);
  +               }
  +       }
  +       return 0;
  +}
  +late_initcall(do_selftest);

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
