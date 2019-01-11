Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26691C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:23:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB9832133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f77WN/Lz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="uhGHaxmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9832133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H2JLbEj/zP4OYwJKQuvZhuZ3sD4ZNyZh4hCRTUdEgjw=; b=f77WN/LzAJ1yY2
	MrPgXS/kKm8YBvPCyNfu5eTqy40jK6tqd4XX/xmaMXn+5j5d8/Uh3w2CJUVfeoDcDRQwgXqixKQgD
	IxYdGCdlByW098WU+nyW8R98nmXLosjl9tLCqw/6xpopflxv8xZYrJ/JLa697aqiX8GjuZ2MYcXf/
	sWxFPxtN+yRRH2lpx1PXC6bv5vCGDA9KM66uWw6iyZ+Z11fSfzkBeihVW2fzCm4d4G4AoRYMblE13
	9NS1CPqadb2ojhdjV/o4z3QnRs10H570cQzpWm/HCL9Pff9Jwoqeaq6i/54tjq7ipYAPlUcX+ORAQ
	+nMWW0VLFPbQcqYdaZsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi0WJ-0001SA-Di; Fri, 11 Jan 2019 17:22:59 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi0VI-0000Jd-Ku
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 17:22:00 +0000
Received: by mail-wm1-x344.google.com with SMTP id b11so3143683wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 09:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wdNPi9yYX+VeO7yfYl4QzOTwh2emyQNtF85luiFVb28=;
 b=uhGHaxmEJviZuGQmGmBjpOazE6+kQBgDedrWgSS8iT8szm3RUCgxV07K6lR7YqFae3
 PykG/z5syFNlaT0+zHQfvyI2gkXAReMEmNrn2vCHXPDqsNo65KJmLCovjM8Z+1bXkfFG
 z2JMyiKbOao1JqKiKt9p7zki09GkScxag2UHps2pmRFUxSPPInK2G7K3na7jojaC9Vkl
 AH5eNZjcBrzOey0U0nCYzg2RNB7n+h9oALKQ8t8DVXcaf7T2yckvEf2nG/VeIZbG9Fwa
 kKk0L9UBPWeL9LneejzIo6byknAzktb8WVukq7YOBFTextXqJGbHPRkuZnx2lpgGS6s8
 GPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wdNPi9yYX+VeO7yfYl4QzOTwh2emyQNtF85luiFVb28=;
 b=TXBwojhX+EkV3VaCzZ60YLjl6QIN0Ig4uPtC1QEixlAjS7azwnRNzjM13ShXDuQyFL
 VtTrALtuMNbgpD1uMJ1723Vr6ILcGUGTuAmDWR3+7Kf2ISHZOOQh5iPAn0VlD0pIHBUy
 7UXWguo6nVwqw0mPGUPcef4AbwfPLWG16J8+FvDPXjxW/m9S3yj91A/lCSQDKMJJNIjR
 /jAeYfMhGtXRhbrbvnZObx1WmFrFQO+waMtqV+UJbiybreIxBg2intAuX01YDpsrVQUB
 TFqd59w4P4Jne/Umz4lbKVJhNfLDk5QKE4ywGddgxTGFvLA44lvj3KQfr60xEKsqzw3w
 oRJA==
X-Gm-Message-State: AJcUukeLyBKB0VbMtLtpTeD+O1ToNxSbQ7ApNHNy2Wmt8NxFs65fs/4I
 ZT1K/0zQ3aitOmdIekbB+DvGAQ==
X-Google-Smtp-Source: ALg8bN51ES/LVNgyvdfRMCzv55KUPPAPMkaAEcAbJT82yMZmq+JTtiU37mTzcH08PmBePII1Rao3XA==
X-Received: by 2002:a1c:6e01:: with SMTP id j1mr3015616wmc.103.1547227315042; 
 Fri, 11 Jan 2019 09:21:55 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.21.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 09:21:54 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 04/17] ARM: davinci: da850: WARN() if clk_get() fails
Date: Fri, 11 Jan 2019 18:21:21 +0100
Message-Id: <20190111172134.30147-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111172134.30147-1-brgl@bgdev.pl>
References: <20190111172134.30147-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_092156_842442_E9DDB5BA 
X-CRM114-Status: GOOD (  12.75  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently the timer code checks if the clock pointer passed to it is
good (!IS_ERR(clk)). The new clocksource driver expects the clock to
be functional and doesn't perform any checks so emit a warning if
clk_get() fails.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da850.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index e7b78df2bfef..9ff377f26c4b 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -774,6 +774,7 @@ void __init da850_init_time(void)
 	da850_pll0_init(NULL, pll0, cfgchip);
 
 	clk = clk_get(NULL, "timer0");
+	WARN(IS_ERR(clk), "Unable to get the timer clock\n");
 
 	davinci_timer_init(clk);
 }
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
