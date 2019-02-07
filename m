Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0593C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:27:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA6B21902
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BMJFM8Zm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="S5Da9fZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA6B21902
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vfOuEx30RPVOuvwmR4k7oW4Q3Q6dkfNHw5/Tjl2Renw=; b=BMJFM8ZmmaJcck
	77naKj4fIqJQiL/bgyaCuFabJ4xUWcIzBkJHpYoII9wI7tEHDbGoWZLwfnyLpGVp3s33OfKhSEw6g
	9BeA3Zpsb9yvQjhIJXAqki2qEaRgBlQ/jl0aJkqXrAMBPF1C4v+gRjwIAxIMf+IRlY119447xEkoF
	T2c/NHhpnTqyl4QQSi+KSFxHGHcUM0y2I3oHeYV1YVZSS2u5S36AN9rpH0FeoHcJzZSF3aLUtoKAX
	zgVVdA618WnSOy1BdrZIi/B8oG0S0SQfSM4EWgNHUS7g0mPZfwfHde+is97xElqex9o/2G7IG+XwQ
	Lbr9HO6pov7dqneqqxcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grjhn-0000SN-0L; Thu, 07 Feb 2019 13:27:03 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grjhD-0008Kb-KL
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 13:26:31 +0000
Received: by mail-wr1-x441.google.com with SMTP id c8so4733748wrs.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 05:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=irDAtFzSD44qLeuz7xjCo1buACjRBJTzikViM/uGxI0=;
 b=S5Da9fZBJtEVAWWpk+jta2WSGqpAaCJdGgrZTstXL7WFAb2jyq8mKFO41p2tZoHp7d
 jHxRFGxUHbmWUhrOXy80xupoIv1ONEALGDpqgyPhNbZAc7wpS/B40GqfLttcMqguAo72
 a23fq+kqTsWDfAClOwNS73XURxWD1cJ7xbhCBpRjCZWw7XrxOzRtHsY+WSs3JVtvWU3k
 7+D4uMk3IRvN25RuVMScTUnwxHTpT1XJQiwUwy+LYpqkZZ2uC94WLRBiqvMGhBvVv4cB
 A8cJMnI5lBAO9ZGgN/DDYKjEN1z0YZevqJuvpqJUpm2n4yLiIChMUy66fMDZpzzPIcZn
 4sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=irDAtFzSD44qLeuz7xjCo1buACjRBJTzikViM/uGxI0=;
 b=CbzQ+1Ks0/fx+j2ZCOABVvo1N8HGfRASIo1VDVgiHrRF8ZIGZZR5K4VayUIvWXVMKn
 hV1e/b8UJNhVn8tkYbyj4AD+o57zaNQFHZVzPmSaLbVSgYXdJ4qR52h10ovsqZGHYo5B
 +y47rzqo7izD83DY5VAFtFEctC+828HFSoZ9JyGNpHv3NibHz9u1KJ3twUgoHdwAAkn6
 9+NlKbYBRyrfn5EkvLS3CSiyJIbG0iR6CGWZy1mU7ZgCU3dFP+eF7bD2pR822PIKbheg
 UhKzPENzGReJ5c045obMU/tCgCv6xj9+93Vk7Tblpi1ZY0OExqKWl8fYRVYvDArvv9At
 u4xQ==
X-Gm-Message-State: AHQUAuYYmYkk8z3vVX56yxT2dAmcgZCf1BWqgRofNMadviSEOl9JNn4S
 Mm62i6ml4kLkg3R+TQOs0AUWdQ==
X-Google-Smtp-Source: AHgI3Ib7ZCQFroZzzM/u4zeLJ/0xQRPB/GHYwz8CzjqiGhLq8Xhb8jSxRw/MQHEcZ1VgEmBPLTGRag==
X-Received: by 2002:a5d:6b05:: with SMTP id v5mr3684072wrw.76.1549545986212;
 Thu, 07 Feb 2019 05:26:26 -0800 (PST)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net.
 [82.243.161.21])
 by smtp.googlemail.com with ESMTPSA id v22sm11061612wml.37.2019.02.07.05.26.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 05:26:25 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 2/2] soc: amlogic: clk-measure: fix-up some clock definitions
Date: Thu,  7 Feb 2019 14:26:03 +0100
Message-Id: <20190207132603.694-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207132603.694-1-jbrunet@baylibre.com>
References: <20190207132603.694-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_052627_673047_A6FF4B03 
X-CRM114-Status: GOOD (  11.47  )
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
Cc: devicetree@vger.kernel.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

As pointed out in review, a few clock are not properly defined.

Reported-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Fixes: 2a4c63e080cd ("soc: amlogic: clk-measure: add axg and g12a support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

 drivers/soc/amlogic/meson-clk-measure.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/amlogic/meson-clk-measure.c b/drivers/soc/amlogic/meson-clk-measure.c
index 5570180b94a1..19d4cbc93a17 100644
--- a/drivers/soc/amlogic/meson-clk-measure.c
+++ b/drivers/soc/amlogic/meson-clk-measure.c
@@ -202,7 +202,7 @@ static struct meson_msr_id clk_msr_axg[CLK_MSR_MAX] = {
 	CLK_MSR_ID(71, "audio_slv_sclk_a"),
 	CLK_MSR_ID(72, "pwm_d"),
 	CLK_MSR_ID(73, "pwm_c"),
-	CLK_MSR_ID(73, "wifi_beacon"),
+	CLK_MSR_ID(74, "wifi_beacon"),
 	CLK_MSR_ID(75, "tdmin_lb_lrcl"),
 	CLK_MSR_ID(76, "tdmin_lb_sclk"),
 	CLK_MSR_ID(77, "rng_ring_osc_0"),
@@ -268,6 +268,8 @@ static struct meson_msr_id clk_msr_g12a[CLK_MSR_MAX] = {
 	CLK_MSR_ID(26, "sc_int"),
 	CLK_MSR_ID(27, "in_mac"),
 	CLK_MSR_ID(28, "sar_adc"),
+	CLK_MSR_ID(29, "pcie_inp"),
+	CLK_MSR_ID(30, "pcie_inn"),
 	CLK_MSR_ID(31, "mpll_test_out"),
 	CLK_MSR_ID(32, "vdec"),
 	CLK_MSR_ID(33, "sys_cpu_ring_osc_1"),
@@ -303,8 +305,8 @@ static struct meson_msr_id clk_msr_g12a[CLK_MSR_MAX] = {
 	CLK_MSR_ID(65, "spicc_0"),
 	CLK_MSR_ID(66, "vid_lock"),
 	CLK_MSR_ID(67, "dsi_phy"),
-	CLK_MSR_ID(68, "hdcp22_skp"),
-	CLK_MSR_ID(69, "hdcp22_esm"),
+	CLK_MSR_ID(68, "hdcp22_esm"),
+	CLK_MSR_ID(69, "hdcp22_skp"),
 	CLK_MSR_ID(70, "pwm_f"),
 	CLK_MSR_ID(71, "pwm_e"),
 	CLK_MSR_ID(72, "pwm_d"),
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
