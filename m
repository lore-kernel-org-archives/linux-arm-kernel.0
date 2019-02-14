Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF5EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:56:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E6F22229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CXM2xE+0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="SUI2yh1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E6F22229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IZwI1uvVM1x6EvG8LmblfV+Jj5SPRdSeqI9dJ27ZAlk=; b=CXM2xE+0Mnaoex
	x0hyZ5433/rWJVMF1UtjkwESW2gFDs5Y36pJiyUPkP8+vt3uwnyHYIjyKcXANCEVYvLXo2pLT8lNt
	CaIJtgVGOwDeufFnnWUBI8mZx7BrSfCS85v5N2JbdNmO0Nsm9h4EkgmmRxdxa4/TkiP0W/r2MqgFC
	3UzPqe3YxSEon5pvGzHpLxc8V3UXuURFrLYhqBZ3B9v7deAr63EuHFx4R8obH6V/wKty+ORD0VRa0
	AclR6L8mRqpWByotmEccGsAigmVDnGXXjmQlRykc+JzEhxVi5o65xmK6YuIruSRSgH6AU23tkQZ+I
	utaLjcxdWyjdACLMgUtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guIR4-0001dK-Rh; Thu, 14 Feb 2019 14:56:22 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guINj-0004wY-3c
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:52:59 +0000
Received: by mail-wm1-x343.google.com with SMTP id d15so6604943wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fA+uLGx9M+6AGQxmQT53ySxAJPrPBENTyOLtHiIytQw=;
 b=SUI2yh1ezEWn/ufZQbq8bxJ7j4G8A7ybv263qbMwo3KTFp1QnXRdkayrjrj+JkTWmd
 +JOAEKfLoK+pfsK+2MR1OLgT5GwdSqARPN3oxd26v3fkHnWmMeqYYOI1GwEIOuidNZqu
 fN+KM1LUR1EdkYV2KuOg2vKikxKbeXvYCfoaCDGhnxmFYlgXo3UGeWEh19snzRycoj+y
 ODffYQO3eyJ/nf++iDm2GwXewltDFCKHdH+kr86MjzpyI5SNxGK2iTf6Wb+x31guRwt2
 4kcq9itucugonOLJAOk8VbhQQbOKsfYPJUmU92kflGyMsmf9d7WKu5QWNVtCoGgQfK07
 cf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fA+uLGx9M+6AGQxmQT53ySxAJPrPBENTyOLtHiIytQw=;
 b=TFIPrci8K0xY5IOR43RCdyPu9sW/hvwP30XpCq5I05BjeQT8MaEQ6wIoxCmwZybAhG
 04FZ2GgX1teGi2YZAbJi/IBWz9h4Hut3g/lqX2AbaqiSL7h9hsUSQL1C5CA9ZyGM8NfP
 PCuZwS+BEHBvGXAR2JhS3O2wcn3HHMS6tPI2npC/XGc28faoLJm+2w9v0DZyVhXcXZv0
 /96GDJLXuXGKekG1qs++j7J3oPtQH98ZkczFQxyPmiBTsEo/uW+H7HjV2j55me9K0mrl
 vrgJYLEHYbIUbbe833grO/e3XMvy8JMj9U8PcG3l08cfOvpvYOqxPsz8YWJ8SPO3vK6z
 PFGw==
X-Gm-Message-State: AHQUAubHuYHGKMc+YX5q6JvOTRXdGplhbfMDDcZaQ5AOPNqyanYHTzxS
 MCR4qCKVSeSmIfMpbUaZchENkR4mLBM=
X-Google-Smtp-Source: AHgI3IZBA2Xe1v0cCa6nTzhhRd/75ud0yRD5ZekmOAgiGFQCAbWV6IadvmBMCTBaun3Laeyz+8+q6w==
X-Received: by 2002:a7b:c2a9:: with SMTP id c9mr3249721wmk.44.1550155973502;
 Thu, 14 Feb 2019 06:52:53 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.52.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 06:52:52 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 David Lechner <david@lechnology.com>
Subject: [PATCH v4 09/37] ARM: davinci: make irqs.h a local header
Date: Thu, 14 Feb 2019 15:52:03 +0100
Message-Id: <20190214145231.8750-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_065255_231951_1958E83F 
X-CRM114-Status: GOOD (  13.65  )
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

The existence of irqs.h in mach-davinci/include/mach only makes sense
without SPARSE_IRQ as it's then expected to define NR_IRQS and is
included from asm/irq.h. As we now support SPARSE_IRQ, this header can
be moved to mach-davinci and used as the source of HW interrupt numbers.

While updating the includes in various files - also rearrange the
headers by directory (linux/asm/mach).

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da830-evm.c         | 5 +++--
 arch/arm/mach-davinci/board-da850-evm.c         | 5 +++--
 arch/arm/mach-davinci/board-dm644x-evm.c        | 7 ++++---
 arch/arm/mach-davinci/board-dm646x-evm.c        | 3 ++-
 arch/arm/mach-davinci/da830.c                   | 2 +-
 arch/arm/mach-davinci/da850.c                   | 2 +-
 arch/arm/mach-davinci/devices-da8xx.c           | 2 +-
 arch/arm/mach-davinci/devices.c                 | 9 ++++-----
 arch/arm/mach-davinci/dm355.c                   | 2 +-
 arch/arm/mach-davinci/dm365.c                   | 2 +-
 arch/arm/mach-davinci/dm644x.c                  | 2 +-
 arch/arm/mach-davinci/dm646x.c                  | 2 +-
 arch/arm/mach-davinci/irq.c                     | 3 ++-
 arch/arm/mach-davinci/{include/mach => }/irqs.h | 0
 arch/arm/mach-davinci/usb-da8xx.c               | 3 ++-
 arch/arm/mach-davinci/usb.c                     | 6 +++---
 16 files changed, 30 insertions(+), 25 deletions(-)
 rename arch/arm/mach-davinci/{include/mach => }/irqs.h (100%)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 41f5a51fee9a..7b8c4aeca096 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -36,11 +36,12 @@
 #include <asm/mach/arch.h>
 
 #include <mach/common.h>
-#include <mach/irqs.h>
-#include "cp_intc.h"
 #include <mach/mux.h>
 #include <mach/da8xx.h>
 
+#include "cp_intc.h"
+#include "irqs.h"
+
 #define DA830_EVM_PHY_ID		""
 /*
  * USB1 VBUS is controlled by GPIO1[15], over-current is reported on GPIO2[4].
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 317f48560534..b0814bd30a1f 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -43,10 +43,11 @@
 #include <linux/spi/flash.h>
 
 #include <mach/common.h>
-#include "cp_intc.h"
 #include <mach/da8xx.h>
 #include <mach/mux.h>
-#include <mach/irqs.h>
+
+#include "cp_intc.h"
+#include "irqs.h"
 #include "sram.h"
 
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 16ffed2525e6..a6bc48c9ecd9 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -36,10 +36,10 @@
 #include <asm/mach/arch.h>
 
 #include <mach/common.h>
-#include <mach/irqs.h>
-#include <linux/platform_data/i2c-davinci.h>
-#include <mach/serial.h>
 #include <mach/mux.h>
+#include <mach/serial.h>
+
+#include <linux/platform_data/i2c-davinci.h>
 #include <linux/platform_data/mtd-davinci.h>
 #include <linux/platform_data/mmc-davinci.h>
 #include <linux/platform_data/usb-davinci.h>
@@ -47,6 +47,7 @@
 #include <linux/platform_data/ti-aemif.h>
 
 #include "davinci.h"
+#include "irqs.h"
 
 #define DM644X_EVM_PHY_ID		"davinci_mdio-0:01"
 #define LXT971_PHY_ID	(0x001378e2)
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 8d5be6dd2019..26c123f35350 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -44,10 +44,11 @@
 #include <asm/mach/arch.h>
 
 #include <mach/common.h>
-#include <mach/irqs.h>
+
 #include <mach/serial.h>
 
 #include "davinci.h"
+#include "irqs.h"
 
 #define NAND_BLOCK_SIZE		SZ_128K
 
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index aa8da725a325..ca903c9105e4 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -19,9 +19,9 @@
 #include <mach/common.h>
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
-#include <mach/irqs.h>
 #include <mach/time.h>
 
+#include "irqs.h"
 #include "mux.h"
 
 /* Offsets of the 8 compare registers on the da830 */
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index d22b19833326..486d53481636 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -32,10 +32,10 @@
 #include <mach/cpufreq.h>
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
-#include <mach/irqs.h>
 #include <mach/pm.h>
 #include <mach/time.h>
 
+#include "irqs.h"
 #include "mux.h"
 
 #define DA850_PLL1_BASE		0x01e1a000
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 3104a3eb2ddf..b8dc674e06bc 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -25,10 +25,10 @@
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
 #include <mach/time.h>
-#include <mach/irqs.h>
 
 #include "asp.h"
 #include "cpuidle.h"
+#include "irqs.h"
 #include "sram.h"
 
 #define DA8XX_TPCC_BASE			0x01c00000
diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index 722c463f9b18..40bd8029e457 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -11,21 +11,20 @@
 
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/i2c-davinci.h>
+#include <linux/platform_data/mmc-davinci.h>
+#include <linux/platform_data/edma.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/reboot.h>
 
 #include <mach/hardware.h>
-#include <linux/platform_data/i2c-davinci.h>
-#include <mach/irqs.h>
 #include <mach/cputype.h>
 #include <mach/mux.h>
-#include <linux/platform_data/mmc-davinci.h>
 #include <mach/time.h>
-#include <linux/platform_data/edma.h>
-
 
 #include "davinci.h"
+#include "irqs.h"
 
 #define DAVINCI_I2C_BASE	     0x01C21000
 #define DAVINCI_ATA_BASE	     0x01C66000
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index cb725244fa13..b27ea4fc1d51 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -26,13 +26,13 @@
 
 #include <mach/common.h>
 #include <mach/cputype.h>
-#include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
 #include <mach/time.h>
 
 #include "asp.h"
 #include "davinci.h"
+#include "irqs.h"
 #include "mux.h"
 
 #define DM355_UART2_BASE	(IO_PHYS + 0x206000)
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index ae1b53ea956a..d9c6ab9215a6 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -31,13 +31,13 @@
 
 #include <mach/common.h>
 #include <mach/cputype.h>
-#include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
 #include <mach/time.h>
 
 #include "asp.h"
 #include "davinci.h"
+#include "irqs.h"
 #include "mux.h"
 
 #define DM365_REF_FREQ		24000000	/* 24 MHz on the DM365 EVM */
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 5ccb49196a71..b2748c82b747 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -23,13 +23,13 @@
 
 #include <mach/common.h>
 #include <mach/cputype.h>
-#include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
 #include <mach/time.h>
 
 #include "asp.h"
 #include "davinci.h"
+#include "irqs.h"
 #include "mux.h"
 
 /*
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 2b55625e8fb5..cf210741dfe5 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -24,13 +24,13 @@
 
 #include <mach/common.h>
 #include <mach/cputype.h>
-#include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
 #include <mach/time.h>
 
 #include "asp.h"
 #include "davinci.h"
+#include "irqs.h"
 #include "mux.h"
 
 #define DAVINCI_VPIF_BASE       (0x01C12000)
diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 34b0eec4de4e..5bfbd9c70a2e 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -28,10 +28,11 @@
 #include <mach/hardware.h>
 #include <mach/cputype.h>
 #include <mach/common.h>
-#include <mach/irqs.h>
 #include <asm/mach/irq.h>
 #include <asm/exception.h>
 
+#include "irqs.h"
+
 #define FIQ_REG0_OFFSET		0x0000
 #define FIQ_REG1_OFFSET		0x0004
 #define IRQ_REG0_OFFSET		0x0008
diff --git a/arch/arm/mach-davinci/include/mach/irqs.h b/arch/arm/mach-davinci/irqs.h
similarity index 100%
rename from arch/arm/mach-davinci/include/mach/irqs.h
rename to arch/arm/mach-davinci/irqs.h
diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index 2de5a04ffc24..25f21ee86f1a 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -18,7 +18,8 @@
 #include <mach/common.h>
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
-#include <mach/irqs.h>
+
+#include "irqs.h"
 
 #define DA8XX_USB0_BASE		0x01e00000
 #define DA8XX_USB1_BASE		0x01e25000
diff --git a/arch/arm/mach-davinci/usb.c b/arch/arm/mach-davinci/usb.c
index 9d4a58a3113a..1e14e964c34d 100644
--- a/arch/arm/mach-davinci/usb.c
+++ b/arch/arm/mach-davinci/usb.c
@@ -5,13 +5,13 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
-
+#include <linux/platform_data/usb-davinci.h>
 #include <linux/usb/musb.h>
 
 #include <mach/common.h>
-#include <mach/irqs.h>
 #include <mach/cputype.h>
-#include <linux/platform_data/usb-davinci.h>
+
+#include "irqs.h"
 
 #define DAVINCI_USB_OTG_BASE	0x01c64000
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
