Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14C9C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:52:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78CA82084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oXpRrB05";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YNWH1F0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78CA82084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qMnLl9nuogFyIN07HuDobVplJrgcgfrmfvxQBAQnZKI=; b=oXpRrB051vJVz7
	hPglK53pqXlLByxF3TqUHzOlqu+YWJ2uQXaIR+oNr/MXsBO6ob/4MqebZvt2iyQ/VMaWoE/9H6XiR
	S/5dTTAlDcK2uwsVNtpfUVkqJ40QqJItrg5lh95ELtrOJ3v5YsFf7eHroPBm4IFJ47rFzDNVuB4r7
	yj7o7a7KlWKHUoMtk/i7r5+KmJPq0OrpmlUVnh4LnZYz/ua5k5yeCcIVeSo5eOp5nAOifuSJduE+M
	kwzMyGKktdaLEJn3woQYVPgoqtQKhP4GgS5N50GQMAXuPB8tFeE8Bi3DqT5r2Wgv8t6hMwi8Iyvyq
	cYDba0ts+T9rZhaIEi9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqPgN-00073h-Jg; Sun, 03 Feb 2019 21:52:07 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqPXK-00005Q-Bt
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 21:43:03 +0000
Received: by mail-lj1-x243.google.com with SMTP id t18-v6so10067622ljd.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 13:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rXBAcdvBpxh0mmOpvAIaV+ZEaPAyDpVqFL3/7RiGnT0=;
 b=YNWH1F0bcerghQOEpAwFgtOBt1qpM5u5Z7oqz+QoZxPZYmg//ZiU2rWWecsG7MIU9t
 n9bQvNl/7g0CcOC6HoARONV3u6ik+F0xgvBixGudRjV9mheQumhDtvmf+warvbiU7X3m
 qoHz6vulssWSb3DuNMGHJpeVdgpFcX8vg07I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rXBAcdvBpxh0mmOpvAIaV+ZEaPAyDpVqFL3/7RiGnT0=;
 b=WnwGjX/ryMrxP4N+Zby/Dgqhp+BKRYTra3rdaph0bVzPasrEIXGXEuaemN6WY4pUY+
 07r9gnnzJ/eeoxLgiah9GIklyYZYD9+LAxpxV8iNjY2KDCOvNar8O7RVPH29cd9YyEBP
 ZX0HXafEypBZwfIAkAXOrOmZJsLzWVVxx4WiI3QzX/RDgH7Dv9Pc5SGptr1DC4Kz3XKF
 Ik7we38leiukqyRNNyec00hy+dPfKw0vhKn8FDoB4lRkCgsiSf2QmPUGm8OdYz0G/icZ
 +FUoH6F6+6jcl75ZqTJbMkZLdWBAvVlq0duxEuP6EPfzq0wQYW+5bcYfCNA6enniJU8n
 mxJA==
X-Gm-Message-State: AJcUukcjSQpHpFSFdX+ZEdXClfhofiAeppRa7fHOV9xZWL2F1SgrEbqc
 LAiVS+4PmDlwE5drxrOcZWNeugNPWJc=
X-Google-Smtp-Source: ALg8bN6oKqai3hIVgB7Fw+5r/Nxbc12aOemB0+pV+eO2Yw7f6yCtBdw+UGBz3ATXOPAzschIYDuNwQ==
X-Received: by 2002:a2e:568d:: with SMTP id
 k13-v6mr40431229lje.105.1549230164446; 
 Sun, 03 Feb 2019 13:42:44 -0800 (PST)
Received: from linux.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id 85-v6sm2456868lja.16.2019.02.03.13.42.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 03 Feb 2019 13:42:43 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 11/17 v1] clocksource/drivers/ixp4xx: Add DT bindings
Date: Sun,  3 Feb 2019 22:41:59 +0100
Message-Id: <20190203214205.13594-12-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203214205.13594-1-linus.walleij@linaro.org>
References: <20190203214205.13594-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_134247_015158_6FD1E0EC 
X-CRM114-Status: GOOD (  14.33  )
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
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Tim Harvey <tharvey@gateworks.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Olof Johansson <olof@lixom.net>, Thomas Gleixner <tglx@linutronix.de>,
 Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds device tree bindings for the Intel IXP4xx
timers.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Clocksource/timer maintainers: I am requesting an ACK for
this once you're happy with the bindings, as I intend to
merge all of this IXP4xx rework through ARM SoC.
---
 .../bindings/timer/intel,ixp4xx-timer.txt      | 18 ++++++++++++++++++
 MAINTAINERS                                    |  1 +
 2 files changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.txt b/Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.txt
new file mode 100644
index 000000000000..5b93477bb6ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.txt
@@ -0,0 +1,18 @@
+Intel IXP4xx XScale Networking Processors Timers
+
+This timer is found in the Intel IXP4xx processors.
+
+Required properties:
+
+- compatible : Must be
+  "intel,ixp4xx-timer"
+- reg : Should contain registers location and length
+- interrupts : Should contain the two timer interrupts
+
+Example:
+
+timer@c8005000 {
+	compatible = "intel,ixp4xx-timer";
+	reg = <0xc8005000 0x100>;
+	interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index ec318f09540c..775a623dc91d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1651,6 +1651,7 @@ M:	Krzysztof Halasa <khalasa@piap.pl>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.txt
+F:	Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.txt
 F:	arch/arm/mach-ixp4xx/
 F:	drivers/clocksource/timer-ixp4xx.c
 F:	drivers/gpio/gpio-ixp4xx.c
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
