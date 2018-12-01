Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598E8C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:44:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A8EE2081D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UC+vQG6h";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJ58giBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8EE2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=659mCtASIqAX/+c6UE1ZFeMtuwYINlJ/Hz/cbjEd9+w=; b=UC+
	vQG6haq1K3U1RcPVS4OldKGlODyRs0c+0GLNSw4QO/gV8idr5ffnTq4TnDOCeAiI9GyWaaWupl3uA
	99EEwgEx+cZmlRUcvwEZVUMnlUxdJINLT3VXjeOLGFLJ+OGmo7ixwuGaWUSDUEwS6eMeMYVLQe7E9
	a1B1Z7KuEKn9FcdLzF8w0GYDjODKoABUCzaxfpjC2ZrABffSMg2yTvWnpavttiS6E+U9mkQlVgqKa
	8M6XSl5eInv+DI9IjToYGdAj0kTOvG7hh+W2oncvEzOxKE7T2sGge0HzpEmT32sktCTC35n+44Mho
	p9/2G8POf6bCy+p54/puU9otheOKFUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gT6Uy-0000Iq-1Y; Sat, 01 Dec 2018 14:44:00 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT6Uu-0000Hn-GE
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 14:43:57 +0000
Received: by mail-pf1-x42d.google.com with SMTP id z9so4243158pfi.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 01 Dec 2018 06:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=oO8ompKbDpgC2V8RT/2nEV/t/n3TE41cjUx8pQHOg5o=;
 b=JJ58giBrCP0/1KsjA3neG+4Bud6977SYMrjvBa6jTHjVVLt3IOq2iPVGNO6heyCmBs
 MfAjAEotAobLTMKUbFSEfbnrXnNUW3h9SXhKkqz4KtWtmG0fp5hqip4/Q7jPYu1/BNyW
 WJJxFFI8UlBajBK57u5znqVseXh2sKfRAP9k6NrSYMz+8IuGjKXoE1EjnTq+50X0vFn3
 6oRUH4bH5o42i7v3fGJiT0gIXIhg4LYARYsIx9DJqT7F3S8SUtXPAdswuN8i4w0soHiG
 ATuRDaCWbVJeWjRjk+LhP1zCwzHVGxEwORaIzaqDgYQbeaivrRPSzr8Jm5mC6BnX1O50
 AQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=oO8ompKbDpgC2V8RT/2nEV/t/n3TE41cjUx8pQHOg5o=;
 b=PlQQzjkj/ysMnk0KxVd2Uc8yaKKULoFGchG5NkV39UE/dZNw0YzfPV8x05Ca3vuu7O
 K4cUpjYI5JVF/NIY1FxHSAfgXZmWD2uBuhLlVlnwLFqsYjPX42U/XUmRC9w0HF0Wm6Xf
 +r3XQ/XMA4Tn3J8lER+h5En590DvFDWWZocJpRB9feDbYXFNf76bERSZrm1LxS1ExZkN
 rr/cfqFbA2NvQM3+iyjzhMwikitjCY9v2W+8OjU6rdsCbHjw5GB5XrI0G3RbfJA7cYMZ
 SNJi32yv+BRMSBH2vpS0dsSxhd8xpXkLXKn62YY8DvsW1J4/oL79nitCyhgVvVLxcXZ3
 2jyg==
X-Gm-Message-State: AA+aEWZ3xRDbXW1no8ctHq6ReKJ5Z3x4SpyMDhQUyO+mYLZAxBi3gHpH
 2OI03iNasr2d5yIla2zJxKI=
X-Google-Smtp-Source: AFSGD/XjzjF1gfTw4epc/wp6Rv2gkhUo/mXaaN4G/croYOiIMmpMcI7Y+imQGTaAzq/BF+eoatJFeg==
X-Received: by 2002:a62:d2c1:: with SMTP id c184mr9602360pfg.248.1543675423941; 
 Sat, 01 Dec 2018 06:43:43 -0800 (PST)
Received: from localhost.localdomain
 (p7732116-ipngn36501marunouchi.tokyo.ocn.ne.jp. [114.158.79.116])
 by smtp.gmail.com with ESMTPSA id 15sm3491461pfr.55.2018.12.01.06.43.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 01 Dec 2018 06:43:43 -0800 (PST)
From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH/RFT] arm64: dts: renesas: r8a77990-ebisu: Add BD9571 PMIC
Date: Sat,  1 Dec 2018 23:43:28 +0900
Message-Id: <1543675408-11382-1-git-send-email-ykaneko0929@gmail.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_064356_568109_6D13BE24 
X-CRM114-Status: GOOD (  13.00  )
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
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds the regulator definition required for operation of
S2RAM.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the devel branch of Simon Horman's renesas tree.

 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
index 62bdddc..3eee419 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
@@ -425,6 +425,26 @@
 	};
 };
 
+&i2c_dvfs {
+	status = "okay";
+
+	clock-frequency = <400000>;
+
+	pmic: pmic@30 {
+		pinctrl-0 = <&irq0_pins>;
+		pinctrl-names = "default";
+
+		compatible = "rohm,bd9571mwv";
+		reg = <0x30>;
+		interrupt-parent = <&intc_ex>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
 &lvds0 {
 	status = "okay";
 
@@ -480,6 +500,11 @@
 		function = "du";
 	};
 
+	irq0_pins: irq0 {
+		groups = "intc_ex_irq0";
+		function = "intc_ex";
+	};
+
 	pwm3_pins: pwm3 {
 		groups = "pwm3_b";
 		function = "pwm3";
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
