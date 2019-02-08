Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C146C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:35:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B90002146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IwSo9We+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="v/Ii9SJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90002146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZG9n2b+UG5mLSQHJ13UCgB3EJnQzonYNZf+1tYTS78c=; b=IwSo9We++vn4h/
	OBGgliRHrL2kMFWWTyMuc/48KQXBkXs6YVHWPDj+CngowH+k1r+EPAi/9OG0VWIX94RbARhgyrFN0
	DPl+yHJWemq7ZVmDe314ywIi0dchrvkFJPdU34lYjv+cGyPM4nSQXHrCHpmAj5o9VNvbSH6IacoJT
	ttbXl5MDxY7A62y186aiXcENVKjL8um+YI/bB9vN9DW//EqWZg20r8BRMm7o2EWMhtN2Er4pyhpjf
	OUtjjDjNHqblYIqv53EWA1NIVSTGk+gRPCoVChLHgx9jBQA5g8MzFLpBZH4B45L11VSLgURD+MX1S
	FkMhVWaSKqNK+dVahtqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsA3g-0007HP-Pl; Fri, 08 Feb 2019 17:35:24 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsA3P-0006GX-Ix
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:35:08 +0000
Received: by mail-wm1-x341.google.com with SMTP id h22so7333657wmb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 09:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FQpTYNOFF/xBKJ0FliQbJ6ZdH9bqB2OMp9FtFZp2/A0=;
 b=v/Ii9SJyJuAmwSaaqOktm0NSIXF7mrcHTm6MfReo5x63shtm7vxeM0EbQQUiZyYrEu
 b4ZD3b4VIYr2ZFP2zRltnQxHhxzVRgElJ/V6JFyzXdEK6Syw9Cyw7ikzmGezfqFw/GXf
 0nAv7M2e1/D3LfiRevQdLaOUeK2wLH+GnJc0TkbdjPOqHMe6rKFLpiw/mFzibjxroA+s
 s418e5OZXSF9Gg9uio7wBFHZZyjMEKHfSbFdfvLULFuFLvM+/DXytAvCg9x+fQkPTkzl
 ma70ao9bHEMBpNJZg24+Zp9h9JS5mksplC9ucN9Ru0qXV1Rx91uhp9pdd543eVzCQdvO
 SiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FQpTYNOFF/xBKJ0FliQbJ6ZdH9bqB2OMp9FtFZp2/A0=;
 b=Ie9B0O669gq+YwRbGphomSMObS1GWf8UjdH5rm0lnRtXabDMvCgVtyhv6SepVm9SLd
 9Njw6pPfVYMQ4dXZDc/45JHKM1zXO9gH1XXiHeXcr/FK9H1WZRYbiSs2KUc6PA2J2UI5
 rkUaqfEDvVpNWWM0RUrVP5nsV3x9yk5KPqKufxJ8Wxni64th9agsoAldU76XTG9iyWu7
 IOMe6PCTQoYfkIeTresQCC9TsWnxKfmbIWwmPStEqJH5ZJqwFDL1K7qV+T/mYOBFjtem
 4x49E1m4tlDs5o2A/arAeIduNvGbXbcR30c2J5AlB66TisbyY86ueXFpcL+9+11y3wzf
 no9A==
X-Gm-Message-State: AHQUAubK3P1CyzlI+jMwKHkzaL1KcK6oFX+e5o/+aKPxIUOMd0NlIIS2
 sNxVqEpXz99jFR1RLo5Tl/BWlA==
X-Google-Smtp-Source: AHgI3IYPdAX3n34cLN9DfUSchpmdQB8sOgNgW67edjr9V44w3BsiNIGAj7fQS7jLmx7pjiKAGGk/yw==
X-Received: by 2002:a5d:6808:: with SMTP id w8mr16815425wru.270.1549647306207; 
 Fri, 08 Feb 2019 09:35:06 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 09:35:05 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, David Lechner <david@lechnology.com>
Subject: [PATCH v2 01/33] ARM: davinci: remove intc_host_map from
 davinci_soc_info struct
Date: Fri,  8 Feb 2019 18:34:26 +0100
Message-Id: <20190208173458.4801-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
References: <20190208173458.4801-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_093507_631399_E08314C8 
X-CRM114-Status: GOOD (  13.29  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The intc_host_map field in struct davinci_soc_info is not used by any
board. Remove it as part of the interrupt support cleanup.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/cp_intc.c             | 5 -----
 arch/arm/mach-davinci/include/mach/common.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 94085d21018e..67805ca74ff8 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -117,7 +117,6 @@ int __init cp_intc_of_init(struct device_node *node, struct device_node *parent)
 {
 	u32 num_irq		= davinci_soc_info.intc_irq_num;
 	u8 *irq_prio		= davinci_soc_info.intc_irq_prios;
-	u32 *host_map		= davinci_soc_info.intc_host_map;
 	unsigned num_reg	= BITS_TO_LONGS(num_irq);
 	int i, irq_base;
 
@@ -182,10 +181,6 @@ int __init cp_intc_of_init(struct device_node *node, struct device_node *parent)
 			cp_intc_write(0x0f0f0f0f, CP_INTC_CHAN_MAP(i));
 	}
 
-	if (host_map)
-		for (i = 0; host_map[i] != -1; i++)
-			cp_intc_write(host_map[i], CP_INTC_HOST_MAP(i));
-
 	irq_base = irq_alloc_descs(-1, 0, num_irq, 0);
 	if (irq_base < 0) {
 		pr_warn("Couldn't allocate IRQ numbers\n");
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index b577e13a9c23..944afd57ee38 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -61,7 +61,6 @@ struct davinci_soc_info {
 	int				intc_type;
 	u8				*intc_irq_prios;
 	unsigned long			intc_irq_num;
-	u32				*intc_host_map;
 	struct davinci_timer_info	*timer_info;
 	int				gpio_type;
 	u32				gpio_base;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
