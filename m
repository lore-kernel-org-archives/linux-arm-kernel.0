Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B39DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:22:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 368C720863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pII2YhRv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxZ3E1TE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368C720863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=BW0y8RzWXL5Xia0IQ3vzXg3WZt5t41UooHRHPWN5cZg=; b=pII2YhRvQlfWr3vU+iZBFD+Rjz
	aX077LyhK72wK5KaYpOOHVpPvxYHF47Qv1vX8ptMCFkXup7f4y/OO0M9Z/qa5Lmp5LzyErwxYHWaW
	Z5KNKw9T2gYPEzpVjdjYPk45DxM/sZieex4uKYTleh4mzn5/Z9udqw2frGKvXjOXsyXnGvNkJxpmm
	wx0z+vfnvhwsUafUJerWbw0gC6EPpri5XE7Aw3mTFyYlwmEFi+Iw0Y5R/jHUT7HWwYFEHAebNvSjK
	iwG7RZEE3PRm7ZA9A4/msxuDnZ8t2tJJTikd3BLyxWUJ9Mq1evACO/LBkjzJuVr7JBao7oI4FsoiL
	MTFsFIBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt7nc-0008Rb-9c; Mon, 11 Feb 2019 09:22:48 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt7mh-0007Zg-97
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 09:21:54 +0000
Received: by mail-wm1-x344.google.com with SMTP id y185so13928448wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 01:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kouOcgNi61HTRl9hVkQr6BVwZ6zXz4ll84P22bRURRY=;
 b=nxZ3E1TEGoQjfdA8uEkVGBINdi30O9EuQ/4tMIcDcZHxYSh5WvSlsOvgCud3kcuSzg
 5rXlmZ1z0I1FV0VhYkz4uezpr2SlxjE0/claa4nMeSU2MigRU56yXDepa/EVFTO6UXgE
 usw+y79CTHwNlYwmLmm2yOLyTUBPa84Ija/Zd1NvuFTuHrjMiQLVSD0ZbSH4pb9QdbHm
 jVwH2Mw1KSIPEZ6v69uVzsyqh/nJj0AczX0AAe40ioZS7QwQ1fM7FcTz8D8Oyblhx5ut
 izMBDzvlc3MetW20GxidHULJGVzT+EyHmZKg+RUyvqFtmMToouev9/tCfwUooQjCycm7
 M2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=kouOcgNi61HTRl9hVkQr6BVwZ6zXz4ll84P22bRURRY=;
 b=m7IDNRkUnbaeFEXtv32lyhnvLsINycwbkJYzne0WCKVzWbQSrqWb/2ju67hQaixW6/
 umwU7ujiawbuao5pAHlVFGM/a95WyU1FdnfRidsWA/45oUU6JdTJesUg8i8kk9id8Ic1
 zQKe4hYMJCpOZrJI060ksFtLo01+KNzQaeGZIVZfl0c8qxigDtkHK2TkxZ4Wtri75l53
 O2XXuoE09MYWy2zXpjIVPCyVUJMSrt+vsNLeKf0O42StHmL8efVQKqKYyq/LTJeal1DI
 r6uogoe5DjLEsw4Ur8ux/uksW7fkpWXnnMuONfX1TcKU4WO3iigWhSXYUePBCPgZS7Fl
 t6fQ==
X-Gm-Message-State: AHQUAuZVXmd3Rj2Ap3vKAxOGJMU8dgkAKlshJWl/sEYh2bnNhVTSwLP2
 NOWTYuXF6pHXOnVkDkvrloY=
X-Google-Smtp-Source: AHgI3IaJ8EMjjtLQ9xm5fWXo4hyjggK8WDV+q7h2jv4C0j66gduhBvULOd222vN7DxTLt0qMvzJ7nA==
X-Received: by 2002:a5d:6850:: with SMTP id o16mr27397974wrw.123.1549876909938; 
 Mon, 11 Feb 2019 01:21:49 -0800 (PST)
Received: from ThinkPad.gtu.edu.tr ([193.140.134.118])
 by smtp.gmail.com with ESMTPSA id o7sm11388979wmc.44.2019.02.11.01.21.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 11 Feb 2019 01:21:49 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-sunxi@googlegroups.com
Subject: [PATCH 3/7] ARM: dts: suniv: Add dt-binding headers for F1C100s
Date: Mon, 11 Feb 2019 12:21:09 +0300
Message-Id: <7ad73fd5c2664a50722cf0771512433483a629ca.1549875778.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1549875778.git.mesihkilinc@gmail.com>
References: <cover.1549875778.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_012151_715354_DD926731 
X-CRM114-Status: GOOD (  12.95  )
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
Cc: Mesih Kilinc <mesihkilinc@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Icenowy Zheng <icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

dt-binding headers for F1C100s merged now. So add them back to dtsi.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/boot/dts/suniv-f1c100s.dtsi | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/suniv-f1c100s.dtsi
index 6100d3b..953228c 100644
--- a/arch/arm/boot/dts/suniv-f1c100s.dtsi
+++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
@@ -4,6 +4,9 @@
  * Copyright 2018 Mesih Kilinc <mesihkilinc@gmail.com>
  */
 
+#include <dt-bindings/clock/suniv-ccu-f1c100s.h>
+#include <dt-bindings/reset/suniv-ccu-f1c100s.h>
+
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -82,7 +85,7 @@
 			compatible = "allwinner,suniv-f1c100s-pinctrl";
 			reg = <0x01c20800 0x400>;
 			interrupts = <38>, <39>, <40>;
-			clocks = <&ccu 37>, <&osc24M>, <&osc32k>;
+			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&osc32k>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			interrupt-controller;
@@ -114,8 +117,8 @@
 			interrupts = <1>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu 38>;
-			resets = <&ccu 24>;
+			clocks = <&ccu CLK_BUS_UART0>;
+			resets = <&ccu RST_BUS_UART0>;
 			status = "disabled";
 		};
 
@@ -125,8 +128,8 @@
 			interrupts = <2>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu 39>;
-			resets = <&ccu 25>;
+			clocks = <&ccu CLK_BUS_UART1>;
+			resets = <&ccu RST_BUS_UART1>;
 			status = "disabled";
 		};
 
@@ -136,8 +139,8 @@
 			interrupts = <3>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&ccu 40>;
-			resets = <&ccu 26>;
+			clocks = <&ccu CLK_BUS_UART2>;
+			resets = <&ccu RST_BUS_UART2>;
 			status = "disabled";
 		};
 	};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
