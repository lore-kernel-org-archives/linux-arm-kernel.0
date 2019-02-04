Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20E0C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:18:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAC3C2087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jkb8lkXp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="mHzJ9Mt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC3C2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Mqu9Hc0h9+T1SkcaQDdGDG3nndVpbjxCiwAM2QTywHk=; b=jkb8lkXpvuXKf2
	z4Q6ZPftc8wk16zTrX4tbd+aD4jnxWZLZO0cn3lcTmmcUwe0cjGv1qCm04l99opdqQIsO7ycvvRLb
	leP64h/AzpQw+BBIHa4Tx9Z3SdEE9IZfcqPyQb2LGr9xP58kl0kJCQwxdiEiHwtGOXNUWOE3ImhfW
	SavLZIGEHoSPcfW38TIPcNRiQsoPee77YiOP+hWAnVK868g2di+EYU5lHmTuyVdzZZ+Q8DVqYcaI6
	fbQv5UxLRsTuTEKc9mwY+f5SCDdtFm63nUkMm59qczgWSi/7aZi546LMJ6+8vNq3dOaR+BEf4PRWw
	DLrhcqcPxYs4AATnMi4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqht5-0000FM-5i; Mon, 04 Feb 2019 17:18:27 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqhsn-0008SA-If
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 17:18:11 +0000
Received: by mail-wr1-x443.google.com with SMTP id q15so635274wro.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 09:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yFpS5DDDhLyl9bQz2zuBoJHX/scehbNVUdh3+QSm0uc=;
 b=mHzJ9Mt23GsbDw0sKI5+ezDtdS4AkNnYBIyoVSB0ETguUWETQgmLTfy8enaI+5E7r+
 jJRPCQ4EZnORxwMSNVMfsW69UEbw6FFL4TUBBfJFXQ2LvCNgTwWidSemMrm+FFKOPUPK
 iraBKtjBU+nvnjlA/OuaUVxM/E76oiJUY5gAjfWm6RZ6rnha8QEdOKdqjFcWezk2YlVQ
 PdPn/HM2lQ+1JtC2qVgYCaP14MN3PkiZdjCb2LqWZQ2opiLfx53kY+kSjvGwWoeNYg7W
 YQ7YREJ3s7q5eZX3L0R343ARndFt+RAX7F6ybyad61hWnDMphSGe0jzvmEiD4R4nhn81
 NZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yFpS5DDDhLyl9bQz2zuBoJHX/scehbNVUdh3+QSm0uc=;
 b=qqFoxb9CJvvOpHRm6h7FNNgLPWYbUWUguTyqTe89s0VBmo0gBEfgrBUfLFCsuzjif4
 hp8LKALIXQ8zJaKMqX37WsYebEvxkhyktPTYcTuwC3nLUIdkPiVK9q0HvPqmxd2CYsPk
 K9CVQPgynE0MHjyf4QEo5agZB7Qe5oyGfjASTBbgW2dhMgjROK0oTZ4/EXz+ldHlDASF
 a8xdjdLNNBivBw3Qz66NU4c60ml+NAblbpsaqd1FXf7iA81FwyzuHGY0QgHLOk3082Xg
 vzqwSHvn0N1irBS42s/3bu2kV7tCphN/PpXZxGx3sp2r63mdYrwi4rg+eOK9ZuTIHIv4
 fx3g==
X-Gm-Message-State: AHQUAuY017ctUu4gH3Z+2+h/JzL+iI7mwV8Rqr/iRhOmpv/jAp8lDaQU
 mw/xW8euTdS8lW5G8vD2FCEgag==
X-Google-Smtp-Source: AHgI3Ia02xaYGccohww9tvSMAvuI8+c4UZjzMOGlLH+nv0yHbnp5Y9YEamYZ5vI8iJ9yS47e8tEDBg==
X-Received: by 2002:adf:c505:: with SMTP id q5mr348997wrf.84.1549300688052;
 Mon, 04 Feb 2019 09:18:08 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-8-223.w90-86.abo.wanadoo.fr. [90.86.125.223])
 by smtp.gmail.com with ESMTPSA id q9sm11197506wrv.26.2019.02.04.09.18.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 09:18:07 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 01/12] ARM: dts: da850: fix interrupt numbers for
 clocksource
Date: Mon,  4 Feb 2019 18:17:46 +0100
Message-Id: <20190204171757.32073-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204171757.32073-1-brgl@bgdev.pl>
References: <20190204171757.32073-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_091809_609913_53285606 
X-CRM114-Status: GOOD (  15.34  )
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
Cc: devicetree@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The timer interrupts specified in commit 3652e2741f42 ("ARM: dts:
da850: Add clocks") are wrong but since the current timer code
hard-codes them, the bug was never spotted.

This patch must go into stable since, once we introduce a proper
clocksource driver, devices with buggy device tree will stop booting.

Fixes: 3652e2741f42 ("ARM: dts: da850: Add clocks")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 47aa53ba6b92..559659b399d0 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -476,7 +476,7 @@
 		clocksource: timer@20000 {
 			compatible = "ti,da830-timer";
 			reg = <0x20000 0x1000>;
-			interrupts = <12>, <13>;
+			interrupts = <21>, <22>;
 			interrupt-names = "tint12", "tint34";
 			clocks = <&pll0_auxclk>;
 		};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
