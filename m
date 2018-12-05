Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA37C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:42:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC4D2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xu0QpKFl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObUvhjBX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC4D2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dpKZpeyEhJbYkxtQ4B0WVlM/n0nUzt2uRRkMTy8ccTU=; b=Xu0QpKFlP8G7rD
	/el7CxFy6fFEUGfB7MMx3exSxnjSoNkmVIzqgUgWT0rK7/l/+9HyTtRbD5o6G68GsRbhiBRZZpV2I
	Q/AOFiSXBMWIm8RIaYXGHMe94l+EAO+Zukbc6dxkp763tyuz5xnKcO/4S9lfte45WYT9Tuq5QzTzo
	+KMXaP9BH2by+PgcIYJoR/JAOCTtG6k4aOnaEXHnh9iWr55xtERDAhgcQV9RLLll9dGbPwDcirwJs
	AxJLumI01uVGvNPe8qyYl5mHplO37c88sSzyuFqvaAm24O++/XBFYbA6vHOFkKsGz8nrq/RLeWuy7
	f03qmR8zwMGVrACiVReg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUMDB-00041v-4E; Wed, 05 Dec 2018 01:42:49 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUMD6-000400-Vz
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 01:42:46 +0000
Received: by mail-wm1-x343.google.com with SMTP id g67so11197350wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 17:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9MYR1fL4LMIx7JzNK3MR85Ll1dY3Hp/rUqi3GHmQqLE=;
 b=ObUvhjBX3KdQS8ZBooFUoCSL1m+/V1krnW0L5tB8QaXp24sHBWmTSGMUsbQARuLu01
 uLkUrSAgj/+T7MKthdojXLP3a27Ny0pmoSm+OwJgWP9O3sQC6ZUK1GMz6UzpP6ie+93A
 9sjtZ7l5c3lqr8vGblsApe3LgbATTmBO42EI7IUBnePWAdk2KpQ7Rv7uZ1R54nsYoIEJ
 w+ERHMrJtlQfTEZDU5bD0tROatf48z28nRE5mkEnZxPWtcy0tgRIl3KuuQoe0DJsJaGP
 0dqglt7ZbH8oDkORW0AmHP2hlAYBiuad157tNHrdHgzbKNSHkI4WuDLRnof+yknSMFdL
 llPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9MYR1fL4LMIx7JzNK3MR85Ll1dY3Hp/rUqi3GHmQqLE=;
 b=VdhEQMf5LdMQy+6hzxoQsyLT1wEkLfAUhIpVyzPacoxgjlp9OZD1g51aSy44yreGxV
 ZCXq4Cu629nT4wwDb6yRGJrrFVk27lq5ywNjPCOU0CdQuH2BlObAYL06O8tT0ymPCWMF
 IKhgO/b36WTAqQGI5W+nGapbAe88Vf3xFMAtY7Ny9AiogEwiEXdRSr4rio04u5GzfqxQ
 RUV/ia1LNfhOtBT9/eT+aCAIQxF4PM/x+zeCsBh407lj3gJ88gubHDxPNcg70wiQFgXk
 s3bjcBBJ9SSUDQW8sGkbyzi3cjM6+x+hhyOpQpXoEilYmm5NKmFKzcYiAufMkeSYJhVr
 9fcw==
X-Gm-Message-State: AA+aEWZnhxlDxpScqlSrnalUIogW5TLeRvnoWOPlK47npbVqBIs6xjo9
 cSm66gJf9dwYSKAEkcVvmAo=
X-Google-Smtp-Source: AFSGD/VPRx8YCkGZV+pYuBcL+DwQ2v2wcepkQtBrmGNvw0iMVrqiWbtdUq7OJOffpk4TskbLuTlnDw==
X-Received: by 2002:a1c:b189:: with SMTP id a131mr14761433wmf.38.1543974152112; 
 Tue, 04 Dec 2018 17:42:32 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
 by smtp.gmail.com with ESMTPSA id b7sm15845784wrs.47.2018.12.04.17.42.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 17:42:31 -0800 (PST)
From: Nathan Chancellor <natechancellor@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Subject: [PATCH 1/2] ARM: Remove '-p' from LDFLAGS
Date: Tue,  4 Dec 2018 18:42:12 -0700
Message-Id: <20181205014213.943-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_174245_032411_8DBAAF40 
X-CRM114-Status: GOOD (  12.73  )
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
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
---
 arch/arm/Makefile                 | 2 +-
 arch/arm/boot/compressed/Makefile | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 05a91d8b89f3..e2a0baf36766 100644
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
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 1f5a5ffe7fcf..dcd07bd24b85 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -131,8 +131,6 @@ endif
 ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux += --be8
 endif
-# ?
-LDFLAGS_vmlinux += -p
 # Report unresolved symbol references
 LDFLAGS_vmlinux += --no-undefined
 # Delete all temporary local symbols
-- 
2.20.0.rc1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
