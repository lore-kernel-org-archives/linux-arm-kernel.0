Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3B7C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:27:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2F902080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jDMg4idd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="iWoQrZmy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F902080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OOQy8GU3fE16Mml24ZId+ZhDIf8cF7e141LeuugeMr4=; b=jDMg4iddOvrYdz
	HHvxUhi6+Cdtum0NUQS3f0Yxz1m5JamzP6IJHZHNdUraYOPNCE+Vrzxp/C07qirYh1bi7vx6LPIvg
	vEolC8qdiO/q9Rn5KPzxMeyfEjcEWcV2cjxkt8N9787qO3AciMfnfLo61z3AjtWulGK7/4rKObPJl
	DlEVW3N8aCcRJ7IzQ+sGNnlx/AgLsdX4sQWycF2R2ilkU+qe/ch59FxE1uESudkV01OLPHf71YEZR
	/+8Gskr3rjzztZ6yCQkq3rsJIJyixziEcY/NeMEjGK7LAwsqFYV3zEWFxlsL3W2JyE9JmbrcXDe6o
	u1aPdkNaSJdjTEKzPrUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqxwZ-0000Ds-Hb; Tue, 05 Feb 2019 10:27:07 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqxvV-0007Qo-9f
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 10:26:08 +0000
Received: by mail-wm1-x341.google.com with SMTP id b11so2990246wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 02:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YI7lGj6dJe+1jKSiIdUHdLpV0CJALW0y9vtqdcoWmhk=;
 b=iWoQrZmyEXVVLnvOIwM5PQVAvKBfwG5luEZW9f/zDaI2O4VZYwnJCOCGzKO1drdajw
 Jdlx8uDUelkhDw43lxxSIyJGcXjRLaiQDOH9BVqwz0RpcCMstHnysgTHdOqNqVw7AKIR
 AYv0VaP/sxhn1yM5VsVReX1iSJUPvHn5MqhZW0KyemDeSCMwk+S15yELF9t7Tt7yK3Jr
 WQUqzNXLO8AeVqz5eIKSAmPVxMtgP/Wb+mK4pL+g/BSJcq27apRzQkMo1J1ikntkZjzO
 2iD3KHv2uD8Tx3sY+stWfw78sW5kiMD14wUO1UtIlMU1qjIiHrUzGkrACEJoH+1RkFOt
 5+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YI7lGj6dJe+1jKSiIdUHdLpV0CJALW0y9vtqdcoWmhk=;
 b=NJg+puAKWNJiTdoqjJN8ZrVVKwbCZktzqLBW0a/zUT6SYjxBP2nMWpjn/thTTS+jok
 mrBOH0CrjNJQUIPzJtwrcQJ7H8UTYmg06h6BpGh+fi4ZsAQ0/S4/04gVQovKMh1lHNxQ
 e+ItbK0qcbM8gwP7KHmWYHNMNMlBhFezoa9QBbPkBW6xFxLOOTdQ/wpaGThGNj98qOao
 xKKUE36OyGCb+843H8+bksomGDwqh5cNpf2jbxp9n1iEql2RIyl9xoRzo7F4M6liFZuH
 H0TLKgFRDabnBKKZAqCVLUGxRlQQM8iRUvC+jYZbNLl2EfTWj9xwKsaGtqrPzBTQaHY8
 XNDA==
X-Gm-Message-State: AHQUAuYCP2tt0AuM2z+coiF2342b+s+Q0zcLw96cBfoLCf/WNdRH1QQF
 ig+LICsu+vYYBbEtq4rBpq+XfQ==
X-Google-Smtp-Source: AHgI3IZ4nPR1E+2u8hkBsTrLXyxyY8xsYuSmFe0pJpeHIc2QhG7pGS242qb/Zai3zg/pyR/6JexZLQ==
X-Received: by 2002:a1c:ab87:: with SMTP id u129mr3137760wme.104.1549362359927; 
 Tue, 05 Feb 2019 02:25:59 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id r11sm5132396wrx.75.2019.02.05.02.25.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 02:25:59 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 8/8] usb: ohci-da8xx: remove unused callbacks from platform
 data
Date: Tue,  5 Feb 2019 11:25:46 +0100
Message-Id: <20190205102546.29457-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205102546.29457-1-brgl@bgdev.pl>
References: <20190205102546.29457-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_022601_856431_21A7E3B6 
X-CRM114-Status: GOOD (  11.58  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There are no more users of these callbacks.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/platform_data/usb-davinci.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/linux/platform_data/usb-davinci.h b/include/linux/platform_data/usb-davinci.h
index 0926e99f2e8f..879f5c78b91a 100644
--- a/include/linux/platform_data/usb-davinci.h
+++ b/include/linux/platform_data/usb-davinci.h
@@ -11,22 +11,8 @@
 #ifndef __ASM_ARCH_USB_H
 #define __ASM_ARCH_USB_H
 
-struct	da8xx_ohci_root_hub;
-
-typedef void (*da8xx_ocic_handler_t)(struct da8xx_ohci_root_hub *hub,
-				     unsigned port);
-
 /* Passed as the platform data to the OHCI driver */
 struct	da8xx_ohci_root_hub {
-	/* Switch the port power on/off */
-	int	(*set_power)(unsigned port, int on);
-	/* Read the port power status */
-	int	(*get_power)(unsigned port);
-	/* Read the port over-current indicator */
-	int	(*get_oci)(unsigned port);
-	/* Over-current indicator change notification (pass NULL to disable) */
-	int	(*ocic_notify)(da8xx_ocic_handler_t handler);
-
 	/* Time from power on to power good (in 2 ms units) */
 	u8	potpgt;
 };
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
