Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92017C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:48:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60B6920823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VfE5CC28";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fi4uaO6R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B6920823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NNoRuBGVksIJT9rThOYzlA/YRNpmywQnNvlb50Djr1g=; b=VfE5CC28F6Ce+F
	ikMi2+RY29KzHMfjSsNfoEPYk71K5KBUetVJogYDjcY+72jHWwV9XtRRgNPRFaQPPWMQ9LLf27elo
	IzRnZjhlT6a0Urby3cuMFVd7gInzHDdYWmxOHXp1X3XLGYAzm/jZ2GMtpbaZvKlZp1Rd/IkR/qJR+
	RW+YDN3ZtwYRbVBwLpZPE7yVCTTYM+q354nvom29YELAgDSWIm6wla3WKLVfb3HjbmdyqLnntLSVc
	wkL3ghS95lhbVaxRJy6c4JhxiQ81zCRQKE00f59Lz20c2TsNjvUcIo+7C35CnwLp4lYYNyz5U/4BC
	s3LnVIh6OiXnj9w3FjCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqaG-0008Nc-Hz; Thu, 21 Feb 2019 15:48:24 +0000
Received: from mail-lj1-f193.google.com ([209.85.208.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqXt-0005eg-B1
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:46:25 +0000
Received: by mail-lj1-f193.google.com with SMTP id g80so24400824ljg.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R2ABnts4A81VsXKHtZ8wtITNo3WTLUTKGheobeTJauw=;
 b=Fi4uaO6RcCY8ZHzfFLaxI2eYSxOrON0jOjIFxRqNH6ZQ64FU0uc0+3OFbAeOFuyTcP
 GO4Ctuhgdy0kqnw/RlETxLXmkPhMIU8SqgsqPv1KdE+BOBCXFk6z0SYTi8y1XH4idRuv
 AFbCwUoav6Wqs/GX9l2LvTWqGbuzPZ3WrNBkSEBzbjsLD5DkPNPNncxPqsqSz1QgG6kM
 fb5Uz7YaYh2TsJq3B/Ysf5RcuDw3FmIn/F2hzSqXir8Ft2Kb37/QoPaEgGffvp5f3fuj
 YvRkyGnw+OP42tDz+nnzIA6EIFnDOcV+t9/7hJkvd/ctJuyAjTKttRv88g/ZuuOQ/joh
 Ao9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R2ABnts4A81VsXKHtZ8wtITNo3WTLUTKGheobeTJauw=;
 b=KzBmSXM0Hn01XKwy22LZHBugWEynfhA0gom2hmhae1yLmazzTy/lQck8rzvfGgtD9r
 Nj8vZtPIS1bjZzEa8L7EO6lTIgh2Wf/wWH2FteHOlPPZGlWFsEezslMNLdevlINTQnkk
 xpCPUhX6Rj8sJL/AGCgMztaMHoQ4E4jvOdpIHdoqTepnFoBZs/KTSCF3gvX6P8iM8OEH
 dNySj3N+9U9ncmHUnSy7icyTr3JjSCuQ2Ef9gu//A+iBW1jKfSZKaCm51rWqJC+vhdmw
 7GiUeETq8XHBDPqyZeOM5NKluZlOjx0Y8g7LSoUbI1o9TZVXET6HEDlnHQZcL0r0JRjJ
 t4rg==
X-Gm-Message-State: AHQUAuYiWwgeMFdnohKZyai+9ZMiAzi8QA23qB0W64LBkUk37GorYeup
 iwte6SW6JcmpEueXKMsuuc3xhdQ1h80=
X-Google-Smtp-Source: AHgI3IZ2phmAm+D6YXU30MndFfVEunPse0DuE91LujITPpb8uqQzF2SgID9jqDmmXLGMiA0yE2sFcQ==
X-Received: by 2002:a2e:980e:: with SMTP id a14mr20371561ljj.177.1550763954666; 
 Thu, 21 Feb 2019 07:45:54 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.45.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:45:53 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 18/30 v2] ARM: ixp4xx: Move NPE and QMGR to drivers/soc
Date: Thu, 21 Feb 2019 16:44:46 +0100
Message-Id: <20190221154458.23763-19-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154458.23763-1-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_074558_044676_437DB65C 
X-CRM114-Status: GOOD (  18.46  )
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

The Network Processing Engine and Queue Manager are
versatile firmware components used by several IXP4xx
drivers.

Drivers are relying on getting access to these components
using <mach/*> headers which does not work with
multiplatform. We need to find a better place for the
drivers to live.

Let's first move them to drivers/soc and the start to
refactor a bit by passing resources and moving headers.

This patch introduce static IRQ assignments but that
will be fixed by later patches in this series.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 MAINTAINERS                                      |  4 ++--
 arch/arm/mach-ixp4xx/Kconfig                     | 13 -------------
 arch/arm/mach-ixp4xx/Makefile                    |  2 --
 drivers/soc/Kconfig                              |  1 +
 drivers/soc/Makefile                             |  1 +
 drivers/soc/ixp4xx/Kconfig                       | 16 ++++++++++++++++
 drivers/soc/ixp4xx/Makefile                      |  2 ++
 .../soc/ixp4xx/ixp4xx-npe.c                      |  0
 .../soc/ixp4xx/ixp4xx-qmgr.c                     |  5 ++++-
 9 files changed, 26 insertions(+), 18 deletions(-)
 create mode 100644 drivers/soc/ixp4xx/Kconfig
 create mode 100644 drivers/soc/ixp4xx/Makefile
 rename arch/arm/mach-ixp4xx/ixp4xx_npe.c => drivers/soc/ixp4xx/ixp4xx-npe.c (100%)
 rename arch/arm/mach-ixp4xx/ixp4xx_qmgr.c => drivers/soc/ixp4xx/ixp4xx-qmgr.c (98%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 20d02e1e60a8..2c4057a7c9b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7723,8 +7723,8 @@ M:	Krzysztof Halasa <khalasa@piap.pl>
 S:	Maintained
 F:	arch/arm/mach-ixp4xx/include/mach/qmgr.h
 F:	arch/arm/mach-ixp4xx/include/mach/npe.h
-F:	arch/arm/mach-ixp4xx/ixp4xx_qmgr.c
-F:	arch/arm/mach-ixp4xx/ixp4xx_npe.c
+F:	drivers/soc/ixp4xx/ixp4xx-qmgr.c
+F:	drivers/soc/ixp4xx/ixp4xx-npe.c
 F:	drivers/net/ethernet/xscale/ixp4xx_eth.c
 F:	drivers/net/wan/ixp4xx_hss.c
 
diff --git a/arch/arm/mach-ixp4xx/Kconfig b/arch/arm/mach-ixp4xx/Kconfig
index 0973270f4863..83afb80d38a8 100644
--- a/arch/arm/mach-ixp4xx/Kconfig
+++ b/arch/arm/mach-ixp4xx/Kconfig
@@ -236,19 +236,6 @@ config IXP4XX_INDIRECT_PCI
 	  need to use the indirect method instead. If you don't know
 	  what you need, leave this option unselected.
 
-config IXP4XX_QMGR
-	tristate "IXP4xx Queue Manager support"
-	help
-	  This driver supports IXP4xx built-in hardware queue manager
-	  and is automatically selected by Ethernet and HSS drivers.
-
-config IXP4XX_NPE
-	tristate "IXP4xx Network Processor Engine support"
-	select FW_LOADER
-	help
-	  This driver supports IXP4xx built-in network coprocessors
-	  and is automatically selected by Ethernet and HSS drivers.
-
 endmenu
 
 endif
diff --git a/arch/arm/mach-ixp4xx/Makefile b/arch/arm/mach-ixp4xx/Makefile
index 5f63b3012826..1fa4e6605782 100644
--- a/arch/arm/mach-ixp4xx/Makefile
+++ b/arch/arm/mach-ixp4xx/Makefile
@@ -43,5 +43,3 @@ obj-$(CONFIG_MACH_GORAMO_MLR)	+= goramo_mlr.o
 obj-$(CONFIG_MACH_ARCOM_VULCAN)	+= vulcan-setup.o
 
 obj-$(CONFIG_PCI)		+= $(obj-pci-$(CONFIG_PCI)) common-pci.o
-obj-$(CONFIG_IXP4XX_QMGR)	+= ixp4xx_qmgr.o
-obj-$(CONFIG_IXP4XX_NPE)	+= ixp4xx_npe.o
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index c07b4a85253f..ae9bf20b26fa 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -6,6 +6,7 @@ source "drivers/soc/atmel/Kconfig"
 source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/fsl/Kconfig"
 source "drivers/soc/imx/Kconfig"
+source "drivers/soc/ixp4xx/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
 source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/renesas/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 90b686e586c6..c7c1a139ad8d 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-y				+= fsl/
 obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
 obj-$(CONFIG_ARCH_MXC)		+= imx/
+obj-$(CONFIG_ARCH_IXP4XX)	+= ixp4xx/
 obj-$(CONFIG_SOC_XWAY)		+= lantiq/
 obj-y				+= mediatek/
 obj-y				+= amlogic/
diff --git a/drivers/soc/ixp4xx/Kconfig b/drivers/soc/ixp4xx/Kconfig
new file mode 100644
index 000000000000..de6becdc78a2
--- /dev/null
+++ b/drivers/soc/ixp4xx/Kconfig
@@ -0,0 +1,16 @@
+menu "IXP4xx SoC drivers"
+
+config IXP4XX_QMGR
+	tristate "IXP4xx Queue Manager support"
+	help
+	  This driver supports IXP4xx built-in hardware queue manager
+	  and is automatically selected by Ethernet and HSS drivers.
+
+config IXP4XX_NPE
+	tristate "IXP4xx Network Processor Engine support"
+	select FW_LOADER
+	help
+	  This driver supports IXP4xx built-in network coprocessors
+	  and is automatically selected by Ethernet and HSS drivers.
+
+endmenu
diff --git a/drivers/soc/ixp4xx/Makefile b/drivers/soc/ixp4xx/Makefile
new file mode 100644
index 000000000000..d20d99e6df65
--- /dev/null
+++ b/drivers/soc/ixp4xx/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_IXP4XX_QMGR)	+= ixp4xx-qmgr.o
+obj-$(CONFIG_IXP4XX_NPE)	+= ixp4xx-npe.o
diff --git a/arch/arm/mach-ixp4xx/ixp4xx_npe.c b/drivers/soc/ixp4xx/ixp4xx-npe.c
similarity index 100%
rename from arch/arm/mach-ixp4xx/ixp4xx_npe.c
rename to drivers/soc/ixp4xx/ixp4xx-npe.c
diff --git a/arch/arm/mach-ixp4xx/ixp4xx_qmgr.c b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
similarity index 98%
rename from arch/arm/mach-ixp4xx/ixp4xx_qmgr.c
rename to drivers/soc/ixp4xx/ixp4xx-qmgr.c
index 2665347a2c6f..2e6d33534afe 100644
--- a/arch/arm/mach-ixp4xx/ixp4xx_qmgr.c
+++ b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
@@ -15,7 +15,10 @@
 #include <linux/of.h>
 #include <mach/qmgr.h>
 
-#include "irqs.h"
+/* FIXME: get rid of these static assigments */
+#define IRQ_IXP4XX_BASE		16
+#define IRQ_IXP4XX_QM1		(IRQ_IXP4XX_BASE + 3)
+#define IRQ_IXP4XX_QM2		(IRQ_IXP4XX_BASE + 4)
 
 static struct qmgr_regs __iomem *qmgr_regs = IXP4XX_QMGR_BASE_VIRT;
 static struct resource *mem_res;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
