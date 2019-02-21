Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167CEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:46:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76F020823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jnVmSchZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n2D4RM0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76F020823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1T+3Shyjff9a3yJznE5tqqkmRuWqVbNENCawz1BbzLk=; b=jnVmSchZ2Njxdl
	I4DTdWb6rBTkr0ItGZl8kPie9yDv26y6vB7/qly9xBjolNSeFeMznHGmh5qGYc989k4d2b3cFam25
	OMye43X0SGPUg6bYGziwzurRNl0jTKXS4I+oXvsEjqDzhAg/nM4JtmLpZfaGtoRco1L459MhtPnM7
	pgt8eGT5fW3x0ktVn1d50aWHlsgG2RT3k2ULEdijVg/i6BRGda5BUUb4V9vmLXrMk0lj8G9xH/6Kd
	xsEGMEcLKdCkKpZBvWzPaIHWLBAJa5d2pbyAjAh+c0nNgBXxeW4u2AoaUE4fLvK7t3K41KuVAO8HB
	ZRsVDJFpe94IIVtnwnNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqXo-0005Y3-ME; Thu, 21 Feb 2019 15:45:52 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqXF-0004n0-BL
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:45:23 +0000
Received: by mail-lf1-x143.google.com with SMTP id j1so20697251lfb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NB14pN23cU5a79uf5Vo+6b4TfyyyCbisUIZiRj9SV0c=;
 b=n2D4RM0sd7tij8qE47B6TTI1pA+vAm1jx+kLrXSegWVmKX0MQSKeHSJxtRwexFXy+I
 EecG5AOO59A5DQ9RGR0mTsde1lbhwcBs3CuOJAtEhC+LHt8BwNuRIu18qPijzXVBGGv6
 BFLSmWzu/Z4qMccfwvIbTKvvIa9zw8LAewGNYbOz+kynYVDEu+HQbO8xd7VrxgnLGLrn
 9s9GyyeO/LF5BfM0sX1MEzmbciwJvq/qHp0FoylRS85UW/xotOq7qW4VnTPQXd4h1H2b
 nCPmrVcQLq4zDbHvZhrfCMjoRlyoeSkJgr1FkhXr748qhL3NyPl7231vxaXWepol2cdZ
 zO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NB14pN23cU5a79uf5Vo+6b4TfyyyCbisUIZiRj9SV0c=;
 b=c2aiuDS/Jjk9su0uwM5pDvjXvgiL/XMO3e1PSqNeFQ1QjcDaAf2g/uLc4p1cN4xrNT
 uua9z1QoJ9aHuWs1i3ITSbovGASaJRzsTUW4jRsz2M5+jVwWSNIrGLrpqh4c3EVZozqk
 gAS3FjVxs24DJxEDIp8rjzEl4JHm+ZCcOi/DAEKDLokaXhbJUtd+B7Oo9tQPondIfKNY
 XS/Qwsl2+pQBXpO8JY5KkH04W7Q62mqUbByw+7ZywJnh+LzqlO5UhbldMTRbagpQvgKq
 sqRJOsMejzihNUcv64oHu5OVvXemXo6IO9Yk9cg5CAI3e9VH7rAoalvdIp8LDkyZ5mJ4
 NmUQ==
X-Gm-Message-State: AHQUAua5uk8zt4BupjZMNQOOCPXzbuho9rM2g6SffVYo7AD/WernBEIJ
 e779ETFOOeQDfhRqzr5Tq4+TA52lTp8=
X-Google-Smtp-Source: AHgI3IYuTeXwEovqLPoQDn8n1nRWggMHqs7gKwnQ4uy1VFgnqlP2kfy9fPsCM2R/zmregAuWnjUwLg==
X-Received: by 2002:ac2:5328:: with SMTP id f8mr21376687lfh.42.1550763915020; 
 Thu, 21 Feb 2019 07:45:15 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.45.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:45:13 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 03/30 v2] ARM: ixp4xx: Convert to SPARSE_IRQ
Date: Thu, 21 Feb 2019 16:44:31 +0100
Message-Id: <20190221154458.23763-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154458.23763-1-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_074517_934928_C3717DE4 
X-CRM114-Status: GOOD (  13.75  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This localizes the <mach/irqs.h> header to the mach-ixp4xx
directory, removes NR_IRQS and switches IXP4xx over to using
SPARSE_IRQ.

This is a prerequisite for DT support.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                               | 1 +
 arch/arm/mach-ixp4xx/avila-pci.c               | 2 ++
 arch/arm/mach-ixp4xx/avila-setup.c             | 2 ++
 arch/arm/mach-ixp4xx/common.c                  | 2 ++
 arch/arm/mach-ixp4xx/coyote-pci.c              | 2 ++
 arch/arm/mach-ixp4xx/coyote-setup.c            | 2 ++
 arch/arm/mach-ixp4xx/dsmg600-pci.c             | 2 ++
 arch/arm/mach-ixp4xx/dsmg600-setup.c           | 2 ++
 arch/arm/mach-ixp4xx/fsg-pci.c                 | 2 ++
 arch/arm/mach-ixp4xx/fsg-setup.c               | 2 ++
 arch/arm/mach-ixp4xx/gateway7001-pci.c         | 2 ++
 arch/arm/mach-ixp4xx/gateway7001-setup.c       | 2 ++
 arch/arm/mach-ixp4xx/gtwx5715-pci.c            | 2 ++
 arch/arm/mach-ixp4xx/gtwx5715-setup.c          | 2 ++
 arch/arm/mach-ixp4xx/{include/mach => }/irqs.h | 2 --
 arch/arm/mach-ixp4xx/ixdp425-pci.c             | 2 ++
 arch/arm/mach-ixp4xx/ixdp425-setup.c           | 2 ++
 arch/arm/mach-ixp4xx/ixdpg425-pci.c            | 2 ++
 arch/arm/mach-ixp4xx/ixp4xx_qmgr.c             | 2 ++
 arch/arm/mach-ixp4xx/nas100d-pci.c             | 2 ++
 arch/arm/mach-ixp4xx/nas100d-setup.c           | 2 ++
 arch/arm/mach-ixp4xx/nslu2-pci.c               | 2 ++
 arch/arm/mach-ixp4xx/nslu2-setup.c             | 2 ++
 arch/arm/mach-ixp4xx/wg302v2-pci.c             | 2 ++
 arch/arm/mach-ixp4xx/wg302v2-setup.c           | 2 ++
 25 files changed, 47 insertions(+), 2 deletions(-)
 rename arch/arm/mach-ixp4xx/{include/mach => }/irqs.h (99%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0bdcacd40591..de2a5647e85d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -435,6 +435,7 @@ config ARCH_IXP4XX
 	select GPIOLIB
 	select HAVE_PCI
 	select NEED_MACH_IO_H
+	select SPARSE_IRQ
 	select USB_EHCI_BIG_ENDIAN_DESC
 	select USB_EHCI_BIG_ENDIAN_MMIO
 	help
diff --git a/arch/arm/mach-ixp4xx/avila-pci.c b/arch/arm/mach-ixp4xx/avila-pci.c
index 548c7d43ade6..9c834f0f4231 100644
--- a/arch/arm/mach-ixp4xx/avila-pci.c
+++ b/arch/arm/mach-ixp4xx/avila-pci.c
@@ -27,6 +27,8 @@
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 
+#include "irqs.h"
+
 #define AVILA_MAX_DEV	4
 #define LOFT_MAX_DEV	6
 #define IRQ_LINES	4
diff --git a/arch/arm/mach-ixp4xx/avila-setup.c b/arch/arm/mach-ixp4xx/avila-setup.c
index 44cbbce6bda6..1981b33109cb 100644
--- a/arch/arm/mach-ixp4xx/avila-setup.c
+++ b/arch/arm/mach-ixp4xx/avila-setup.c
@@ -28,6 +28,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 
+#include "irqs.h"
+
 #define AVILA_SDA_PIN	7
 #define AVILA_SCL_PIN	6
 
diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 58a1b851425e..aa8fd248c125 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -45,6 +45,8 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 
+#include "irqs.h"
+
 #define IXP4XX_TIMER_FREQ 66666000
 
 /*
diff --git a/arch/arm/mach-ixp4xx/coyote-pci.c b/arch/arm/mach-ixp4xx/coyote-pci.c
index 5d14ce2aee6d..a16c35d2bb96 100644
--- a/arch/arm/mach-ixp4xx/coyote-pci.c
+++ b/arch/arm/mach-ixp4xx/coyote-pci.c
@@ -23,6 +23,8 @@
 #include <asm/irq.h>
 #include <asm/mach/pci.h>
 
+#include "irqs.h"
+
 #define SLOT0_DEVID	14
 #define SLOT1_DEVID	15
 
diff --git a/arch/arm/mach-ixp4xx/coyote-setup.c b/arch/arm/mach-ixp4xx/coyote-setup.c
index 7e40fe70933b..7ca43ca2816d 100644
--- a/arch/arm/mach-ixp4xx/coyote-setup.c
+++ b/arch/arm/mach-ixp4xx/coyote-setup.c
@@ -25,6 +25,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 
+#include "irqs.h"
+
 #define COYOTE_IDE_BASE_PHYS	IXP4XX_EXP_BUS_BASE(3)
 #define COYOTE_IDE_BASE_VIRT	0xFFFE1000
 #define COYOTE_IDE_REGION_SIZE	0x1000
diff --git a/arch/arm/mach-ixp4xx/dsmg600-pci.c b/arch/arm/mach-ixp4xx/dsmg600-pci.c
index 8dca76937723..6899023bd1b7 100644
--- a/arch/arm/mach-ixp4xx/dsmg600-pci.c
+++ b/arch/arm/mach-ixp4xx/dsmg600-pci.c
@@ -22,6 +22,8 @@
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
 
+#include "irqs.h"
+
 #define MAX_DEV		4
 #define IRQ_LINES	3
 
diff --git a/arch/arm/mach-ixp4xx/dsmg600-setup.c b/arch/arm/mach-ixp4xx/dsmg600-setup.c
index 397190f3a8da..0daaede8fb6d 100644
--- a/arch/arm/mach-ixp4xx/dsmg600-setup.c
+++ b/arch/arm/mach-ixp4xx/dsmg600-setup.c
@@ -35,6 +35,8 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/time.h>
 
+#include "irqs.h"
+
 #define DSMG600_SDA_PIN		5
 #define DSMG600_SCL_PIN		4
 
diff --git a/arch/arm/mach-ixp4xx/fsg-pci.c b/arch/arm/mach-ixp4xx/fsg-pci.c
index fd4a8625b4ae..6c08bb9d9807 100644
--- a/arch/arm/mach-ixp4xx/fsg-pci.c
+++ b/arch/arm/mach-ixp4xx/fsg-pci.c
@@ -22,6 +22,8 @@
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
 
+#include "irqs.h"
+
 #define MAX_DEV		3
 #define IRQ_LINES	3
 
diff --git a/arch/arm/mach-ixp4xx/fsg-setup.c b/arch/arm/mach-ixp4xx/fsg-setup.c
index f0a152e365b1..648932d8d7a8 100644
--- a/arch/arm/mach-ixp4xx/fsg-setup.c
+++ b/arch/arm/mach-ixp4xx/fsg-setup.c
@@ -29,6 +29,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 
+#include "irqs.h"
+
 #define FSG_SDA_PIN		12
 #define FSG_SCL_PIN		13
 
diff --git a/arch/arm/mach-ixp4xx/gateway7001-pci.c b/arch/arm/mach-ixp4xx/gateway7001-pci.c
index d9d6cc089707..903c75330b76 100644
--- a/arch/arm/mach-ixp4xx/gateway7001-pci.c
+++ b/arch/arm/mach-ixp4xx/gateway7001-pci.c
@@ -27,6 +27,8 @@
 
 #include <asm/mach/pci.h>
 
+#include "irqs.h"
+
 void __init gateway7001_pci_preinit(void)
 {
 	irq_set_irq_type(IRQ_IXP4XX_GPIO10, IRQ_TYPE_LEVEL_LOW);
diff --git a/arch/arm/mach-ixp4xx/gateway7001-setup.c b/arch/arm/mach-ixp4xx/gateway7001-setup.c
index 1be6faf6da9a..678e7dfff0e5 100644
--- a/arch/arm/mach-ixp4xx/gateway7001-setup.c
+++ b/arch/arm/mach-ixp4xx/gateway7001-setup.c
@@ -28,6 +28,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 
+#include "irqs.h"
+
 static struct flash_platform_data gateway7001_flash_data = {
 	.map_name	= "cfi_probe",
 	.width		= 2,
diff --git a/arch/arm/mach-ixp4xx/gtwx5715-pci.c b/arch/arm/mach-ixp4xx/gtwx5715-pci.c
index 551d114c9e14..1223d160448f 100644
--- a/arch/arm/mach-ixp4xx/gtwx5715-pci.c
+++ b/arch/arm/mach-ixp4xx/gtwx5715-pci.c
@@ -30,6 +30,8 @@
 #include <mach/hardware.h>
 #include <asm/mach/pci.h>
 
+#include "irqs.h"
+
 #define SLOT0_DEVID	0
 #define SLOT1_DEVID	1
 #define INTA		10 /* slot 1 has INTA and INTB crossed */
diff --git a/arch/arm/mach-ixp4xx/gtwx5715-setup.c b/arch/arm/mach-ixp4xx/gtwx5715-setup.c
index 16a12994fb53..5dbdde8e2338 100644
--- a/arch/arm/mach-ixp4xx/gtwx5715-setup.c
+++ b/arch/arm/mach-ixp4xx/gtwx5715-setup.c
@@ -36,6 +36,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 
+#include "irqs.h"
+
 /* GPIO 5,6,7 and 12 are hard wired to the Kendin KS8995M Switch
    and operate as an SPI type interface.  The details of the interface
    are available on Kendin/Micrel's web site. */
diff --git a/arch/arm/mach-ixp4xx/include/mach/irqs.h b/arch/arm/mach-ixp4xx/irqs.h
similarity index 99%
rename from arch/arm/mach-ixp4xx/include/mach/irqs.h
rename to arch/arm/mach-ixp4xx/irqs.h
index dadcd4ddb0a9..6b7f220cf9e0 100644
--- a/arch/arm/mach-ixp4xx/include/mach/irqs.h
+++ b/arch/arm/mach-ixp4xx/irqs.h
@@ -63,8 +63,6 @@
 #define _IXP4XX_GPIO_IRQ(n)	(IRQ_IXP4XX_GPIO ## n)
 #define IXP4XX_GPIO_IRQ(n)	_IXP4XX_GPIO_IRQ(n)
 
-#define NR_IRQS 512
-
 #define	XSCALE_PMU_IRQ		(IRQ_IXP4XX_XSCALE_PMU)
 
 #endif
diff --git a/arch/arm/mach-ixp4xx/ixdp425-pci.c b/arch/arm/mach-ixp4xx/ixdp425-pci.c
index 318424dd3c50..c1340465b2ea 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-pci.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-pci.c
@@ -24,6 +24,8 @@
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 
+#include "irqs.h"
+
 #define MAX_DEV		4
 #define IRQ_LINES	4
 
diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
index 57d7df79d838..6f0f7ed18ea8 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -32,6 +32,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 
+#include "irqs.h"
+
 #define IXDP425_SDA_PIN		7
 #define IXDP425_SCL_PIN		6
 
diff --git a/arch/arm/mach-ixp4xx/ixdpg425-pci.c b/arch/arm/mach-ixp4xx/ixdpg425-pci.c
index 1f8717ba13dc..ac0e9bc6eb4d 100644
--- a/arch/arm/mach-ixp4xx/ixdpg425-pci.c
+++ b/arch/arm/mach-ixp4xx/ixdpg425-pci.c
@@ -23,6 +23,8 @@
 
 #include <asm/mach/pci.h>
 
+#include "irqs.h"
+
 void __init ixdpg425_pci_preinit(void)
 {
 	irq_set_irq_type(IRQ_IXP4XX_GPIO6, IRQ_TYPE_LEVEL_LOW);
diff --git a/arch/arm/mach-ixp4xx/ixp4xx_qmgr.c b/arch/arm/mach-ixp4xx/ixp4xx_qmgr.c
index 9d1b6b7c394c..4c7c960e1b4c 100644
--- a/arch/arm/mach-ixp4xx/ixp4xx_qmgr.c
+++ b/arch/arm/mach-ixp4xx/ixp4xx_qmgr.c
@@ -14,6 +14,8 @@
 #include <linux/module.h>
 #include <mach/qmgr.h>
 
+#include "irqs.h"
+
 static struct qmgr_regs __iomem *qmgr_regs = IXP4XX_QMGR_BASE_VIRT;
 static struct resource *mem_res;
 static spinlock_t qmgr_lock;
diff --git a/arch/arm/mach-ixp4xx/nas100d-pci.c b/arch/arm/mach-ixp4xx/nas100d-pci.c
index 8f0eba0a6800..925ef805f966 100644
--- a/arch/arm/mach-ixp4xx/nas100d-pci.c
+++ b/arch/arm/mach-ixp4xx/nas100d-pci.c
@@ -21,6 +21,8 @@
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
 
+#include "irqs.h"
+
 #define MAX_DEV		3
 #define IRQ_LINES	3
 
diff --git a/arch/arm/mach-ixp4xx/nas100d-setup.c b/arch/arm/mach-ixp4xx/nas100d-setup.c
index 4138d6aa4c52..9d67f8de0772 100644
--- a/arch/arm/mach-ixp4xx/nas100d-setup.c
+++ b/arch/arm/mach-ixp4xx/nas100d-setup.c
@@ -34,6 +34,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 
+#include "irqs.h"
+
 #define NAS100D_SDA_PIN		5
 #define NAS100D_SCL_PIN		6
 
diff --git a/arch/arm/mach-ixp4xx/nslu2-pci.c b/arch/arm/mach-ixp4xx/nslu2-pci.c
index 032defe111aa..d69ee4066d20 100644
--- a/arch/arm/mach-ixp4xx/nslu2-pci.c
+++ b/arch/arm/mach-ixp4xx/nslu2-pci.c
@@ -21,6 +21,8 @@
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
 
+#include "irqs.h"
+
 #define MAX_DEV		3
 #define IRQ_LINES	3
 
diff --git a/arch/arm/mach-ixp4xx/nslu2-setup.c b/arch/arm/mach-ixp4xx/nslu2-setup.c
index 7c2b6604187e..ee1877fcfafe 100644
--- a/arch/arm/mach-ixp4xx/nslu2-setup.c
+++ b/arch/arm/mach-ixp4xx/nslu2-setup.c
@@ -32,6 +32,8 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/time.h>
 
+#include "irqs.h"
+
 #define NSLU2_SDA_PIN		7
 #define NSLU2_SCL_PIN		6
 
diff --git a/arch/arm/mach-ixp4xx/wg302v2-pci.c b/arch/arm/mach-ixp4xx/wg302v2-pci.c
index c92e5b82af36..cf83f7e24179 100644
--- a/arch/arm/mach-ixp4xx/wg302v2-pci.c
+++ b/arch/arm/mach-ixp4xx/wg302v2-pci.c
@@ -27,6 +27,8 @@
 
 #include <asm/mach/pci.h>
 
+#include "irqs.h"
+
 void __init wg302v2_pci_preinit(void)
 {
 	irq_set_irq_type(IRQ_IXP4XX_GPIO8, IRQ_TYPE_LEVEL_LOW);
diff --git a/arch/arm/mach-ixp4xx/wg302v2-setup.c b/arch/arm/mach-ixp4xx/wg302v2-setup.c
index 90b3c604e8b6..8711e299229b 100644
--- a/arch/arm/mach-ixp4xx/wg302v2-setup.c
+++ b/arch/arm/mach-ixp4xx/wg302v2-setup.c
@@ -29,6 +29,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 
+#include "irqs.h"
+
 static struct flash_platform_data wg302v2_flash_data = {
 	.map_name	= "cfi_probe",
 	.width		= 2,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
