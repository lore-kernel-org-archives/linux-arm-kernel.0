Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D91FC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:27:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F0CF2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PJ3zIZee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0CF2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wGb8dUTDxbuko766u2HrScxKI5aT+R0uHKsBU9M2NHI=; b=PJ3zIZeeIi9+Q3
	wCaNyqr97rd+YtX5fyrXedliYcEV+o4RWvx614RjvSK0cipG5NGHx46ZawvYhF9SzX5LRWnEmlH5n
	SrcPWkkgQGsp3t3jZDWekd5OVhF6MID3xQf5rL6gIxy9os2OG+l2/8FM1I9tkfZEec0B9MVAIL47l
	eCq2I749oXVZPk0VW9O0uNKksxhx59bYIQaAkkvTenTmwjeWjozB3VHCxiE79h0mri+2Te4q3fOOZ
	CaYnKgIxo5Wkjx53WNyEAkfY8o5yJqgfrFkq53qp8RMpzRJJLUFh6rSFHfb6ajG8TasklhyZuuVcR
	aVwpddAiD0kx1ORBCyFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gms9V-0002N9-9g; Fri, 25 Jan 2019 03:27:33 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gms5W-0006iw-7l
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 03:23:31 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 6C7B25FDD9; Fri, 25 Jan 2019 11:23:15 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 09/11] ARM: dts: sun8i-a23: Add compatible strings to display
 pipeline device nodes
Date: Fri, 25 Jan 2019 11:23:12 +0800
Message-Id: <20190125032314.20915-10-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125032314.20915-1-wens@csie.org>
References: <20190125032314.20915-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_192326_782465_972F851E 
X-CRM114-Status: GOOD (  12.50  )
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
 dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Now that the compatible strings for the display pipeline on the A23 have
been added to the bindings, add the corresponding compatibles to the
device nodes already in the A23/A33 shared dtsi.

While the A23 has the TCON ch1 clock defined in the CCU, and the channel
1 registers are available, it does not have any means to use channel 1
due to a lack of downstream encoders, and the enable bit for channel 1 is
hard-wired to 0 (off). Hence the ch1 clock is left out.

As the MIPI DSI output device is not officially documented, and there
are no reference devices to test it, it is not covered by this patch.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index d00055e9eef5..a5e884a8b2ae 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -62,10 +62,26 @@
 	};
 };
 
+&be0 {
+	compatible = "allwinner,sun8i-a23-display-backend";
+};
+
 &ccu {
 	compatible = "allwinner,sun8i-a23-ccu";
 };
 
+&de {
+	compatible = "allwinner,sun8i-a23-display-engine";
+};
+
+&drc0 {
+	compatible = "allwinner,sun8i-a23-drc";
+};
+
+&fe0 {
+	compatible = "allwinner,sun8i-a23-display-frontend";
+};
+
 &pio {
 	compatible = "allwinner,sun8i-a23-pinctrl";
 	interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
@@ -73,6 +89,10 @@
 		     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 };
 
+&tcon0 {
+	compatible = "allwinner,sun8i-a23-tcon";
+};
+
 &usb_otg {
 	compatible = "allwinner,sun6i-a31-musb";
 };
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
