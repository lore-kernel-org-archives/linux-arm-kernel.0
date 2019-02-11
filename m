Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4E3C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:33:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C8CE20818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NqC1clle";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="09fk1c0k";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jNfPuPtP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8CE20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/rnoHFlr6A3w9QTlNaKzvOO4x04sVVh+q+E2serXTEM=; b=NqC1clleouV/83
	cxE9Mj6J1aiW4r/g6jIHBFzjEX5VF229S2Y5Zt018qVV+HFra71pyrNADtLSVVK3JFwu+juzFX0xm
	jzOo6wCnppRfwgTN4PGgIC8DpX80gVw8QWmrITPv0MXldmD6eMV71BGX9KQd7Btdv9fDMehppYGMz
	7AFTYCORDz4oUaxhtlKUuij4z1cimlQQzFQ0mwKHAzP2EuZYGxQZ0v0l7AHE+0uWkrD+HJ0Dt61PB
	FAz0OUneyh7LKG6bWDamz5fczV+BxeBrq0ZPf0ASCZowtXGXD6YXqDuufQdD3O+1bTlWGnL1ysBWO
	pjR9Aasa+thTi2P+yTkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtAlp-0005yx-HD; Mon, 11 Feb 2019 12:33:09 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAfj-0007mm-QO
 for linux-arm-kernel@bombadil.infradead.org; Mon, 11 Feb 2019 12:26:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PVpMk4DVv+a2tPz6DDcxjR1CpV2M9ZT7i4uU6Q6sRTU=; b=09fk1c0kUoChzDtu1R7cbRF/NV
 SCG1miI7F0MlByp7AqDhSDUjzhcfrN9JDbW6gJl/IF71s2kBVqTkK53VzCnE0rPObTwzts0KKjDgX
 rkTm9rIg/Fa+r0fp7XLoQWywRCTWOuOWwwTD58OLXnSXa/YXYOafsj5JyqCBTIn945RO/60wdWlCz
 8F52l5FbRZQ1sETcmyCwjXC3tDgjM4mqgGGcbo4V0RTb/MJMnW+ugfXvLIwGL6+xqFNaWh5OwLavJ
 vJ8GVNHPNyHdJfSa1ISoUDwzy/SRVh0mZsp7j7AqLVdxFzQzK1oTNQ+4tY3vax6jFNbtuptekl8Bz
 I+KwOfdA==;
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAfh-0008TB-9W
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 12:26:49 +0000
Received: by mail-wr1-x442.google.com with SMTP id q1so4484737wrp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 04:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PVpMk4DVv+a2tPz6DDcxjR1CpV2M9ZT7i4uU6Q6sRTU=;
 b=jNfPuPtPZZ1iElfR7lBREEpMmy4JVpCcJWxwmvB2x+kGyLKK3gZmxNavs+ZsWppjZQ
 OzpALHu2GQuRgyu0/XyI4fT1JpktYHsdoPQq7qIkWoHCMMefSKIJaIhtgdw1nwFDuTrD
 Gp+qbAsV+yacD86IiVX7HB+k7EgP0IgRaQbUKJMKdReAG59ja+meEnJqk0p3qm21/QFF
 6IWgxbUdCbnfJaR4rwSjdJus5nlDkUDxfUmeqinnG1fT0Fma1Ki35HeY+KMD/eM7nXPH
 3q7xriUwsoDU0x3FdbZjEdQqJjHtTVPYVqDYmie2Ms18u1MeUgnFvsS8X+OI2P4WxJz0
 SjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PVpMk4DVv+a2tPz6DDcxjR1CpV2M9ZT7i4uU6Q6sRTU=;
 b=q4Zh8o2vb/tnlGHXFOSlaCijfxhY2UaOJIjVuAApft1XmZF8zIus2iHUg3IyjDqBDu
 9kr1X+MDjxkxwjMgiSUdzv5YzsZjgF7SLbkbkNYG66gL8eLGU3lppeZemGwAOtBTmJAd
 mEH1s/++TQ+DHFefedsN7Oh4/vmzPlbr9645RHQjysCPibRdlf3SftLUjKBlC1F2tyIW
 qTcrg8Tsfn2Jb9P6EvVI/klA4edrEbCLB6T+HI+gk8PFUKkKYnVCJjL8sc1nGNgGY4Yy
 isNa2xUntLqKem4yiHsLRNDr0g/ZOaLuCvTg23+Pj1SWQZJnhYpxZJ7M790hTZmqrShl
 VZSQ==
X-Gm-Message-State: AHQUAubvRfRCclQAFTDAmFECcESttWA6r1lttFYzMHIsTvLkBg1gD2/p
 5xgeqahmCpud0wKyP8PjcIFl5g==
X-Google-Smtp-Source: AHgI3IbqIQIgpmEsKfirMG84alydoChsZyJ/cJAXGK+6oaOJTTy2ywYowbHZxmw+JPEc1CCw9ZCy3A==
X-Received: by 2002:adf:dbc4:: with SMTP id e4mr29297329wrj.320.1549888007733; 
 Mon, 11 Feb 2019 04:26:47 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 04:26:47 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [RESEND PATCH v2 28/33] ARM: davinci: cp-intc: unify error handling
Date: Mon, 11 Feb 2019 13:26:01 +0100
Message-Id: <20190211122606.8662-29-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_072649_379687_6F74EBD3 
X-CRM114-Status: GOOD (  13.73  )
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
