Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D472CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:10:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73BCA218FF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cCJLb+XG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fZRB6Dkz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Rvul6yt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73BCA218FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wt5oqgGsHbcuxKPTEEuURX03bRgDpAh95EgrX4x03Sw=; b=cCJLb+XGP20j4F
	0cdq/DUMgiNZVXsHKK3fXpCRkB13tkWtGHbmSR1ItXQW3swazHwuHQ2Ffxkv3eXDc+ONIqiC2oeG8
	Ig/H+tRNYmwbm86B7JUrQDFs7vrL55RGfgXZ6yOibua5rGR00kGEOiH2IxrbSXNNQuCvbgvub/e8L
	zUFs/Q50tmOAmA5fqNK9nzLVxrroplRnlXHn0H/VYF0TDGk1BEV2u58BnK/+3rkjuVUCWNyf2w5Xv
	G9dFR+v3/uEud3kZa+mWVl7F2ko36Fqfn2fYxWSVRfVRkeCT/c2fqkY763KRepRCWqHBT1LudPFy+
	fDojBbUHXBqlJEE4aq9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guIev-0002vJ-HK; Thu, 14 Feb 2019 15:10:41 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guIeJ-0000Jk-VJ
 for linux-arm-kernel@bombadil.infradead.org; Thu, 14 Feb 2019 15:10:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aM1xrGIBo2FFuSsmFTHMz/H1xNta7gzJkLnZYdQJhl0=; b=fZRB6Dkz09p61AtWMgdDGUv8ZU
 5nFq1gLnUKQ4wuHpKwB9arfWgRbOgariG/qulZ5fuJYqxleLucPFilJ9O8+mT04QVS/JIpLdtAt9i
 IUDALjHK18fggjj3G7f4xaODBwUe0hxWhNkXVsHgZyd09y5VxrK9F3fiOdFyBJyVuA6r2Uv3qdPTV
 SrAwBcX03BCMgG86dZRP9No1FwSu6fDQXX5ZTqi6+2ah9/S4PVXQK8T9FXsvgqa3hnprWIO3ocZ8O
 s/ITpeyFW1DoETGq/IwT2kT7ZFDeSHnSxXBWxv+10QogqCum64qFeBNjs7HpZtDFn3AS4noir31L9
 NnS1aR0w==;
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guINy-0007mr-2e
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:53:11 +0000
Received: by mail-wr1-x441.google.com with SMTP id f14so6831845wrg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aM1xrGIBo2FFuSsmFTHMz/H1xNta7gzJkLnZYdQJhl0=;
 b=Rvul6yt72Uwr3bRtEJcC6I1BHBHLO17zBhrTDZp+43ywZo0tX7Nc1nfQaV1nQfdMg9
 KAqsCKeRnHEk33COzaf+0D3Oyn+V5g6J+4tKCe3/EZaqVfUWINfzl64oqlqrF4FW/C0V
 qer9hhgHSjxeAoMmS1Cj0HHYaQt73qlwQVo5OV9pDV++fYAVvxDrFsgYWOgMe1LztAKX
 u2Lp9BWwY8O7llkhdOY6DUMADHclTrCF2I7jdLPTAFKRKG9L88TX8GW+x6+Ef4XjjO8G
 2j6rwfOQ/uixpmalXr20n2FaTk6ugI2Qq4zPtCiH3uGPwYXc7VHcLPt7pR+p0baDy0mu
 dpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aM1xrGIBo2FFuSsmFTHMz/H1xNta7gzJkLnZYdQJhl0=;
 b=VM27UdLAH4wD27yr6ddzZchMBJ7FpoyqG36r1xRH4648gdCJEMn8m0OxBhq/dpwa+s
 lm4OK76fB/29I7z8JBS9YZ/muAsjacpr8LG3jzuxFvggZuxMniL4EN6WBa9w7KhO/jTw
 GBDmQv6Q+mU0Bk7/KiaruBjqAlcODyCN3cb5pJRceuIf8b//A5lpY6e4HJCnfk4n7LIp
 SfG4Mym01AgY+2VSigNjHEoheeNNv+ZfrXY2rOTxDR31yd4SDk0uC7m2Bqtj4HPwAjMZ
 DrKBmwo247Qzc41nr9J8a67SIRnWUi1QDIx462w3VsSmVGtYCN1Mp/X1kch7cOIW5XWY
 uzxQ==
X-Gm-Message-State: AHQUAuZKX9Ubhc1ev6jg/5lLGxCEJL1yiuu9LA1LsNm2N7x2FLUJ+7ik
 MzGtH5VVlIAr8rCuZ6srIPoXnA==
X-Google-Smtp-Source: AHgI3IYrmPhX6LitBswpX2LropaG4cWp7UbgyexCuEbIsp79u6SnchGmw2yORC9r4/JJ/EwEmejPcw==
X-Received: by 2002:a5d:5506:: with SMTP id b6mr3015045wrv.33.1550155988226;
 Thu, 14 Feb 2019 06:53:08 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 06:53:07 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 David Lechner <david@lechnology.com>
Subject: [PATCH v4 21/37] ARM: davinci: aintc: remove unnecessary includes
Date: Thu, 14 Feb 2019 15:52:15 +0100
Message-Id: <20190214145231.8750-22-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_145310_151538_18114410 
X-CRM114-Status: GOOD (  12.29  )
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

These includes are no longer required. Remove them.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/irq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 92b6e653d8cb..810ccc4fe476 100644
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
