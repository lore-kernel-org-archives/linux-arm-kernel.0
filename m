Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40A3C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:44:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3393220863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gE4GNdbm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="gfgHhJCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3393220863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Sp9Xnisle8jwTzFrs8EBRE0aH967VvXKqBQ2Cj9nAFI=; b=gE4GNdbmEzEG4n
	AnJkJi3pWKqZZHY0DZvO5mK+36U0GcDxMCjV0krAo1Wjyc5c8ukE8jrExPhUVwj8Ta0SCqPP/oTas
	atqXegRR2R4LsoLiUI4CD/lmaDNeBK7PVzWsZ4wSAnTRMvn9ZVjTpPoKcFYZK0qv7tmhhsw5NPpNu
	aJpMKdVeM0X2LKYxL++O09hemlaY/13mHybd+jvrllhvgCVLlQLeYI/xaEdGAX6k2cCRRNhPWOet7
	86/GceRsEDFbwkJa2GBm/OMvRpokoSrj4vqon78fQyMH3W9r48RNWlKdJFa1drx/Lo70p/VRM2Nzq
	eWLrSBFKwtoFSVUqdt8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVY0-0003Oc-Eu; Tue, 12 Feb 2019 10:44:16 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVTE-0006D5-Lw
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:39:38 +0000
Received: by mail-wr1-x443.google.com with SMTP id l9so2047617wrt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 02:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3Hwye1NlQfpROfiatGP4AAPQ8WZ+X3wpSFiN169P8MI=;
 b=gfgHhJCIMdwQyiwFGV1QkFfJAo/DDHvP+0/W4htvK6gnnLaReXahhbh5X74EFkBBfr
 sKc4L8uQ2ODt66SDQXUryWorKbMbxWYx0Vpi5SNsosTd3CsR4t75neGvePx2UBLCA78C
 ipcJlrHYVRryoueriLI/jIT36jpGFvy6z1GXJHmOgE4JE+kryJa+aAjgAD4PfU+exRDT
 QuMf+gGATYsaB0uHAY5L95hFytaZNmdkEblwyLBD0WfFf92WPlSf5Y82Q5iI1TtipcS7
 6TX+OTLvfQ4WURPzfgC9Dg2WeQ/j5AUUaCoBgui3yfzWCYus2dqshT2nDPiupSI2FWHO
 dj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3Hwye1NlQfpROfiatGP4AAPQ8WZ+X3wpSFiN169P8MI=;
 b=Jgl/bnZkHQWou0GpG4sW/95SBGDaKSIPfrWmRtg82c/UivMngGkIsxVYjdzYxh+z43
 lE/XbGmTKNbZQHTb6WtqmRNXlWj3orGgo5ExrSRJrlH8zccP0Uom7IIkoFS4PQI7CSZA
 B8Cx1zXLcr6AlG+WRMqc8l5ke+RazDT6AjCTBR/Noz7I+rU3ShGSNudXAWClkByzdvwx
 c1zon/9eh7nHkLCVif5yoK5fB0bt1HtZuk9IqgfwqbhjzVaygZAGY4d1g2hAPdF1hrKS
 VjfjPK7vxGbbIMvS6U4a62H8+JIGedw7MzN0SVIazHta/gVo85/tKCBS0N5TgzpkqW0J
 YKFQ==
X-Gm-Message-State: AHQUAubPYVJ3OH2Fe2J9aPtBscXyssSL6yaYcSv47LU/U0Qpj5pBVJGb
 FsvZbOTUYoSnD838XRGoh9+1kg==
X-Google-Smtp-Source: AHgI3IZzJrN9VqLpqD7nqk+Dht2iIf2+d7+v4HQuiBiFinrky53GVdpUqe79GPK45WLE4hPlxLlhsA==
X-Received: by 2002:a5d:42c3:: with SMTP id t3mr2257680wrr.232.1549967959188; 
 Tue, 12 Feb 2019 02:39:19 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
 by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 02:39:18 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 19/37] ARM: davinci: aintc: request memory region before
 remapping it
Date: Tue, 12 Feb 2019 11:38:17 +0100
Message-Id: <20190212103835.7768-20-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_023921_516467_4FF80EBA 
X-CRM114-Status: GOOD (  11.84  )
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
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a missing call to request_mem_region() before calling ioremap() to
make sure the region is not being used by anyone else.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/irq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 2afaf19dc46c..2b6943731af9 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -86,9 +86,18 @@ davinci_aintc_handle_irq(struct pt_regs *regs)
 void __init davinci_aintc_init(const struct davinci_aintc_config *config)
 {
 	unsigned int irq_off, reg_off, prio, shift;
+	void __iomem *req;
 	int ret, irq_base;
 	const u8 *prios;
 
+	req = request_mem_region(config->reg.start,
+				 resource_size(&config->reg),
+				 "davinci-cp-intc");
+	if (!req) {
+		pr_err("%s: register range busy\n", __func__);
+		return;
+	}
+
 	davinci_aintc_base = ioremap(config->reg.start,
 				     resource_size(&config->reg));
 	if (!davinci_aintc_base) {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
