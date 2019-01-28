Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F21CC282CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:23:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6EEC2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UzntINdH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="M7+NLFO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6EEC2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZGC0/HLVYNQYJQyHPbZzFsw99vuDCKpE4xERaEp2z2Y=; b=UzntINdHId6iWH
	kC7Re7fDPg/pgokxwim3UtGPvkjX/Rvd+HcRNSb+q3eFARTwgJdFO92OCdZQdwa/0UDHLby7iXzdB
	uZglxI10dxuQUvTBw6KTxkJ/nYVE5s0BvUJnBV5wDTuoL5/Z+USdr0L6eNdnHL6XyOZLIwVuTmz5J
	F77Q0TR3G17W1LyNoORyls9TwFtNRz1E8ni426cpLUqC2V6Cch0iSLSDdk0JhFgHp2pDBdrjyll/B
	J+7NbSfzojxmnakBo8Fxea+H7el/MtisSbCd72xBcMs40F6+M49rOFR+LXy1ICmUvcMFSJA2tbjkD
	HzhRyCF+UvDjGg585jgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBYz-0008Fi-Er; Mon, 28 Jan 2019 18:23:17 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBYj-0007xz-GH
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:23:03 +0000
Received: by mail-wm1-x341.google.com with SMTP id n190so15099361wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 10:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dSImbPlNDIywIdqcZTWb3Qn/6DZr3el7F0sh0GH4dss=;
 b=M7+NLFO/nlmBfyC59hkNptd7DHeK7vI5LyDgPf12El+xVGcTqxP9I/08aBi5m7B7a1
 kJ72Sc8hlsn3emC4zcH0K3UOx7ZYWG87qE5y1aFCO/rodTlY7gUQ8nPYDGfQiv1SDfjy
 sAa5gIjAQC49nJXDozRMozzVuaXXfPXjBjl3qo1FECRBT+Gyg2UlhzPQ4zaPfc+5aMCk
 poDogurE31LdjdeY+I46MmzQCuB29KKOfaPvYkb7i67r2KDHT789qQ1dDVHwqJynBm8T
 x7PI0LF+qtuMHZ8oKhRko0S98gPzuM2f0kZI50OHuEaO/OVgcht6QT4aKYGRFo/gi+XU
 JoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dSImbPlNDIywIdqcZTWb3Qn/6DZr3el7F0sh0GH4dss=;
 b=G3Tnz3xrH8WJd9Q0mey2Wv2KpY7KGqqpiGFk/68GgLpA1nNU8F159B+CCEgi3V1NBF
 FZALCgPffrMhdCApwtyJXVUnFRcAYlmhSaG566B1F02iQp/8Bv311liJanC1hriT+9OV
 9Z0hwgzswZUlQ3l7m+PK99wo4bfd8XPQ/nGRD1dRFkuW7Nw0EMd803K0XYDbWtx7+Lwl
 9zE4DmDrfVMaWSIcczyhkvCilVEKlj02+8c8l54oFoVjnlw+zsG4T+j3v8/IC5ZFh+52
 rd86c+4n5wwYZnJMDZlJiuYerSobPCbgZRynce+gCY+sJG9u9AD47y4wc7YmYkvxuP/H
 9rjg==
X-Gm-Message-State: AJcUukfN3Uj3luOkhIyLOLg791R4JVShDf7a07AxON3VyyxfF8RviFyq
 4M5VF/RtkfGqirCGXygeGzzDOA==
X-Google-Smtp-Source: ALg8bN4AEdWhwQn2iOThFA+3Lvqrn6rmwSBfNsb+pcUvuauS0gfrltNNs5Cj5CwUzlA/pgz+Ws4zhw==
X-Received: by 2002:a1c:6489:: with SMTP id y131mr17963873wmb.34.1548699779850; 
 Mon, 28 Jan 2019 10:22:59 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.googlemail.com with ESMTPSA id s1sm169223758wro.9.2019.01.28.10.22.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 10:22:59 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 1/2] arm64: meson: remove COMMON_CLK_AMLOGIC selection
Date: Mon, 28 Jan 2019 19:22:51 +0100
Message-Id: <20190128182252.32589-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128182252.32589-1-jbrunet@baylibre.com>
References: <20190128182252.32589-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_102301_537239_F7CB65CE 
X-CRM114-Status: GOOD (  10.73  )
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
Cc: linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Selecting COMMON_CLK_AMLOGIC is not required as it is already selected
by the SoC clock controller driver

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/Kconfig.platforms | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 251ecf34cb02..819e74ae9224 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -112,7 +112,6 @@ config ARCH_MESON
 	bool "Amlogic Platforms"
 	select PINCTRL
 	select PINCTRL_MESON
-	select COMMON_CLK_AMLOGIC
 	select COMMON_CLK_GXBB
 	select COMMON_CLK_AXG
 	select MESON_IRQ_GPIO
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
