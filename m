Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCDCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:16:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA7F92173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wt2SnH3c";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="os8exHFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7F92173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=xT/ng4H57wuoE2ibn86Ua7m+OMBsDfX8msXKHoWwhaQ=; b=Wt2
	SnH3ckfdf/inTPahgHoWfmENhpQvlkqDGax9uxYIxn9X9/ma9DPqi6MjZ7/SCW1DhEMyxw4JEbd8d
	eIdLs+aITFRTgKn89w2qfn7W6enwqGht1HMsOJcEgOib/nWqH31WIHdz+l2tfKDShjTZH4OeXKL67
	LNSc4Myl9Ewu8eFnLkzjPNEu06CXAGXc5VT/dmsd06kV/sXq1mqHcI8m8t5Hhr4zegSGl2WML3joE
	aPBd2DEI/eHgpvY0Evrtl7Rz8EdAcC6tPrLMbthYH4sOxNn+YSLVur80hdAHy2NCyGy4MfsyULp6U
	Kshft0pW0gXtGz8S2jnkbOphR+gnf2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gydWg-0007pz-1D; Tue, 26 Feb 2019 14:16:06 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gydWc-0007pe-BK
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 14:16:04 +0000
Received: from localhost (unknown [193.40.103.250])
 by plaes.org (Postfix) with ESMTPSA id B8667411A9;
 Tue, 26 Feb 2019 14:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1551190527; bh=FMKmMZa79gVq+T7Nmx2rAHozElSXaYYN0uJOOYlLSvo=;
 h=From:To:Cc:Subject:Date:From;
 b=os8exHFWwyTF4YQW6HsICNL4ouezid2RYKhdSqGatfz9Qk3zNsG+ugJCVDCDo/MXl
 uZQnAY9t7CKO2QE/oW659agDSpNktqNWOy81HCjlVMfK2nQA4YmwDwt7zhMiUbSc1A
 T3w2wPiHQMhJFFMfi92xbYye+ZMwxYpvY40ui8OMsVPE08/g+2G4fG1tNDZFhi+hNb
 xYHtqIU7Q7v5Bdfw24tFlFjXhfwL+yjQw/OQy/D+FlWXqbAsnNCRExNL6UrVg/R9ef
 TjTfNVJVhXvjcgCtg/cPbhHWtYd4t37Cplms7776eUIqxCAjUDdYUJQA5jwhC5ReBh
 Ce21VLaluchtg==
From: Priit Laes <plaes@plaes.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: sun7i: olimex-lime2: Add regulators for GPIO banks
Date: Tue, 26 Feb 2019 16:15:25 +0200
Message-Id: <20190226141525.1039-1-plaes@plaes.org>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_061602_532901_2379C9DA 
X-CRM114-Status: UNSURE (   8.12  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-sunxi@googlegroups.com, Priit Laes <priit.laes@paf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Priit Laes <priit.laes@paf.com>

Make sure that A20 Olimex Lime2 pin bank regulators are
properly represented.

While pin banks A, B and F are connected to 3.3V static
regulator, pin banks E and G tied with LDO3 and LDO4 regulators
with 2.8V reference.

Signed-off-by: Priit Laes <priit.laes@paf.com>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index 4e1c590eb098..3de479bfa4cf 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -174,6 +174,12 @@
 };
 
 &pio {
+	vcc-pa-supply = <&reg_vcc3v3>;
+	vcc-pc-supply = <&reg_vcc3v3>;
+	vcc-pe-supply = <&reg_ldo3>;
+	vcc-pf-supply = <&reg_vcc3v3>;
+	vcc-pg-supply = <&reg_ldo4>;
+
 	led_pins_olinuxinolime: led-pins {
 		pins = "PH2";
 		function = "gpio_out";
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
