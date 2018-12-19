Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD27BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:35:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71F3A20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vj8xFbph";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="b60byp3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F3A20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O/PZMCry5eMt44cOzfgqOlU3T07BhxRYxwnQceYXUOM=; b=Vj8xFbphxf3owP
	dhbo9NExgiwYk18ak/0+WNW6TP320CjwoxhYZkOIe0FJmLJJw025dtO3QpPGe+1jOYwZOJeiY2cM2
	j2PA89ZjHMZat+xfnHlXM7768OwYwNLHIw/WF+lvj3cVLsrD6dAdxZsTsufjmIs4pcjhb4pRSzejV
	s72ngd0cqYq2/HfN5f8FfNSJ5vhAs/VBXwuGjQ+3OjZGPdFajDDfQD2URYrMMs8iBTm11SKuevtMl
	7ysZHQKEqJO9I8YANEYSvXtpXoBr0cwJh9anivz/7+GotVakPyv/lKQNlNY7KCmibsuRiDsiUikrE
	K5ITzk3Wk8/S9ak1oqvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZlNX-0002fO-6i; Wed, 19 Dec 2018 23:35:51 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZlNG-0002Pm-6G
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 23:35:35 +0000
Received: by mail-pg1-x542.google.com with SMTP id j10so8940698pga.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 15:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0+0ZmMnSJcwh02/Zr8Y/Gkk/GLzxY/huUOTOniqe87E=;
 b=b60byp3DNsn5H0hKYrPbr1ipHRyLtx+EJ0X2jJ0eah4m5SDeMKbrC/9hYMUBzFQaC6
 qe4iQvpOSiPVJlPcKFJ2a9iVonrKR3AcYkReTIlb42Gcui8nhTtZbzP7reCt5pXbomgC
 xVAKHis1LfwEclvh3YhhoAqkXaAJ8LO+1lCdbhF358K1r2gkLK9ZqCYhZ4P9lnLaYFrf
 Xo/RQttv7O5+STHeVWtIxXTIxRSfcT6fDWBWgX19a5cBM0jP++8oyJFr/M9Y1ukXJART
 8xkgx6xqnoq3Y4CC0ee1+9Gp6Yp8Ghxxu5oXBAOJjrGZ05glvndpHZsxQwMEwjbI7B7Z
 exaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0+0ZmMnSJcwh02/Zr8Y/Gkk/GLzxY/huUOTOniqe87E=;
 b=MHG4aLH06uRYmbSnjBA3YH8vjOv+mfXB7KrzAz9Yk1rIZxIa+woBPf8YT0NlsGe+2r
 RZ69n8G88QClk0eyANR6D+Yg81otmb4rkursFQdUK3n9vEYIW4RnV87INl8IjeqscrV/
 /KvPTTvScrUVLTKa3ELLkoxZvVNVEK8xP2V9fmWvPbvateCHXrD2Z4DgaEciBDVoqEQA
 WrSpEMiT7MoHR4ip+IyPzPMjWyhl4sBGKHNYu6fiUTpU6O81PlZl+5DdTGZFVyNGgv+S
 ESDgk5IVal2wDxyLxWMz0hd578EHcBzFvLlh1nFakpMkeQ8EUA20n0n8aktch0GACI3i
 v4ZA==
X-Gm-Message-State: AA+aEWYukVSWJPMBOhmKFP5F540OfswhNRoi5jMXVdiJ3SHKAep2FNkz
 5hVO71p2PoMdAzyuK/oESvoMKA==
X-Google-Smtp-Source: AFSGD/VcSwOyTa3hDe6Z+qDRNfYhc3WvMlo7QLp6xDX85dlncfGaSlVKNlVe6tWYWAAKezfpmrED3w==
X-Received: by 2002:a63:7e1a:: with SMTP id z26mr20508583pgc.216.1545262522186; 
 Wed, 19 Dec 2018 15:35:22 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:da9d:67ff:fec6:ee6b])
 by smtp.gmail.com with ESMTPSA id d69sm25194196pfg.168.2018.12.19.15.35.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 19 Dec 2018 15:35:21 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: linux-amlogic@lists.infradead.org
Subject: [PATCH v2 2/2] arm64: dts: meson: add g12a x96 max board
Date: Wed, 19 Dec 2018 15:35:19 -0800
Message-Id: <20181219233519.35287-2-khilman@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181219233519.35287-1-khilman@baylibre.com>
References: <20181219233519.35287-1-khilman@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_153534_231571_525CA7FD 
X-CRM114-Status: GOOD (  14.53  )
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
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the G12a (S905X2) based X96 Max board[1].

There is no branding for the manufacturer anywhere on the product, so it
took some digging to find the manufacturer.  But since there's nothing
about the maker on the product I've left it out of the DT name because
1) nobody will know that name and 2) keeps the DT filename shorter.

[1] https://www.cnx-software.com/2018/09/25/x96-max-amlogic-s905x2-tv-box/

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts

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
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
