Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342D1C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:51:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE782084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="meZGehJE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQVx4c9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE782084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w2ioDNmnJEDoxIx5grJNAn551SMrt3YW9wkvhkpBzmY=; b=meZGehJEL3kSqB
	rPoxZ75KktjYhukBJ3y+1NxNu+Wu4r+c6ptJTrDKGxvreXjfT8+a+tkBOYpEPBZp/EsTCoLmFHEWk
	OU0usqFW0TiRDzXaw2h5xvaRejYdjo9cqz37kHP7ldZfe8KQOVpGC2Tk/leUXPoqbH6IGHrT6o62B
	9XDAWOFMwLu98d2FwaRP203+oaJJxblpr1ozGbVSBMGXItaqOxdoPaqHMCA3MS6/bLQTk/jQiTc5w
	qE9lg1sWIJLdc7jS8gu7H92gIPoscEOa8oOvY9u7oWXZSXSADx90bA2Ut/q2vkUc6n+5ahKE34LDk
	0sRSI5+B3wqfz0aBUVMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqPgB-0006pF-5X; Sun, 03 Feb 2019 21:51:55 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqPXF-0008Rn-Kk
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 21:43:03 +0000
Received: by mail-lj1-x242.google.com with SMTP id l15-v6so10018153lja.9
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 13:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B7FFvSbFEdEOlGQG13PaDC6yVK3bQrkjP/q2THoicDo=;
 b=aQVx4c9vEytpnRkyN0VA2Oqd/uApzi25mROXs5WT1n80W8TA5A4wUaeiK/ZFG9vmbL
 aTvi3txYKuvN6IpzGE/AIx49yHigNE5OsEZC0e2Gs1zvCwUEt+I/Fl/buYoQqA2WftWg
 QnF0AMR+tXRzgP4y9gH8YD9xXNNUnkLcxGL3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B7FFvSbFEdEOlGQG13PaDC6yVK3bQrkjP/q2THoicDo=;
 b=IXZ/hIw8TiM1wvSvwhEIQeX3izd336tATCHn0M4nXhL4ffc+r2+VOiymH2jc3N7p4m
 KWn0X8lH+BW+a+Ins1IutkApXjNxhlWyJUiI24XgJKXfmAtY+Q3tSoYd3k9i0jaAO7xe
 x+wB9ODwWbyxAvYsVzdvcqAFpEYu3hOEvHEAzCzRASza2LSZGEWzia10QsIVsbM+cv9F
 2aiQBl/zGc4ILgsi5WBhUQgTWaYXTx38BAmPJ75NmiRiEcQaJuSFKnfzxdhyrbqQ6n9r
 IzqVfiBiUF9DRta15v83xwXDLIP7cxGtdVHHFnXd2Rq0fvWIliomj5kGytoiREtBX8WV
 qVaw==
X-Gm-Message-State: AHQUAua2kWn2CHhtr5+WgY0fSm1dwbjews0wzO79tESz03Jr5sqmQAFz
 GWrcjzjE8i057Vs0clQRJXuHBRGAB4M=
X-Google-Smtp-Source: AHgI3Ia6k0xS4ZYGOPNAbm/YdU9Y5/CErJo3uLVPqSxE7ue3hUtGLGWsFoO28XKXEVp+LcJ6UDaRjA==
X-Received: by 2002:a2e:744:: with SMTP id
 i4-v6mr14861923ljd.140.1549230159428; 
 Sun, 03 Feb 2019 13:42:39 -0800 (PST)
Received: from linux.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id 85-v6sm2456868lja.16.2019.02.03.13.42.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 03 Feb 2019 13:42:38 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 09/17 v1] irqchip: ixp4xx: Add DT bindings
Date: Sun,  3 Feb 2019 22:41:57 +0100
Message-Id: <20190203214205.13594-10-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203214205.13594-1-linus.walleij@linaro.org>
References: <20190203214205.13594-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_134242_253116_FB252AC7 
X-CRM114-Status: GOOD (  14.80  )
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
Cc: devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
 Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>,
 Tim Harvey <tharvey@gateworks.com>, Olof Johansson <olof@lixom.net>,
 Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds device tree bindings for the IXP4xx interrupt
controller. It's a standard 2-cell controller.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
irqchip maintainers: I am requesting an ACK for this once
you're happy with the bindings, as I intend to merge all of
this IXP4xx rework through ARM SoC.
---
 .../intel,ixp4xx-interrupt.txt                | 33 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.txt b/Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.txt
new file mode 100644
index 000000000000..70ee93b9a6c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.txt
@@ -0,0 +1,33 @@
+* Intel IXP4xx XScale Networking Processors Interrupt Controller
+
+This interrupt controller is found in the Intel IXP4xx processors.
+Some processors have 32 interrupts, some have up to 64 interrupts.
+The exact number of interrupts is determined from the compatible
+string.
+
+The distinct IXP4xx families with different interrupt controller
+variations are IXP42x, IXP43x, IXP45x and IXP46x. Those four
+families were the only ones to reach the developer and consumer
+market.
+
+Required properties:
+- compatible: must be one of
+  "intel,ixp42x-interrupt"
+  "intel,ixp43x-interrupt"
+  "intel,ixp45x-interrupt"
+  "intel,ixp46x-interrupt"
+- reg: The register bank for the interrupt controller.
+- interrupt-controller: Identifies the node as an interrupt controller
+- #interrupt-cells: The number of cells to define the interrupts.
+  Must be <2>. The bindings follows the standard binding for controllers
+  with two cells specified in
+  interrupt-controller/interrupts.txt
+
+Example:
+
+intcon: interrupt-controller@c8003000 {
+	compatible = "intel,ixp43x-interrupt";
+	reg = <0xc8003000 0x100>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index a2fb67b75026..ec318f09540c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1650,6 +1650,7 @@ M:	Imre Kaloz <kaloz@openwrt.org>
 M:	Krzysztof Halasa <khalasa@piap.pl>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.txt
 F:	arch/arm/mach-ixp4xx/
 F:	drivers/clocksource/timer-ixp4xx.c
 F:	drivers/gpio/gpio-ixp4xx.c
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
