Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9774C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:44:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5118020863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QphajGTD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pDok3eT4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5118020863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0bR0SWmTKb2IcvZ8sGlbcfcyQM9uXqiCmwB1W3zH9nY=; b=QphajGTDgQZ1PH
	e9JuAzig0GEn/m9EYevN+YT8wtXRjkKCqYjVPcMuO7EkK+8N6BF8Aj9QEXdlF67usBnU+4a+F8nOF
	Hc44pLMB7EgB4Oeb95wfajAbVRzq8t+AJAXpIuqMMbrNngbdK9jBDZI/tKBvuznp6FtgIgVY0g4GS
	8AxdcY+c6P/Fu3M0VKC/ojzx2fbG+6i1jekUj5mosFOowjcqgc5dSaDiEiwmd7WoRJjadbR3gHo+H
	5mpC22kbSDNQhHX1JJ66hotNALWNIEDyZqECHCVg010934s6IVdhzi0bAdEcRPTsDnQvL34g0OguB
	XureUm8SOgqc3kRa1sew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVXq-0003Fw-4C; Tue, 12 Feb 2019 10:44:06 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVTD-0006Bb-Hw
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:39:36 +0000
Received: by mail-wr1-x442.google.com with SMTP id i12so2131114wrw.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 02:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4I38YIiHSc0ZdT9iV5cSNguHO1bDo83hHtu+LVNIPe0=;
 b=pDok3eT4L7i0miBraC0DtB/RJ8s/FpyKfn3aRHCQZXTtOIyvcxzQ6A4TdRRwdkjb/0
 pZQ/U4k03bg2S18HCcZ9OmpS3oSFe8r0H15TXvaA6Q8vzAwEhmY/Pb4QjSRVxGt0cM7Y
 nFARVR1QlAjckDDEs4u6UCS+1wARyuayOLKVcJUQeFaleH/f0QrNz1AMfKzft5PSyJGj
 zIiuh0wwJUqEAkcIuFoRB+WRcyyruM+4a06MA+h2R8l8uuFS9q96ZIz8qgyr/L1NosZk
 23Q8VhroQZfxzGk6SfZMgLO/junNhYlpvDx75WE55+DqtIHvC7Fd29SSP/hr40z4FNOy
 pMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4I38YIiHSc0ZdT9iV5cSNguHO1bDo83hHtu+LVNIPe0=;
 b=gznCrrlehHHS4GaPf1PBMSqElrsGnKHu5AZhk/JAWPiTUTb3HV2A4Nl8JC1SOrzDAX
 s3uMHR2ugfLA+LU4kmkUALpWmTEPNJAcmZKcx4AjKLK59k8/zq0s31YAMaW7XVw5K0JD
 x0cJz6h5CqGJyi0b2kp508GfcmTAnKxzbkC/sfVfyuR8j92q2Z+duCjMGIK1ffLINVJ/
 PhNpub6h8tEvBGNbyJDD2IAP7NKlfAuwP10/6aEIy40cX+JFgyj3emH2vTKs9TJbReOo
 F2eFMNPog6XXZ3Yz94NZNKVgVBm3lrR2fHSgOJvMVYP0Nx7p4op1aL6ahEcPXCWWh3WN
 rnNg==
X-Gm-Message-State: AHQUAuagddegP7dyqYjTKgQx320SRgyYcQaO6OgTKKsleHXQ6itOlq5v
 cHi7d/DVqgnvl9t1gpDtBgKiCw==
X-Google-Smtp-Source: AHgI3IYyzonvJQpn4K5gOlcJOHGtqyl4DYQjw59CLzlKc2GSdWKTLCojSkK8BzkU6/3jwFifIFUFfA==
X-Received: by 2002:adf:f903:: with SMTP id b3mr2498681wrr.82.1549967958092;
 Tue, 12 Feb 2019 02:39:18 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
 by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 02:39:17 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 18/37] ARM: davinci: aintc: unify error handling
Date: Tue, 12 Feb 2019 11:38:16 +0100
Message-Id: <20190212103835.7768-19-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_023920_944286_75F131DE 
X-CRM114-Status: GOOD (  13.46  )
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

Instead of dumping stack traces, just print a specific error message
in aintc driver.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/irq.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 1b2eeddfabd1..2afaf19dc46c 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -91,8 +91,10 @@ void __init davinci_aintc_init(const struct davinci_aintc_config *config)
 
 	davinci_aintc_base = ioremap(config->reg.start,
 				     resource_size(&config->reg));
-	if (WARN_ON(!davinci_aintc_base))
+	if (!davinci_aintc_base) {
+		pr_err("%s: unable to ioremap register range\n", __func__);
 		return;
+	}
 
 	/* Clear all interrupt requests */
 	davinci_aintc_writel(~0x0, DAVINCI_AINTC_FIQ_REG0);
@@ -125,20 +127,28 @@ void __init davinci_aintc_init(const struct davinci_aintc_config *config)
 	}
 
 	irq_base = irq_alloc_descs(-1, 0, config->num_irqs, 0);
-	if (WARN_ON(irq_base < 0))
+	if (irq_base < 0) {
+		pr_err("%s: unable to allocate interrupt descriptors: %d\n",
+		       __func__, irq_base);
 		return;
+	}
 
 	davinci_aintc_irq_domain = irq_domain_add_legacy(NULL,
 						config->num_irqs, irq_base, 0,
 						&irq_domain_simple_ops, NULL);
-	if (WARN_ON(!davinci_aintc_irq_domain))
+	if (!davinci_aintc_irq_domain) {
+		pr_err("%s: unable to create interrupt domain\n", __func__);
 		return;
+	}
 
 	ret = irq_alloc_domain_generic_chips(davinci_aintc_irq_domain, 32, 1,
 					     "AINTC", handle_edge_irq,
 					     IRQ_NOREQUEST | IRQ_NOPROBE, 0, 0);
-	if (WARN_ON(ret))
+	if (ret) {
+		pr_err("%s: unable to allocate generic irq chips for domain\n",
+		       __func__);
 		return;
+	}
 
 	for (irq_off = 0, reg_off = 0;
 	     irq_off < config->num_irqs;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
