Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A453C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:56:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB12B20881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bJJaUSDX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uiN/J1s2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="KZZFIKFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB12B20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C1ILc6qtNO5EKVsv/MzifgZqHnoGVnPW6f+vBmec9XI=; b=bJJaUSDXIlxENv
	bVnu4n+j4mGvyTtbNtxNMV+asCSIiuQk2eq00mmxYBY56E7hymcpy3m8LuAYVqph/hztGe4kh9uT0
	/n/nAA65pSFAkDbJqHF+KeSTLqyvvRQu54dimiFgxdbJQ/yqCj7keElQo33cIU3UT9e/nCwpy9/22
	DuZ2F07iRyePOrbTwsNfhy8sQYCT+qmhx+I4lH5HRJFxCJ+NmXEsJOQVLCtFr80dFjreWvghfbQeO
	k61//H4+5nyJ07Prl/vVIUmbwFyl9ABeHbGU27yRKsKtcCMWtuj29L+UqGxc/3ioK7WCRCXKFiwZq
	cipVn8Ej3YQkNP4zb9Dg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCpj-0001Qt-Rj; Thu, 31 Jan 2019 13:56:47 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCoj-0000Gm-Lz
 for linux-arm-kernel@bombadil.infradead.org; Thu, 31 Jan 2019 13:55:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kiBWtlRU9Lv1TNlAe7u938RwMGut2xvtFe1CB/XYr9Q=; b=uiN/J1s2Ejph2bXtCmqjJV21mK
 l3/dgxy8eOqn4hRzQiBqM11UIYofGd2cnk6jDZ1aJFSY8m6pPwoxf+r43S8au+K7NWvLs9LoIISli
 pkYmlxnLeYJbLQiToMIJN8ot9MVaaxOZq9clwvH6xi+J3PQlYXHdgXjsGIUlMCc3GX1l5KD7Rvwt3
 R+889p3eaG201yESOIufttrUrwm+dvfikTLJNbTegVJD81kp3gxu+k9TN3iGLywP9jEtx3v4qB976
 n+nG+eAcaqTcd0b2fC2s0B0UiaOrRgntZ4G3Yv3q0iVCEbrxXfP3IxwnClICGnKI/mbC3dVKZEGa5
 XuGC+NIw==;
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCZd-00059O-0m
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:40:15 +0000
Received: by mail-wm1-x343.google.com with SMTP id y8so2573298wmi.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kiBWtlRU9Lv1TNlAe7u938RwMGut2xvtFe1CB/XYr9Q=;
 b=KZZFIKFEnSpOLEmJzYc0d52J4r/ZzyuTbfMa1Kcz2exMYS8V9pyI9UEBEZfvBFJYzJ
 4m9+9afl487V6Re4yxadzf1qPs8x6gR/5o+CznxMRj97t7yDvitgjQWEU8SBFSaSGrhS
 kGVGDfZX/fVl1iJ6VJtMVV2s9vlwOWvX+Ufa6Ks8DZXCzIOevECzL5VyshoAyZ4QU1of
 D2Q4/Dt/so9Db6r3jd92EuIMuKHGVokkW2/hUl8KSHyh5z/TkeBZEIHZtIohgG/afSc2
 Yx75FP8jQYj2R6t1PzIkzykCwHpcAX8+Ak7BJxzYtVMX8VMiw6dNaeZ0OQQXkyk25hU4
 d9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kiBWtlRU9Lv1TNlAe7u938RwMGut2xvtFe1CB/XYr9Q=;
 b=GL1EiUgVj0MtJhi6YJjQcbvN8pSDUeukKa57D5P58ch4beGJZgTXxL0bG5n6u8jL2M
 +F9LhzrjzD8kUjjzYbBrjubWNdRqd5VpQHSjZjClwS9BthYbV1VgakS2w3wcaDwj/+cG
 hctMzMJsowAjM73qeQdtMeqerdAO/BOHjECC9G3AMyaYboNkZzOItFA85C4BwqmO+3nq
 ZzqVrvnGLoSRdIVdhT1/W5AZHoO48e8MQdUPIYsW7ytvNJGgNAchjsNIGiMq/LmnmF8I
 fa4LfP3Q2ai1WgplzNYfyMeDGx2JkJVc4I+y+kGNghi5HQr2+LdABvcYQMUw2xUgE9Ms
 +Izw==
X-Gm-Message-State: AHQUAubp1sdJSimE2OTbE/CfWIuE/B8LxcLJGYHWfCt9lh2Ax4hKSAzu
 7TZ3lWUICkPa7p5alp81Xx9yCg==
X-Google-Smtp-Source: AHgI3IaeU4wPRnVdskTvnoa4D5Bwf2OoIri7AYedrJchwcgCmtIN2YFR8d/+LqFdp8FRIUQRkSQMKA==
X-Received: by 2002:a1c:c64e:: with SMTP id w75mr3830698wmf.46.1548942007705; 
 Thu, 31 Jan 2019 05:40:07 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:40:07 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 22/35] ARM: davinci: cp-intc: add the new config structures
 for da8xx SoCs
Date: Thu, 31 Jan 2019 14:39:15 +0100
Message-Id: <20190131133928.17985-23-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_134009_070501_B15DD54A 
X-CRM114-Status: GOOD (  13.25  )
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

Add the new-style config structures for dm* SoCs. They will be used
once we make the cp-intc driver stop using davinci_soc_info.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da830.c | 10 ++++++++++
 arch/arm/mach-davinci/da850.c | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 8b9220badef5..6d3da4364f7a 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -12,6 +12,7 @@
 #include <linux/clk/davinci.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
+#include <linux/irqchip/irq-davinci-cp-intc.h>
 #include <linux/platform_data/gpio-davinci.h>
 
 #include <asm/mach/map.h>
@@ -742,6 +743,15 @@ void __init da830_init(void)
 	WARN(!da8xx_syscfg0_base, "Unable to map syscfg0 module");
 }
 
+static const struct davinci_cp_intc_config da830_cp_intc_config = {
+	.reg = {
+		.start		= DA8XX_CP_INTC_BASE,
+		.end		= DA8XX_CP_INTC_BASE + SZ_8K,
+		.flags		= IORESOURCE_MEM,
+	},
+	.num_irqs		= DA830_N_CP_INTC_IRQ,
+};
+
 void __init da830_init_irqs(void)
 {
 	cp_intc_init();
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 9f48e1ac61fb..5e7f2c962abf 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -18,6 +18,7 @@
 #include <linux/cpufreq.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
+#include <linux/irqchip/irq-davinci-cp-intc.h>
 #include <linux/mfd/da8xx-cfgchip.h>
 #include <linux/platform_data/clk-da8xx-cfgchip.h>
 #include <linux/platform_data/clk-davinci-pll.h>
@@ -671,6 +672,15 @@ void __init da850_init(void)
 	WARN(!da8xx_syscfg1_base, "Unable to map syscfg1 module");
 }
 
+static const struct davinci_cp_intc_config da850_cp_intc_config = {
+	.reg = {
+		.start		= DA8XX_CP_INTC_BASE,
+		.end		= DA8XX_CP_INTC_BASE + SZ_8K,
+		.flags		= IORESOURCE_MEM,
+	},
+	.num_irqs		= DA850_N_CP_INTC_IRQ,
+};
+
 void __init da850_init_irqs(void)
 {
 	cp_intc_init();
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
