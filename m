Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899CBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:04:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A0C82190C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aQF7bbtV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="r986BO1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0C82190C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=H+IYvo/4FOonZiDhwpWzJpjUQ/kQsd3lDfMTDPGMPDk=; b=aQF7bbtV8rBj3dBCt/AIQXEvW4
	1Dhq3ii2LKJMUNoUxPbe5DV8QcNx++kZc6OZ3z/fTCfR5O5okW9aISGbxZa8+Cwktz/fYJabGmuBh
	AjY9InWMU4tzcOh5xwG26ozAWs4R4iVHbPehOQdGttWYLlYU5YKsQQxXLPcB46ZWnF+G7i/LH2Bg/
	Xru06y7d/3vvvmWvhL5MWStLmHCKjYLkd5ghlD4uK5vLqTW6B71uwe6Vu26/jdzkl8ccUj/cvoZ72
	fvYc0n0O9aPeL1qw5c2odtOmr+gMlOVWo78BNty6WxpiKrb88mggNC1LJOSZCeUmtg5IGwcmphfMH
	dUXDDyNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvjWc-0004hA-Er; Mon, 18 Feb 2019 14:04:02 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvjWQ-0004WZ-Tn
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 14:03:52 +0000
Received: by mail-ed1-x544.google.com with SMTP id f2so13868327edy.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 06:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=yRbFDaxWpy1WZcEaSiXFGy4r6+XphTOi/wCgftAJFLc=;
 b=r986BO1Bzxok2V8E1eD37WYjzK2SBEteAVMs6PJ+GyfPBhlMmSQusvvsx60zQIua0j
 HEtFc2Cbjy57gwxNqqBkJTEfiend4iuH9mrGHHfaPOHdhozsGK7yXfjWIX5pNCwVJfzf
 Hi7DRrqfs8UCedwzmElcbeS4l2np34oQ+BmVxFRzAKISQbXvMikWdJV9/RWIbEHMnp8t
 B7CuoCwlSNrRceunX/D+BNQP/vorwExi5Q3k3KPWa29v4DiDhCkN4xsC777AFI8ZwwZc
 VzHmLw2/DQxlDztf1WTkxkdvMn9z8ND9aIuIVSjPg6LbZqJVTe885POnip9mNLyZWwYu
 I2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=yRbFDaxWpy1WZcEaSiXFGy4r6+XphTOi/wCgftAJFLc=;
 b=Jc9CSxXqWGpVBNxANUBG0LRR+HG7WFCxAL/fkDfgPT3m8dl9L5mrFjCaUYAAGHl66E
 lz13El8J7sk3D4E1A715+fzgyeSIxoA0OWKjmnR9gROCuhGCkjkpaDSlNgkxB65pceEO
 azaqAky0K5yem+mIzDm4ONWdzzWfP/dVX1zRi/xi/FoZheY4jCmIYDCu6pOZk/JInkKt
 SaWP8ncOe1CWqhT9jIxezNpqg6D6cgLxNODzdHih1RMUqGUjLNDHfHOcgCCa/IeLYe4A
 l0aa3iPFDwf5bzAHCQ2aqpUxgS1Lm++LuRcZ3mj7JW7BLFzxuBEO1gIZ2AYru6q11MGc
 jLqw==
X-Gm-Message-State: AHQUAub2Kgnrja8x32NercPxHfZlBUYfnU4tPGbiVedV3w+FjFt4dg3a
 wXB2wNvZPPUXWg/1Vt5PfjD6/w==
X-Google-Smtp-Source: AHgI3IYj7ckxoDKJl3E4bX/rvyXEihO7cEuEYlmgZecPBrtn60bN0Tp19Cvro+2kMS5QDOx/dl2T5Q==
X-Received: by 2002:a50:b527:: with SMTP id y36mr19649567edd.83.1550498629140; 
 Mon, 18 Feb 2019 06:03:49 -0800 (PST)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be.
 [188.118.3.185])
 by smtp.gmail.com with ESMTPSA id w48sm1421606eda.88.2019.02.18.06.03.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 06:03:48 -0800 (PST)
From: Patrick Havelange <patrick.havelange@essensium.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Esben Haabendal <esben@haabendal.dk>,
 William Breathitt Gray <vilhelm.gray@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/8] drivers/pwm: pwm-fsl-ftm: use common header for FlexTimer
 #defines
Date: Mon, 18 Feb 2019 15:03:15 +0100
Message-Id: <20190218140321.19166-2-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190218140321.19166-1-patrick.havelange@essensium.com>
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_060350_954763_4392658F 
X-CRM114-Status: GOOD (  12.80  )
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
Cc: Patrick Havelange <patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This also fixes the wrong value for the previously defined
FTM_MODE_INIT macro (it was not used).

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
 drivers/pwm/pwm-fsl-ftm.c | 44 +--------------------------------------
 1 file changed, 1 insertion(+), 43 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 883378d055c6..f21ea1b97116 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -22,51 +22,9 @@
 #include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/fsl/ftm.h>
 
-#define FTM_SC		0x00
-#define FTM_SC_CLK_MASK_SHIFT	3
-#define FTM_SC_CLK_MASK	(3 << FTM_SC_CLK_MASK_SHIFT)
 #define FTM_SC_CLK(c)	(((c) + 1) << FTM_SC_CLK_MASK_SHIFT)
-#define FTM_SC_PS_MASK	0x7
-
-#define FTM_CNT		0x04
-#define FTM_MOD		0x08
-
-#define FTM_CSC_BASE	0x0C
-#define FTM_CSC_MSB	BIT(5)
-#define FTM_CSC_MSA	BIT(4)
-#define FTM_CSC_ELSB	BIT(3)
-#define FTM_CSC_ELSA	BIT(2)
-#define FTM_CSC(_channel)	(FTM_CSC_BASE + ((_channel) * 8))
-
-#define FTM_CV_BASE	0x10
-#define FTM_CV(_channel)	(FTM_CV_BASE + ((_channel) * 8))
-
-#define FTM_CNTIN	0x4C
-#define FTM_STATUS	0x50
-
-#define FTM_MODE	0x54
-#define FTM_MODE_FTMEN	BIT(0)
-#define FTM_MODE_INIT	BIT(2)
-#define FTM_MODE_PWMSYNC	BIT(3)
-
-#define FTM_SYNC	0x58
-#define FTM_OUTINIT	0x5C
-#define FTM_OUTMASK	0x60
-#define FTM_COMBINE	0x64
-#define FTM_DEADTIME	0x68
-#define FTM_EXTTRIG	0x6C
-#define FTM_POL		0x70
-#define FTM_FMS		0x74
-#define FTM_FILTER	0x78
-#define FTM_FLTCTRL	0x7C
-#define FTM_QDCTRL	0x80
-#define FTM_CONF	0x84
-#define FTM_FLTPOL	0x88
-#define FTM_SYNCONF	0x8C
-#define FTM_INVCTRL	0x90
-#define FTM_SWOCTRL	0x94
-#define FTM_PWMLOAD	0x98
 
 enum fsl_pwm_clk {
 	FSL_PWM_CLK_SYS,
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
