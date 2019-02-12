Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDCAC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:41:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CCB320449
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eZSPkIZv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="m/Q6M+Ov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCB320449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IZwI1uvVM1x6EvG8LmblfV+Jj5SPRdSeqI9dJ27ZAlk=; b=eZSPkIZvdXQVxq
	aJ8n4AghTwaZm0yPCm5mKpJD6VE7duE/pevVwenuTUiuIJ9M2QSamrptBe9HsNNKbp0vLVQDi+coK
	7pboWYpJSGsX/SlNFXjXrT2bCdiqq+k3iaVzAhQA7pquKN/OfuJeDCyivXcQwqSIyb2hoh8XLpqDG
	04/bWsgGByJRBum+GO2NihDy0BhQPjxHxnIUA5pTkEpUnqYo1SkLlkQCIw9wXt79SrfA3n9R2l5Qu
	zYPih7khljhrV/W6vyEui0saWv57AFTqbiIvEoXl63hVRbfctPE1HQZ9Sye7uoByYufkeKv3QwTu5
	nYjiQDi1aso8IgzkcGEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVVC-0000vo-SO; Tue, 12 Feb 2019 10:41:22 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVT2-0005yh-Rx
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:39:22 +0000
Received: by mail-wr1-x441.google.com with SMTP id o17so2109679wrw.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 02:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fA+uLGx9M+6AGQxmQT53ySxAJPrPBENTyOLtHiIytQw=;
 b=m/Q6M+OvrW4I/qo0iwyh9z2j34nvBqBtTF/aieEjVNfGoyiP1XSRN1iHJEn/2NB6mA
 C5Hxr+u3/NuTB+uc0uwKI5fEmNtzswu11p4SXEWJziKf2RTnLhR/XyN1QrMHEbDgclGn
 hEaA0oVR+/5kYZ2cSDmKsSWNkNsn4cTd4VO7V7j38rcM/35YKkSVwca7uvUlmA3lhkqI
 SfMDcWsK0BV/QMLkJQwc8JWxKkGgGnFGgqgL/TWmOF7sxQOgXojICO6+4Ezh1H09/MDH
 LcZidoiSzlFR5N6oxajiylIMJnlTIWVBeVWhGZaRiMv0MzaS7AQKHKQ2b5t2GO5edpRD
 3Dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fA+uLGx9M+6AGQxmQT53ySxAJPrPBENTyOLtHiIytQw=;
 b=crGT9mXKLxMG4zCY881+Wr/Qdw9BU1y5slES+UmTk31iyy3Q5z2YhvBZ+yEeh+z5xk
 3PwAz9eY728gZoYIm0Mrj6XB4Gaxv2UMFgttzzOypDLxUGeOIY2e9C4krzUvmXV4XCjK
 TZhfG4onevCSrQGYnzN36XQ8T5tkAzUhVzEtp4Th4mEckniK7VX4BXzcJPaHWz9uDy3S
 i6ddXZQSRwuCx5c5xZ2w5IfNSJzDgcCTIqcg7cYhii0sRNqaOPWkXMSTAq1twDIJo2h9
 PYuum6Cg7xVgqxWZeIhfosa3iLS7USfuQLKe+/Z8JxDnCfzCFg35zh3tUgN3oKISMZZi
 kZ3g==
X-Gm-Message-State: AHQUAub1GL4kCnHC19FLsFVxIg8vpLRifTsSfHTSj3Op4xj30cR0Kvkh
 geC/UhYxapEx9DNTK9LWSzA5Aw==
X-Google-Smtp-Source: AHgI3IYYIzIVWhqLoxnYNJI5PNq+PKAxihOOi80YUF2KNzzzsduA4+tgDzzRyvpeh0qCZ3g71khh6Q==
X-Received: by 2002:adf:91a7:: with SMTP id 36mr2209584wri.77.1549967947447;
 Tue, 12 Feb 2019 02:39:07 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
 by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 02:39:06 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 09/37] ARM: davinci: make irqs.h a local header
Date: Tue, 12 Feb 2019 11:38:07 +0100
Message-Id: <20190212103835.7768-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_023909_739550_9A546508 
X-CRM114-Status: GOOD (  14.05  )
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
