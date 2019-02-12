Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0D1C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:45:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6383120863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BQDrsTjV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ut2KDGaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6383120863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t3PvnBbeMBfAaBbhKYD8dXrDggvKjgK6PCxcEzWo/uM=; b=BQDrsTjVKMMgl0
	MwZ3EuTh+qtYouMZ3H+4Tc26Ck0iB7/cWVH7Xmia8qzjsweJHBYxrTHrr+lvEU59bQ9hfYzDCF1Tn
	+v3PgqdkcfSeXYkRzga2m6XG/nCJG/JEeCMFmgyPvD54o6tDW7R64E+UGyON+xU3cdBka7kNucFLC
	X+7gc11uOkPfrlxW4UgA1q7bWXxOfPv+gvkUR2IvQYAnxbPupgb6JzhJl6y2dLY9VASQN2IV69kJY
	hGnKSoAot/AYOInI52fj/xcd6/FZaYS+ILlBwaFSWIUfNmn90mzG/w0UZpH6TO1T3zgQcyghmhhiK
	diFSOwz+UgYOtAaiEHUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVYo-0004H9-1w; Tue, 12 Feb 2019 10:45:06 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVTS-0006Rn-QP
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:40:07 +0000
Received: by mail-wm1-x342.google.com with SMTP id a62so2357007wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 02:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9Az3ypPlBn0rnU2jjDB+ljZF9C7NpKC51dYPhKPb90M=;
 b=ut2KDGaFqx2JElLvv0qXtMjhy7PxTPnUpAp19rewP5PShINHfjufkeLLE4uWSpGrS/
 1i4fUTBWWH6rfUk66wLHWqQy6+7ymTQ9ItdG9mf5MrCrwSFWgI3DWbvWPERmfWP//9Yk
 nL8B0g10IXSO0007xLVYp+FGKJfr5n5TyaTBJeDnUru08JMNNItMJ11NciuexLtQzuK8
 bdnKTw+NOx2h1hyQ5ELBgy0oUGFirYn2+o8p1ZvPLqIwssCk1V3AFKY059MVomtZOUcm
 NlFS7pECMQyta2na5o1QfStWAMUutuwJxQJS/11VdNiJL9X31JeiKXlJQli1vu78aDVh
 Sy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9Az3ypPlBn0rnU2jjDB+ljZF9C7NpKC51dYPhKPb90M=;
 b=LeFuDqpjGxlQsCfm934kv7Qt+S0JV8FulwXp/H8qhOx4IfOFhiTqVKDN4twPev0qva
 sY2v/SQ/R3i+VqQWM/4sVdDF0nxJTHomH4jQCvuEZhOBdrh5rBGYsytDT0a5g/zR3POG
 6i2PvS4swvzkUSfFnLKmLY4V8cmYEoFBhiMPmT+4LMTbWWC14jag6eFZowxgwIztUejm
 gIudqdrdSe3tCJyIY3QRfXUHVMJ28OgenaWpkNN8k5DXjFINkvn/59gARoa6txbxFp10
 fGKFlnTIQPqjA2LkqZrEt62omg6eKTTijtkLTvyiCEijKCKtRqgwDUVdjluABH0Ukp82
 UJBw==
X-Gm-Message-State: AHQUAuZjT+PnpXC6kGD7wrz7CG0/0rUNO2JRUkDxzWvDcd48bXVezldF
 TXI6T90Gz+nXP0LJTkHmqr61XKVioWI=
X-Google-Smtp-Source: AHgI3Ib38aMEIKjPS3Tv599kkTUJeEgHHJGyXWmZ2QhFfcO1fZjrdlJ17qEnA/o9KcMOIJcUd/Vabw==
X-Received: by 2002:a1c:6a16:: with SMTP id f22mr2357484wmc.25.1549967973561; 
 Tue, 12 Feb 2019 02:39:33 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
 by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 02:39:32 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 32/37] ARM: davinci: cp-intc: unify error handling
Date: Tue, 12 Feb 2019 11:38:30 +0100
Message-Id: <20190212103835.7768-33-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_023935_239156_ED3DA8E4 
X-CRM114-Status: GOOD (  13.85  )
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

Use WARN_ON() on eny error in cp-intc initialization and drop all
custom error messages.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/cp_intc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 25221dfe8a20..1bf11fa8be76 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -177,8 +177,10 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 
 	davinci_cp_intc_base = ioremap(config->reg.start,
 				       resource_size(&config->reg));
-	if (WARN_ON(!davinci_cp_intc_base))
+	if (!davinci_cp_intc_base) {
+		pr_err("%s: unable to ioremap register range\n", __func__);
 		return -EINVAL;
+	}
 
 	davinci_cp_intc_write(0, DAVINCI_CP_INTC_GLOBAL_ENABLE);
 
@@ -210,8 +212,9 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 
 	irq_base = irq_alloc_descs(-1, 0, config->num_irqs, 0);
 	if (irq_base < 0) {
-		pr_warn("Couldn't allocate IRQ numbers\n");
-		irq_base = 0;
+		pr_err("%s: unable to allocate interrupt descriptors: %d\n",
+		       __func__, irq_base);
+		return irq_base;
 	}
 
 	/* create a legacy host */
@@ -220,7 +223,7 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 					&davinci_cp_intc_irq_domain_ops, NULL);
 
 	if (!davinci_cp_intc_irq_domain) {
-		pr_err("cp_intc: failed to allocate irq host!\n");
+		pr_err("%s: unable to create an interrupt domain\n", __func__);
 		return -EINVAL;
 	}
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
