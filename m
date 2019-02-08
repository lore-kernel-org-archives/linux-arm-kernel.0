Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA32BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:15:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 766562085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pwnt16L7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kiIAwiTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766562085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lvno8z04vVYFYDGoHGd6u+CWmeJn14S1OMKmLFD4lnA=; b=Pwnt16L7pCrHEL
	fzCl/jn1wSqcjFF5Woz/Ct5qmUmQrOOtK2w25Mn920R/hYJkOE5OMS22z3taaZTxwx9NzgW9up+mf
	55BnARHLaQsQtDh21MZUXnVBOiFBoOr5rXZpe5zzcUtn3UQUjGhpwtmlySK67RcSDolki0lzStisR
	v2thulb+WTj4nJCBGakz0E1RgBQK/gcwHh6XBKwb+ZcLTMLbWCJObWuLcwXgJS2nlcsE4EqxEcriy
	pjmCxf4sxngPW1p57b3+RCqFuz6VJGkebtzEPt3uGpsK6oMlx1g4yhyvNVwGtuS466Egpn5KD+1zz
	insB8hp9oOJh8Jn7klBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs3BT-0006OI-Oz; Fri, 08 Feb 2019 10:14:59 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs3Ao-0005jq-Vu
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 10:14:20 +0000
Received: by mail-wm1-x341.google.com with SMTP id f16so2773794wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 02:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BRXDa+0TVxZcYoEC45CBTpx7rG6dgcS0Dc6O77EV4hs=;
 b=kiIAwiTqinORRZqbH7rVzo72b8E9f7tv8pZtF5tGQwUsd7Gijie4pObU2AcxROrqGE
 ah92UYjSBCvCLCkMCRk2pyWnIF2j/UPQXrVIo5qKlmJ1OOIzJNrVP9DVEX3khfojqWOh
 WqCoxR/OalA32yXCo0MB15dZ0sAID+kKoiHVI+QPoRiEQNWTQdURZ0bN0UjRoIyR5sjP
 +nSRRqR9RBa7PP1NBYMkheF7/DuIHATa9yEVHCa8+2AdM29qKF3xWjv+QibzF0aWu275
 YW/v96Td7G81c/eHQuxSHeQBSUgfQYY43/EQWrVRRI0/UIRN7Y7RZ7237tX6XARSl8vJ
 R7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BRXDa+0TVxZcYoEC45CBTpx7rG6dgcS0Dc6O77EV4hs=;
 b=uCMmGCMWx1SMx5J5biG4oR2BBUgbqzwjXahazz5uefofOhq3UWR9C8dLg8sWdwl4U3
 3z+3KbMVWa3eG3/NaJ7/wife75osBid7fA+yunghLXCY041rJF2EkwL36eW29lo4tfR2
 BrcngnfZsDIvvAndwrMS1tswW3Fz2erKMzBRmytutaEyKfQ/tQGiKEq30lFLDJKVhgra
 SzRg04veCz8VMg/TMpVCsEVlzgeIPpmNGBFKYITuAem2beLJwQwNxKlLl5Ui35X1q9gr
 brze03ijsC0lpJgqoUT6dG+KaKBU3X4PPDVjC3pj8WC5e2N8Et8pUXfcTa16D5xJtSuy
 9cuQ==
X-Gm-Message-State: AHQUAuZOiMVUjxYJ0XuUhmMGUuvLDzF96+lsMgpz7C+CX5dZXIhak86Z
 7vVx/AFqjHC4E4ME5YFoCXeHyw==
X-Google-Smtp-Source: AHgI3IaDcp0Kd3lbpFEdo8o04UwImuCBn8esuyWNfU5kXFZuDRopItxxaBfWAXrGzLFLj5E4UjFe0w==
X-Received: by 2002:a1c:c282:: with SMTP id
 s124mr10748554wmf.105.1549620857288; 
 Fri, 08 Feb 2019 02:14:17 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e35:2e9a:6060:2ed3:c463:803b:b085])
 by smtp.googlemail.com with ESMTPSA id
 a62sm1901634wmf.47.2019.02.08.02.14.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 08 Feb 2019 02:14:16 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 2/2] arm64: dts: meson: g12a: add peripheral clock controller
Date: Fri,  8 Feb 2019 11:14:05 +0100
Message-Id: <20190208101405.25699-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208101405.25699-1-jbrunet@baylibre.com>
References: <20190208101405.25699-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_021419_022324_AAC8E34A 
X-CRM114-Status: GOOD (  10.45  )
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
Cc: devicetree@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the peripheral clock controller to the g12a SoC DT

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 05ea750b8c16..701a02244e04 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -121,6 +121,19 @@
 				#address-cells = <2>;
 				#size-cells = <2>;
 				ranges = <0x0 0x0 0x0 0x3c000 0x0 0x1400>;
+
+				hhi: system-controller@0 {
+					compatible = "amlogic,meson-gx-hhi-sysctrl",
+						     "simple-mfd", "syscon";
+					reg = <0 0 0 0x400>;
+
+					clkc: clock-controller {
+						compatible = "amlogic,g12a-clkc";
+						#clock-cells = <1>;
+						clocks = <&xtal>;
+						clock-names = "xtal";
+					};
+				};
 			};
 		};
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
