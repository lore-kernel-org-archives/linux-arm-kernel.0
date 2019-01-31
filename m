Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4115C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:56:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89C662085B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RzfFaQlZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TS2TIl7f";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Oi5dsV1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C662085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=outWGmDj6HHJZ7B076WpOpZF2wf74/hfp9ApGIYz3A4=; b=RzfFaQlZ3vhmMv
	/hDa9xZXNeeuavjwXLzPlAtY9rtyvskJr4Ov4u3KSuzSwsRwa7zW7oNo45GzpqBuURmmM8ci/TnT+
	9g69IayT96I5nmsACdxRltav72ogHNCRmXRV19AD2klU2d0Q3lHjmybzEQOYsdLhjSerggyD5JmLg
	mXoITQOtASwVzOrd2OpO1FnaRzVrwWhRr3KqCnn9heEPR6Ju6ceJ92zjVWb6UE/b6a8amDkCV2/Ma
	qbCTELoQMazAaYRV8RB49VzzZEMZinVDhBA5Wj2eLT0OSxGT8Te3B7i+tHGp3fJlSUKjATaHq9fmm
	NRvLh77nZ/3PmusCNUOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCpT-0001Cy-22; Thu, 31 Jan 2019 13:56:31 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCoj-0000Gv-2Q
 for linux-arm-kernel@bombadil.infradead.org; Thu, 31 Jan 2019 13:55:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vxfm0fKbkuL8SE9c4CrhCSFAKt2dnHDzKJRVV3w+UdE=; b=TS2TIl7fBm/AQaRe2AAF0yt0cR
 PPT4oQoGbDXCz0n58rK1C7W4gt8pvofw2GZC14F+M6zgKfXNIVKfGI1bvAlD/UhNpJVe3wyqaVkKb
 MfbITSBWV6XsR8CmKjS3IGPoRbyOeqn+u584kmyrGDevA3jc2+ldzvt7/va5wELZB2nBYo0gWxxRT
 KYHiU3hUt1Uqk/oAOJp00NI55sJVsccv6+EBhfcHt1ubCqyXCCunM73pTonuuVRziKj9JkVtKsoFj
 Su4qbklsFNFz38ztsmnpIK+igGZkx60bp4c6+HwU6ztH2zZLhWi9asTDQapT2bIZNPacWUcIlj4A6
 XzmPOAsA==;
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCZi-0005Aw-OI
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:40:17 +0000
Received: by mail-wm1-x343.google.com with SMTP id y139so2510956wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vxfm0fKbkuL8SE9c4CrhCSFAKt2dnHDzKJRVV3w+UdE=;
 b=Oi5dsV1IH5FhJX8S3ZuGU/CN53LrP0QqDD+FHNkMaT8NdpywplaK4XK29ZsbTcf30N
 NPHpXD4GACwqZ0XycIeop3T1/yvW0AshHTXnLy45JKjS+cV9V7ORtLHtYMxBEJ4/ZBXQ
 LASQpuFU48Mqfh0dxqq9+NMoxgPOwoklOGYjd7t+BBqeqUs8gqFCjR/HU8eaCCV5TZ96
 4fTNGdBCGy00uFZ9U4NJigu6JvMWdjGUqu8U26XmSdXAL7WIrtaRPc6a0serPHoGdy0E
 1uIcXs8Rm0Lh1EFK/rttuZ8EuOQjU7HCcGx4w34EJhMrGBBSFdfWZAW64tn3MYRYAv7S
 1+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vxfm0fKbkuL8SE9c4CrhCSFAKt2dnHDzKJRVV3w+UdE=;
 b=o6OrEkHD5mU1Xt5hmPNMQN75uAed8IlCR41BR+I2PbcKayO9KuQ7wnZfDHeZeJ5jlO
 xl9F2QThc6EcYVWsMxWZJO7mNQJT4PY4pTHcip7HmxBzquG4DP+xXLQKxeS0f/NxFzHj
 i0/auFIXfvTbM8fBW4RDdB/h5oTKStTWJPmoNYwQa0G8wGWmqXzwFEKRl8aZVZB7LYQn
 NFjYneoB5ye4CU53rXPqBu+RaLvD2cUftBknzkcY5xO8JizDhAqbttxOTPFRKVLYiaF/
 T4FGNAW5d3IistQQTB494HDzOAwd4ZsGCA+4GI5GEraN+y+7NVlHgZwe5+orhk9JPyzJ
 ohew==
X-Gm-Message-State: AHQUAubSCFx9VFJzmaL765yQOglQx68R5urg2MTS2ix+csuRSatWqMJe
 8X74QuCCgbHg1ajmaaMpeZZ13Q==
X-Google-Smtp-Source: AHgI3IbYvqW8nVCYDm7z4NeIwu8NZvfbdpzPIBEZ+pvo2Wymz8BGH4jH+TEFaNz4jnVpLHlMQrVVww==
X-Received: by 2002:a7b:c1d7:: with SMTP id a23mr1297394wmj.48.1548942013583; 
 Thu, 31 Jan 2019 05:40:13 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:40:12 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 27/35] ARM: davinci: cp-intc: unify error handling
Date: Thu, 31 Jan 2019 14:39:20 +0100
Message-Id: <20190131133928.17985-28-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_134014_826670_B8AA3741 
X-CRM114-Status: GOOD (  13.71  )
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
---
 arch/arm/mach-davinci/cp_intc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 4cd515b507f4..8d751318682d 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -187,20 +187,16 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
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
