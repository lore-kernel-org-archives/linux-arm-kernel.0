Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4D5C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:24:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D5B2173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GaMN2D8i";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IPs0GLz4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tzgS+uF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D5B2173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YxJ+pj8JOgvoO7dSezAk22x6RChVVBKWPd37NUc9RYk=; b=GaMN2D8iEs+rtk
	wPvSggv/Sf5LCzYtmatrEmSCs9r8sRIMCV+Ds8H+i43SJQtA5/yp/kCD6iXSkvynaRQyuZO5lQthJ
	hL3S965YLCUN9kCwf2AD0829wGcvAVPk4TvDmunJ/VqV5t0wD7bfj88u7YqlLcLSyRYNI6Kjcc8U0
	yBfQA/yTOp2A3JJCmbvJVV497VVfqk/kUtwBH48jCFxajtUCSdIHaXmkOPEi/d+6rZLmiU+DgZ65D
	pDA98cTX9oDd5cCj9KC9FlsE+5ywz3XPCL0WgbPAnaR1j2DbtuZEZJqqYrjwFGDq+7A/ZYMpye+Gb
	hN763ZNtHJmcx1l1eBfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybms-0005UG-H0; Tue, 26 Feb 2019 12:24:42 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybmK-0004P4-Jz
 for linux-arm-kernel@bombadil.infradead.org; Tue, 26 Feb 2019 12:24:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2FgZZ1EvXiQW14YwhWJkkZvTKvqMw94PKF0P4G+L3sE=; b=IPs0GLz45FYUbTkyIBDLF9JlcZ
 zmzz9QoDWUDnOEz6f9JOWKYPylvC64ywYZaU/5vxqS5NQ4OHf3YmV0qQOH3BjAjW3n1qP9i4bihvy
 Qox8+haUVmEuNHFC6Cw4F2QEkaKaZyiGUyimYI9tBIxmTzGe05GJqrGa16xImfblSP8VH/N7TUAeZ
 A5PrjvKN70ppDi8b19NmxeWjbL/tTKuzyGp2KG62tNXPtwq58T98EGpWXBr94ez9YlGHO4xcySxDo
 fsqbO83l1kQj2laHSBThkcaLaxPCMau+PmFkV5g9/oZFRTWAQ9I0YUk/E+W3Mr5uFRPGIodCg6351
 zI8XcZYA==;
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybWN-0002lh-TQ
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:07:41 +0000
Received: by mail-wm1-x342.google.com with SMTP id n19so2140772wmi.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 04:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2FgZZ1EvXiQW14YwhWJkkZvTKvqMw94PKF0P4G+L3sE=;
 b=tzgS+uF9F9GSsACIgXXYU2lRUlanElCpH5tzyt9UCVDqcpYHelyOhBsWKfgV3W51TR
 lGkJj8jXQvLV4thwQVkP2pjdiXM37aOOIbY3cq+KL99Bbl1sAozH/3RUzeAhpv0kmShk
 ArGVNM97OcKuqoI/YOC/Sf4v78fPBkN+YeTyUg74salDIN2vXte8Toqx8ff1s+xUH/lD
 SzI3H30QfS0s90mMoON8tfbPFrWKE1SVLUEF+zPqSZfBe2fm4EwzW/eZ/XHZcmoEOkyH
 lSMp6HBlmhatZ/Lcbk3L5sxzP1UJpJKBi+SoISwfT+asVFTnPA2EnszGW1g8AnXSza74
 Qmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2FgZZ1EvXiQW14YwhWJkkZvTKvqMw94PKF0P4G+L3sE=;
 b=NgZspADgEZJ7EgDy191IpfHlTdx2pQ7RRcJakn3S/pqNXPtD6YiGm+BusLan7d2isL
 i6eKLofapPYR9e8myAIoSQvzbm8V1la04DJfDjeuEdYQSt83NsWvWiG178kjjs9pqY8F
 VCNOv9RxXCehvGOnx1nBuG6iastZQIeXDUERFtfgXZBasigJY7CEqeAvVm09ThyESQy5
 6m2nHVqIA5ttbMr//JqU+tk43Rh3nYe0GoMWb40EtPdYcTFdUQzwswKl4sU6QMadhHT3
 fLH2+U6PZzl7uN149RVF7dIjdXiDQWWyyMKJYD4BjQxGqb4v20Oj8ZFNe6Kh2FzYYXmf
 bOEA==
X-Gm-Message-State: AHQUAuahSLn91o3b0nE1fhiKIT8UNRL71wIHfWLb3sWoNbRsRcwKGMLq
 nH/QWlwa+GSdDYxnhvxH/qJaRw==
X-Google-Smtp-Source: AHgI3IZmEmWsQKkR1jNbodwtQrYqFRnzcqSd/SNj1IlIflOSuOgG64Ml7NHqeFRmExoUFJkPA5GU4w==
X-Received: by 2002:a1c:6788:: with SMTP id b130mr2589872wmc.102.1551182857584; 
 Tue, 26 Feb 2019 04:07:37 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id a8sm12642158wmh.26.2019.02.26.04.07.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 04:07:36 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 06/11] ARM: davinci: move timer definitions to davinci.h
Date: Tue, 26 Feb 2019 13:06:28 +0100
Message-Id: <20190226120633.18200-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226120633.18200-1-brgl@bgdev.pl>
References: <20190226120633.18200-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_120740_005960_162E9402 
X-CRM114-Status: GOOD (  14.24  )
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

Boards from the dm* family rely on register offset definitions from
arch/arm/mach-davinci/include/mach/time.h. We'll be removing this file
soon, so move the required defines to davinci.h where the rest of such
constants live.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/davinci.h           | 3 +++
 arch/arm/mach-davinci/include/mach/time.h | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index 56c1835c42e5..208d7a4d3597 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -60,6 +60,9 @@ void davinci_map_sysmod(void);
 #define DAVINCI_GPIO_BASE 0x01C67000
 int davinci_gpio_register(struct resource *res, int size, void *pdata);
 
+#define DAVINCI_TIMER0_BASE		(IO_PHYS + 0x21400)
+#define DAVINCI_WDOG_BASE		(IO_PHYS + 0x21C00)
+
 /* DM355 base addresses */
 #define DM355_ASYNC_EMIF_CONTROL_BASE	0x01e10000
 #define DM355_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
diff --git a/arch/arm/mach-davinci/include/mach/time.h b/arch/arm/mach-davinci/include/mach/time.h
index 1c971d8d8ba8..ba913736990f 100644
--- a/arch/arm/mach-davinci/include/mach/time.h
+++ b/arch/arm/mach-davinci/include/mach/time.h
@@ -11,9 +11,7 @@
 #ifndef __ARCH_ARM_MACH_DAVINCI_TIME_H
 #define __ARCH_ARM_MACH_DAVINCI_TIME_H
 
-#define DAVINCI_TIMER0_BASE		(IO_PHYS + 0x21400)
 #define DAVINCI_TIMER1_BASE		(IO_PHYS + 0x21800)
-#define DAVINCI_WDOG_BASE		(IO_PHYS + 0x21C00)
 
 enum {
 	T0_BOT,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
