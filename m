Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D90C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:32:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46AAE20838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FQoVgv4G";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="neyaAKT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46AAE20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KFO0HH4xwpBbI/ntxYPE3+CftaiaG00pvj7qdLzm/5M=; b=FQoVgv4GMriRuX
	B4azFBWnI55cvgntHKi9rcYCRVY44RZ7EfwBB2uvwQCZCAUpBWdU1Q15R2JEnhfU0Xw56y5NZDdO8
	UoOq6fDAXZ/JQE+cRBs0uSRr3x+XPAD9NT7iYmXpOnozlBu4H4W/1IzB5H/bJok2aYce1bJwcaSJK
	W5idkhYqcp6l+SGo6VEWsDLi3T/x+QFBkgLPISBMN8wloVWXgRkydSMWkOT+DPoVyO9dai1gv4BIA
	OGync7vki09fshNpHCRxXa55+g54Zt7Usk+ThrqbdLP4OZ/+uzT1PlQ9PjYaylWqp+kdPnwRWvf0s
	t9FeVDiXMcJgMFOOIkpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUspA-0002za-5o; Thu, 06 Dec 2018 12:32:12 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUsin-0004AR-D4
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 12:25:43 +0000
Received: by mail-wr1-x444.google.com with SMTP id z5so261020wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 04:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c3irOTZqglCe0+q+NuOFKdHcgcEut4vEB08n2fct2jM=;
 b=neyaAKT0SnRF3m9Va46jiGHE6yqDTX+/qkDaGCzTfyovNE7fgEiBpHCH6E8H6pp+Dg
 0V0P6R3gZXIzt6Npzf0dbDRYL8Segztlu9nPAwlHmkpVL6i1WQnVRLnveSf0VX7FUXUK
 0cTIsQkBwIH3ZkWUotsAs+TKxDFa5Y9Z2Quc3dcP2YuxWCU42kiKEIGfhwIkNFXUNKSD
 hCfLOG5PdM3jVSyheXBqSSO9uucECOKJeKjxpGpB7xEix22PdxX5UErNMDlIZlw4oPq9
 St5iuKFy2FfMyKSj8DLg2jVhjVWKfuYjzEnkhBGUnYmnyILzY+gq98tl22Emi+J1SvnQ
 mfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c3irOTZqglCe0+q+NuOFKdHcgcEut4vEB08n2fct2jM=;
 b=MlfkLFvJidn25/4IO/m9asI1bPwDmyhJQo+fvdbsejLEBb9jOJ1J0kJV4FIARuhOfl
 Tv0malnVF+8z64j9WHtifph/hJGtoaICUpUZfHwZaZTdaRS5OhHrCFfgHvAW1z7YPXgB
 YfSAklgO+nZIP3brLJf5q4hGXENve8ZKWmwEmimol+UbqO7NSC3lft2v4rjS1dKCeVJP
 17wvX+miJj1aWPlhhgttdJBwo79pXK8dmYKP1yZb6jKbIow+UMEz0FZ3en6mh6pb1bdZ
 6gJT5j/5WbCtaAifcNM1ia02Srni8I19ZDuIReCeBo5/H6iGzJd6aRLUdrpwHSryiyMB
 bh7Q==
X-Gm-Message-State: AA+aEWb8+Ry4Dul++SXtEarr42AX8EpcYXR/sb0ATAHUlw9IOP1oXoZi
 27R8FpYgn6mS2DyNLG4/61nJoA==
X-Google-Smtp-Source: AFSGD/XkE8mejCoGUEy628et/JZL/sxDM+RBbFhKJ78kRjJ2xXA7tnfyWjFXQnlU4GWTOKOYRyZgpA==
X-Received: by 2002:adf:f091:: with SMTP id n17mr9679121wro.292.1544099125848; 
 Thu, 06 Dec 2018 04:25:25 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:10:3180:41f8:3010:ff61])
 by smtp.gmail.com with ESMTPSA id j8sm339988wrt.40.2018.12.06.04.25.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 04:25:25 -0800 (PST)
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
Subject: [PATCH v13 23/25] kasan, arm64: select HAVE_ARCH_KASAN_SW_TAGS
Date: Thu,  6 Dec 2018 13:24:41 +0100
Message-Id: <25abce9a21d0c1df2d9d72488aced418c3465d7b.1544099024.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <cover.1544099024.git.andreyknvl@google.com>
References: <cover.1544099024.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_042538_074181_6BE37553 
X-CRM114-Status: GOOD (  12.39  )
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

Now, that all the necessary infrastructure code has been introduced,
select HAVE_ARCH_KASAN_SW_TAGS for arm64 to enable software tag-based
KASAN mode.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ea2ab0330e3a..66f2c625fd1c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -111,6 +111,7 @@ config ARM64
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
+	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
-- 
2.20.0.rc1.387.gf8505762e3-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
