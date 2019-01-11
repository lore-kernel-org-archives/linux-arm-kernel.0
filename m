Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753DBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:22:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A8A420872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l1OJqOdi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="e/66MXAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8A420872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yztFoKjq/O75SwHtGWsdFQhWzOCBtIBRRMlEBJ8S9Wo=; b=l1OJqOdiWH6u/q
	GuB1jXpDlfkrb88A6WPFDkALyyAPkfs3+UMbOefPKKedenHPVhGv4k6NSm+5zmKnBUcxjmwtjnV0y
	+in28h/8kylBNCdGvRXHML4WwG3VHIPlKrhALkbI2ce9+LQlQ47m+x9iWuCnBfM817f9IjuOdXqHJ
	/Q7avirLMvP7Aqs5MCXC/LC1MVBQ5d4Fa7Hc1XMZpVy4wsHhTX8UFW3ta/HLwL8103PGPqlyEq2Bt
	5y8DM8gLivBRF7W4fRCrfs1wX6PydO1HZOMzyTQhd6b/RLKICcYxqlTwpL5c/eDgxzODwE8TjglgK
	KECLPAw8SjEQxlT7Ez/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi0VV-0000Xn-Ak; Fri, 11 Jan 2019 17:22:09 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi0VE-0000Ik-Rr
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 17:21:54 +0000
Received: by mail-wr1-x443.google.com with SMTP id r10so16001145wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 09:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T5wxOOtRPEpRp3NqPU5OWIWIo8d5meG2Q4lKl/MEhWw=;
 b=e/66MXALy0oMKyfIZxENV25RBdYLzmeemileG5eHJQ0Zxt6IKjyFNlw3rXW1wK8Mfd
 1YfMnZCl0lFm6Ihq1xIjSJv4r/YUb3sMrEEzapaIdkj948u1paqffsRNbAEz283z4zOy
 9aureX7GhHrONT0IOycm8jSwTtsXOptc6IsmI5qP6/PClxhQZQ75q2xb8FurIY3WOj7y
 aAizECrqwqWyG8+JC3bBaVVKnrfYvoMRKIfX2tuZxU2sgDbPeXkBrBfwpzMEo1lm6ZXU
 8MDAAwksDVH/vUAAa/khNm3Ya99SuyVow7iO4aDez2yXS/ccZg8zozY/k5Q/O3LkVThO
 6VJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T5wxOOtRPEpRp3NqPU5OWIWIo8d5meG2Q4lKl/MEhWw=;
 b=LVrb8grE7oU6PTvuXWdZSsrFsZm56TfwkQzqBuRemV0vcAtjMdSquBqxHUw9/edzIh
 2fY4kvf6gZNIkJxyo7JLvO7Itnzbxrh4JuO/sUeD0XbOM7AgNePlh++GorKuJf5NPALj
 pA5KcbaPsxYO5zDuI3qdf08zbbIJWCgQ46uUHRoGzckM7JQz4fMUVcMkZDtRZg1OAUYR
 q9H12AWYKqC+QyawhGkar9E2uuaCBBr7ZbkGowil9G64/ge4OknjICJ89+h7Pr4emzM2
 2KG9WjV4qp/2wNNiE5EDJBfFYlLO4hxWcd/a/cjkBllpo71ZjrMy+XJwOOTka4UAHfVr
 3cdw==
X-Gm-Message-State: AJcUukcJtkVfFzYenKV1wQRdX8Lj7rcWEWylKqwzrNV5v83x84GAsR54
 +iNPepWWVXtJQg6z3Du1MrZaIw==
X-Google-Smtp-Source: ALg8bN6JrlHaHd9Kb9BKNe9ETCtms1Agm9rsGJqbpV4tR6ep3omWM3gClOtHRI3AhBHB/q/nB+jMrg==
X-Received: by 2002:adf:f052:: with SMTP id t18mr15116950wro.112.1547227311159; 
 Fri, 11 Jan 2019 09:21:51 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.21.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 09:21:50 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 01/17] ARM: dts: da850: fix interrupt numbers for clocksource
Date: Fri, 11 Jan 2019 18:21:18 +0100
Message-Id: <20190111172134.30147-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111172134.30147-1-brgl@bgdev.pl>
References: <20190111172134.30147-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_092152_901189_FF57CC75 
X-CRM114-Status: GOOD (  14.25  )
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
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
