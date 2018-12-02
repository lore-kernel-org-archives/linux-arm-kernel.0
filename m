Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0783C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:40:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E5C20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a2omObBH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c86y217+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E5C20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=97OVGuw6lQRzMFv3zwW/E9uJSJBT/voSxO5AMwdGwmg=; b=a2omObBHeDNi+uy3aR2xtjl+Ne
	nYph9nmQP9T5WdwrzGNcO6u36MrVhiU0C/1UJUKkXXCM+TO95T6sfr5fnzLvui0mitToCmfR/2/vy
	Cc8utrlYrV1JA93cmEXCMTWFT2o5T3ZCs7wc5htkihgePwsQzIwrSAZQL1wtASGfyxs4SVNftyttc
	DTwH+8QXJ7NruAou/oL8tm1vjuMT1hTrCklJzpqIHomBCJvQOCMI8GM+thKIlW7hrDpqlKjWp5LHN
	AwiWK14/KY28lNOAU4qNuf8LSgo+mWWboOQlerp0wOeorDZU6Sd3vD1lNGWT5vzdRtkgO1X7ONlD9
	1YaOtrGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTYXP-00040w-E0; Sun, 02 Dec 2018 20:40:23 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTYIK-0002BX-PG
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 20:25:08 +0000
Received: by mail-wr1-x442.google.com with SMTP id v13so10054815wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 12:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=iD1UyqjCCFF08dz9kmj5kIY680LVUEWD9EKoGw4tLF8=;
 b=c86y217+EssT553fPEG7MQk86eyrX1V0dx+1thpVElww3Eq9XhMrWqUUftlMnaQMU7
 cyl/SAf/SCDJW/6GZsw8tY45EQBKY39LJNbzuB683A0vYdXF4/HvVZd7Kjuaq1wJbP02
 MNwUU8ioNr88gS8Pjaxq2LBtrAgRnUiHyYajpi6sQH/2kESVb9xtBIdPUwNW8OfhlYu/
 Vz7I4KRYyRTB1bWrHpjGaOo/T+t18EGm9p7AAdMQ8y8R9aFX93vM/axlAZpkRd+EtDS5
 iAAHuCl/k1abRlRFQ7/i2niHjhJCk+n/bcD7yF9mslZAKr1E7Ej7+0Sf8GUxuYLM4B55
 mnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=iD1UyqjCCFF08dz9kmj5kIY680LVUEWD9EKoGw4tLF8=;
 b=hcXoy6kYWOnvTBhCV4LTWf4mYR/b8NHwXpXeiolI7s/fG8m0kV1FluPfbjtznRx0Td
 z/23l9CaHX5mJF37C0Q4lx2+nxCzGhs1VcmoAuDqJQWxMhjIDgXmBQzbx4qSwHaOznq8
 X86XSNEPUJKptHhGnHqiELwOlVKuF2Qk8Vjjq4V+wSP4wPSZQzBlSg1pf6Zy42Zr8K+h
 YKrIzsCpNmD4CGrMaD5nLEOzyeSeLN4uprg5hxAvaQBWaZVwNh/X0u8JwhQ3IEU3x68d
 zObEiEq54naMzOE1eP99CojlOc2TGt3lhCyy0w6ikSM72NXaf3uecTNqRvwNTanAJ+6a
 Gsuw==
X-Gm-Message-State: AA+aEWa0xdjUteuKYcaQMez/U/bWJpD1KK2JosBB+9Otz4bykWvMNC5y
 we/zNy8egHUza75b1p/CXpU=
X-Google-Smtp-Source: AFSGD/VPOOrnSKr8mzkgmLIdvSF++Z35odAHG4iAbEXTnXRN6wJoOxIskM6YjD5v5O+I7amaREuxQg==
X-Received: by 2002:adf:b201:: with SMTP id u1mr11711337wra.165.1543782277021; 
 Sun, 02 Dec 2018 12:24:37 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
 by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 02 Dec 2018 12:24:36 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v6 15/17] dt-bindings: watchdog: Add Allwinner ARMv5 F1C100s
 wdt
Date: Sun,  2 Dec 2018 23:23:49 +0300
Message-Id: <fb0c64319cbb5c2b062844ff38aba7b7323eefcb.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_122449_509500_9D1BE8CE 
X-CRM114-Status: GOOD (  11.71  )
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
 Julian Calaby <julian.calaby@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Marc Zyngier <marc.zyngier@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Icenowy Zheng <icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Allwinner ARMv5 F1C100s has similar watchdog timer to sun6i A31.
Add definition for it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt b/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
index ed11ce0..4605525 100644
--- a/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
@@ -6,6 +6,7 @@ Required properties:
 	"allwinner,sun4i-a10-wdt"
 	"allwinner,sun6i-a31-wdt"
 	"allwinner,sun50i-a64-wdt","allwinner,sun6i-a31-wdt"
+	"allwinner,suniv-f1c100s-wdt", "allwinner,sun4i-a10-wdt"
 - reg : Specifies base physical address and size of the registers.
 
 Optional properties:
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
