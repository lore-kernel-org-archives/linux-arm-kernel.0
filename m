Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496AEC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:38:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E2D218D2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JVWWTJ9V";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sE6aka9P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="g1PCSE8H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E2D218D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rLInrmz7GAFNobJkO9UfWAbD2nyD7QghwtYKcwdeYY4=; b=JVWWTJ9Vq1bI26
	HMwIYeilC28+VNuCLmUrAOXSWCOs+CHcrCE0flNHnFp5lwut/AJFSc4KPVW15ayHXfFBLjb5wUXRV
	7GKHfASplia/PKs28kPWkDart2lugLWrIy7gS1izZEJUbbba7pivEVacf09ErIvtrZRik+uqMhF0I
	PO175p54xrj1mxkUOdOt8mEq0VllfCI+JpD0ObjnB6bMad8w/VoZtL/n6XJV1/ybca9KAvcx6M0y1
	bC7GyKlqdf62cTVBoSxJhlId/k6mQnMaOm4IIofCfg5cjosFcPx320Xw4gS/LSucycDaNpH2eLGj4
	PE2IEhc1CS/P7OCpjP0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsA6C-0001Kx-Um; Fri, 08 Feb 2019 17:38:00 +0000
Received: from merlin.infradead.org ([205.233.59.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsA3r-0007RH-27
 for linux-arm-kernel@bombadil.infradead.org; Fri, 08 Feb 2019 17:35:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=krZKYWoU8pidQJSuC93zX28N7u3H16YP6+0fJKp65YA=; b=sE6aka9PIBhK+omEdrfjcFCpQb
 bZWD2HwsDE9arN/0Y79Z5pcjju+0tz3i8H5iHd8S+0tNRW5dflarxJEyquNbiLD/J5+vUnQffzuFB
 KrpyPrSSPXT0Ft2u2Rh6cr+sqltxzRaq/9gTY0MbDWlKJ/iQUIp45AXt5HdEP+6tjli8n7dHypmC2
 JZLmxSE4GL/WWaOwAk9hE8afukLDa+lJuU9CiGvMvoNeL2kOzotcOrH3LBP6/F6IWtYVZbtiUddPc
 H0r96CdVKooGBuT30X+Th6/sOeUMuSmibF+UPHfuTZStN/GA6r4Sm8VpCANkO1UfaxxTxdj5vSiM3
 R2H8NHCw==;
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsA3n-0005q0-IA
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:35:32 +0000
Received: by mail-wm1-x344.google.com with SMTP id a62so4351111wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 09:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=krZKYWoU8pidQJSuC93zX28N7u3H16YP6+0fJKp65YA=;
 b=g1PCSE8H4NRPRwdR5gSw9St8gLtnFSfzX+xkJidkPUsJsGIOzc3pw3FuScFZqrjNxx
 chfJBd+lXeZw0WTIonBnYn/Isugire9ZiVtiboJ3wdBMywQ/EyXV1GEeHdQtTkGwWlrA
 NrtBJ9xVcMMc+6tblnK3PmlIsY8ZuqG2k+6O5LMA6QyZxXG/kqqxW1f0nLyvGQlnILIu
 6rnv/Pk2ZaqZ+Lp0LAqwh1wfFs2A1WIHKUAE4Jxr4xDb+cfzZn0aqAM5rC9AhTTP5a5m
 OaEGsMSrTIGBMtyUOUJZniXF+JXIs9GcDEhMFBjefyQkPdYDJbtiqHwptAVlzmXmPAvU
 eQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=krZKYWoU8pidQJSuC93zX28N7u3H16YP6+0fJKp65YA=;
 b=DebGHbOdXQ1GPVL0xY+wmsYf1YdrVAdMMXIFA6xqItiF9FDgChDHIIgcwko5TTxdmY
 Nkckt0xjjRAl//BcidkcroqdBti4BpI1wfG3jS59TiouFvFXDi1ax7cwh+y7ZckomK3S
 0fosvb/TDjXal169ALOzsViOH+Tts88M/Ld3sAQv+4K16fbhaiSZX1By/fE2Pjjqqwqt
 0nheg6dNNDzKvohKjobBAMIsuCXhkPG7e8mYAvLNr/1CdW44z0ifaGNaiucQPLIaeX5N
 1kCX8UM7d2TVDuobuX1QOPv+QIgacsorUr2ENjsaRREdCOJY27wfdyPvKBiB/bsWmb+C
 UQmQ==
X-Gm-Message-State: AHQUAuazG2ekgLcvPbYIOrUI6Gg9NtUQNqMz5H3cELvBfLrIcXRGF4YA
 NDXe39p2oOi8uYr/hc9B3/k1eA==
X-Google-Smtp-Source: AHgI3IbgQ/VM6XgrgnNUQ5bh34WjL5FESmPkUww+I9D6IlcykpHcCr/TefDLN7RCHYBkPQKD4t1/Qg==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr2801634wmb.148.1549647327937; 
 Fri, 08 Feb 2019 09:35:27 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 09:35:27 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, David Lechner <david@lechnology.com>
Subject: [PATCH v2 18/33] ARM: davinci: aintc: remove unnecessary includes
Date: Fri,  8 Feb 2019 18:34:43 +0100
Message-Id: <20190208173458.4801-19-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
References: <20190208173458.4801-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_123531_634251_E3CC53B2 
X-CRM114-Status: GOOD (  12.26  )
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

These includes are no longer required. Remove them.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/irq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 0f469c59acfb..0768edfc3b66 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -12,10 +12,6 @@
 #include <linux/io.h>
 #include <linux/irqdomain.h>
 
-#include <mach/hardware.h>
-#include <mach/cputype.h>
-#include <mach/common.h>
-#include <asm/mach/irq.h>
 #include <asm/exception.h>
 
 #define DAVINCI_AINTC_FIQ_REG0		0x00
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
