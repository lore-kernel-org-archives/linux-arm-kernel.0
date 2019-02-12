Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CD1C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:02:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5346F222C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hAJi56tL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="H/67sS+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5346F222C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XgkeJ8/8u4wfihmgHxh+0grm+R6zrHyTqrmaGbkqNSo=; b=hAJi56tLVGUMOn
	yXgWkh0hpxpI/LxswvKfUGfZkErVAMiFuC2Bn2tHvCgHcEBiaEbBCKAzN8dzWw5luTKDCpOYd7Peo
	8jnjAbz7tiZGCitOzEi1OSXkqXi13inP3Krhv5Xn3I5FvInsqBxY70uHRQlx2xD8UX7Z/V+TdpLEi
	4NBBYZi7MqEFguYO+xr2c8zn6l02C6VdkV2knsvN6H6XJV58XIgGTh33h9U7QM83iLTlCV3+mCfVG
	W/bRwC11XtvPKQntfTKIAtUTlwuW7JGMTX+DreC+jKSuaK8FPAtGosVXH4lRhtoKe4t8QkjD93JEb
	d1IFU/md53kGT7VF64rg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gteGb-0006PG-Rg; Tue, 12 Feb 2019 20:02:53 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gteFn-0005gW-J4
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 20:02:09 +0000
Received: from zyt.lan (unknown [IPv6:2a02:169:34b6::564])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id C62F25C0AC6;
 Tue, 12 Feb 2019 21:01:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1550001717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cXeNL+64FISLhbwR9mg2d2+3UikEl6ZzdyE+RZRceY8=;
 b=H/67sS+7bVUEfP8EhEKoCVZ2+kKKGOv9zwp2yhOd1RoGp5L0dIxUMoCc0SMSmIEJLS+xjd
 YgzW88iE0KW+S0BcsfA6DtLF49JaZESmTHnD7YkEa+i7Jw6s2caJtPzWgG9BDzG+Hd7rlf
 8R43s+26s5Sd9oHRdPCFanDLCsCWSuU=
From: Stefan Agner <stefan@agner.ch>
To: linux@armlinux.org.uk
Subject: [PATCH v3 2/5] ARM: use unified assembler in headers
Date: Tue, 12 Feb 2019 21:01:58 +0100
Message-Id: <216a514a296ed623b6cbd34dcc6853e42fac9d4a.1550001435.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1550001435.git.stefan@agner.ch>
References: <cover.1550001435.git.stefan@agner.ch>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_120204_164932_A7858B14 
X-CRM114-Status: GOOD (  12.48  )
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
Cc: nicolas.pitre@linaro.org, mark.rutland@arm.com, arnd@arndb.de,
 ard.biesheuvel@linaro.org, will.deacon@arm.com, julien.thierry@arm.com,
 ndesaulniers@google.com, linux-kernel@vger.kernel.org,
 Stefan Agner <stefan@agner.ch>, thierry.reding@gmail.com,
 Nicolas Pitre <nico@linaro.org>, natechancellor@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use unified assembler syntax (UAL) in headers. Divided syntax is
considered deprecated. This will also allow to build the kernel
using LLVM's integrated assembler.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
Changes in v2:
- Remove excessive null tokens
- Move t token before conditional token

 arch/arm/include/asm/assembler.h | 12 ++++++------
 arch/arm/include/asm/vfpmacros.h |  8 ++++----
 arch/arm/lib/bitops.h            |  8 ++++----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 28a48e0d4cca..b59921a560da 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -376,9 +376,9 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 	.macro	usraccoff, instr, reg, ptr, inc, off, cond, abort, t=TUSER()
 9999:
 	.if	\inc == 1
-	\instr\cond\()b\()\t\().w \reg, [\ptr, #\off]
+	\instr\()b\t\cond\().w \reg, [\ptr, #\off]
 	.elseif	\inc == 4
-	\instr\cond\()\t\().w \reg, [\ptr, #\off]
+	\instr\t\cond\().w \reg, [\ptr, #\off]
 	.else
 	.error	"Unsupported inc macro argument"
 	.endif
@@ -417,9 +417,9 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 	.rept	\rept
 9999:
 	.if	\inc == 1
-	\instr\cond\()b\()\t \reg, [\ptr], #\inc
+	\instr\()b\t\cond \reg, [\ptr], #\inc
 	.elseif	\inc == 4
-	\instr\cond\()\t \reg, [\ptr], #\inc
+	\instr\t\cond \reg, [\ptr], #\inc
 	.else
 	.error	"Unsupported inc macro argument"
 	.endif
@@ -460,7 +460,7 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 	.macro check_uaccess, addr:req, size:req, limit:req, tmp:req, bad:req
 #ifndef CONFIG_CPU_USE_DOMAINS
 	adds	\tmp, \addr, #\size - 1
-	sbcccs	\tmp, \tmp, \limit
+	sbcscc	\tmp, \tmp, \limit
 	bcs	\bad
 #ifdef CONFIG_CPU_SPECTRE
 	movcs	\addr, #0
@@ -474,7 +474,7 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 	sub	\tmp, \limit, #1
 	subs	\tmp, \tmp, \addr	@ tmp = limit - 1 - addr
 	addhs	\tmp, \tmp, #1		@ if (tmp >= 0) {
-	subhss	\tmp, \tmp, \size	@ tmp = limit - (addr + size) }
+	subshs	\tmp, \tmp, \size	@ tmp = limit - (addr + size) }
 	movlo	\addr, #0		@ if (tmp < 0) addr = NULL
 	csdb
 #endif
diff --git a/arch/arm/include/asm/vfpmacros.h b/arch/arm/include/asm/vfpmacros.h
index ef5dfedacd8d..628c336e8e3b 100644
--- a/arch/arm/include/asm/vfpmacros.h
+++ b/arch/arm/include/asm/vfpmacros.h
@@ -29,13 +29,13 @@
 	ldr	\tmp, =elf_hwcap		    @ may not have MVFR regs
 	ldr	\tmp, [\tmp, #0]
 	tst	\tmp, #HWCAP_VFPD32
-	ldcnel	p11, cr0, [\base],#32*4		    @ FLDMIAD \base!, {d16-d31}
+	ldclne	p11, cr0, [\base],#32*4		    @ FLDMIAD \base!, {d16-d31}
 	addeq	\base, \base, #32*4		    @ step over unused register space
 #else
 	VFPFMRX	\tmp, MVFR0			    @ Media and VFP Feature Register 0
 	and	\tmp, \tmp, #MVFR0_A_SIMD_MASK	    @ A_SIMD field
 	cmp	\tmp, #2			    @ 32 x 64bit registers?
-	ldceql	p11, cr0, [\base],#32*4		    @ FLDMIAD \base!, {d16-d31}
+	ldcleq	p11, cr0, [\base],#32*4		    @ FLDMIAD \base!, {d16-d31}
 	addne	\base, \base, #32*4		    @ step over unused register space
 #endif
 #endif
@@ -53,13 +53,13 @@
 	ldr	\tmp, =elf_hwcap		    @ may not have MVFR regs
 	ldr	\tmp, [\tmp, #0]
 	tst	\tmp, #HWCAP_VFPD32
-	stcnel	p11, cr0, [\base],#32*4		    @ FSTMIAD \base!, {d16-d31}
+	stclne	p11, cr0, [\base],#32*4		    @ FSTMIAD \base!, {d16-d31}
 	addeq	\base, \base, #32*4		    @ step over unused register space
 #else
 	VFPFMRX	\tmp, MVFR0			    @ Media and VFP Feature Register 0
 	and	\tmp, \tmp, #MVFR0_A_SIMD_MASK	    @ A_SIMD field
 	cmp	\tmp, #2			    @ 32 x 64bit registers?
-	stceql	p11, cr0, [\base],#32*4		    @ FSTMIAD \base!, {d16-d31}
+	stcleq	p11, cr0, [\base],#32*4		    @ FSTMIAD \base!, {d16-d31}
 	addne	\base, \base, #32*4		    @ step over unused register space
 #endif
 #endif
diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
index 93cddab73072..95bd35991288 100644
--- a/arch/arm/lib/bitops.h
+++ b/arch/arm/lib/bitops.h
@@ -7,7 +7,7 @@
 ENTRY(	\name		)
 UNWIND(	.fnstart	)
 	ands	ip, r1, #3
-	strneb	r1, [ip]		@ assert word-aligned
+	strbne	r1, [ip]		@ assert word-aligned
 	mov	r2, #1
 	and	r3, r0, #31		@ Get bit offset
 	mov	r0, r0, lsr #5
@@ -32,7 +32,7 @@ ENDPROC(\name		)
 ENTRY(	\name		)
 UNWIND(	.fnstart	)
 	ands	ip, r1, #3
-	strneb	r1, [ip]		@ assert word-aligned
+	strbne	r1, [ip]		@ assert word-aligned
 	mov	r2, #1
 	and	r3, r0, #31		@ Get bit offset
 	mov	r0, r0, lsr #5
@@ -62,7 +62,7 @@ ENDPROC(\name		)
 ENTRY(	\name		)
 UNWIND(	.fnstart	)
 	ands	ip, r1, #3
-	strneb	r1, [ip]		@ assert word-aligned
+	strbne	r1, [ip]		@ assert word-aligned
 	and	r2, r0, #31
 	mov	r0, r0, lsr #5
 	mov	r3, #1
@@ -89,7 +89,7 @@ ENDPROC(\name		)
 ENTRY(	\name		)
 UNWIND(	.fnstart	)
 	ands	ip, r1, #3
-	strneb	r1, [ip]		@ assert word-aligned
+	strbne	r1, [ip]		@ assert word-aligned
 	and	r3, r0, #31
 	mov	r0, r0, lsr #5
 	save_and_disable_irqs ip
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
