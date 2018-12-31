Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA9FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:12:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C1520B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PSUX49eO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8DBKwCl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C1520B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=whOjBu/yqahGBiG5iDAmeOlu96i+uAbJhGEdiWpQmLc=; b=PSUX49eOs2Ce3e
	Ie7O+p0ycgsV50oKCwXYihQk5V4cM4Zaljf7IQL2IMlse6k2ay+OAGU1C+T0zqeYJDuZ1EeaUNgky
	DdbDEcatyJt1vqikuvm/xfPw4btRKhHxT8cI/sd/F1Aml+/odV0WcLGEP3TNx19N88+ZmD+m3zQIv
	y7iLgIyoQTYXaK82U9hMxW9B2KNvDEgO6/eOqWiJB4KqADGkfTi7UPwV1Zy3LbieaLKPB0yQ6UmFE
	WRo2qSqGZH+OphprorFPT/FKvsGUsftBkfqz3hll3/I4QTiTBFw50Bl4O7F3k9AFiGTVy169Wy8TL
	KeWd6Ln+XSnP5/NQekDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ge23E-0006vL-0R; Mon, 31 Dec 2018 18:12:32 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ge23A-0006uf-AZ
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 18:12:30 +0000
Received: by mail-wm1-x341.google.com with SMTP id m1so23890521wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 10:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AAOnbAxkac0UC41NM/y5SZGaEvMV/qtWid+iG06fEiE=;
 b=V8DBKwClcmmVtlJtWihVDKHGuwOYfXuUtXwtEiRLJo4wr+TOqrrRwZ4gEwdrMg2Ybq
 1HkfDWnSSuS1+p76KzZkj1Knum1hpzQGneiZgKFgK6q3L1XqgNTos71fOL8KwuaOo/d7
 +3eA2kh7t67CPQNPDZ7vG+xS91oeFLv4+wyXASNeWyxmhEN5JZV21rFhurxDARm0HE5l
 LJe/hQklMch00z255TSgGVu0PqOZAHvydmk0o6y8APGPjoBRGy+u7TdZnRYL6fH++hNR
 AgcqZ0TeEyDWBZpmjnxQJv0tBnMaPkB2SVW6crILFEEPJpEFuAbZrqxqFqS5WH20JlqT
 5uxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AAOnbAxkac0UC41NM/y5SZGaEvMV/qtWid+iG06fEiE=;
 b=Hu21QaZBVWmvESKzMsFwh2mPDZd9ZP7SE1hBVGteEDViXRaGZSdU2pLMfk0XQWifMw
 4eRc0F4owcf5HvvGmUKo4JFY8f4vlUMgOOLjg2DUldUNFCuQB7dnRxWA5bCtZczxdVq+
 culUkAWjlDHTthQ6CNAZiHGjIPAzLmd7EahI8kNeFfkJwiuCcMviupTazwM4FhLpLNaI
 oe5XeKzPd6TVHS3GGrnGvT7OtZpOVkxezp1LCe3gvrKKWCv85IunZYX3eMnhpzVAks+C
 X5LimUk7i3yRltyGH13yezSETRgA2eD9LLZZ/dIMc4M/umoAB6rlgVXY6xEptgQqqqqA
 lRQg==
X-Gm-Message-State: AJcUukdtoVn6ND/7M8HJtPx59yRdRV9nglpNXsR0G6KyrNUmK845OzCa
 lU1yb8pk8wj8VVphpUlW5c8=
X-Google-Smtp-Source: AFSGD/V96Ltg1sJB72FtjDfLwpK33HJZhp0Nwx6OIVwcf2HNJiuq2TM9KfYhSR9Jq9PYXn+oQKRZXA==
X-Received: by 2002:a1c:af08:: with SMTP id y8mr29566776wme.94.1546279944581; 
 Mon, 31 Dec 2018 10:12:24 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
 by smtp.gmail.com with ESMTPSA id t5sm38254713wmd.15.2018.12.31.10.12.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Dec 2018 10:12:23 -0800 (PST)
From: Nathan Chancellor <natechancellor@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Subject: [PATCH v2] ARM: Remove '-p' from LDFLAGS
Date: Mon, 31 Dec 2018 11:12:10 -0700
Message-Id: <20181231181209.28695-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181205014213.943-1-natechancellor@gmail.com>
References: <20181205014213.943-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_101228_388661_57689F19 
X-CRM114-Status: GOOD (  13.58  )
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
Cc: Nicolas Pitre <nico@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Stefan Agner <stefan@agner.ch>, Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This option is not supported by lld:

    ld.lld: error: unknown argument: -p

This has been a no-op in binutils since 2004 (see commit dea514f51da1 in
that tree). Given that the lowest officially supported of binutils for
the kernel is 2.20, which was released in 2009, nobody needs this flag
around so just remove it. Commit 1a381d4a0a9a ("arm64: remove no-op -p
linker flag") did the same for arm64.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Nicolas Pitre <nico@linaro.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>
---

v1 -> v2:

* Collect tags

* Remove an additional occurence of '-p' in the bootp Makefile, thank
  you to Stefan for pointing it out

* Drop patch 2/2, it will be fixed properly in lld: https://reviews.llvm.org/D55505

 arch/arm/Makefile                 | 2 +-
 arch/arm/boot/bootp/Makefile      | 2 +-
 arch/arm/boot/compressed/Makefile | 2 --
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 0436002d5091..1d48c8ed5f89 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -10,7 +10,7 @@
 #
 # Copyright (C) 1995-2001 by Russell King
 
-LDFLAGS_vmlinux	:=-p --no-undefined -X --pic-veneer
+LDFLAGS_vmlinux	:= --no-undefined -X --pic-veneer
 ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux	+= --be8
 KBUILD_LDFLAGS_MODULE	+= --be8
diff --git a/arch/arm/boot/bootp/Makefile b/arch/arm/boot/bootp/Makefile
index 83e1a076a5d6..981a8d03f064 100644
--- a/arch/arm/boot/bootp/Makefile
+++ b/arch/arm/boot/bootp/Makefile
@@ -8,7 +8,7 @@
 
 GCOV_PROFILE	:= n
 
-LDFLAGS_bootp	:=-p --no-undefined -X \
+LDFLAGS_bootp	:= --no-undefined -X \
 		 --defsym initrd_phys=$(INITRD_PHYS) \
 		 --defsym params_phys=$(PARAMS_PHYS) -T
 AFLAGS_initrd.o :=-DINITRD=\"$(INITRD)\"
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 01bf2585a0fa..ecfa4ca320a7 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -132,8 +132,6 @@ endif
 ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux += --be8
 endif
-# ?
-LDFLAGS_vmlinux += -p
 # Report unresolved symbol references
 LDFLAGS_vmlinux += --no-undefined
 # Delete all temporary local symbols
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
