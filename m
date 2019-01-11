Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C81C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:23:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB6AE20878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AmQ2TrmT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hffmTclC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6AE20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xbcbh8VMXRvMSf6fu/DrAjjbv9AGrAmdR9GvFs/Q420=; b=AmQ2TrmT+1gikv
	WRrcDNiouX5kGo3khL3g6pQtvNpmjn/VxqWxWf3xVNFKA+ET+tB187M1g7KmjenYE5qUAUBVx2rxI
	+TXHKvuFMHCgpr0syreFkPHvm5VPnw4BQdIQ68p9bhLX7Ns/nKJu1jx0sA6cSjt57nJt0A7MSwH3Y
	7wyYPWcJN9flRUboBYKyGgXQtvNl4rtnfAwWw6YASgmJbHUUlGxzO6KjCSPTidw7cNcpbjbL6cuQi
	3e4Ck5lK2oyNpvhcTfMRcEwvQZSs5gFI1v8Ck+5rgCkbs+rwB9j3GrZ3Y4/si8eYHzHhMDzpmh+uO
	FtVljv9YegZ1mFmK3mQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi0WY-0001iU-Eo; Fri, 11 Jan 2019 17:23:14 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi0VJ-0000KS-Jl
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 17:22:01 +0000
Received: by mail-wm1-x341.google.com with SMTP id a62so3120747wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 09:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5eYRdbvgDdHfOnobAkn0se7ULIb/ZfwVvRXf2x91rcw=;
 b=hffmTclC/x8u+Wt1kuG5Wxtfm6YyV5cO0iMi6wL530U8HsPEkq2jYoL7b3WqwuOtNk
 pJF5S8qKGlpdEiHaJ6/glLMHv8dolGRBCLqxQJ3yVqNv/Ex5EoizPFGgj5hQW+1Yw6bq
 1GOhkPHEfRACFJPJW6ygjfLI4qbsk8oq2GEZAPaWsl3cf052aQmnKrumxiuYvhERp7da
 GlYrESykyYFVlln/BA59FG4HQ9QLn6gC/D7ys4XosCrFf/9ssPJrd3QnjiRL79QOCP0e
 hs0S7kStYDI9SNs9BQC96nLGd3yR163GIsUaDGoJlmEIq8crLDiBKuEnZ62PmuCHqTNC
 l4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5eYRdbvgDdHfOnobAkn0se7ULIb/ZfwVvRXf2x91rcw=;
 b=aKLdrYDUn2Z1+/wA2ilUMs5AnAqYGAq2+UXfQmyh4B+bWuyHvt7dqoAJwl85zoWNTr
 g/ErMaO/ZbtZ0FTjCkrJNIGvXvLlPbij0B+gxViHxsWzpZwhipUNbtIER0F1IRTvJnu7
 LBCtd+CPN8HPeLAwb8rJ1q307ngU+QsyjT2hMyj5IMWEQUNcPiDtJDVc/rMhGWTnFY2n
 803wJnO5MjPPaCyC3FX2ZRXlss8CpIFQuWk0hdEMtHWjzP7YcnppgBx4fuNK+m0AJTPg
 Ju1SXDYOe3GRFsAStKTd1zdvJ3EhvtCmrLuJZshu9tSH32mwbhP2d25Onkg+GLmSpzPh
 p9yA==
X-Gm-Message-State: AJcUuke1fgiseeppOrB/5nEwELprklDQef9H7RC9aNU+HtDtD0ra7EF+
 EQRphXwqjmSH+fuNZV58frtPoA==
X-Google-Smtp-Source: ALg8bN6/vlQROYcPFMxZim6E1/hYDMGefiK5Z6JM9KdqjaHc9jDYPjMkBD3PcbjuASZry8S9lXjO1g==
X-Received: by 2002:a1c:4346:: with SMTP id q67mr3257815wma.114.1547227316209; 
 Fri, 11 Jan 2019 09:21:56 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.21.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 09:21:55 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 05/17] ARM: davinci: da830: WARN() if clk_get() fails
Date: Fri, 11 Jan 2019 18:21:22 +0100
Message-Id: <20190111172134.30147-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111172134.30147-1-brgl@bgdev.pl>
References: <20190111172134.30147-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_092158_090664_0B36554B 
X-CRM114-Status: GOOD (  12.76  )
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
 arch/arm/mach-davinci/da830.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 2cc9fe4c3a91..ceb0417f10f6 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -834,6 +834,7 @@ void __init da830_init_time(void)
 	da830_pll_init(NULL, pll, NULL);
 
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
