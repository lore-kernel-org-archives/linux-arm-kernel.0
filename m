Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF1DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:07:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2AE62086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fbp9WmsJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJNovvbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2AE62086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=9TLVTqmfSRDzvurC5U0jCH1KU9xxJwQBMziX5T1eS6c=; b=fbp9WmsJZ9nmpUUMmcWf9n0UCg
	DKt7DM4c80gNdrlK0JLshDiUf0NiDu4PfuFj3Xla+bSVIcOQtTxZMcFapP3lTI0g0O834g4w32VpY
	Ds2QtFxWPER2/vdhH5uKUm61IJ+C5K92iHR6eKWV3Yh1df63nMOEIuYfe/h5uzShtFA67CfACTKLT
	nYhQ8zxF3ndiCaMa8PcGhIu+rogApNU6wu9N8na56RT8Rql4021DGBENcEUhnwT3hH0NY9Lcqp7JZ
	8S9hWdu4D5gs1+tL6syre7EJ11Jp3BS+sDM5TRn3RsIuJgjvmzZot6+6MHr5MEk2oa7Ua3mhGTa9C
	2NGfB7GQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjXns-0004Yy-6o; Tue, 15 Jan 2019 23:07:28 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjXnS-00049w-Fa
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 23:07:05 +0000
Received: by mail-ed1-x544.google.com with SMTP id h15so3971381edb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 15:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1h9d9A95Fr5hAd0WXvQzD83nIGqZQnGK3nipgpZF0Kw=;
 b=jJNovvbt1uZsPOb/cQuvDRQ42pCBFWyGb/Cm188BfcTgsor9rwdZHm7jElTl2SDRqm
 NB/Ve4H+LlflNHnvYSz0Y+vSOPSCXcJZ1xljxqvyaAfN/lN8IoUsdnEfPVfyonVwfYUo
 fsI3UI2rrJ3zOeftN+EsZc0eEyoqsmkjAwLYVchS33OmsIOBzkmR4bZvUoZyNZnvNVHP
 btEe30buHizz8k54le5a3+PgfS8AcfmdorqsiqhkdPH4o/dzIo0GCr5XgOCbjHOXDrqN
 b7bbzKjgSBu9r/nOuAyesddWm6n06t4h+xWasY/967HDamQQsIhoUgqi//i8ao7JB7Ms
 P7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=1h9d9A95Fr5hAd0WXvQzD83nIGqZQnGK3nipgpZF0Kw=;
 b=bueEss3twxaUhi9fE+DG9FGo4TwLGco3zx2tlR8/lwPnWgjjgPJtxbaVpWlWBnUFJF
 xZlvrccS+0/GgY0y37vu0EScVMJXVvdoBQdaT621VThLiMmcUSEUK3+1loP1eyCzQ72b
 hcdqoLTlct3Cg2CINemhwVTio912Bm0i6Z0os+jbbHBgTyCLatGBXOae3EeLIeiIcJ1s
 mP8i1s5rQAieb2Pm4TT4Mkj5WU46lqTjJEZwi5QOFfJvqhWOlwLoiqKsrWWop3KXUnnP
 d2dK3NwiznBFUYVRwW66x6kbtKtnh9JxQgT7sZzqgocfjrBZ8ZwpfG0YXs1RfeKlAP6Y
 UCMA==
X-Gm-Message-State: AJcUukccjAOx5U16PjYbYU+xfJkTBseFj3PGp+/Jz11WLg52a+Nz+h8T
 xxrYIefmQjwDYWIbZy7dfHI=
X-Google-Smtp-Source: ALg8bN4CoK9QUQYQICNKjAvjY9JDX2Ax8MEFLndlp9aNBrzwQwpFcK5zg6qJOe0wteenxoHSWo2fyA==
X-Received: by 2002:a50:8f44:: with SMTP id 62mr5050087edy.264.1547593620497; 
 Tue, 15 Jan 2019 15:07:00 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
 by smtp.gmail.com with ESMTPSA id v14sm4872324edq.74.2019.01.15.15.06.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Jan 2019 15:06:59 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 2/3] ARM: orion5x: Include platform_data/dsa.h
Date: Tue, 15 Jan 2019 15:06:12 -0800
Message-Id: <20190115230613.28334-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115230613.28334-1-f.fainelli@gmail.com>
References: <20190115230613.28334-1-f.fainelli@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_150702_936771_9995BD17 
X-CRM114-Status: GOOD (  14.19  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 "moderated list:ARM/Marvell Dove/MV78xx0/Orion SOC support"
 <linux-arm-kernel@lists.infradead.org>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Now that we have split the DSA platform data structures from the main
net/dsa.h header file, include only the relevant header file.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mach-orion5x/common.c               | 2 +-
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c | 2 +-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c  | 2 +-
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c | 2 +-
 arch/arm/mach-orion5x/wnr854t-setup.c        | 2 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c     | 2 +-
 arch/arm/plat-orion/common.c                 | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index 83a7ec4c16d0..c67f92bfa30e 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -20,7 +20,7 @@
 #include <linux/delay.h>
 #include <linux/clk-provider.h>
 #include <linux/cpu.h>
-#include <net/dsa.h>
+#include <linux/platform_data/dsa.h>
 #include <asm/page.h>
 #include <asm/setup.h>
 #include <asm/system_misc.h>
diff --git a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
index a3c1336d30c9..c65ab7db36ad 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
@@ -16,7 +16,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/ethtool.h>
-#include <net/dsa.h>
+#include <linux/platform_data/dsa.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
diff --git a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
index 252efe29bd1a..76b8138d9d79 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
@@ -17,7 +17,7 @@
 #include <linux/mv643xx_eth.h>
 #include <linux/ethtool.h>
 #include <linux/i2c.h>
-#include <net/dsa.h>
+#include <linux/platform_data/dsa.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
diff --git a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
index f4f1dbe1d91d..5f388a1ed1e4 100644
--- a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
@@ -18,7 +18,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
 #include <linux/ethtool.h>
-#include <net/dsa.h>
+#include <linux/platform_data/dsa.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
diff --git a/arch/arm/mach-orion5x/wnr854t-setup.c b/arch/arm/mach-orion5x/wnr854t-setup.c
index d162d4c7f85d..83589a28a491 100644
--- a/arch/arm/mach-orion5x/wnr854t-setup.c
+++ b/arch/arm/mach-orion5x/wnr854t-setup.c
@@ -15,7 +15,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/ethtool.h>
-#include <net/dsa.h>
+#include <linux/platform_data/dsa.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
diff --git a/arch/arm/mach-orion5x/wrt350n-v2-setup.c b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
index 9250bb2e429c..cea08d4a2597 100644
--- a/arch/arm/mach-orion5x/wrt350n-v2-setup.c
+++ b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
@@ -18,7 +18,7 @@
 #include <linux/leds.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
-#include <net/dsa.h>
+#include <linux/platform_data/dsa.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index a2399fd66e97..a6c81ce00f52 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -18,7 +18,7 @@
 #include <linux/clkdev.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/mv643xx_i2c.h>
-#include <net/dsa.h>
+#include <linux/platform_data/dsa.h>
 #include <linux/platform_data/dma-mv_xor.h>
 #include <linux/platform_data/usb-ehci-orion.h>
 #include <plat/common.h>
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
