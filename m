Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4325EC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:34:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 115D7217D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RXfjudD1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWe9AOIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115D7217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=r4CCLHWKzch+94zz+kaeOxcRGv8HJet0qmYWfHNcRvE=; b=RXfjudD1wkkGVkc+yqKu/x/El1
	22CuLdV6WOofY1+HnsMvee5lkUym3ANYF3dokh1nio9WiK++WLPXiqQr4bfZTMmtxLOZhpD69cpN9
	g8eUAQQIesubrGDkzrGU7hFR3s4Cp9u0j5RNRmNoADJBd97P1u/Y6l+C7Zc4OSsI+ImgApIpkTGU8
	+heHkKeLrh8xGLy74T4DkHXga1r0QDJIrZSH7QthaChcIDjySBR06pceDsbUrLhe2pZjB0Lzwu3B2
	+FToS2ysrTrs9x+JjP0wApJn25NpRq8TfrSDIZTls5tJl2YrC5YUyNPby45veG+njmxRFKRMJ6WPo
	ARvUa17w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm6Uc-0004pX-BV; Wed, 23 Jan 2019 00:34:10 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm6UK-0004ZV-FH
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 00:33:53 +0000
Received: by mail-pl1-x644.google.com with SMTP id y1so202129plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 16:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VqOzV70nxn1aW4YfYzttzB6N0VuBYDY1Aq/89e4xjMU=;
 b=AWe9AOIkv9l1RZqN62H7Kq/OQ3+m3b+nwSJGFdCtsD2hWxr2SH/qrS+AkJz4Q5X48j
 kVIpYm4ClBd0baxCP+wOw9GvQEdi1HK+iKa8vVoUHj9xY0c7p8w8xmDL0FO6QCdmfwjO
 Xo3D6m/1OWdZ/fEU1BWBzPdW2i0iM0b8wh1uwFSLmMgPZc9p2+ksaYTKDgJaB3iqZyf5
 WTPgNC7ihnCSo5gW0O57jCsOMEuxfJyLg/s4kUgT0S0Hey9d2w2vUeKrRLkGBOLA2bnu
 zya8z2Pg9ckp9IVknWH3+da40NVWIjNB1kDhh3QlUuVLlz4pcVjuYLZItkusWxnn0ZHO
 lGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=VqOzV70nxn1aW4YfYzttzB6N0VuBYDY1Aq/89e4xjMU=;
 b=cj1aJjydp/VBhVGaP3nv1tWeC780YjUEGFx1kSjmgZ8IrOdCjUzVRjAnDFnTsjosDM
 oefaMqxoL1k5gF0lqFSkhFTIQlHLPiHug3MVzaCX84J+7tgeBtH7smCwxnBAQ4HC+NuC
 fgYffK/hiSonkr/lcjOwf8mXvXQZpdP4f7onOhyszKk/2TvwEoJbrPargpI0ox6/UBpL
 pAvdFeeffJkfuTilLTcIrujS73x9yL6modeKIifllws8XadmHJg+lvvGJSjZkftY0EJA
 GmuGnhKiXi0AuX3csmNkQSYr9Qv8i9da9P+teKLsPVp8K4OuBEkbeCrgNZB+UV8M/P/5
 GHvg==
X-Gm-Message-State: AJcUukfEZSm3M7r0UCnHg7zrf5vWwjO/VMT4umYeLsPcoIYZ1RUiOiDf
 2emilKufhgaBKenipOOMr7Q=
X-Google-Smtp-Source: ALg8bN6l8JdqmLtMFRJekrpeUWsbzJiGZHxNvPvvu5yMskwWQ2j3uRemVufdSEJs3e7/B3mrCwryCw==
X-Received: by 2002:a17:902:a5c3:: with SMTP id t3mr92596plq.117.1548203630540; 
 Tue, 22 Jan 2019 16:33:50 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
 by smtp.gmail.com with ESMTPSA id e86sm25465257pfb.6.2019.01.22.16.33.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Jan 2019 16:33:49 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH reset-next 1/2] reset: brcmstb: Make it tristate
Date: Tue, 22 Jan 2019 16:33:44 -0800
Message-Id: <20190123003345.13750-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190123003345.13750-1-f.fainelli@gmail.com>
References: <20190123003345.13750-1-f.fainelli@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_163352_506940_C83AEF26 
X-CRM114-Status: GOOD (  13.35  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, sfr@canb.auug.org.au,
 rdunlap@infradead.org, paul.gortmaker@windriver.com,
 Rob Herring <robh+dt@kernel.org>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, linux-next@vger.kernel.org,
 Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The driver can be built as a module just fine, so let's make it
selectable as such.

Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/reset/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 1ca03c57e049..d9a02b7f90cf 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -41,7 +41,8 @@ config RESET_BERLIN
 	  This enables the reset controller driver for Marvell Berlin SoCs.
 
 config RESET_BRCMSTB
-	bool "Broadcom STB reset controller" if COMPILE_TEST
+	tristate "Broadcom STB reset controller"
+	depends on ARCH_BRCMSTB || COMPILE_TEST
 	default ARCH_BRCMSTB
 	help
 	  This enables the reset controller driver for Broadcom STB SoCs using
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
