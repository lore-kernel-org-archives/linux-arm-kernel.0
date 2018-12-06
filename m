Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCC7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:04:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 444CE20878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UAKG701d";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZuWdCdDK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9wnjTYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444CE20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=saLQLkdSS3wrWT72Qvy6qvGkTkTV3rV8lluBudCRUYI=; b=UAKG701dcivINF
	Ys13+HKJ+Vv4AbHZ6MzHwnQDsM5v6KmaXti6ckB5+wl8BsC6UdWzS5Gy2iICMhtS2y3DveERTOWn8
	5wAcE7iaFPv0L/yweJpAJPV+U/DNiOtLFPyH1iayYNy8Ook43kX2snRiv6TN+Y8CcFHr3LZ9R8WO5
	RnT5+Cc6MYYChWQHhDP7chnvFSmdP3HW3BFmsc9IwCqVYDvahmPKOvtYEuCmgj1tRYR38sVh05nbw
	Kq3+Id7Na0CkUDTAKMD5jaNPLZxEGDgvDL25K1Jqvic017Hu/oP8XSq77+saTvkLcFNagPHAaqg1s
	GYTs+KKs+hss9vN/xk5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUx4i-0002i9-5a; Thu, 06 Dec 2018 17:04:32 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUx4T-0002O5-Qu
 for linux-arm-kernel@bombadil.infradead.org; Thu, 06 Dec 2018 17:04:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ngklVJ3Ds5Q2HpJVhnzuL9tYg9MzPBmoOMFN1gaZ2AE=; b=ZuWdCdDKkRErcbyg2XbDIXqZhx
 Qne147p8066fZjULzz7HJvGPxwkLPh4Rff/H3WK9fZIJnyznG1aB1MHt8EF5pjAWCIgGPS0kLZ8iY
 YzYIOswhlbD5fJI7ssARNajYFYVSKWZO1OtTKKObxmEBQKgMaZ6igPswGvjc3+15io9IR4zZkr3Ek
 q56t/czX2FCOmKn9sTa8tDpEW/JeuntVKrW3Lgr3FRK0/i2T6rBcswOG6BbQB6TOxK81bJNznpz0z
 rqvMs+6I2aRyVHO272oEKgrsCTyful1QmYpRYHe+dlY4dkLIvn55uMw88NRd0ErEYy6nQzfm5tcrb
 FiGPpENg==;
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUwrH-00064j-TC
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 16:50:41 +0000
Received: by mail-ed1-x543.google.com with SMTP id h15so1341228edb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 08:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ngklVJ3Ds5Q2HpJVhnzuL9tYg9MzPBmoOMFN1gaZ2AE=;
 b=B9wnjTYyJCB6v06tCSkQAHXRGQ84q4f1GE8tRFNuEmO+ItqP7TbMKoBWHoLO4JCNfh
 CHp7tQFyl7DTcg83EQ8BezZxUpCW/g/BHk/zyqB5BRXWiaD7tdPK6dgGu9TLNfR0B71r
 gW+pvzlsYz2K3VHFzv7M9awN8u8jG9VXOViKjkOZL+9VuEZfiU0ci0rHl+q0wEhZ/kVj
 d9v1mR6Ith367jn9Kd9QDomw156rSJ3yjJ1YnNtMIfwUXTzNgOkQpRBvvrGTzvo+wF7X
 RJVDn8OVEO2n78UdKk4Xm5fDbre8zaoKxVlf8UoSXlHxHk3mg8hj9lupwGzgTOZ75WP7
 AkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ngklVJ3Ds5Q2HpJVhnzuL9tYg9MzPBmoOMFN1gaZ2AE=;
 b=Sk475hbjza1PJDR6SuTLu9R296V3o/TX02nkpQQDPYX6qbXjf0V4A+6fCjHmI/3Fzv
 IplquoomE4GJINqpeyRqUjRtwDL2x+fEycPbSOymuVG4ta1ddVDY+mzHEkH5JbzQ42bT
 ARsF7J80QbXKkZVbq5Qo0rQcs5BZiUSdss5ThuDyun2hY8u0HYkUT8iN+03h9il5xPwW
 V8B2l0U4XG5RFp2QFnT2/vVagc7o+NnZ2O/5YYi9B76HelXbqKrry7nA4aExhSyneBV/
 dOLDqz+8T422DSRO8WgLCrlQrvdJT23XZM2DRumFoowqgajmk8Zd8ECUYmUwlUTY/cMw
 N62Q==
X-Gm-Message-State: AA+aEWZ8zvWkhJk53EKuJNGEiLfUg+Vt4wbukYcng9qG/GSiA9lp6WNe
 adgsKq+Okoqc6m06H9tSLNU=
X-Google-Smtp-Source: AFSGD/WEjrKilwkFZgtDevRiEe21XQFpZg3a0NGUtGOw0HoV98A/A1QpCNGBwzaCfyBGrfojCz11ew==
X-Received: by 2002:a50:a125:: with SMTP id 34mr25430207edj.175.1544115028578; 
 Thu, 06 Dec 2018 08:50:28 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id b11-v6sm167762eje.38.2018.12.06.08.50.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 08:50:28 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 4/7] arm64: tegra: Add HDA controller on Tegra194
Date: Thu,  6 Dec 2018 17:50:19 +0100
Message-Id: <20181206165022.23845-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206165022.23845-1-thierry.reding@gmail.com>
References: <20181206165022.23845-1-thierry.reding@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_165039_977019_04864D8A 
X-CRM114-Status: GOOD (  11.30  )
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
Cc: linux-tegra@vger.kernel.org, Sameer Pujar <spujar@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The HDA controller found on Tegra194 can be used for audio playback over
HDMI.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 439ffe86a823..59baa631b422 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -328,6 +328,22 @@
 			status = "disabled";
 		};
 
+		hda@3510000 {
+			compatible = "nvidia,tegra194-hda", "nvidia,tegra30-hda";
+			reg = <0x03510000 0x10000>;
+			interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&bpmp TEGRA194_CLK_HDA>,
+				 <&bpmp TEGRA194_CLK_HDA2HDMICODEC>,
+				 <&bpmp TEGRA194_CLK_HDA2CODEC_2X>;
+			clock-names = "hda", "hda2hdmi", "hda2codec_2x";
+			resets = <&bpmp TEGRA194_RESET_HDA>,
+				 <&bpmp TEGRA194_RESET_HDA2HDMICODEC>,
+				 <&bpmp TEGRA194_RESET_HDA2CODEC_2X>;
+			reset-names = "hda", "hda2hdmi", "hda2codec_2x";
+			power-domains = <&bpmp TEGRA194_POWER_DOMAIN_DISP>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@3881000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
