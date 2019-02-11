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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A68AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:24:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B0F520863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s/e4wltM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyTJPG/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0F520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ypcjKBuT2w48wzEoOtDVcvj6duqIAcSD2dL+PbAqhx4=; b=s/e4wltMtnjrAGh6iZ01ci8ROI
	8BJYbXuonkf/VWTpskYNagKvFYzUMIU9LZNL5BTYx+MB1At8uP4nVyKSKzGRC4a23P796IE/iyFsi
	Xr1fFiPNKn/BUWwTF8J+pR+08sKm2a4ze+4K2tPfvuJRDxgM8RMIOBrWplGgu+kMU2gNa7AZDjPOa
	/f0VJwxqNEXmrrbOFEGhN3VidR4UWNwPkJsonwTFSsDmjoGX/bHysAaXrFuTodpzImrAfWECb3aIh
	cB9B4njeG7eD0wuocCGwOBNfcIJqO406li80lXu8PL2r8mwe3VTOClrpzTgUTls3DlYYYTP+oB4bz
	64SgHPCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt7oq-0000qU-2g; Mon, 11 Feb 2019 09:24:04 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt7mk-0007dp-Ss
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 09:21:59 +0000
Received: by mail-wm1-x344.google.com with SMTP id x10so10325924wmg.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 01:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fwD0w9cY6pAqgprkGqKHjvaIM0lWzxAak4iqngIDanE=;
 b=QyTJPG/Bx/k2DgyeqFolci5TCnumOLVhB6okYdjDW2ie1kneDcXMMhJEOneqSRvWwP
 DldyUsX+E0iI5swA+sWqYeikX8sAeCbzFUjALZBe8i1S8Ihj9J2Ai8v8eI6q7Be4HNmO
 vHoZtXAUI+90kaxejbRrKJcZMLF7Tj7GyruKxNPN7otIlmWRV5BSwelqHhWUVmEeM4zK
 47LS+vurw1O4EHF2GLuFPhWxxj3inkzkxLLeicprL7sDXknvKJxbXHMyPub1VWM6Ddwj
 I1zRR/LchiJ7EqGZC0dtdYSjTNXme1B+ProKtjbWTYZnew08nXjt/NldLTTZO8NB+bRc
 W1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fwD0w9cY6pAqgprkGqKHjvaIM0lWzxAak4iqngIDanE=;
 b=jhPy2nlA37rvIc6QBnj6c6ffM0+ETz9fMuESWZP3E73gdPfFqYjxuoSaEVixHMbQDo
 Z/n+fjv1HWekQtBphCNo3eZjTqoXOj30DvRxyF7cg2xcyiLW6MZgCS9UczakdG9w5Ioy
 UCQtpzvZm9Eh4b3z7cDUMP2Hz4RpoyGVvXIo4VW4M7zZgV40Dp2MY3qkfJTEWIz/4D0/
 0xbiqUqEbY3YeJW4HshJMCwEBO8FPIGC1Tsl6xhIY1NJQrsXhNIc55scb8dHFChpFUO6
 YIt3egFjU/sJ2SYCoPce+zc0/qIovxX0KJPfLEfgXCwoUmNhnhRd9keOMSDo6Ssi7oUR
 xTpg==
X-Gm-Message-State: AHQUAuaeNVap1oT9sLmXjkZNfTZ+gOw4oc9oIcrH2maaaYkCDF00BQj5
 RsCnWDMDtOCaWzVXysjNXPQ=
X-Google-Smtp-Source: AHgI3IbI8Pp3O5chVjMuKPKEycPJpQtScjVPz5GgOvT4cXuGkW8JSB+BgetdDfEqZniD2hysWJ0lXQ==
X-Received: by 2002:a05:6000:8a:: with SMTP id
 m10mr25834299wrx.79.1549876913504; 
 Mon, 11 Feb 2019 01:21:53 -0800 (PST)
Received: from ThinkPad.gtu.edu.tr ([193.140.134.118])
 by smtp.gmail.com with ESMTPSA id o7sm11388979wmc.44.2019.02.11.01.21.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 11 Feb 2019 01:21:53 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-sunxi@googlegroups.com
Subject: [PATCH 5/7] ARM: dts: suniv: Add SPI device-tree nodes
Date: Mon, 11 Feb 2019 12:21:11 +0300
Message-Id: <d1f0bd8af72b0902bc1d44a0df64a844b00fa895.1549875778.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1549875778.git.mesihkilinc@gmail.com>
References: <cover.1549875778.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_012155_802738_FF7E2C97 
X-CRM114-Status: GOOD (  12.48  )
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

Allwinner suniv F1C100s has similar SPI controller as sun8i H3.
F1C100s has no dedicated mod clock, instead it uses AHB bus clock.

Add support for both SPI0 and SPI1.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/boot/dts/suniv-f1c100s.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/suniv-f1c100s.dtsi
index 953228c..1b332d9 100644
--- a/arch/arm/boot/dts/suniv-f1c100s.dtsi
+++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
@@ -143,5 +143,31 @@
 			resets = <&ccu RST_BUS_UART2>;
 			status = "disabled";
 		};
+
+		spi0: spi@1c05000 {
+			compatible = "allwinner,suniv-f1c100s-spi",
+				     "allwinner,sun8i-h3-spi";
+			reg = <0x01c05000 0x1000>;
+			interrupts = <10>;
+			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_BUS_SPI0>;
+			clock-names = "ahb", "mod";
+			resets = <&ccu RST_BUS_SPI0>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		spi1: spi@1c06000 {
+			compatible = "allwinner,suniv-f1c100s-spi",
+				     "allwinner,sun8i-h3-spi";
+			reg = <0x01c06000 0x1000>;
+			interrupts = <11>;
+			clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_BUS_SPI1>;
+			clock-names = "ahb", "mod";
+			resets = <&ccu RST_BUS_SPI1>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
 	};
 };
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
