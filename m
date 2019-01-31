Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B27C282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:40:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 949D32085B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g6mFlomM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="kR8b33Dw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 949D32085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1tUgxFpdDsMH4P7MhXv3y1qVFIefTLlwEvbIeRVelOY=; b=g6mFlomMBGnDsl
	ogJIcW+byoc2P5PMTF6o/wJYHYUm3EzJXb3JAHsum7+C+0DH+Bx4pJBJM99a07z8fniTsO978qJ0f
	wco5QJVmNo4T9Bzz+dIO0E3u1mSV7/rTDBVR9QQOCEphg1KF34Md505zAg+PocZ6QmQxf1x1+LIle
	YIBac+71kr/MxplWG/ewgFbLBvc6gCpml+o79c0ufSmw9LSyYCD8zD0GUc+aFRqL9dqeRI07z1FsS
	IvHObsUIU4vGQNVlMY1VCC+Jit38AHqQKduOyNU+ZwVHTyQrUuds+lzX/6PiWXx/XhD6CHUWCfwGs
	+jI1qfb+TOm/gu/Fos8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCZR-0004j8-Nt; Thu, 31 Jan 2019 13:39:57 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCZD-0004Vg-Mi
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:39:45 +0000
Received: by mail-wr1-x441.google.com with SMTP id t27so3325672wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gYOoz7sLfOmvnQTTTNScB4YjgZPjHnNJytRdhrJ93Tc=;
 b=kR8b33DwbGVi80dq56qDYiOVzCpjcWmz+Oo4usclGpeR/XtgWNj2/0oG/J37mMKBc8
 vibG6NIVXChxP94HL9cW+fVmTjJy+kwW/Pibxf17VuoG8gW0nKfgi0y2Io+ff6UWQQSM
 sHv/8aKiT4J5c8qdUMgxnaG/vV9bFlhBMoANb3WtZ3gxXemgDIaRBFLdGhf93wEtyWCr
 7zOHgGcwx/9eVh5X7G8tOx4dPbEU1iWdLDmY5IckhEUUTqsfMk8g0KMxzm9rlFPhgYCL
 YdZ4VkSdWKJ9Frs6stYe1OuZL6ju9IOGDsW0TUpIErQrygTXCh+BHUC2mVJQ1tnti4Je
 yv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gYOoz7sLfOmvnQTTTNScB4YjgZPjHnNJytRdhrJ93Tc=;
 b=sjVoLURqgY+dyKh9vos8hLS8d3/Eup0go8/v+2vEPOY9c99fWhUEiqcdUyCyxQbW/m
 2QW570h2AGI4Mt2Cc2kUyav7+I1jCV25Rxkb0w+w2K2qy74tUmv3kV4BtK9Ei02H3fm5
 Lh04mdDGhh6paLdv1sd4ORyB9NFUMOoF08aaLInmxSzcYIlkRFhRaZp0dVkenl0shfXf
 YB6GCiS7z4i1sXxN0Q1cyi8ai2E7kANUlVYgCpb1hoCkiG6e9JEAfTsoFE+hluK6Cjqd
 YuAlHlb5cbgxei7wk3oqoKbR0u9P/5rdoxlc5mQo0wRlUwSi2rWgT2ele1dbi3NqctR5
 xkLA==
X-Gm-Message-State: AJcUukc7cFVmB6o4BzTg/5DGBVh57ylv0zoIFJm5TMXaxnzt4YOcJm7R
 kqmQrGTGjqeUpb5/1F/9fIXW4A==
X-Google-Smtp-Source: ALg8bN4elrVkZx/+xtRZqyIM8PbE8pDnzz5A63wKiI9Vhou1RSuYQCaDYuX2DdSfLagFB8lDga9RyA==
X-Received: by 2002:a05:6000:8a:: with SMTP id
 m10mr33726539wrx.79.1548941981798; 
 Thu, 31 Jan 2019 05:39:41 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.39.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:39:41 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 01/35] ARM: davinci: remove intc_host_map from
 davinci_soc_info struct
Date: Thu, 31 Jan 2019 14:38:54 +0100
Message-Id: <20190131133928.17985-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_053943_735229_625DE34C 
X-CRM114-Status: GOOD (  12.01  )
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

This field is not used by any board. Remove it as part of the interrupt
support cleanup.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
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
