Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32436C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:09:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0094A21019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b+rSoyfy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EHkasOnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0094A21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=mkypOJKGKquwN14pISBHHm5C14Xh3yIih6KZJ467l0I=; b=b+rSoyfylciDsF
	WXmWMSUtqW+/VtRItk5WX3UEmi6QwWIMGsQynm2wYgI0T5HlWZXQcPOQvDQidE5xqHx6FUYVFc87y
	lsVTe8FzMVjbtaSzzw6r+0rp/RliOcjVT4JqNredaF7lOV1DD19wprVzdtwOLULo22Krtb8wHl2G2
	sdZtU18sNcKY4wG8TX3LqpvgKxLzPeIAXKOZpqceIgmYiRMIb79buPX+TX84FfOorH+byoOvG72vA
	fblDJTo+0Pg1XZl/eGWn+sRzpgFwM3TeGGP+1WAR49LcqHl/D79bnQ4bDtN62MvEGoJl11KdXbbnz
	j4W6fw0gi9SME/JXq7Sw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gltvu-0002rS-Q0; Tue, 22 Jan 2019 11:09:30 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gltvr-0002r7-Os
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 11:09:29 +0000
Received: by mail-wr1-x444.google.com with SMTP id t6so26778951wrr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 03:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ROUgXmOMbPBW0YJ4K5XOWpi1yfmG9ctSUKsvRHOqTto=;
 b=EHkasOnHwg6pEoiZGGX3ep6S9N39s2WMY1vIj8EU1uMr59np2gxS8EpdGMX2jYZr4x
 yIn4bO/04z+45ZGkXmoPrdV72fqL8yek2Vx1CyUHNizDqDiRTOpkePVKtBUMf8QIvao7
 37YmWgUDfhTJDopC6rbbonBtPWNOoPfB3c/ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ROUgXmOMbPBW0YJ4K5XOWpi1yfmG9ctSUKsvRHOqTto=;
 b=cP/+ydqnLuxM+CHYqlJa1bDT2uJE+cTVTJehOML3PRSn+WFF116jgDMXkGCqV7Eqbg
 xDafZoVtIYAyiW527kn3OIaq5+3mTTZ0K98d1im33kn9o8RszJji//KK8C/EAaDyib8s
 dXU3CiKVS/IMZMQtx1EbAaH+NIjMinzoEUdSHY/bAm8cdcs5E2LbhsJkwKt6ZWvZwGPa
 hSbJPMzHX4nVhcygyDg/qFZietKg0fdL3CWdheTC7UPlQQ3SnSwOd8MFLAgqfbuedk6j
 M2SB4sCdlqChoafG6bMzY34/abxXdLsfqaxInQfBtPMc8gLh6Oshi5EDCVue0qgQG+MO
 8Hrg==
X-Gm-Message-State: AJcUukcmLERjJ9pjGnuwb/NK6IaH7ql1T2Sib+LHaeHnw8OtDXj7Nj5A
 cF7OplGdgEHhQAkd8BLYTgwB3b6omk1qrQ==
X-Google-Smtp-Source: ALg8bN7zhnU09nsH+pKxZ4kfJoTjgfzbZfDp7FFIsct4xDwPEKtw+ZBu0pEJe7w4Qb2p3iow2KFXvQ==
X-Received: by 2002:a5d:5182:: with SMTP id k2mr32221930wrv.121.1548155364583; 
 Tue, 22 Jan 2019 03:09:24 -0800 (PST)
Received: from localhost.localdomain
 (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
 by smtp.gmail.com with ESMTPSA id v4sm44478213wme.6.2019.01.22.03.09.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Jan 2019 03:09:23 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: multi_v7_defconfig: enable GCC plugin support and
 structleak plugin
Date: Tue, 22 Jan 2019 12:09:12 +0100
Message-Id: <20190122110912.31134-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_030927_834872_5BD3A316 
X-CRM114-Status: UNSURE (   9.48  )
X-CRM114-Notice: Please train this message.
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
Cc: arm@kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable the base GCC plugin support symbol CONFIG_GCC_PLUGINS for
multi_v7_defconfig so that builds hosted on systems that have a
supported version of GCC along with the prerequisite headers will
allow GCC plugins to be used during the build. At the moment, this
will also enable the ARM per-task stack protector plugin, since
all its remaining Kconfig dependencies are fulfilled by default.

At the same time, enable the structleak plugin. This plugin ensures
that local struct type variables are fully initialized, preventing
inadvertent leaks of kernel state if such variables are shared with
userland. This is a reasonable transformation to apply by default,
since it does not adversely affect performance, and does not affect
GCC compiler diagnostics regarding the use of uninitialized local
variables.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5bee34a7ff2e..c1e82c237ed0 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1028,3 +1028,5 @@ CONFIG_CRYPTO_AES_ARM_CE=m
 CONFIG_CRYPTO_GHASH_ARM_CE=m
 CONFIG_CRYPTO_CRC32_ARM_CE=m
 CONFIG_CRYPTO_CHACHA20_NEON=m
+CONFIG_GCC_PLUGINS=y
+CONFIG_GCC_PLUGIN_STRUCTLEAK=y
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
