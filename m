Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBA4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:56:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AE95222DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="La3cqeEm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="je69WcmH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE95222DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UNh8DLPU7VtfWI9fYa4us3ZZYdlprzYpzdTfL2aftR8=; b=La3cqeEmFs9hJm
	90SxZyPe+v87MxG8qKq+0U42FNDq/uVehutR6Lru714XnaR5zCkhwv6AldoXE2LudeT3qjGwTEuSK
	6iOKf18ZJ5J5V65DV93WwFKbVW47oGbQqpkdpQ0fXA6XHkPhm3QQx68myTlq9QP6PBF/XOfOKAy+V
	ajLeyOrrxxmQNLdNHhxkA5S3Gq+NBZ611vYO+l8Ioy5+ZQXurFEyqKCYnn1g8ndsGO9TDr+/gJjRO
	qDLaDRH6nKnQaVbp70s5eit8Ih/PJV2DXvIe8262qW65wMmlw2ZM8WPaw0YCcXOc9PxPJgG9fqjVu
	neAycDI7J4VTXCKhl0PQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guIRR-00027G-CO; Thu, 14 Feb 2019 14:56:45 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guINw-0005Fi-A7
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:53:32 +0000
Received: by mail-wr1-x444.google.com with SMTP id x10so6770266wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MwgpcBpoQMZ/y0HzyDL1fssen+k0kz1TThumbF16U64=;
 b=je69WcmHdRPYvtJuCnNskBDAdR9NWb8Ajo0M+bnWnsUbsVT8cB/bbHQHKe1sGYwr9c
 6jia32K6dFPmCc36L5vFxEcP+5hFXZ324BHTikWWJxLeoiNmbJT8Buz0WHKB/scXCf8q
 KYV03J5u4SSPqiEGPXUQJosD2D5L/mLpDSO0Y9qiUqgmhWs55GLlK9tccJ4UuIyZaRTZ
 Y8nyu2RwpRHXafIgl1cS9UTD2KQBK5UFtEMU9OvfcGDOkjZCL6uGFKKHIc3lSTSKzHRU
 wbcEmX0oKfr9RwVAxxUCL0T1NJ6wmWBl6ny7JtuVTYw3SGO/o9dMs7mNb2AXZFZybLo1
 tLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MwgpcBpoQMZ/y0HzyDL1fssen+k0kz1TThumbF16U64=;
 b=ZAYXTS5b7BOTqLBLH1bBGDiTO5OeENrB9ItigY0WHk6rwWVc3xgdvIY2dsNwKC/t63
 gPA+M4BcJtbZE6A5qH0VwNXn75+sFt7v29AD7ztb+8u1DoHO62MqcSPHcKx4OFo8x8uS
 0/vNWzNjNkrmvKgra3yWalAvfZ9heoLOQL8NxYYjQdEMB+mXLWhhsdgIlXeC952WECEs
 8UEbNr+35HEpzdMEmFnR9TwAnRDVw9Jthh8fiFiMnbC9IvFkS5RmVGZIygUqtmQ03DUR
 fRt7pOgD6uzjLEc+8c2vKK3NIcDeeQ8gKLW9mf64lC41dkIMiUA5H8RwUhqcTX0U75vL
 7KMQ==
X-Gm-Message-State: AHQUAubtwP81siCf4rnkbXcqvRqRd19ejz0Am1rJL0kqqStHIDBpGk45
 hGgwa3O9w5s8Faof4Kdx3wculw==
X-Google-Smtp-Source: AHgI3Ib+dC7DUyOfGRb7ZE2q6bWo9oFo2ysKITQ3FRlJj9Rz0LIJ/QfdDHdL4Utne5iGTtnh2r4CIg==
X-Received: by 2002:adf:dc4e:: with SMTP id m14mr3258990wrj.107.1550155987042; 
 Thu, 14 Feb 2019 06:53:07 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 06:53:06 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 David Lechner <david@lechnology.com>
Subject: [PATCH v4 20/37] ARM: davinci: aintc: remove the timer-specific
 irq_set_handler()
Date: Thu, 14 Feb 2019 15:52:14 +0100
Message-Id: <20190214145231.8750-21-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_065308_779744_79E5EFC8 
X-CRM114-Status: GOOD (  12.30  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I've been unable to figure out exactly why, but the IRQ_TINT1_TINT34
interrupt is being handled as level irq and it's configured in the
irq chip driver instead of set by the irq_set_type() callback.

Since this is probably some legacy hack for out-of-tree code - remove it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/irq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 2b6943731af9..92b6e653d8cb 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -18,8 +18,6 @@
 #include <asm/mach/irq.h>
 #include <asm/exception.h>
 
-#include "irqs.h"
-
 #define DAVINCI_AINTC_FIQ_REG0		0x00
 #define DAVINCI_AINTC_FIQ_REG1		0x04
 #define DAVINCI_AINTC_IRQ_REG0		0x08
@@ -165,6 +163,5 @@ void __init davinci_aintc_init(const struct davinci_aintc_config *config)
 		davinci_aintc_setup_gc(davinci_aintc_base + reg_off,
 				       irq_base + irq_off, 32);
 
-	irq_set_handler(DAVINCI_INTC_IRQ(IRQ_TINT1_TINT34), handle_level_irq);
 	set_handle_irq(davinci_aintc_handle_irq);
 }
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
