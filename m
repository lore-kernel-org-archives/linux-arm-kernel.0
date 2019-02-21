Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07E0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:48:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD05E20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="awNRGXhK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cccHI1sN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD05E20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9OmY1PWbw3pMVJCxzM2OcJpLoPlvVOEUKtExZCJlKIc=; b=awNRGXhKSZwcCD
	l/IFVKl9XVQ31IJJsJDT+GJNVQpkyCvGxwBJGDcPRU1elXnH/RGaM5y09cAFLlRNWbzrZYSoUR4TA
	t/DWWWTWuITVhyN4W2s7DyJSznU8XIt7BLNM7WtxIi6FSyPOcG3ooFZ3e853J0ak/8COzFmf2twc9
	84RDCi00vsp8opeoa18wnPAyTL0lcyF3F8U9DtUiFPSwonsDz3bU+JUjiKey8GqdBZhMAQU+1b/Ge
	iNQ74qKciLgsm1DpxQ1n0Z5SxO4P/G1SKYX5OKag23RgAAqddnBKHoMJELhZSC+Yl5DXb86tmwBLd
	pSmHWPuqXMPG+c5wIwVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqaV-0000FX-Q4; Thu, 21 Feb 2019 15:48:39 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqXv-0005hM-1o
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:46:28 +0000
Received: by mail-lf1-x143.google.com with SMTP id g2so20656456lfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IG8WAtyjVcV/McYwRasNEnrkhaKksxoln8zg4LDPzTc=;
 b=cccHI1sNwUvWbGUSyj33yPVdHkH1LOezUfZrS/bv9wEqETdm4oEwYlxXRcpbq6o1vD
 ryj5CuvmxGSKO0eeiE3yMGEQLt0YlLRDEhHPAYJIjeV24mlCmLZ2poET3i9XdyT4QZDj
 ocNMw8JZ5M/6mdtbgwOhQ7PVohrvdIxOgNGHqKMEmgrrlSIijYHDGzQX8MYzd31I2YUV
 kPyfAEUd9vqXvBUwXm+NhdNacOLpaDXvEUWOh6zLvz/UhgFKmCWM+g/LypwQ2gO29PR3
 AF46pj64dtv8XWBWtOHQjEI7haWfyzF0aEV0pu5GCYX3hiKzbaWGBnp76f5deuEYwUlx
 PDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IG8WAtyjVcV/McYwRasNEnrkhaKksxoln8zg4LDPzTc=;
 b=t1HArH9LBi0BVhSY28SmWOY0wQ2sEvUC0CcP2ptzk6EYzohnxFsCsqeiiSRG2ChLIi
 G0c1Ngv2DG6Aq6koH+H/JpO2MM7hdukvkrUs4Sp5pzISdy/Kdd5qV1Q30AWlYSlfbhP1
 YaqJtupeSuqg6IuLnNYVbz2IeaviYYxkr+n5koZLZefkS1kIIGzLA2+PbH5ylNgUAWO6
 /v1x6Tx3eHwVT5A0OQH5hALBX3v0HuG2kYM/1hSq6C/5ugCTUkQUR6vpbcinyCySdihq
 roJjhnmoSKixeKQ20WvmP/8p9sahnua00Z1U2j+FQBYyCKSRAYDfnQDXg+sBjMv+7K0D
 x1jw==
X-Gm-Message-State: AHQUAubNHI1lU7UiLxUN8s3qYpcTXjh/6fI6hNzHePWVhQhw1mBqNB4l
 85HddiiiNDpjqdjsLz88CB8LawHC2yY=
X-Google-Smtp-Source: AHgI3IYAd+3WTOemMwQ1/cK/H+L8gkDYFdEkkwl4zUPmD2WCZj0SekaqaZu1nMS13CjrvETM76GJCQ==
X-Received: by 2002:ac2:52ad:: with SMTP id r13mr10070097lfm.50.1550763957035; 
 Thu, 21 Feb 2019 07:45:57 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.45.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:45:56 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 19/30 v2] ARM: ixp4xx: Move IXP4xx QMGR and NPE headers
Date: Thu, 21 Feb 2019 16:44:47 +0100
Message-Id: <20190221154458.23763-20-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154458.23763-1-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_074559_777442_5F76017B 
X-CRM114-Status: GOOD (  11.87  )
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

This moves the IXP4xx Queue Manager and Network Processing
Engine headers out of the <mack/*> include path as that is
incompatible with multiplatform.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 MAINTAINERS                                                   | 4 ++--
 drivers/crypto/ixp4xx_crypto.c                                | 4 ++--
 drivers/net/ethernet/xscale/ixp4xx_eth.c                      | 4 ++--
 drivers/net/wan/ixp4xx_hss.c                                  | 4 ++--
 drivers/soc/ixp4xx/ixp4xx-npe.c                               | 2 +-
 drivers/soc/ixp4xx/ixp4xx-qmgr.c                              | 2 +-
 .../include/mach => include/linux/soc/ixp4xx}/npe.h           | 0
 .../include/mach => include/linux/soc/ixp4xx}/qmgr.h          | 0
 8 files changed, 10 insertions(+), 10 deletions(-)
 rename {arch/arm/mach-ixp4xx/include/mach => include/linux/soc/ixp4xx}/npe.h (100%)
 rename {arch/arm/mach-ixp4xx/include/mach => include/linux/soc/ixp4xx}/qmgr.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2c4057a7c9b4..1eb9dbcefdc4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7721,8 +7721,8 @@ F:	Documentation/media/v4l-drivers/ipu3.rst
 INTEL IXP4XX QMGR, NPE, ETHERNET and HSS SUPPORT
 M:	Krzysztof Halasa <khalasa@piap.pl>
 S:	Maintained
-F:	arch/arm/mach-ixp4xx/include/mach/qmgr.h
-F:	arch/arm/mach-ixp4xx/include/mach/npe.h
+F:	include/linux/soc/ixp4xx/qmgr.h
+F:	include/linux/soc/ixp4xx/npe.h
 F:	drivers/soc/ixp4xx/ixp4xx-qmgr.c
 F:	drivers/soc/ixp4xx/ixp4xx-npe.c
 F:	drivers/net/ethernet/xscale/ixp4xx_eth.c
diff --git a/drivers/crypto/ixp4xx_crypto.c b/drivers/crypto/ixp4xx_crypto.c
index 19fba998b86b..97f2a5dc7cc6 100644
--- a/drivers/crypto/ixp4xx_crypto.c
+++ b/drivers/crypto/ixp4xx_crypto.c
@@ -30,8 +30,8 @@
 #include <crypto/authenc.h>
 #include <crypto/scatterwalk.h>
 
-#include <mach/npe.h>
-#include <mach/qmgr.h>
+#include <linux/soc/ixp4xx/npe.h>
+#include <linux/soc/ixp4xx/qmgr.h>
 
 #define MAX_KEYLEN 32
 
diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
index 7ad3c3b56a77..abf59f30f18b 100644
--- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
+++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
@@ -38,8 +38,8 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <mach/ixp46x_ts.h>
-#include <mach/npe.h>
-#include <mach/qmgr.h>
+#include <linux/soc/ixp4xx/npe.h>
+#include <linux/soc/ixp4xx/qmgr.h>
 
 #define DEBUG_DESC		0
 #define DEBUG_RX		0
diff --git a/drivers/net/wan/ixp4xx_hss.c b/drivers/net/wan/ixp4xx_hss.c
index 6a505c26a3e7..791af08ed822 100644
--- a/drivers/net/wan/ixp4xx_hss.c
+++ b/drivers/net/wan/ixp4xx_hss.c
@@ -22,8 +22,8 @@
 #include <linux/platform_device.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
-#include <mach/npe.h>
-#include <mach/qmgr.h>
+#include <linux/soc/ixp4xx/npe.h>
+#include <linux/soc/ixp4xx/qmgr.h>
 
 #define DEBUG_DESC		0
 #define DEBUG_RX		0
diff --git a/drivers/soc/ixp4xx/ixp4xx-npe.c b/drivers/soc/ixp4xx/ixp4xx-npe.c
index e0ce22cd9bfc..1f6e01369d54 100644
--- a/drivers/soc/ixp4xx/ixp4xx-npe.c
+++ b/drivers/soc/ixp4xx/ixp4xx-npe.c
@@ -21,7 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <mach/npe.h>
+#include <linux/soc/ixp4xx/npe.h>
 
 #define DEBUG_MSG			0
 #define DEBUG_FW			0
diff --git a/drivers/soc/ixp4xx/ixp4xx-qmgr.c b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
index 2e6d33534afe..1bed048924bb 100644
--- a/drivers/soc/ixp4xx/ixp4xx-qmgr.c
+++ b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
@@ -13,7 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <mach/qmgr.h>
+#include <linux/soc/ixp4xx/qmgr.h>
 
 /* FIXME: get rid of these static assigments */
 #define IRQ_IXP4XX_BASE		16
diff --git a/arch/arm/mach-ixp4xx/include/mach/npe.h b/include/linux/soc/ixp4xx/npe.h
similarity index 100%
rename from arch/arm/mach-ixp4xx/include/mach/npe.h
rename to include/linux/soc/ixp4xx/npe.h
diff --git a/arch/arm/mach-ixp4xx/include/mach/qmgr.h b/include/linux/soc/ixp4xx/qmgr.h
similarity index 100%
rename from arch/arm/mach-ixp4xx/include/mach/qmgr.h
rename to include/linux/soc/ixp4xx/qmgr.h
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
