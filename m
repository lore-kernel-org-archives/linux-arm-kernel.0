Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC611C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:43:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A2E82081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IxGsIt2M";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="usE36wC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2E82081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zIf7//Su8/Jlx7fscO5zWj6U1FqbC11RME/eWBQGhgs=; b=IxGsIt2MSwQ2TW
	xuqKlTJDYh92+xs6NgUVrsq6ODk9PvlGE0wFsNmuzF3TG01agDi55ybzjr/3N4ynkJgfC2Q9EhNuW
	aUkrhpSGOLFK0SFq3TSXFnU3td0zkLFKsxYi+L96+ictR3un4s7JSZPbpt6ZwxKqqI/azMJmm9t9D
	Iqyph9yyAiAEO4MMKiUcoR6zWfFuTbKHxn0TgxxYZSsBgk+xQ9IASZ+blQam2hnE9u3C0OxJQbyjo
	rmdxYNq4aanjzvqjIifWfZyvgP0Lk/xjwQZEaSl7PUr+yd3ACnYHwXiwcWobNhH4pBfFUZ9scoKjn
	JPWWij9m2qRJQJIRI0/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTZWm-0005DW-8u; Sun, 02 Dec 2018 21:43:48 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZVr-0003yf-Ou; Sun, 02 Dec 2018 21:43:03 +0000
Received: by mail-wm1-x344.google.com with SMTP id r24so5591633wmh.0;
 Sun, 02 Dec 2018 13:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LeOCN/JAo8y1dEhko9gXCXdHi5oNb9R1+5af4PRI8Xs=;
 b=usE36wC1QSBP0B1DYhEcAd8f7r/Yfc4gFCFSfvAyfIVxr51piBXILzUiROT/0mg/U0
 So3KN2s7qww3mn6LJPENNwZU/GfCCxdvj3th/WGduyZR0C6D/ruIWwprNF4LG7pZwR4m
 h+pni3yhpso/TE/ZLwqUO3XYBOZ94s2789aawcMsPwTwLUEhR7849FEN/7fyk7o4FmVP
 jpBEUHk0JliUB0THTRkYaQW6pPrS0VSvu6y0SqnQg+iCMTksCiym9e/1flfC1+A0MK+y
 ijnExY6iRy3HTNce/Nll3CJnsfiAovZUcXjMsO5/VUcmkqe+gFFgPLiK0QLbUlljEE9w
 JUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LeOCN/JAo8y1dEhko9gXCXdHi5oNb9R1+5af4PRI8Xs=;
 b=Az6wZMpkxB37B7BU1boQC5jid/nCnSO1I0EJMKQsG7B96Xe97YFlooHUkSo15yQ3h6
 k3OkpdW9U5rzYw0qBO4ll/+PWecy8yFCm0u9hQ+zsWqCCHFm37htuGX4+zXvJ1fdwCtp
 2XQRmxZpQqG/wmrJby5xWOcJkMgd2OmsvMxb2oTfK9sax58QLcLUJx6c5A1fo/OA5U7r
 SuM6yJygjQwVuHLVcEPP1tF2y/XrPE8bMYjeJ5+aADgkrpCbwauk2/nBtBELufkRNIn8
 hyR1AkFMNy4XKQ1zZlDPTa1QXXrdWH3PZTmtqp3pzZsZLIFQ06mgovCpaL/CmcNSjVLv
 Ca+A==
X-Gm-Message-State: AA+aEWa7KUHoPzhvbIu8oL0292Y41vw9ofQrZ+hcy+yDvCqoyvr7r4AB
 kX2SPc5mLIAkQvc6sva6hgH+Nfii
X-Google-Smtp-Source: AFSGD/VqM8kY569wrkq0zLSjphTgPsZkNf2DYfQA74MjZjlucQJNpFUZ7Jvhan1oZSUPxm1+O0dB6w==
X-Received: by 2002:a1c:eed4:: with SMTP id j81mr5956177wmi.24.1543786959555; 
 Sun, 02 Dec 2018 13:42:39 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73FBA00B1CC0EB38CD20A4E.dip0.t-ipconnect.de.
 [2003:dc:d73f:ba00:b1cc:eb3:8cd2:a4e])
 by smtp.googlemail.com with ESMTPSA id a18sm13073110wrp.13.2018.12.02.13.42.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 02 Dec 2018 13:42:38 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
 narmstrong@baylibre.com
Subject: [PATCH 2/3] clk: meson: meson8b: add the fractional divider for
 vid_pll_dco
Date: Sun,  2 Dec 2018 22:42:19 +0100
Message-Id: <20181202214220.7715-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202214220.7715-1-martin.blumenstingl@googlemail.com>
References: <20181202214220.7715-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_134252_456557_BDC1A6FC 
X-CRM114-Status: GOOD (  11.48  )
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
Cc: sboyd@kernel.org, mturquette@baylibre.com, linux-kernel@vger.kernel.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This "vid_pll_dco" (which should be named HDMI_PLL or - as the datasheet
calls it - HPLL) has a 12-bit wide fractional parameter at
HHI_VID_PLL_CNTL2[11:0]. Add this so we correctly calculate the rate of
this PLL when u-boot is configured for a video mode which uses this
fractional parameter.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 5 +++++
 drivers/clk/meson/meson8b.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index a4ae9c957fde..0f3f4759fc92 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -137,6 +137,11 @@ static struct clk_regmap meson8b_vid_pll_dco = {
 			.shift   = 10,
 			.width   = 5,
 		},
+		.frac = {
+			.reg_off = HHI_VID_PLL_CNTL2,
+			.shift   = 0,
+			.width   = 12,
+		},
 		.l = {
 			.reg_off = HHI_VID_PLL_CNTL,
 			.shift   = 31,
diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index 0abb331162ab..e953923792d7 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -33,6 +33,7 @@
 #define HHI_MPLL_CNTL			0x280 /* 0xa0 offset in data sheet */
 #define HHI_SYS_PLL_CNTL		0x300 /* 0xc0 offset in data sheet */
 #define HHI_VID_PLL_CNTL		0x320 /* 0xc8 offset in data sheet */
+#define HHI_VID_PLL_CNTL2		0x324 /* 0xc9 offset in data sheet */
 
 /*
  * MPLL register offeset taken from the S905 datasheet. Vendor kernel source
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
