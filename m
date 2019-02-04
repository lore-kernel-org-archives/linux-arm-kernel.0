Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B58C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:19:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FDAB2080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mO23nl0g";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="F1jCRjN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FDAB2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BH49d0MYwrgSUnhplXRpacZWgvVMoSi7+2BaEL+AEgw=; b=mO23nl0gc/Al+T
	iFsTXJ7j10QrDV5bMhfXlvGJARQt+gKCwhZp5n71JCWc72X3U9YOVvs8ku1L7PDQyDlkn/NzfHwGy
	qOW80bGaa6OxktKbNcQX8JTBbIyatSUvLdKLgrbaS4Z16a4Z01by8Fb9LL8hO0GmfQ7XDfCS++LDj
	3GhvqoJ+hHXmT3vo41/1ex/3rmDJrt+JBTrlZoAz4JgibS0lf4lAQQ9suNooiT+H/cZJa17RraLdg
	YMmE0zvNW+VCdzohHLQuZ1EBmVzqe5mKKsm+a6odfEzm5+spBNnXg2gTlwS00YUUUTeHiReu24EZg
	UJkqCQZfNH9bmoa4MNrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqhuP-0001Ug-MS; Mon, 04 Feb 2019 17:19:49 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqhsv-00005X-0F
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 17:18:24 +0000
Received: by mail-wm1-x343.google.com with SMTP id m22so751503wml.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 09:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cL06X0SvDGMjwFcjqHY6E+rz25qUhZDQqZhRx5iU7ME=;
 b=F1jCRjN8h8/nMYlj12bcajal+uotZrxHk42c9h4CQV3w8N7Jmhl4MBsR4mruIs8czv
 hhjG621Ul6NTAC3hqPzsV2JybtBfP7R9xaaRmKLv55C23v49ZEpqlSAgSudEdjW5+PhA
 ib8aofUBRsnb2QV4q7BGjpALJTTAYhMg2IuF9DRN1V4tN7bz4h6ktGxyQErwVqqFUrjA
 BP2S1QZbDfW6EsWZ0lhXx9E5orB7txQMiFTjx96NBKRhz/eJsKD+OnXQrR7wRVYadXHT
 j90ZyaPDWP/L9ByaF+9J3Ocdnk9szuX+zJloQ92zJwTltvEqIl8t+z12UxSYgNT5DssM
 p+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cL06X0SvDGMjwFcjqHY6E+rz25qUhZDQqZhRx5iU7ME=;
 b=d+D/Dy+FKB8M8rZaZNJmOkCIsbQo3OmAxljXvaAAXthUHjxLnZbedGsDA7oOTCjKJv
 drcAkuNB62NNHXPdXzWkroU39TG2zRYFKsmBLKXqnmI2clQcFZF/+xJovBqz3iW1mGrM
 mE3xOqw7PgszDpd3XwtBoMzSDhJiGk4+mf1Fru09ds4yqBVrbvCXOd0JusEnLq7mQK5R
 xOwXMEM8DsJyR6O9ZGkAhjR4Xi6NsbSpdUuHT9Htxesoordvpft7qQ/1cufw57M94bLK
 CwEfhED3VrUZozQ9VXjNomyXNkr5/pHB3ftFIxaLZHlq3cpbJ+dYx3dBiy47wRzCR5sI
 8FCw==
X-Gm-Message-State: AHQUAuYbkoPhkwOI9MdY/CDweM1TVwXoUx2Frw+A19UbpY6TBrvSn0Ae
 vVK/Ff+qi3Vv5JQ033Z0JMV67A==
X-Google-Smtp-Source: AHgI3Ia+a096I3KabgzhorfVAQJI3FLct3YvppdB9aSJOuW9Y77GT0Q4bikWwc/27RSP0jRxc99ElQ==
X-Received: by 2002:a1c:570d:: with SMTP id l13mr307866wmb.139.1549300695211; 
 Mon, 04 Feb 2019 09:18:15 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-8-223.w90-86.abo.wanadoo.fr. [90.86.125.223])
 by smtp.gmail.com with ESMTPSA id q9sm11197506wrv.26.2019.02.04.09.18.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 09:18:14 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 07/12] ARM: davinci: move timer definitions to davinci.h
Date: Mon,  4 Feb 2019 18:17:52 +0100
Message-Id: <20190204171757.32073-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204171757.32073-1-brgl@bgdev.pl>
References: <20190204171757.32073-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_091817_642654_58F7F5CD 
X-CRM114-Status: GOOD (  13.93  )
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
index db4c95ef4d5c..dfd1b1ab7b59 100644
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
