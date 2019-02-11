Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6519BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:09:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3594F20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TWR5Vw7R";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5EGKxLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3594F20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=MK+xPrqLCOJXQCiHm+F/efuVOe0Kx6m5PnyNielpL/I=; b=TWR5Vw7RFaHqjy
	yyJyT/IyEaGSpZ8Sv6ggqTrWXas4iOihZNAf0z9ISWr5mX9aqDQeEKcTZZZxFjX2K2kR4AkLrk5J2
	l2RM1Spr2Rzgshn0MG+Fx5c342lwQrtvDRaIfL3a5iI9NIsM7KHSMNdvHfcCdwPkNqIanZCArLLJ1
	3mudh7Vi2r9oys7L3abkvBd2xeYUORYjc7JbXS22HCyCUasmuSQGsdeT35UAr7f7z9XRvpUnR1HtB
	oxhLfkQMjVYrhQBjnTgudZVBx4xv16C989vgZAIWTO+lwx0rQSwqAxB7EkGf66b2NsfHfitWWOGvj
	hmW4bG8Z7Ky4ftyHk+ow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt9So-0005T7-Cf; Mon, 11 Feb 2019 11:09:26 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt9Sk-0005Sm-AC
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 11:09:23 +0000
Received: by mail-wm1-x341.google.com with SMTP id b11so17072749wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 03:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QxR4ydY2asPONlOFGBW5etgVpUXzE8d1exJ++uN0wXU=;
 b=A5EGKxLL5iykMofqRqHSqdwj18iG04+j1nHO1A0xiC6tEoTT134GF5GKz//7NW8MLL
 3R6EvIHAFkk/85wXZKr+KLeFrR8cs+W2yPejJleSa7HL+u5/q/QxmfFNVWyjqjSEJu8u
 ivxxWiWvyINTotAyCfjpMVRN2kPaI7J9Cyzhw5e6LoUVS0ExhvJDiTljpzt8zYr2Ih5w
 aorBWFcIY37ugPv8f1dsWVhQNgQt6n+Go7tYRDijzAvPwVTZqZTkf6gzK5T8J4FKKnmI
 QKwUKWJHLTZIcc3/Sbjrw+1QFOJ1Zq1zMlh/KDknwPNx27HlWxK+LkVtSf2XnYXfCzFu
 zSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QxR4ydY2asPONlOFGBW5etgVpUXzE8d1exJ++uN0wXU=;
 b=ZPersrLxLLkWnL2UTS40IU4YYcas90IyP18SNpYKTR8AAHrCp5NfYsckzxSsc2xVsS
 NE+Th+XhxXWjsuXw3+wLsD16Uu8qhArpf4K2a5qMmKHXBQr48ZoK7uLH0aF/lFz8Lwj4
 DQhTC52Z6GfZ0SrvnwWfZOHA8oGwar6YNrKy3sxASLEN8HypgxeyFw5NU9i2OqBRGxjs
 2A98Tz4NOpbvdh9ru/OHKWeaLfoMA8wxBv4vizuNB9/SPY3g6vgnH1WxSpchFf39A9my
 kcbs5puE+vn+S5pw/HmElcV6NkGIur1BxS2ouajiLyYp2gpaU4b55VURxj6PliAM/m9A
 V1ZQ==
X-Gm-Message-State: AHQUAuYDSiEH7Tc8xjoGbscTXlSnZn6ofMWUDMbiJTbat9qzGEE+bX8b
 duoUJxZAkbTpX1JIkjGEzl9rIkMu
X-Google-Smtp-Source: AHgI3IaL6iEgQxU2vX5daEdKUZBJAD/TfVShSwkTr/6wXRI9emFGjA0+bKrjGMjv3YMRuRavh0S4GA==
X-Received: by 2002:adf:f28d:: with SMTP id k13mr28092250wro.78.1549883360690; 
 Mon, 11 Feb 2019 03:09:20 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id y145sm9976625wmd.30.2019.02.11.03.09.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Feb 2019 03:09:20 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2] ARM: tegra: Restore DT ABI on Tegra124 Chromebooks
Date: Mon, 11 Feb 2019 12:09:19 +0100
Message-Id: <20190211110919.10388-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_030922_376155_D4517F3D 
X-CRM114-Status: GOOD (  16.89  )
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
Cc: linux-tegra@vger.kernel.org, Tristan Bastian <tristan-c.bastian@gmx.de>,
 linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Commit 482997699ef0 ("ARM: tegra: Fix unit_address_vs_reg DTC warnings
for /memory") inadventently broke device tree ABI by adding a unit-
address to the "/memory" node because the device tree compiler flagged
the missing unit-address as a warning.

Tegra124 Chromebooks (a.k.a. Nyan) use a bootloader that relies on the
full name of the memory node in device tree being exactly "/memory". It
can be argued whether this was a good decision or not, and some other
bootloaders (such as U-Boot) do accept a unit-address in the name of the
node, but the device tree is an ABI and we can't break existing setups
just because the device tree compiler considers it bad practice to omit
the unit-address nowadays.

This partially reverts the offending commit and restores device tree ABI
compatibility.

Fixes: 482997699ef0 ("ARM: tegra: Fix unit_address_vs_reg DTC warnings for /memory")
Reported-by: Tristan Bastian <tristan-c.bastian@gmx.de>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- remove memory@80000000 node pulled in from tegra124.dtsi
- add device_type = "memory" property

 arch/arm/boot/dts/tegra124-nyan.dtsi | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index d5f11d6d987e..bc85b6a166c7 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -13,10 +13,25 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory@80000000 {
+	/*
+	 * Note that recent version of the device tree compiler (starting with
+	 * version 1.4.2) warn about this node containing a reg property, but
+	 * missing a unit-address. However, the bootloader on these Chromebook
+	 * devices relies on the full name of this node to be exactly /memory.
+	 * Adding the unit-address causes the bootloader to create a /memory
+	 * node and write the memory bank configuration to that node, which in
+	 * turn leads the kernel to believe that the device has 2 GiB of
+	 * memory instead of the amount detected by the bootloader.
+	 *
+	 * The name of this node is effectively ABI and must not be changed.
+	 */
+	memory {
+		device_type = "memory";
 		reg = <0x0 0x80000000 0x0 0x80000000>;
 	};
 
+	/delete-node/ memory@80000000;
+
 	host1x@50000000 {
 		hdmi@54280000 {
 			status = "okay";
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
