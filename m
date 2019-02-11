Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0A0C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:31:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDBE820818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PttOLOFi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Ob2V0uLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBE820818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ymtW5LiHNbOe1VhJwavfGtEImAMBsJpChSZsqkFGK/o=; b=PttOLOFi/YHYUi
	ny2yB0F/LNe7iJ0ffv4humd5kv/xCdxXxqNjSfDmvFwOVFYPDDZYhLxRgOIrv8Hmv/F+JqTeHD55g
	sRyQBF4SQ8L75ZHN6Uo3TB7lDsYI33zkKzGunTaooIU6QFLARiO+o3lKP25VzekgqbEDe9THUlHfj
	K+SRKm0zec3ETp7PZo3NiAQFzOBrHR3addmZGTGf9G062gT5QcZMRdJoAbdaqwT2LZMi63qxSqHXy
	1Wi2vMc3N5Anv7prhArcSnYYltPk+GvT4k/BI/z/9EIvK6Y12w5oJ3ZfFSyPGq2ez3LN40Fi8rNYk
	7ql3EbquG/jFCcsee56w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtAkQ-0004hv-DT; Mon, 11 Feb 2019 12:31:42 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAfQ-0007Qq-RJ
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 12:26:45 +0000
Received: by mail-wr1-x444.google.com with SMTP id q18so4465460wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 04:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5xoYgZeFd4jbYH06UIuAag4pMtuSlF7B4aVziE0WwaQ=;
 b=Ob2V0uLkmrtuwWtPxVud0yokG4gomj2iZaQcTLHVWFokz4yCSMGB8kUdD1F5saDez/
 KqmOMG5mMi4nkjI1W43r+rrCdfaWJYE6T+EdJW1wUyPMsgZ6N8kBXLhpxfLCx04jRfgx
 KD4ZMBv/6Awwst3KuHkoFz91hPJphJZQlteMEzkr9tQT9LS3lNDvYrXAuIW8n4/yzEG2
 NyeiivWPLiJ3fWVjHRmwfYy1tkgFkXZGw/mPV9zQJ8ai9ee2Z1VYFL/nM/86NpFoPvMV
 O5tBGl0b9u4u3QyHX+0M5KaYPm9inYKXLjAE3uMpCEBGYtW3uy7RQQKiYRtlatJ6/hxd
 EKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5xoYgZeFd4jbYH06UIuAag4pMtuSlF7B4aVziE0WwaQ=;
 b=ftVyd4u9cF4qdiF+u8iVRFPS2ZAYH1ZUEo3l0ZQeuNSlk6UBlLgym9rVDnRuzvfCau
 NCjOCLThR3OIxQ2+094Jso4s2J7F8tJLGcWMztFEyht0HJybheUemRhrtvc080LouTZg
 n2FgJWGvwwVgwR2lNUeF1Gq54ERF0BYhvKzCBz9xrUKvZrXrn7EawJpUBjur46CAr/ah
 VP/lTHWXV8ulxEL3I59sL01k0T/9SxGShqZowNCgSE5E1KqfvdYsT9TdqcTxzU+cXN3L
 ibbxmRJLLZULndwZUrlL58+gWoO+H8sRG46W6GzXJOW+tv7LMBLARDztzQqrjA5YZqVQ
 k3KA==
X-Gm-Message-State: AHQUAub0hf4SfFH/JioPz6Tw8snTQdYvfReU9Rrmx+TOkoZbTDaIU2rj
 F+6ksiOX5JXPsDsE2SqT1/rQzg==
X-Google-Smtp-Source: AHgI3Ib3ufdV3JJ8HpUVVBn3lmc7RDQ/jNotQIrcWskt+PH5iDrdUGEcOKKjtpnyRjeyGH5t4kkUdQ==
X-Received: by 2002:adf:ee46:: with SMTP id w6mr28055297wro.261.1549887989765; 
 Mon, 11 Feb 2019 04:26:29 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 04:26:29 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [RESEND PATCH v2 13/33] ARM: davinci: aintc: use
 readl/writel_relaxed()
Date: Mon, 11 Feb 2019 13:25:46 +0100
Message-Id: <20190211122606.8662-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_042633_013256_AA5C9F65 
X-CRM114-Status: GOOD (  12.06  )
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

Raplace all calls to __raw_readl() & __raw_writel() with readl_relaxed()
and writel_relaxed() respectively. It's safe to do as there's no
endianness conversion being done in the code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 148c23728bdb..6a7205a844e1 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -36,12 +36,12 @@ static struct irq_domain *davinci_aintc_irq_domain;
 
 static inline void davinci_aintc_writel(unsigned long value, int offset)
 {
-	__raw_writel(value, davinci_aintc_base + offset);
+	writel_relaxed(value, davinci_aintc_base + offset);
 }
 
 static inline unsigned long davinci_aintc_readl(int offset)
 {
-	return __raw_readl(davinci_aintc_base + offset);
+	return readl_relaxed(davinci_aintc_base + offset);
 }
 
 static __init void
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
