Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F38C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:59:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECB96222BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EE1jgzGQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Cizw0xtO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB96222BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=7HfZjTBFhKUy0QaP9pDduj5wwRYUU2IVUGgManPG7Ew=; b=EE1jgzGQTWvAdt
	804FudTqzaokhznf7LFMq4zZVBLKAT9rQaesXGxSbsR734n52PwkGTuKckcGq8aw2Kzd0xbN90lTU
	vwXe+6boQD1iGaItrDtUFWwn7Ub/rW0hoHHNRcj5p7nVq1pCIUTz+Uup/Ukm9XG7xWlQFkg5ceS65
	TGH3S3putQnh1NMCLUhD6Sm/SmaWJNCdOI9XsqGtiYCN/Y2CBM87QxC5xDFcPQ/pDkx4OzJERByga
	cVZnvDZJqs3eGTvedUYvgVyNCXhiX47Gll47lPRgv3q1ae8WPb9zUXwfElRnpugp2mMEGNuV0sn7z
	afUU6ySEyJ9Zv8ptrs8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtrJp-0002kG-Sg; Wed, 13 Feb 2019 09:59:05 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtrJl-0002is-8K
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 09:59:03 +0000
Received: by mail-wr1-x443.google.com with SMTP id c8so1751858wrs.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 01:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cTVgMV4QN/O1VM1NLUgFFlyBDlQnQrXLeyqpgio8zrY=;
 b=Cizw0xtOihKs5jdEPG671F9h5Q28JsSdgKfgLpEe1KZkcMhya3OViJAHAhztxklVes
 YcD+j0uGl0Abe7ASFnYhyPWB97FZrP0W8WbhO7HFc2A5rB6XtF/txUQSTn59Q4dgeGpg
 AEcFCzhQEsGEBRAnxn7KcAdsI1GJmzp0+eu4NBzq3itNeLmGLAVQWmRSjQxm0uLAiV0+
 8hLsFiatl3HnaY0wpAYKnkjcePUn2AgeLueOVI3McHAjjmnL5im0EJLrcCxBdSey85dn
 tJ+ypfJrQISv35VeDgfzQJjvAB5cwkJ2N59ZZ6WWUDeSusMt0AH57Xqnn0jR0kQO7maz
 OtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cTVgMV4QN/O1VM1NLUgFFlyBDlQnQrXLeyqpgio8zrY=;
 b=T0vAsepgPsQhm0nBfC+Fv3Veb5NoRr0hwPu3dPo77fGqrmQLZqRVJC0NSL4IS/Vq5j
 zbAa9eYsa7kLa5ottvJ1xngBlFunsMLqSnL9n2lNX2YAcinPc9azOfRzZLlLwe3SJGup
 6V5a85bsKV8NpjGlbSmm7k2rS+HEbRQJf4WCSZcHp2Nfdtk44vGLKXF1amiXLcmUJrr1
 nQZpD5Jfu3LQrs/kBuH8m1sThkP1/p+EydgsSCfXBkXW7B4Ri3urIkAzwJ01iYFRAZlu
 Lz//oUj5wUMZMI6M+vH3HT4MYZ10lCbEvgZPKa/2pq5OXyefCHOHpr9jmkNNZXHvx/CE
 95fg==
X-Gm-Message-State: AHQUAubmWaLjG71oDjtznPxq8V2YamER3AUFovLQKAQPrP5s1+GxxxJR
 fshBSjW/NqTjG9GBy58j9gFW1g==
X-Google-Smtp-Source: AHgI3IaLLNDjLhSH2mNv/pSNiss75mv4YTJlPuylODIHgSKJqE9uCLBuBgdrl6w9J20IByguEfVPYg==
X-Received: by 2002:adf:a4c9:: with SMTP id h9mr1888592wrb.254.1550051939768; 
 Wed, 13 Feb 2019 01:58:59 -0800 (PST)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31])
 by smtp.googlemail.com with ESMTPSA id k23sm2839467wmj.32.2019.02.13.01.58.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Feb 2019 01:58:59 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH] dt-bindings: clock: axg-audio: unexpose controller inputs
Date: Wed, 13 Feb 2019 10:58:35 +0100
Message-Id: <20190213095835.17448-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_015901_346170_E5C43D1E 
X-CRM114-Status: GOOD (  10.50  )
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
Cc: Maxime Jourdan <mjourdan@baylibre.com>, devicetree@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Remove the bindings ID of the clock input of the controller. These
clocks are purely internal to the controller, exposing them was a
mistake. Actually, these should not even be in the provider and have
IDs to begin with.

Unexpose these IDs before:
 * someone starts using them (even if there no valid reason to do so)
 * the actual clocks are removed. The fact that they exist is just the
   result of an ugly hack. This will be resolved in CCF when we can
   reference DT directly in parent table.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg-audio.h              | 20 ++++++++++++++++++++
 include/dt-bindings/clock/axg-audio-clkc.h | 20 --------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/meson/axg-audio.h b/drivers/clk/meson/axg-audio.h
index 7191b39c9d65..644f0b0fddf2 100644
--- a/drivers/clk/meson/axg-audio.h
+++ b/drivers/clk/meson/axg-audio.h
@@ -60,6 +60,26 @@
 #define AUD_CLKID_MST5			6
 #define AUD_CLKID_MST6			7
 #define AUD_CLKID_MST7			8
+#define AUD_CLKID_SLV_SCLK0		9
+#define AUD_CLKID_SLV_SCLK1		10
+#define AUD_CLKID_SLV_SCLK2		11
+#define AUD_CLKID_SLV_SCLK3		12
+#define AUD_CLKID_SLV_SCLK4		13
+#define AUD_CLKID_SLV_SCLK5		14
+#define AUD_CLKID_SLV_SCLK6		15
+#define AUD_CLKID_SLV_SCLK7		16
+#define AUD_CLKID_SLV_SCLK8		17
+#define AUD_CLKID_SLV_SCLK9		18
+#define AUD_CLKID_SLV_LRCLK0		19
+#define AUD_CLKID_SLV_LRCLK1		20
+#define AUD_CLKID_SLV_LRCLK2		21
+#define AUD_CLKID_SLV_LRCLK3		22
+#define AUD_CLKID_SLV_LRCLK4		23
+#define AUD_CLKID_SLV_LRCLK5		24
+#define AUD_CLKID_SLV_LRCLK6		25
+#define AUD_CLKID_SLV_LRCLK7		26
+#define AUD_CLKID_SLV_LRCLK8		27
+#define AUD_CLKID_SLV_LRCLK9		28
 #define AUD_CLKID_MST_A_MCLK_SEL	59
 #define AUD_CLKID_MST_B_MCLK_SEL	60
 #define AUD_CLKID_MST_C_MCLK_SEL	61
diff --git a/include/dt-bindings/clock/axg-audio-clkc.h b/include/dt-bindings/clock/axg-audio-clkc.h
index fd9c362099d9..eafb0de8466b 100644
--- a/include/dt-bindings/clock/axg-audio-clkc.h
+++ b/include/dt-bindings/clock/axg-audio-clkc.h
@@ -7,26 +7,6 @@
 #ifndef __AXG_AUDIO_CLKC_BINDINGS_H
 #define __AXG_AUDIO_CLKC_BINDINGS_H
 
-#define AUD_CLKID_SLV_SCLK0		9
-#define AUD_CLKID_SLV_SCLK1		10
-#define AUD_CLKID_SLV_SCLK2		11
-#define AUD_CLKID_SLV_SCLK3		12
-#define AUD_CLKID_SLV_SCLK4		13
-#define AUD_CLKID_SLV_SCLK5		14
-#define AUD_CLKID_SLV_SCLK6		15
-#define AUD_CLKID_SLV_SCLK7		16
-#define AUD_CLKID_SLV_SCLK8		17
-#define AUD_CLKID_SLV_SCLK9		18
-#define AUD_CLKID_SLV_LRCLK0		19
-#define AUD_CLKID_SLV_LRCLK1		20
-#define AUD_CLKID_SLV_LRCLK2		21
-#define AUD_CLKID_SLV_LRCLK3		22
-#define AUD_CLKID_SLV_LRCLK4		23
-#define AUD_CLKID_SLV_LRCLK5		24
-#define AUD_CLKID_SLV_LRCLK6		25
-#define AUD_CLKID_SLV_LRCLK7		26
-#define AUD_CLKID_SLV_LRCLK8		27
-#define AUD_CLKID_SLV_LRCLK9		28
 #define AUD_CLKID_DDR_ARB		29
 #define AUD_CLKID_PDM			30
 #define AUD_CLKID_TDMIN_A		31
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
