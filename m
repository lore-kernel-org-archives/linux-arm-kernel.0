Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8B9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:40:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC98221934
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dpA5lZ8z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmz7UbHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC98221934
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=RfmhpWZzB56DvgL1RhxHW+VohZzpOWoRI1N/vu01OG0=; b=dpA5lZ8z760c0n
	HgS7eB+QZ3qQnfH0XdLIBGwdax/TUo8ecay5MhmHGpn2Ic2Vgle16swmjvfbYfJMAo9sy1yO5zQeD
	76lDnslCIxbsL5yvnrNqMbtBwevSyDf3VcViEzCu9fe/Zi7LFAKfWfozwQDmeSqmXVQG/nz4fsrG7
	XaZC+QXVUuCbCTRIEXtOcKR9QqaWgq5LIcBrHb93pklJ9BQPnlgA/YrnB/ToG2GX8AaCMgvr/jmjT
	0YhywB4+Hy8f3cTh90c/ocMUEivTrsABnHFUMo2M8+rgQwPjBLAukuvUQPOPbIAn82w17kBjgclJs
	zV8RoGwNzfTezqgFC2sA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guSUV-0008St-AW; Fri, 15 Feb 2019 01:40:35 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guSUR-0008SC-Uk
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 01:40:33 +0000
Received: by mail-ed1-x543.google.com with SMTP id b3so6719047ede.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 17:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uwCXhwiC/fPv5tuKoeJDhMs1VaHJk1Bz4OiYh196ZEI=;
 b=dmz7UbHpHt7I1SGc8Gs/EB6ga54A+68M5SljCar/19SNyBDCsu8+JuLZDU5A7T7amu
 uIZzrWB8cWyqpm1VeNkeZjmDRe0N6CvUezVXvAjCmX/X81ubQsGodB9e7ENf2PZFGhQ0
 L9RbPJ6kmT7ZOS2HyP1STiKnDQKMl9fISM6pjelNo3jgscYGnXzCt9rs3/gQZgyiKQaR
 R2FuFKSgMJtqPXdmhoFCzvFqM8GDrjVbWJvsHjrPrK7igAz6Mw+FtopIXwQ5KasX9uSU
 CdyGGEy+PjwVa76ugrhk6XhoJg7ha4XjyusyCy5ugk8uLq/ML+znPiZA5dGW2wAVhUtx
 WjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uwCXhwiC/fPv5tuKoeJDhMs1VaHJk1Bz4OiYh196ZEI=;
 b=jdyPEj0jiLbuQoKaDTzxq2IeXVA6/fZaFARkaVdV9gTcVMz4m3nqKJuNUpbEUbxXcA
 t3kRNZhz02GB3GYbmrFgHp3J7MGitr47xsYcK8puUTV3huOWwrf7AF2zL2PAKKuaeDyd
 LxfKhxq3YFOEJxGvHkeN3Vgd4lJB8GH98uZdXV5A4TVNlX1LM/DP5mzjt9C4FgeTn7mt
 WGYNq6ub+lai6+p/DvUF6NxJqySTJt7d75FdkuGvEbnCemn/RFk+MjDEv8V5E8r2x+rq
 D6enKqqisxTf7QUwnlk1u5JqDEfHj5eTIVMHCRaLRXBPFWf2diAyffz9TFcNuHQCt2Ek
 ey5A==
X-Gm-Message-State: AHQUAuZQYr2bRN5aqTVAK7kUbrCRllaiysqHDyNlsH6cqB/S9aaASPAY
 ek9Izo+i9YOX0TXwT2x/lL0=
X-Google-Smtp-Source: AHgI3IY6h1L+htqNpwMawWWiNbFCgqHnX2tvGsFZ3dowxODW0XHXL8DR9mBSTU+HUnawjSDXPWnzbw==
X-Received: by 2002:a50:a4ce:: with SMTP id x14mr5288893edb.229.1550194828224; 
 Thu, 14 Feb 2019 17:40:28 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
 by smtp.gmail.com with ESMTPSA id l25sm1090247edr.45.2019.02.14.17.40.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 17:40:27 -0800 (PST)
From: Nathan Chancellor <natechancellor@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH] arm64/neon: Disable -Wincompatible-pointer-types when
 building with Clang
Date: Thu, 14 Feb 2019 18:39:59 -0700
Message-Id: <20190215013959.21320-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1
MIME-Version: 1.0
X-Patchwork-Bot: notify
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_174032_016714_1AF97ED0 
X-CRM114-Status: GOOD (  10.11  )
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

After commit cc9f8349cb33 ("arm64: crypto: add NEON accelerated XOR
implementation"), Clang builds for arm64 started failing with the
following error message.

arch/arm64/lib/xor-neon.c:58:28: error: incompatible pointer types
assigning to 'const unsigned long *' from 'uint64_t *' (aka 'unsigned
long long *') [-Werror,-Wincompatible-pointer-types]
                v3 = veorq_u64(vld1q_u64(dp1 +  6), vld1q_u64(dp2 + 6));
                                         ^~~~~~~~
/usr/lib/llvm-9/lib/clang/9.0.0/include/arm_neon.h:7538:47: note:
expanded from macro 'vld1q_u64'
  __ret = (uint64x2_t) __builtin_neon_vld1q_v(__p0, 51); \
                                              ^~~~

There has been quite a bit of debate and triage that has gone into
figuring out what the proper fix is, viewable at the link below, which
is still ongoing. Ard suggested disabling this warning with Clang with a
pragma so no neon code will have this type of error. While this is not
at all an ideal solution, this build error is the only thing preventing
KernelCI from having successful arm64 defconfig and allmodconfig builds
on linux-next. Getting continuous integration running is more important
so new warnings/errors or boot failures can be caught and fixed quickly.

Link: https://github.com/ClangBuiltLinux/linux/issues/283
Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/arm64/include/asm/neon-intrinsics.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/neon-intrinsics.h b/arch/arm64/include/asm/neon-intrinsics.h
index 2ba6c6b9541f..71abfc7612b2 100644
--- a/arch/arm64/include/asm/neon-intrinsics.h
+++ b/arch/arm64/include/asm/neon-intrinsics.h
@@ -36,4 +36,8 @@
 #include <arm_neon.h>
 #endif
 
+#ifdef CONFIG_CC_IS_CLANG
+#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
+#endif
+
 #endif /* __ASM_NEON_INTRINSICS_H */
-- 
2.21.0.rc1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
