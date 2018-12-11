Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF5AC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:08:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D0720811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ro0yrfIC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AIxhl9qH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D0720811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vYJr189Jw9vauV94uLufuuNyjFF48O2HvSk16eFKue4=; b=ro0yrfICn9POqA
	/ZhHXEUDDEPCd8Pf92DpEWq+EQ/1t+XVoR2T+/q5CvfMBIGXj47hKE+c5RJ4+bSaQg9xNU+JTtLaX
	WCbUhUFVhyxvH1jluC0KPy0B2NwsGLchufTqBVdoZScUeUBeQ3ABM/R/wI0LP+kCwojpy6ZFCDHBY
	9iz9jE9eJ7PrEqZkeUWwT58HEE+flnnBCfzZGJwaC/zU8lAJBAUuANZRmjkwnlK2q+ddlZW69WNVl
	XOgfwrxlFSYVvzr5Kln7mTckhYKTRG3eN373RrAe29HbbHPWUx9BX6e3w6uVklVlVGdCpJzC5VwNk
	KViPnJ8l3M5zhZP37pfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWd5q-0004xC-1T; Tue, 11 Dec 2018 08:08:38 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWd5Z-0004gj-DP
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 08:08:24 +0000
Received: by mail-lj1-x242.google.com with SMTP id g11-v6so12124039ljk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 00:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XFMX7pwr67TprPCa2NffBIqRvAhF7bv/aFoxxzEpeHY=;
 b=AIxhl9qHKHq6SyM9un7zQhJX2hIIrjSO44oDT2CLINcICCTpTQj2MMhE7dlJaD/2Xb
 xavv5CwxdWV+4Oz0pqTNFJdnb1Zwb7SuUwUjsaRmwZqNoe4MkP6yfK6pzMzkR2AFR8T6
 8aAJjcUtFyXLMDyl4Vr7PY+Smu8ojiYfFjSzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XFMX7pwr67TprPCa2NffBIqRvAhF7bv/aFoxxzEpeHY=;
 b=YPX3eo9JGN9Lf3QsttAFL6Xzxa9MUfP/ziaCrpq/DyG5B7/qOu0laMbXHqw8zG/QRl
 7MRBT2uRBhtelkx3N+2ImXGIOMY4cP50GsPFK1dpG/pOZw6+6Pke28wgsurlcffYTvTy
 FyJFQr8Ob0arUbhbOoJSs7WlxyOeNFnRyXMHYaTfk+MspUffouEc2naDPE13amzVkYga
 miTZQRO63eVUoQkOwgyi6WoH6nMLlid+bFw6fSaYw8gt8b1ArFVXZitYnd2Y0+9sQ4Wy
 HenQv6IS1KwTlE+ogEPDW9h7LyeXKOqx53EdF3bMDXIwAVb88qNK20MKd95Cg3q+jX5s
 1uBQ==
X-Gm-Message-State: AA+aEWYKFXS6EWwtccSrW+gwK6n/yh/pVUO5lxGDD30VD7LhE4mSaEMx
 PJefmjX/dAwuaH7Zh9fv2X0J+g==
X-Google-Smtp-Source: AFSGD/XBsDBHG0+8UeC8MHlRjxreZ70ptctvGcXVqvsDQrrjiD9+AW4L7rYz8CmawHfzopIf+txrHg==
X-Received: by 2002:a2e:7011:: with SMTP id
 l17-v6mr10017823ljc.147.1544515691670; 
 Tue, 11 Dec 2018 00:08:11 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id l21-v6sm2524424lji.6.2018.12.11.00.08.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 00:08:10 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/5] ARM: actions: Drop unused function
Date: Tue, 11 Dec 2018 09:07:57 +0100
Message-Id: <20181211080759.3150-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211080759.3150-1-linus.walleij@linaro.org>
References: <20181211080759.3150-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_000821_742274_56CCD3AC 
X-CRM114-Status: GOOD (  11.22  )
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

The owl_secondary_startup() prototype isn't used anywhere
and seems to be some development artifact.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-actions/platsmp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-actions/platsmp.c b/arch/arm/mach-actions/platsmp.c
index 98fbcaa764a5..b66a768afedd 100644
--- a/arch/arm/mach-actions/platsmp.c
+++ b/arch/arm/mach-actions/platsmp.c
@@ -38,8 +38,6 @@ static void __iomem *sps_base_addr;
 static void __iomem *timer_base_addr;
 static DEFINE_SPINLOCK(boot_lock);
 
-void owl_secondary_startup(void);
-
 static int s500_wakeup_secondary(unsigned int cpu)
 {
 	int ret;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
