Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38D0C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 19:06:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B11B2217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 19:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W0dFyOCH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQbuOg+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11B2217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N1LVR1LDwlT1P595eA/hqPvAK2TynctiMmUNzN0btlc=; b=W0dFyOCHw/Zi1n
	8UO63wsusWPsGOxy+Ci1vE3ECzXOW8+MOM2x7ZU5c2moewkfBh66TowIuqivzAGe8JZsnYAQCveXV
	U7wI5J1AywtOkb8nBwKaDdWy9DSewLh5egDdagIILQZu8QYtY+1HYhKo8z1opUV7C0r2xQQ5IrA+/
	tjroMIEGeHLKELaVVNbLptweB9n9QZ1x28C5o/Qo0Tk0i+8RUTMGr3fGhunFITvYPuDZC4UY/mHyN
	6RrlofJq9QLfi+lYXqEOjKQ9COjJu6umSfUpHzVG6KlLqvLj8yC/claFdNcSU5Uc9gBPaUem0jNlw
	/v/rdOFnbjNlBlJhU5TA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqN6G-0002pP-Qw; Sun, 03 Feb 2019 19:06:40 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqMvi-0005JI-IQ
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 18:56:01 +0000
Received: by mail-pl1-x642.google.com with SMTP id z23so5765960plo.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 10:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SrvFVouaYjNTy08YBCU5WIYZS8Tl/vfILBmGEJvEU9c=;
 b=aQbuOg+iWAKPen9xDikaYua9cPAeiuccbuMzSzSzEL52sUnWSKru07/5ypsO1Z2/hm
 LEbLhIFGG77DYeV1ERML6CtwLGYUiRHmz3BT8IVOBbKH2oSFKJi7A50E9kht9YWtrYjX
 s7PTzkYjdmC6ycENBdSONPosKMZ9THoZ2RgZlW3zOZuFf31PtS+wxELX/ojNGYzUwKLp
 uhLnjAYtH8Tw6oVMzhlPe2xUzdkVW/FUjOkFHDpyokjTmj2ouSvTwxvv+9PkaevBQmKk
 6ppx2vKsiUfuJn5Y5gy6qf/SLkmEkzSA2GMJOjUKF52XVLgDGtmm43ETCDdk2cXY6pYH
 WcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SrvFVouaYjNTy08YBCU5WIYZS8Tl/vfILBmGEJvEU9c=;
 b=M6zwP/z5Q8mc3b8xRwgFiPCbYRmPeKlJcJhQ8mulLotGmdNoJU8yYdykYf2947cI+n
 /fcwsge5OtVWabsgZMaXb1g+/eI1MwFZX/AoGPf4z8+2da6rvCbBBtLXsOQuwvmSyhts
 SUn+rroXdmijvrum1yGSlwTr5ZiTeAKTJ6JC+4Fk+KGkgQ5Y5zGwlt2KV/vuvcG7xc7C
 LQpbbIU9hF4MeYu8IE1lgbQZTFWtsrGCEx0bmYhnMfrZRqYD9sgQ7A0R9TD+1i9BOA5x
 fubtB+vE1bEuFaYka3ANT2Cn0EBGEAaliXCl9gFIBCQrZv1d0YFgT6/T7Hobb7Zre9+S
 7ZBQ==
X-Gm-Message-State: AJcUukemPUGqIxDsII9Tm67KtnKyXYbueO4uJSwQ16fu9X93nQWxXiDA
 9ER8aH+l0HD5gji95MkoSQshRhtvPNU=
X-Google-Smtp-Source: ALg8bN6dQkkPe/sAz4pJxu4gnRWdTn37Wt/+v8rzVRb4YZQoYiuJQfh3kQs/xVMJxe8AZfT1gKmJJw==
X-Received: by 2002:a17:902:bc3:: with SMTP id
 61mr48893735plr.15.1549220145889; 
 Sun, 03 Feb 2019 10:55:45 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net.
 [216.71.213.236])
 by smtp.gmail.com with ESMTPSA id g28sm19524553pfd.100.2019.02.03.10.55.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 Feb 2019 10:55:45 -0800 (PST)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Archit Taneja <architt@codeaurora.org>,
 Andrzej Hajda <a.hajda@samsung.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Icenowy Zheng <icenowy@aosc.io>, Sean Paul <seanpaul@chromium.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Subject: [PATCH RESEND v2 10/12] arm64: allwinner: a64: add pinmux for RGB666
 LCD
Date: Sun,  3 Feb 2019 10:54:59 -0800
Message-Id: <20190203185501.8958-11-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203185501.8958-1-anarsoul@gmail.com>
References: <20190203185501.8958-1-anarsoul@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_105547_392250_17AC3A7C 
X-CRM114-Status: GOOD (  11.31  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Icenowy Zheng <icenowy@aosc.io>

Allwinner A64's TCON0 can output RGB666 LCD signal.

Add its pinmux.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 837a03dee875..4fc3ca5fa53e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -559,6 +559,15 @@
 				function = "i2c1";
 			};
 
+			lcd_rgb666_pins: lcd-rgb666 {
+				pins = "PD0", "PD1", "PD2", "PD3", "PD4",
+				       "PD5", "PD6", "PD7", "PD8", "PD9",
+				       "PD10", "PD11", "PD12", "PD13",
+				       "PD14", "PD15", "PD16", "PD17",
+				       "PD18", "PD19", "PD20", "PD21";
+				function = "lcd0";
+			};
+
 			mmc0_pins: mmc0-pins {
 				pins = "PF0", "PF1", "PF2", "PF3",
 				       "PF4", "PF5";
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
