Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F145C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:47:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643D720656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y4Q+5gsn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bo33h8Tf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643D720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=2/7bWLsQx6I1+f3eXA5jRLihrSmKSWRvm05RKm8GORs=; b=Y4Q
	+5gsn/Pttu4cHxTfQmxNTqq6Np/476OKHrJ5dk4NFarP74U9su0QWIIrMitIfJVLAsyopUQC0cqYw
	ZIPFZCo2quBG8A+Fjw095TyIFu683ew5beHlqQ7gBjYq0qK1GDHPKbBvwGGE+07gyXdk0VZa0Q+aa
	sRD4GhbYyvaEnLL9YL5CGLj70Ctgg64mD6KgIIaI6/CsJ8pkwirYMtTQefCtJ/VRr7lvgklb2Qyjk
	n8pf9ni9TmO0ueo/S6NGe2e52L0P8HgFxWovW7aEEgYM1uzFOrGi5nJXtGA57mhgIfkTKT5+cHfy+
	3p3mNsEkYLmbA999SqF9Hskli5LEqzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjUgP-0006hr-RF; Tue, 15 Jan 2019 19:47:33 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjUgM-0006hT-0c
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 19:47:32 +0000
Received: by mail-wr1-x442.google.com with SMTP id s12so4384566wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 11:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=kLiMgksvqNy7QuzIiTILylAxcDol8fKPxUPVmnNe3FU=;
 b=Bo33h8TfymXOleLIumJmWW/mzNQkV8TKvPwDy3D2PGP/sT2p7BD2b2h5JZgeG0S1DJ
 qFCjhAh/GyUMrR9nZJ5wGL9rl4LxaTM8tqQgJrx41WdWSzDXBbXRBzVsZr1FTO9q+yGc
 HPJCocAKrgnoDPtW9coHXnt8wGXBp4HrV0/5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=kLiMgksvqNy7QuzIiTILylAxcDol8fKPxUPVmnNe3FU=;
 b=fF2oRIxbZVUtSPzUbo1IpfGBjY3YtBUNE6QR+b5QciGkhcR7JwR97V4gBqjjeRkuF/
 3KZc0jC71n2gwzneY5VAn0niquBiPZQUy8aL5hSUispRSxoDtf4K06TIoSPbZOINseRG
 y55v8qIbF3DOi1NmrL9A9zK0l3qNQ61OlbpXCQ09gpPsWCYSTl+EImwaMMjQ/XjmbzZJ
 Yi2cydoTHiwJjmiZ917E827vvYEV0+RYY+w/TInnTLuOi3IfNOWypylX9hn+xtO6AUT9
 4w/sjv+rLy+9z03orzLvknxNfoth8ts0WlK0nhlmXrrc0eseA1kfmrAUjakAKRd4SMaC
 KViA==
X-Gm-Message-State: AJcUukcnznl6Q9Ev1P2STp1bTNVPtQ3a6/NFR3ODjr3+b19+i/OqwlSn
 86bnIbmjsledt0/uN8DFEp2RUY+Qz3/P/Q==
X-Google-Smtp-Source: ALg8bN55doBq0FCnscYv4dRaOFK/2ce8zv5l/AxNJBz4d/1E3pQLsYV7tuw2FGGcP71ldlXrp3evDQ==
X-Received: by 2002:adf:e5d0:: with SMTP id a16mr4450277wrn.89.1547581646624; 
 Tue, 15 Jan 2019 11:47:26 -0800 (PST)
Received: from dogfood.home ([2a01:cb1d:112:6f00:c8d1:b905:1bdd:adb6])
 by smtp.gmail.com with ESMTPSA id y1sm38148289wme.1.2019.01.15.11.47.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Jan 2019 11:47:25 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: kaslr: ensure randomized quantities are clean to the
 PoC
Date: Tue, 15 Jan 2019 20:47:07 +0100
Message-Id: <20190115194707.11614-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_114730_062629_47616988 
X-CRM114-Status: GOOD (  15.41  )
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
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

kaslr_early_init() is called with the kernel mapped at its
link time offset, and if it returns with a non-zero offset,
the kernel is unmapped and remapped again at the randomized
offset.

During its execution, kaslr_early_init() also randomizes the
base of the module region and of the linear mapping of DRAM,
and sets two variables accordingly. However, since these
variables are assigned with the caches on, they may get lost
during the cache maintenance that occurs when unmapping and
remapping the kernel, so ensure that these values are cleaned
to the PoC.

Fixes: f80fb3a3d508 ("arm64: add support for kernel ASLR")
Cc: <stable@vger.kernel.org> # v4.6+
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/kaslr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index f0e6ab8abe9c..ba6b41790fcd 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -14,6 +14,7 @@
 #include <linux/sched.h>
 #include <linux/types.h>
 
+#include <asm/cacheflush.h>
 #include <asm/fixmap.h>
 #include <asm/kernel-pgtable.h>
 #include <asm/memory.h>
@@ -43,7 +44,7 @@ static __init u64 get_kaslr_seed(void *fdt)
 	return ret;
 }
 
-static __init const u8 *get_cmdline(void *fdt)
+static __init const u8 *kaslr_get_cmdline(void *fdt)
 {
 	static __initconst const u8 default_cmdline[] = CONFIG_CMDLINE;
 
@@ -109,7 +110,7 @@ u64 __init kaslr_early_init(u64 dt_phys)
 	 * Check if 'nokaslr' appears on the command line, and
 	 * return 0 if that is the case.
 	 */
-	cmdline = get_cmdline(fdt);
+	cmdline = kaslr_get_cmdline(fdt);
 	str = strstr(cmdline, "nokaslr");
 	if (str == cmdline || (str > cmdline && *(str - 1) == ' '))
 		return 0;
@@ -169,5 +170,8 @@ u64 __init kaslr_early_init(u64 dt_phys)
 	module_alloc_base += (module_range * (seed & ((1 << 21) - 1))) >> 21;
 	module_alloc_base &= PAGE_MASK;
 
+	__flush_dcache_area(&module_alloc_base, sizeof(module_alloc_base));
+	__flush_dcache_area(&memstart_offset_seed, sizeof(memstart_offset_seed));
+
 	return offset;
 }
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
