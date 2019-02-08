Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D50C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:42:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A2972146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CGnxYaxw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="qdkfBUKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2972146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/rnoHFlr6A3w9QTlNaKzvOO4x04sVVh+q+E2serXTEM=; b=CGnxYaxwngCrNb
	TVcYsJn2V/563Fe0nZZlCy5nssRd39bDVRLDaWy4LUJH1yEcySLPYEeyJWDI5TGKkg3fKfssGjgHR
	OHlgtETsnsZzhXjvu+gaZqQg7Gdk0TOuG/197zdcsbb9+PHmpTBKTm0mIm2XfVDqdTQ5lF8v5+qA1
	KKSp+dq+8WbV3XMuiS+WgFIAUAEF6OAr8+8ExWsUocrpIcGpif3KIxwQORRQd2L8gvFcbVVnAgDjp
	Q2VCOfXIMz80s6/EmklLqmQjGZro+yMEQN1vRUE0aa+oyrzMrdoZIeBMvRlY6K5tNGrnmm5lE8oUp
	l++DRYWtMyZjs72SIHGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsAAS-0006QB-S1; Fri, 08 Feb 2019 17:42:24 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsA3x-0007ZQ-29
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:36:04 +0000
Received: by mail-wm1-x343.google.com with SMTP id h22so7335178wmb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 09:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PVpMk4DVv+a2tPz6DDcxjR1CpV2M9ZT7i4uU6Q6sRTU=;
 b=qdkfBUKhc0c+MqnyHXOX00G61dK4ACw5ynB90QEdhw6ZC5J3gLCSt5pJh3ade/JX0G
 0UVGjeh/lFKGPfdblPoa8AaKIZ8LrwuLkBt0U81aLEciYbQK7Q8WGv1DH5ucAR6B5TvP
 v+ffuYSi77tgGKtUHwvsuCR8pLt1uvf3NIa/au2XY9q7Nd7A0Q4rLGoTsLIK8FGzwqv2
 FW4ir0lZ7s88OBzM9J4YKQM0dGyiVetzvtXKuj7q5xRiB6GfejFfdVMkLzpKkH0CPNns
 IJGlziFZ6t7Tyz/nIM96IZkMadNqMicABII12WuuCW9SV1DrKi4+O9BoBy5zq8Y7pWim
 KUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PVpMk4DVv+a2tPz6DDcxjR1CpV2M9ZT7i4uU6Q6sRTU=;
 b=Wnbg3k9Bp0900hB90Xf6j0W+mEDeU8tH5us3VbKM9oIhLeNaeRDI5qZCEJiVQ+Y1LV
 tIE6VIEqhTaQuejLB7R2+BylPIEBiJvYd7axm2iBy73iEa1dXCSapxAxEi4N2jyLBw5a
 oNlofr34IIp1JZ04+8xTzX1CKUn/TgY7vfAvJE81Uu78BcmKtlvodViq3n9fvl6fm2x3
 VjE6siUjE5se3Onm95TlTuGElmrYSHyLj7CKD2mhZwASWq3GOHa6JYC+8xUfx0PzrBAM
 d1bMLQLy+QZbRKnM7HwocjHa/jjaqkc7gIc89y1IFy0TFuRImjJ3IEYGWj+luYWtaPxh
 WI2A==
X-Gm-Message-State: AHQUAuZTCe+JW04W/CGD+8xBnW7DfZOg+e3DbV9epsehnv3+R6y/HTWP
 dm7tU83izsr3dvUw12y+98y2RA==
X-Google-Smtp-Source: AHgI3IZfdQBpIamoh+P+L8MSzoquKbELHayyn0ZizI/J0l5xr+FNc3723pXA+WZ22Ktuv72zHyMCnQ==
X-Received: by 2002:a5d:4349:: with SMTP id u9mr18215515wrr.223.1549647339671; 
 Fri, 08 Feb 2019 09:35:39 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 09:35:39 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, David Lechner <david@lechnology.com>
Subject: [PATCH v2 28/33] ARM: davinci: cp-intc: unify error handling
Date: Fri,  8 Feb 2019 18:34:53 +0100
Message-Id: <20190208173458.4801-29-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
References: <20190208173458.4801-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_093541_747311_8D734A39 
X-CRM114-Status: GOOD (  13.80  )
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

Use WARN_ON() on eny error in cp-intc initialization and drop all
custom error messages.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/cp_intc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index f3787ae4cdbd..c1efb9390655 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -200,20 +200,16 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 			DAVINCI_CP_INTC_CHAN_MAP(offset));
 
 	irq_base = irq_alloc_descs(-1, 0, config->num_irqs, 0);
-	if (irq_base < 0) {
-		pr_warn("Couldn't allocate IRQ numbers\n");
-		irq_base = 0;
-	}
+	if (WARN_ON(irq_base < 0))
+		return irq_base;
 
 	/* create a legacy host */
 	davinci_cp_intc_irq_domain = irq_domain_add_legacy(
 					node, config->num_irqs, irq_base, 0,
 					&davinci_cp_intc_irq_domain_ops, NULL);
 
-	if (!davinci_cp_intc_irq_domain) {
-		pr_err("cp_intc: failed to allocate irq host!\n");
+	if (WARN_ON(!davinci_cp_intc_irq_domain))
 		return -EINVAL;
-	}
 
 	set_handle_irq(davinci_cp_intc_handle_irq);
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
