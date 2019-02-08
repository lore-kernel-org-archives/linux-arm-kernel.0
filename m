Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FF5C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:42:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57A02075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ILFK6cee";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hQgcIPkN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57A02075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qWEMVwgK1CU/nGf8JjioejuaXiQjryHiTa5WeJs9Qt8=; b=ILFK6ceejNznmZ
	2R1NzIQO89OVGh1Gixg5/ZuJH3IBDzIubWP9cqX2Wq6KOLgLGyHyU4K3ZgflCVTQ4FFaj7vaooKmT
	Zu07BSOTONjdDmDdDUQ48VV+sKvmw4Fucj7eibLPRDeaHThV0P0RNt6d9VEL6KIX4GRyGa04nV/v3
	IrUJX2YSmK6tj1iA9dDPxRezTyibYI/L4Fkn0SOR/ztqDsUn4nt5nXMqSkdFCfiXZYKeFwEMU4LtO
	iK2btSgti6VjAO8l2prJYmXkk7g3rHznnBK2GWEvjCupi4FzhCUfjKIoybA475HcJFuJgQikLQMce
	310YWoGzJt8KBZS8oIOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs7Mb-0005f9-D7; Fri, 08 Feb 2019 14:42:45 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs7MM-0005RI-Js
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 14:42:32 +0000
Received: by mail-pg1-x541.google.com with SMTP id c25so1667637pgb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 06:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tyT92C3dEmrnaIfaPycI37ukcjwYqWOVbzH9NVAKCkQ=;
 b=hQgcIPkNJWUasAOAsWSBAai28MX3Htbs9EmKAbkONioNSb+u7oHDsYprgR9YQoTwjK
 s1SJVnOLPFhAbaXk6MEXjtnTxLbsNwDJQEquojEvSWCU9DsX8g6SRiAcJp2YZLMw8ovo
 bZSrwI0Q2jmFuw5zveKpBnlcB4Zzj5/DHCWQWC3ngbp5zwvcZxjei9wteMcuLILyibOA
 TMsAvMZK6UOzvIDhWfYKrMY3fLfNR9K/3eV+YqRLdzsPyT2uTCQdoNzYSXQz4F8Ng3ct
 rPdI18hCJD+AkaIPJg/60F3UbZhIDQNVwQGtj61JvQwHRYy5VPS7KXp2hiZLKw/3auYB
 AktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tyT92C3dEmrnaIfaPycI37ukcjwYqWOVbzH9NVAKCkQ=;
 b=S408d7AnG+Ex+ocPXoTQEzbRUdtViI3NTZAoE9hnitIyJmKUrBFVdKDmkXgPtEZhvy
 xAvUJkvjr05ZnMMK6QD9rMcTxX5tm1fjnMwnLq+ys+AuU/TejGhFFMOGNlWBUB7uJA1X
 NboK4+3QIHJ0QrxjdXs462aEu+ySOwqPLKKVpiAW0rFLDLXhDv5UK8HL6LAf+k7pnrdH
 vPHsup5pxpBRdp2j2xFROP5J/xc9y2Av6FSxD0WiH3m7GNMuWzVWYjC7E74NgZVeY5+d
 1A8bClb9TSh0o11rXCx1jK9Jd3wpUFcRMIHjeyndP3g2o0dpeDOMv0wq/CblUA3gxCv5
 Ozsg==
X-Gm-Message-State: AHQUAubjTEmdSqojB6freeFCzvd6FdKFPn8KNVa4ctPsISIyUA3m2K2Z
 Ct9mInBKDSPfrg0i5iAwZfjxyw==
X-Google-Smtp-Source: AHgI3IYPcloHlBmDINdKrbNSwZUcZvoiLV3Q353/5/Rs/7JJ2cgni7ENzaNsPzF5TB6SMJzOkQV3pg==
X-Received: by 2002:a62:5658:: with SMTP id k85mr22411480pfb.231.1549636949149; 
 Fri, 08 Feb 2019 06:42:29 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:da9d:67ff:fec6:ee6b])
 by smtp.gmail.com with ESMTPSA id e11sm2425573pgs.53.2019.02.08.06.42.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 08 Feb 2019 06:42:28 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: linux-amlogic@lists.infradead.org
Subject: [PATCH v3 2/2] arm64: dts: meson: add g12a x96 max board
Date: Fri,  8 Feb 2019 06:42:26 -0800
Message-Id: <20190208144226.15102-2-khilman@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208144226.15102-1-khilman@baylibre.com>
References: <20190208144226.15102-1-khilman@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_064230_649776_1B007D27 
X-CRM114-Status: GOOD (  14.96  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the G12a (S905X2) based X96 Max board[1].

There is no branding for the manufacturer anywhere on the product, so it
took some digging[2] to find the manufacturer.  But since there's
nothing about the maker on the product I've left it out of the DT name
because 1) nobody will know that name and 2) keeps the DT filename
shorter.

[1] https://www.cnx-software.com/2018/09/25/x96-max-amlogic-s905x2-tv-box/
[2] https://fccid.io/2AI6D-X96MAX

Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
v3:
- add dtb to Makefile
- add link to FCC info

 arch/arm64/boot/dts/amlogic/Makefile          |  1 +
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 28 +++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index f12efa27c636..0821fed4c074 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_MESON) += meson-axg-s400.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-u200.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-g12a-x96-max.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nanopi-k2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nexbox-a95x.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-odroidc2.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
new file mode 100644
index 000000000000..c62d3d5706ff
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2018 BayLibre SAS. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "meson-g12a.dtsi"
+
+/ {
+	compatible = "amediatech,x96-max", "amlogic,u200", "amlogic,g12a";
+	model = "Shenzhen Amediatech Technology Co., Ltd X96 Max";
+
+	aliases {
+		serial0 = &uart_AO;
+	};
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x40000000>;
+	};
+};
+
+&uart_AO {
+	status = "okay";
+};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
