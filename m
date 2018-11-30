Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5E3C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:36:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CF452145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J/GE+LsM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TLoQF32h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF452145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=oXWyksapHTAtfyMCe7qKPBtx8PEAwb5bvVEo4w53lo4=; b=J/GE+LsMbfV7PI
	xuG92F2kaIBJeF+31Xdh+DMQa+YFeLB+/gOi2Bz/dIOyH+cQUJ7+5aLwtOblJ/OXkUwXc4nBMReoV
	50oF4VUYQa+71shKNt8+EGWv++hs7JNcYU5aXjD2gDloceRy/5OIj0y2vGuGr/jMKa9ZqI6kS5RGe
	3pd1Gy2clpOt07CYktrsJI917zGvsE/1W5jPUQxJjlr2PHXBsL8S1jRpPyBGwniIBQPnI4QN5MGY2
	Uz3fJDGuSd7ijvJOFcw4ixvzdWY8Ey6YbvaSODXWYGFKThGC3ot8VjzeGW9GEg0ZWEth76G6z/IKp
	q7R3tWhctkMDF71v0t2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSh5n-0003Jz-Go; Fri, 30 Nov 2018 11:36:19 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSh5k-0003JH-AG
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 11:36:17 +0000
Received: by mail-wm1-x344.google.com with SMTP id q26so5347886wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 03:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2DrRwlNhWmcexXHUFa6mLLJUB8elF/12TyOVEW08kM4=;
 b=TLoQF32hR6MENnF9NLW/wA6P7TTyThwtxte6UePfPsozjdaakL9CRsG0sdAY/uI9US
 zO1jbujBRtunInp3UY+EvWSj9kmBVPJFRWsVJZO/vqn4Y9SpAwCnE1ikFPE9I4wUkQ0L
 OaQlFDHJDwUEFetDyLz5oiVl2RDwuVrbZCu4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2DrRwlNhWmcexXHUFa6mLLJUB8elF/12TyOVEW08kM4=;
 b=Xf7rwmvCgV5rN3TG0GqLg5YP+qIv8KopTyfwUM4FmBe6XkpF9GWmnUGGaqKKBOHJF9
 vMem/A5LFZ3HKhC7hXMJUFCwKxYgy+/byNKezj9ByJ90xama7SjXc3Il4mQs+Wdin0Jq
 IrCW6FlnCvozCMrJNDFKart9nA7fNVMFDT2NkreMQdLhsYTloUUZYcZfVL5Tnlzx57rB
 rqVBwPIWwgU5YNopgmivj9YkfW5ckU1G+mGkkm/GvslarA3K5fXvdCEtjNI64IIt81r3
 4qrwX1x7GY1mMLaSFU6SGSZzvo36vyCNE9Lq1QopIkViV9Yn6i2lf/IAJSR5ISV6xuWi
 YSvg==
X-Gm-Message-State: AA+aEWYesY8NpTTGaM97B/tzbLeN6r7tfDh0b+n7YS4iMjC8E09qHx2V
 tFHW43LGvsWhptH2VUKLspCX+hfwjng=
X-Google-Smtp-Source: AFSGD/Wi9e4MH+kxqmhOlfAFXYN23J45T2khTsFC6ni0zW7dj0Og914SjwE6KZAHcxQgjooZakkDEg==
X-Received: by 2002:a1c:aa92:: with SMTP id t140mr5144570wme.36.1543577763727; 
 Fri, 30 Nov 2018 03:36:03 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:f070:d240:312e:9f99])
 by smtp.gmail.com with ESMTPSA id a12sm4390887wro.18.2018.11.30.03.36.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Nov 2018 03:36:02 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: drop linker script hack to hide __efistub_ symbols
Date: Fri, 30 Nov 2018 12:35:58 +0100
Message-Id: <20181130113558.15198-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_033616_452294_9FEA300C 
X-CRM114-Status: GOOD (  10.97  )
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
Cc: catalin.marinas@arm.com, Nick Desaulniers <ndesaulniers@google.com>,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Commit 1212f7a16af4 ("scripts/kallsyms: filter arm64's __efistub_
symbols") updated the kallsyms code to filter out symbols with
the __efistub_ prefix explicitly, so we no longer require the
hack in our linker script to emit them as absolute symbols.

Cc: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/image.h | 46 +++++++++++++++------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
index a820ed07fb80..8da289dc843a 100644
--- a/arch/arm64/kernel/image.h
+++ b/arch/arm64/kernel/image.h
@@ -75,16 +75,6 @@
 
 __efistub_stext_offset = stext - _text;
 
-/*
- * Prevent the symbol aliases below from being emitted into the kallsyms
- * table, by forcing them to be absolute symbols (which are conveniently
- * ignored by scripts/kallsyms) rather than section relative symbols.
- * The distinction is only relevant for partial linking, and only for symbols
- * that are defined within a section declaration (which is not the case for
- * the definitions below) so the resulting values will be identical.
- */
-#define KALLSYMS_HIDE(sym)	ABSOLUTE(sym)
-
 /*
  * The EFI stub has its own symbol namespace prefixed by __efistub_, to
  * isolate it from the kernel proper. The following symbols are legally
@@ -94,28 +84,28 @@ __efistub_stext_offset = stext - _text;
  * linked at. The routines below are all implemented in assembler in a
  * position independent manner
  */
-__efistub_memcmp		= KALLSYMS_HIDE(__pi_memcmp);
-__efistub_memchr		= KALLSYMS_HIDE(__pi_memchr);
-__efistub_memcpy		= KALLSYMS_HIDE(__pi_memcpy);
-__efistub_memmove		= KALLSYMS_HIDE(__pi_memmove);
-__efistub_memset		= KALLSYMS_HIDE(__pi_memset);
-__efistub_strlen		= KALLSYMS_HIDE(__pi_strlen);
-__efistub_strnlen		= KALLSYMS_HIDE(__pi_strnlen);
-__efistub_strcmp		= KALLSYMS_HIDE(__pi_strcmp);
-__efistub_strncmp		= KALLSYMS_HIDE(__pi_strncmp);
-__efistub_strrchr		= KALLSYMS_HIDE(__pi_strrchr);
-__efistub___flush_dcache_area	= KALLSYMS_HIDE(__pi___flush_dcache_area);
+__efistub_memcmp		= __pi_memcmp;
+__efistub_memchr		= __pi_memchr;
+__efistub_memcpy		= __pi_memcpy;
+__efistub_memmove		= __pi_memmove;
+__efistub_memset		= __pi_memset;
+__efistub_strlen		= __pi_strlen;
+__efistub_strnlen		= __pi_strnlen;
+__efistub_strcmp		= __pi_strcmp;
+__efistub_strncmp		= __pi_strncmp;
+__efistub_strrchr		= __pi_strrchr;
+__efistub___flush_dcache_area	= __pi___flush_dcache_area;
 
 #ifdef CONFIG_KASAN
-__efistub___memcpy		= KALLSYMS_HIDE(__pi_memcpy);
-__efistub___memmove		= KALLSYMS_HIDE(__pi_memmove);
-__efistub___memset		= KALLSYMS_HIDE(__pi_memset);
+__efistub___memcpy		= __pi_memcpy;
+__efistub___memmove		= __pi_memmove;
+__efistub___memset		= __pi_memset;
 #endif
 
-__efistub__text			= KALLSYMS_HIDE(_text);
-__efistub__end			= KALLSYMS_HIDE(_end);
-__efistub__edata		= KALLSYMS_HIDE(_edata);
-__efistub_screen_info		= KALLSYMS_HIDE(screen_info);
+__efistub__text			= _text;
+__efistub__end			= _end;
+__efistub__edata		= _edata;
+__efistub_screen_info		= screen_info;
 
 #endif
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
