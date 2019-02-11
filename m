Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30807C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:23:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F311020863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FEIH7qQx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgfAnrGQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F311020863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ZhGRBHKkop4Cb1uwP9oX5R0fO6Oj/Dj0k4eypo0u1B0=; b=FEIH7qQxPLcWSzdBE0QfbPSWi0
	BpHj1R9V52ELnku/Q8BxICb4JWmfBbAeaT4mvUN2AYxiiufGggyYG57r00olggfTqBAVzb1HHxA/o
	ZqZZAcqtrQaklPcs7yZJ7pD0xFtIaIW/Hodx4Djt1zlluctQ45PdJA3AZQ/rkNvLsZu8LnNumMt3/
	nXqkHyE219UExBd2aPRc2FvQ798qv+AYzT587tUCeyk1c+y6L/Rc4LXIv/2KTC7RQDR+wpsvQIa0/
	AKN59531hSJL0/LyM+hFU5/ZUtkQ/bQoeqPTLh5Vx5mQq6AR9F30Re0BDWd9RyR9An1UOH7AdpUIK
	mG7i7BKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt7oZ-0000aq-IS; Mon, 11 Feb 2019 09:23:47 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt7mm-0007fA-E2
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 09:22:01 +0000
Received: by mail-wm1-x343.google.com with SMTP id d15so16213562wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 01:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GeJh1mZ8HNX8SodOIqWEKIstu7HfmSuWt0fhpAm7b20=;
 b=kgfAnrGQirpPWUUooWkQC+SnSWB04mo7Pqhkcs1A89WQY0iT8EcwHDsUyO8K3yirgy
 2pB+6Z8vluIXPQ6ErQNkP8JHO7RWvw5cJzYCOV6sGmopeAoq+bbiXgKqipxhr+8tc3j/
 DG1gTk3cUqlrnljMGtUzPTk3RU8Uu6FGJfci90YZIDv7JVx+NcC6gZjg901n9v8Wzn/g
 A+HpYtkswMGWnUyLzntd7OTr6XfshPlsllakCRG3icYwZ3XS+jX6FT9gGFzYnPWY3X8T
 Uj430tYf/rhduqpocHdAVw6gZ/CnJo/vdYXxg0dtXEfhjE9dfAmiEoxpQavG2Sp0D6pu
 RI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GeJh1mZ8HNX8SodOIqWEKIstu7HfmSuWt0fhpAm7b20=;
 b=qotwyKeKXpkch25fd+oUl4M0Ft4cpyuMmMsB6UdtKaGYDqyqOvmVcArz5hkWaKyjUQ
 qcRysYeDdIrO7zN92TDpEzKwZrH1oEs7eGVOhK5zp5hBEtntnhnNRYUK9phs3HwKBd1d
 T0boi8RC2OWdCqkwSirYL6HtwK1CELDf7ZuzDWRUesSQk9ykuEFFQTBHD1plRTglK7g+
 bqgI5rgTZ2ImmNcZHJ/sFHtEaI/UQCpr7mtYbNDfcShcyylqsPKQN8nOoYtTw9gfB8L7
 dktanUussp7WV49Lxd+1CM7Tho57qeqRbqYFmlIVcJGskqFn4Dvp5hcaETqFM/7YzDxc
 lo9A==
X-Gm-Message-State: AHQUAuZKcjrAAGAV4xL4RTcXU5JYaQcLLB0MP7xdGjfSh1mL5G/sGf0s
 i+xbCXlS8Gs9b2sAqBZF1gE=
X-Google-Smtp-Source: AHgI3IYjSM1FfR7S2WwI6NLUi2OnKURL/gGbASgo2peTVXcVSWpFZO/Rkr81Uw+beLruJ1xXJDssjQ==
X-Received: by 2002:a1c:f919:: with SMTP id x25mr8461804wmh.61.1549876915112; 
 Mon, 11 Feb 2019 01:21:55 -0800 (PST)
Received: from ThinkPad.gtu.edu.tr ([193.140.134.118])
 by smtp.gmail.com with ESMTPSA id o7sm11388979wmc.44.2019.02.11.01.21.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 11 Feb 2019 01:21:54 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-sunxi@googlegroups.com
Subject: [PATCH 6/7] ARM: dts: suniv: Add pinmux for SPI0 and SPI1 of F1C100s
Date: Mon, 11 Feb 2019 12:21:12 +0300
Message-Id: <37f573797e18fc22f8f78d0a62550b6d5e460a8d.1549875778.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1549875778.git.mesihkilinc@gmail.com>
References: <cover.1549875778.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_012156_789655_C2EA6EF5 
X-CRM114-Status: GOOD (  13.28  )
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
Cc: Mesih Kilinc <mesihkilinc@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Icenowy Zheng <icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

PC0~PC4 is pin group for SPI0. PA0~PA4 is pin group for SPI1.
Add device tree nodes for this groups.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/boot/dts/suniv-f1c100s.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/suniv-f1c100s.dtsi
index 1b332d9..a92a411 100644
--- a/arch/arm/boot/dts/suniv-f1c100s.dtsi
+++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
@@ -96,6 +96,16 @@
 				pins = "PE0", "PE1";
 				function = "uart0";
 			};
+
+			spi0_pc_pins: spi0-pc-pins {
+				pins = "PC0", "PC1", "PC2", "PC3";
+				function = "spi0";
+			};
+
+			spi1_pa_pins: spi1-pa-pins {
+				pins = "PA0", "PA1", "PA2", "PA3";
+				function = "spi1";
+			};
 		};
 
 		timer@1c20c00 {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
