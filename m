Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3565C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:32:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3CD620989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PCdwY4TN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGgvnpJD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CD620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Tt8lbaKXjNZ3QM/TRppGmhI58bh8ujMOX8KvT2n1qNM=; b=PCdwY4TNIgNp2d
	VH2O4/gNbG5UdsmuHGwBN2arJmuZkIS+8TrpFfKKnD/nvDRQYhKymdBjxY/wyQIqSwa9AH8/LHdWe
	2njEwP6K723ZS7BmQGS0FsEGX2XPnOQGjDAdC9+1vWgYv5IbBAoicXpLQw0zUbaOyrF7oaLn9OA6s
	IbigySPn4HfUrC8JT9cTFBl+ioaEN8BvP8ohxZSiSRFEjRwiYpGjOMo44BOAcp/wbv4bPs4w7yL1a
	mR/WNLYGl6tPBPA+P5eZxehM0Yc3gH7C7S0HqlPXUD+JXM89LDqkH2FlcUMoNmsoQpYe8dykl14TY
	KD88DIFLtmqKUQBP9svQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUo9G-0006T2-64; Thu, 06 Dec 2018 07:32:38 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUo8b-0005dF-Be
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 07:32:02 +0000
Received: by mail-pf1-x443.google.com with SMTP id u6so11338114pfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 23:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2UAI3OUKoprsOY9OdCB9E22gIwtD9enXDzWD/fAxr8E=;
 b=kGgvnpJD5ZK67Nrw9ngrxknNuTTD+rwOxBm+CTJ4vmBQ897PoeLijHC7L22hZ1DCTh
 OFlCryuu3SpzKSJk+BiHLHquV94Auz63D/hN4pq3814QIZABHcp5rmtKEMSHU0GHYcJu
 FNXeXPV8QjAfVx+82IX8JEtXjrY/61VwZBGSzkSebo6rqSGEuH0AlAFuUczPm6/hg2Ju
 DF5BRKs1l+lHt9fu46k+onK3noefXuZ4Z8a3JCr2kzDuY5awJWaIYnQ/froXrHWWWYkf
 f/ejsqzg/zQeJ6PrQBEKXbgmBz39HLeYIb0nZQ/bY3iPioktGV2xjHAz8OztGIFS3dgU
 vEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2UAI3OUKoprsOY9OdCB9E22gIwtD9enXDzWD/fAxr8E=;
 b=D5XnYoxFqLOqAVGtaovC1hTCYTnXPY5ZAryIJyGyaLrNpMuGOh22KNmK1m+ZpKHuzz
 2nM52v+qKpHkK+uxTLfHoPemLiLF+my5+HXfE5EuzeISYEDe4WDRNdKjaMKyabQmsXD7
 Y2flvnpgPSMqVg7YOwTyxl6rukfLzNMRlHKrumiQJ+tdlMLObTNcmBhDCWMpUe1iaVw8
 TqNNuRRtNZYHINoK9xN6pG5WQGrH4d2v+u2ZH/gqzxDuGti7eN4CJYugDIzhzYML2aMJ
 owuuMy6SJloI+BVlkWzyOjtVKw9gmpuUPGEdOkKKrFu/dorWB+1+mrGfrzpTHa5Flqfw
 nOww==
X-Gm-Message-State: AA+aEWa5pgwSswcZXM/Ls9CJxvhKg9TGKzRzPO+mXlB0iLGN8JT8gVaw
 6v1YnECJnorB82ZzQ07EfP8=
X-Google-Smtp-Source: AFSGD/VUxg/Qt4R+bt4RCmL2WIGr0OLVj2NYMaKR7gAkMctBajPQDNHXsbzrJ4HblmDzb1xk6ZDmAg==
X-Received: by 2002:a63:5c41:: with SMTP id n1mr21009907pgm.1.1544081506464;
 Wed, 05 Dec 2018 23:31:46 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id o8sm55023141pfa.42.2018.12.05.23.31.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 23:31:45 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 2/5] irqchip/irq-imx-gpcv2: Share reg offset calculation code
Date: Wed,  5 Dec 2018 23:31:22 -0800
Message-Id: <20181206073125.7255-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206073125.7255-1-andrew.smirnov@gmail.com>
References: <20181206073125.7255-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_233157_794449_94E44447 
X-CRM114-Status: GOOD (  15.90  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 Jason Cooper <jason@lakedaemon.net>, linux-arm-kernel@lists.infradead.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com, Thomas Gleixner <tglx@linutronix.de>,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Move identical offset calculation code into a small helper function
and make use of it in the rest of the code.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: cphealy@gmail.com
Cc: l.stach@pengutronix.de
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/irqchip/irq-imx-gpcv2.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index cbed00319315..b262ba8b2652 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -28,6 +28,11 @@ struct gpcv2_irqchip_data {
 
 static struct gpcv2_irqchip_data *imx_gpcv2_instance;
 
+static void __iomem *gpcv2_idx_to_reg(struct gpcv2_irqchip_data *cd, int i)
+{
+	return cd->gpc_base + cd->cpu2wakeup + i * 4;
+}
+
 static int gpcv2_wakeup_source_save(void)
 {
 	struct gpcv2_irqchip_data *cd;
@@ -39,7 +44,7 @@ static int gpcv2_wakeup_source_save(void)
 		return 0;
 
 	for (i = 0; i < IMR_NUM; i++) {
-		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
+		reg = gpcv2_idx_to_reg(cd, i);
 		cd->saved_irq_mask[i] = readl_relaxed(reg);
 		writel_relaxed(cd->wakeup_sources[i], reg);
 	}
@@ -50,17 +55,14 @@ static int gpcv2_wakeup_source_save(void)
 static void gpcv2_wakeup_source_restore(void)
 {
 	struct gpcv2_irqchip_data *cd;
-	void __iomem *reg;
 	int i;
 
 	cd = imx_gpcv2_instance;
 	if (!cd)
 		return;
 
-	for (i = 0; i < IMR_NUM; i++) {
-		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
-		writel_relaxed(cd->saved_irq_mask[i], reg);
-	}
+	for (i = 0; i < IMR_NUM; i++)
+		writel_relaxed(cd->saved_irq_mask[i], gpcv2_idx_to_reg(cd, i));
 }
 
 static struct syscore_ops imx_gpcv2_syscore_ops = {
@@ -97,7 +99,7 @@ static void imx_gpcv2_irq_unmask(struct irq_data *d)
 	u32 val;
 
 	raw_spin_lock(&cd->rlock);
-	reg = cd->gpc_base + cd->cpu2wakeup + d->hwirq / 32 * 4;
+	reg = gpcv2_idx_to_reg(cd, d->hwirq / 32);
 	val = readl_relaxed(reg);
 	val &= ~(1 << d->hwirq % 32);
 	writel_relaxed(val, reg);
@@ -113,7 +115,7 @@ static void imx_gpcv2_irq_mask(struct irq_data *d)
 	u32 val;
 
 	raw_spin_lock(&cd->rlock);
-	reg = cd->gpc_base + cd->cpu2wakeup + d->hwirq / 32 * 4;
+	reg = gpcv2_idx_to_reg(cd, d->hwirq / 32);
 	val = readl_relaxed(reg);
 	val |= 1 << (d->hwirq % 32);
 	writel_relaxed(val, reg);
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
