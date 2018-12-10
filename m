Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1210C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:17:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87CF220821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TSJkH/hc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qim2WD8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CF220821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qQAop8UbyrF1EFP5HpZBLstjSNo0/F4JjpwWG9hfGTw=; b=TSJkH/hcgXESdG
	lYSjUO/3knrhDaoW/8rp+lAlnIN7PV8nXIWjpbO/S0gvy9gY5jD5nrm+vdsMw0tJtlWz/AaVNwPl6
	q1VwcCaNam+Ryr1xn65ay9bh0mUJp7NRhElnlBSvjt2Csf278gKZ77t0amsLkf+LtXfejSC6i9WZm
	xHY9uTHabqo0JwKd/B9CwltmR1TBvVlmFSJbmWh9FtkVB6PtSIPJjbJEm6yWLoALJcjqYlLP+c1RA
	lybzYM+8UeH94Y9cnH7tSxfbZs2VaGkePrE/q/wZht7zj0IdaTXpM9u5NRWH5uP+xaPc6yBMLe96L
	gKXwhqYCEn8mS0eUXIEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWIcU-00081M-8B; Mon, 10 Dec 2018 10:16:58 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWIcC-0007mI-34
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 10:16:41 +0000
Received: by mail-lj1-x242.google.com with SMTP id k19-v6so9026512lji.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 02:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L3r+GyllezKxmRk8avKRJT8WiYOzJ4+YohMYRD0mJlI=;
 b=Qim2WD8wT6Z2xjDi6CFojn5Zzg/f0qVqH/Fup5I+iEBzBp59CCt4jEo6b21qHFEX6U
 +I021HY7jWLbQARKnCX3tjCXRJjlHTKbhkv5fYpbVMpI3W06c+CX4Ox6J3WsTxs5/YSg
 xvkzOMPHKCC7GYjWio+Gx4Nt3koiNas7e+Edw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L3r+GyllezKxmRk8avKRJT8WiYOzJ4+YohMYRD0mJlI=;
 b=oa9NdnPlXVKjAnBCX31uQ/7zck9j438zLY2f9oDX9DuvkQLdJhLS5FMsz9I6MWrIHg
 uX757v6f1Uvhh+budD77K02bsfjssHB1WlvH60A2AVDvMDkd9J/9zE1Y6XW1YKrzzUmy
 POuIhrv0iHceBpI2LlDJeB1KHYTkbJqxa5+ZOldV67b+V5ulJdueKLUZkDdqklzlpMO2
 Vpb9VzXp0GETmBmmWnVuKiKwk7nMD5RgTqGPTYQu/EglscnUyD9Il0S5dzjpsp/mlsEO
 /N+bV9iNgjVNRxC375rw1JPWIuQfv3PAn4eeqluL9YfUK9Agv2j0R6CCH80yV5uQfF4+
 xCgA==
X-Gm-Message-State: AA+aEWa9RlbVoCMUrHrDlGXFt9YRlRH8q+R1U3Ao7TCWXlL5LJQUZTKW
 uec3lz/HzrcPCyf33Nu1eYRD9w==
X-Google-Smtp-Source: AFSGD/XABui3I6cJt5Jmrbk0HnSHiavqbzjui3xvsGw//eWElLJe8OJ0clkV+hCFNELh554CdvfWpA==
X-Received: by 2002:a2e:9a84:: with SMTP id p4-v6mr6570478lji.73.1544436988115; 
 Mon, 10 Dec 2018 02:16:28 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id w9sm2032939lfc.66.2018.12.10.02.16.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 02:16:27 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 2/2] ARM: defconfig: Switch LPC18xx to use PL11x DRM driver
Date: Mon, 10 Dec 2018 11:16:20 +0100
Message-Id: <20181210101620.418-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210101620.418-1-linus.walleij@linaro.org>
References: <20181210101620.418-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_021640_126329_9520CB47 
X-CRM114-Status: GOOD (  13.71  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

None of the LPC18xx device trees contains any display settings,
it just defines a device tree node for the CLCD (PL11x) set
as "disabled" and no panels are attached on any device tree.

This I conclude that the hardware is dormant on existing
systems, so we can without any problems switch the defconfig
over from the old ARMCLCD frame buffer driver to the new
PL11x DRM driver.

Cc: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/lpc18xx_defconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index 3627495b3dd0..1b72a1af8d54 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -117,8 +117,10 @@ CONFIG_WATCHDOG=y
 CONFIG_LPC18XX_WATCHDOG=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
-CONFIG_FB=y
-CONFIG_FB_ARMCLCD=y
+CONFIG_DRM=y
+CONFIG_DRM_PL111=y
+CONFIG_FB_MODE_HELPERS=y
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
