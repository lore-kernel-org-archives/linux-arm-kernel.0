Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E8FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:10:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D9AA2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NaKB9Y7t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GICbLcBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9AA2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=VLaqot+y4YtDI0lioG8awq186qn+Quuz8mZTphhW35E=; b=NaKB9Y7t11rrm3
	LIM94kJDtn49xCxeA3m6QFhAe24MGzIi/PMAcWq4ZyxqCHzr3TPCax1F7tmlDkUXmBybcuWlVbSYc
	9qK6MJqX4Z1PsfXL18ZQWs8NCcGWk5XjYb3UxRmr1JL/6P4UEIc8rpd5vXN+uo041PZX3gK6/+UvC
	Tj1GIqnJn9irne6Qy2LYTTIU4kblUrPK9l3D+6jaB90X9sC+kgeTTyjzN/HGvkWLpMhC3dyxL8PK3
	7HRmr1ro2WdfQkG8a6OpRIuv7+aOxGpWHxtccVEYJKlVXOoI+Fms0cnoqX/ApRC+ZCpj/fla/912X
	M6GkSS5yIsO8w9thjsWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gge2V-0007bf-9W; Mon, 07 Jan 2019 23:10:35 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gge2R-0007bF-J6
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 23:10:33 +0000
Received: by mail-lj1-x244.google.com with SMTP id v15-v6so1774517ljh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 15:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DaUraNM1q4KO24w1b+/8Y+EUn93dJTQx3DlsxwKwogM=;
 b=GICbLcBWx3ELTNLJJ+CdRQaV8wQrc+HTtd76txKu+8k5QAuJ7edpaU2wEYpbLR9RjL
 AcvUEOGxbIETOaxJlhlwAlivxGVea4KfqbuELPLubbkJiEybHAlUeb5l+u0TbW77LL0+
 iBrDOK/Qn5ZTNgK5nTpqI8ghjdRfsfytAgj/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DaUraNM1q4KO24w1b+/8Y+EUn93dJTQx3DlsxwKwogM=;
 b=AHtB+kqJfzZyhJMgRyWyjKTeip11d5dLQ4C8a0xs2Jq4UBiBcBwTO0KvrfNPdIkt9Q
 xypx7/EhRwL8YUZlJnCAKmUP2H+KP9DfhkiQ2FXjzBlwG5rFHONqgbzfDop8cAKd8djD
 O+kC3vkHi1azIBK00A4b7z71fI/cN8/zfqk+T7teiLadPyVZcFHe0XO8QKaPmlC5Lba7
 2JdQU9mKk9ohsdVseMptpezqi40vs5Zz8RbyZ4a5ItnWj9rJ8dhqPaeLOeslvXjKGoAY
 Lo9q4sQKOg7+rAKN+UXuSpH5kwLgRDAEApsxBlVH+Bgi4NEJfWrxR72aF4cPdJJOF9Qb
 nPKQ==
X-Gm-Message-State: AA+aEWbsHx4m8oQ4D8KLv2YJ3lBfNYRc9rPmYFcMi+xpEF6scqV3JcR4
 Go9IcutNMQfqMCaSmZe5YHSbjw==
X-Google-Smtp-Source: ALg8bN44JOlskRYxjZK6PTvykcL+QL5jjeIdOIzR6A46fAVDhVWKbirTgPPKmwH4KC2Q9XVCAa99nQ==
X-Received: by 2002:a2e:8992:: with SMTP id
 c18-v6mr35006659lji.17.1546902628519; 
 Mon, 07 Jan 2019 15:10:28 -0800 (PST)
Received: from localhost.localdomain
 (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id f11sm13035343lfi.12.2019.01.07.15.10.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 07 Jan 2019 15:10:27 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH] ARM: dts: kirkwood: Fix polarity of GPIO fan lines
Date: Tue,  8 Jan 2019 00:08:18 +0100
Message-Id: <20190107230818.6020-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_151031_655427_FB240484 
X-CRM114-Status: GOOD (  12.55  )
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
Cc: Julien D'Ascenzio <jdascenzio@posteo.net>,
 Linus Walleij <linus.walleij@linaro.org>, Guenter Roeck <linux@roeck-us.net>,
 Jamie Lentin <jm@lentin.co.uk>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

These two lines are active high, not active low. The bug was
found when we changed the kernel to respect the polarity defined
in the device tree.

Fixes: 1b90e06b1429 ("ARM: kirkwood: Use devicetree to define DNS-32[05] fan")
Cc: Jamie Lentin <jm@lentin.co.uk>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Julien D'Ascenzio <jdascenzio@posteo.net>
Reported-by: Julien D'Ascenzio <jdascenzio@posteo.net>
Tested-by: Julien D'Ascenzio <jdascenzio@posteo.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/kirkwood-dnskw.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-dnskw.dtsi b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
index cbaf06f2f78e..eb917462b219 100644
--- a/arch/arm/boot/dts/kirkwood-dnskw.dtsi
+++ b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
@@ -36,8 +36,8 @@
 		compatible = "gpio-fan";
 		pinctrl-0 = <&pmx_fan_high_speed &pmx_fan_low_speed>;
 		pinctrl-names = "default";
-		gpios = <&gpio1 14 GPIO_ACTIVE_LOW
-			 &gpio1 13 GPIO_ACTIVE_LOW>;
+		gpios = <&gpio1 14 GPIO_ACTIVE_HIGH
+			 &gpio1 13 GPIO_ACTIVE_HIGH>;
 		gpio-fan,speed-map = <0    0
 				      3000 1
 				      6000 2>;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
