Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33897C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:36:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E88CD20700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RF/7LkyC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0H7/W/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88CD20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yp7MyFkqRFfUvi87cUOhOF7HZZHqCH3jkKpf6YLTjAk=; b=RF/7LkyCqR5ewx
	mcn5vXgImGqx9IH6vJ0FJ4gZGnXA/5JsKfsUz9M+GjJ3cDUU82dCFZ7fRKHw+VWuf9kJxNhV2a+/F
	YmuGoKnMGaKpNHlP74Gq3ZqpYoeNuAT8BImPH1wyoQkpXAjEs+HXwkpTtWRrlM/xaTAkt2bHGYcqz
	r4jdUOot8IFiK4lXNJtf2P1vvX6pKTuNtg55T3Hu73hxNiL5bSugrJq51bKicF/vboDTy6EpdjlPK
	UDdEdKYSuF7fqeo7WQ7u7tmUy5kolm3NOdOu25rj7FUf6I7thEacVHB9NdolcNIjAxIRfLWPtumNY
	u9Pov+on3grFxD63NR8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxGcZ-0004Rr-Gu; Fri, 22 Feb 2019 19:36:31 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxGc0-0003o2-4E
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 19:36:10 +0000
Received: by mail-pl1-x642.google.com with SMTP id p19so1542288plo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 11:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s9q3gbd6+FFh+E4/n8m7zDglopcsbqNaagda1Y5Is1M=;
 b=E0H7/W/9+Wf7PUgt2VptNB69Q+9Gny+RBJ/5biERUq5qivm+sMpg/x1VxXQr4gN2G6
 aBcaoouwvS+bPxAfh3bq8IQXSD9OtgnyTJx6f6WV+1Lv4e4/rxO+g2vSmKYV9Tp5rQxu
 +Dqynre9s+MzK6BdHBTxNEJ2zfBKeC10T4ZrJshqMxm/KGepvS/CRQeUFoc5Ny9FnGW7
 CUSIyFCjH4aJOnOyk9TTUwtHq048PylZHuYuRwyEnnNGfweV9vxQtH+TM599Cw+yzK70
 mDy2ReYX2d7aPgRtvqM3Nmz18gmD0kvpiPpUkg19dq+bWxL4BAmjssJ/4PE68d5+k3vD
 MyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s9q3gbd6+FFh+E4/n8m7zDglopcsbqNaagda1Y5Is1M=;
 b=PD6xNLTnwmu6lL1xX/ycEFLYPYeOv/3BBnKGmfq9QHvATiiUq5NN+NG42vOzGPGtmp
 sjCiikmrRVQT59ilyf4HC78Lesw2SceEDbPgNpOdtioA1rWNLkfpapF1Wx4mYRxDFT/z
 Sg5AiSkRmiYL3g73snG91/KMkt1YAS33JCVKcWvI7JbLYMEsAUYNYyQXOSJy7LHv7O12
 elomcfQYkLZSsvUmqd6IuwxZ/+bhdh+0OH+ERaT5Kh6joGut2YDyqg+x2bgHCyr7nlWv
 EF+mNe3z3zAQrm+AzzdeVlK55IO9jz0BgBZYpj8NdqHl1ma7dqKsSzBha1PRgX6ktDxr
 +vrA==
X-Gm-Message-State: AHQUAuawKCqsbRwJoMCmRwVP8QqyIncafojLc/lVJLyVbyCE0fGbsW1k
 QGWVagi4c0FsWu+fgN0hx4o=
X-Google-Smtp-Source: AHgI3IagDA2ESNkuTD51pAeXz6/JGyrW/QEyxf0/GmHYePf/5JcaPtSwMprxlXCIyRIQUBEpN7utzA==
X-Received: by 2002:a17:902:1122:: with SMTP id
 d31mr5810807pla.246.1550864155323; 
 Fri, 22 Feb 2019 11:35:55 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.gmail.com with ESMTPSA id e21sm7687190pfh.45.2019.02.22.11.35.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 11:35:54 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Robert Yang <decatf@gmail.com>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v6 4/7] ARM: tegra: Set up L2 cache using Trusted Foundations
 firmware
Date: Fri, 22 Feb 2019 22:34:23 +0300
Message-Id: <20190222193426.10747-5-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222193426.10747-1-digetx@gmail.com>
References: <20190222193426.10747-1-digetx@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_113556_644485_B18040E4 
X-CRM114-Status: GOOD (  12.84  )
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
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tegra30 L2 cache should be initialized using firmware call if CPU
is running in insecure mode. Set up the required outer-cache write_sec()
callback early during boot using the firmware API, it is always a NO-OP
on T114+ and is NO-OP on T20/30 if Trusted Foundations firmware node
isn't present in device-tree.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/tegra.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index f9587be48235..1e89cfefbf68 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -38,6 +38,7 @@
 #include <soc/tegra/fuse.h>
 #include <soc/tegra/pmc.h>
 
+#include <asm/firmware.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -74,6 +75,7 @@ static void __init tegra_init_early(void)
 {
 	of_register_trusted_foundations();
 	tegra_cpu_reset_handler_init();
+	call_firmware_op(l2x0_init);
 }
 
 static void __init tegra_dt_init_irq(void)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
