Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBAAC64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:25:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F15520851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YGUPg27F";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzmdAlgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F15520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=q2Ha9YRTq2KJTp5nemZM7kGUfyxWju8c5hjdHel5akk=; b=YGUPg27FlGurSqiYpwZ1H98x05
	SzcL8Yd4V+HMeQEsjL86Z5F3M3wP2KpYJFhQDfK8BgHVBO5Cibk+0JYAw9gL9ZrBV3G7GlFExL/Iu
	Hz0qmPIaQ+wzQQC9/aXdyE2eLBYWg9BG7bbw7Znl6ywE7xD8NRuprDuRC1Yb43NM8OJ1mcXjHkFQE
	R9VgDlK/G42QFuxYUfsU49pN3NA3erV+hXiHckVQUH+AlOgpFLAxzEilTXPpHSt7xZ0yGS7oGKAYw
	WlQt6OZPjTQTMK6rgbX0Cwf3AcNOs0kMPFat2Zi0jaFqLPvIOUTDRiffqcTkN5m/LJoMcM3DDynuM
	X5BJHsuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTYIl-0003Kf-W5; Sun, 02 Dec 2018 20:25:15 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTYHz-0001wI-FW
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 20:24:28 +0000
Received: by mail-wr1-x441.google.com with SMTP id 96so10078874wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 12:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+V2WbDnTTYDb5DheTPlD4ID/xDgu/F+Pl9HjYjs8x9s=;
 b=gzmdAlgscUYL21LnLlekT5aOUIsAwdn6tX96qbCodW9DGKkZFT40/EKT+Xv9/xMNUl
 0Vjuurbizu6q5Xq/a47UvjlY9mUlWaDFYTk+6WWiybiH/lwae5t+Dt3d0TS0MPRqy4iJ
 le2t5pxPRldKUNTBBuW92urVTjZtLQngeNs49LXoZWqC3mc8q2ATrs18VBN5FiyMdsgg
 MqylHFQ77uz9jnexx8vdSDvMXjzafQ1YhnhBBmVWGxGWSdwUPsD9AGzZbymjv8dxilJl
 nUFQgJFc5l5PCVPeyU980UOFkUdfF4VdQQAWta/46S3BYqFgh0emVWYWtk0F+V887dTN
 hmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+V2WbDnTTYDb5DheTPlD4ID/xDgu/F+Pl9HjYjs8x9s=;
 b=rljlA3VfPe0L2kCXhFv9AQdhtGeIvlz9hX6B/8mVwH0wmFGO3vhYZNvuwJWJTUqEA/
 wnPMYvi10sq+QwuZu+d+PIYCtnGiYkmb+y8LItFB1g11b33TaZNOAhU9KNBAPoMW6kt6
 BZiHJg+tS5GwTwkEpyiC4v5yPTYfG2aKB50jWql+7uEOwyU7Djm/pnYpLByIip9Y4V/q
 B6RZJ0gbqH7cVqHuWXWxVniZ6MP95AxZDdjsIsLS7ReK9qwct8HomVzWumdp5Zu2UOnn
 o3cFiHwvnyFTv6VkFdLXLOiQ2N0hA5FWAa6+q969xz5wRcada3WIiJhwrq3oEPzD0Hqh
 oqwQ==
X-Gm-Message-State: AA+aEWY9znkARZTwxWDWSWkF5Tnv1ECjgAdBTZW9XtgSLhbbqbCIC7dc
 KhjAN7NSBojleRgRaGdTY/k=
X-Google-Smtp-Source: AFSGD/UvqSUUDOejX6SjyUwczTcah8rkFmvGhQoVogLPun72q5lzEFpLT8WIyylrx395yFeAiioYlQ==
X-Received: by 2002:a5d:61c4:: with SMTP id q4mr11112960wrv.308.1543782253959; 
 Sun, 02 Dec 2018 12:24:13 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
 by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 02 Dec 2018 12:24:13 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v6 02/17] dt-bindings: arm: Add new Allwinner ARMv5 F1C100s SoC
Date: Sun,  2 Dec 2018 23:23:36 +0300
Message-Id: <6fa3cf509379a0888388821eef3e322c014df5b8.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_122427_522298_D890ECD1 
X-CRM114-Status: GOOD (  11.61  )
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

Add new Allwinner ARMv5 F1C100s SoC's compatible string

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
index e4beec3..f9ddc05 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.txt
+++ b/Documentation/devicetree/bindings/arm/sunxi.txt
@@ -18,4 +18,5 @@ using one of the following compatible strings:
   allwinner,sun8i-v3s
   allwinner,sun9i-a80
   allwinner,sun50i-a64
+  allwinner,suniv-f1c100s
   nextthing,gr8
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
