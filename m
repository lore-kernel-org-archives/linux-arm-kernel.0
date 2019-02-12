Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1F5C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:55:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E9B42083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GatoUtO6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kl7ren/s";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="zMMMKSHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9B42083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wt5oqgGsHbcuxKPTEEuURX03bRgDpAh95EgrX4x03Sw=; b=GatoUtO6KhqMnU
	9hLpu86ovTl3p/QphqtFkEJM9gfA10lWb408SpmOdczSutLTryBOh0iRcqSG/jxjo5/7zfxBxAPgX
	gMxQ2wQRUNizYdTnM9ibtTRpcOozxQfBp18hU+2Wb44kwKucrVGcmjyy2PLTSEHIPeoOkt8CiQKHV
	1piVlel89hhJt4WaIt5ZuCbev8fzF2zINNjbF5FyeI3s75S2tPPe1+rF7EmFbsQoD7e6V5chLsjJ5
	eRkdh3IZ9kHqVsXuKD9NOrZycFzPY5Zz0cJIkuTOow4k9OIP1Yv4mhA9XM8utNw4LkCU8jffHgyDD
	KnWfk72Z+J/mI+MDGXPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtViW-0002s4-6A; Tue, 12 Feb 2019 10:55:08 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtViM-0002Da-R0
 for linux-arm-kernel@bombadil.infradead.org; Tue, 12 Feb 2019 10:54:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aM1xrGIBo2FFuSsmFTHMz/H1xNta7gzJkLnZYdQJhl0=; b=Kl7ren/ssxcRdR/QLxkSMAkDZc
 zN6M/mkdqs3w6CpS9YNaCy0ZDhW7hiefomRStNJj6iso2nuR+4bwZ7D+7H4N6STwMCVyjkXZqsOcf
 PcINn+r6u6dqwVeb8oRAGpBT+6ilwk0qcDty0cy1eMn5zamT/UNlfjVfLNyKzU8uf+eakqt0ekLZ8
 sdVXRN/oFm1Jda1FledisfxdDmuhE8w6iPttpeCSn3OqqTp73s4I57STNa/Dj9+JLkr2HEzgzIpcN
 WbXoM//TZDXeYflw9CKzwvm0Ii3nzpvECj5jv24Cnfz6SdujTdtVTiwzjtm1l3Px1i1MtQezwrbbi
 OZAlA8Sw==;
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVTH-0003ko-2b
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:39:24 +0000
Received: by mail-wr1-x441.google.com with SMTP id l9so2047742wrt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 02:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aM1xrGIBo2FFuSsmFTHMz/H1xNta7gzJkLnZYdQJhl0=;
 b=zMMMKSHFQibmHtmVol+4g5z++egugz+ma4x0V9e+S98FunxVu4sxjhnGYnGIZ5bIXw
 wIfhXxTbF6Tlrn7UbjvEJazD3Tdr5uwa22tYg3bVGL68GIKSRNAq2h6tV1t98wSUhg1X
 bc4jjGgWpyCUi0awNeRiAI6AQnnL9g1j9f3yLHZhbaFzZJFenWaFvLQ4DzY+iHJZfobD
 3T/+3BKim7DOpK4pXDbcFqRY9HnirCXCkb1IpvaDgY8qM2B60rmki9nN0/9tPGNI0TAn
 DU+fs92YqQ0uUnBzwOVPtniaDgKqXl3YoWEeEBZKC7+cOF9vRqZfdNBKCF8VehW5tMo8
 T6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aM1xrGIBo2FFuSsmFTHMz/H1xNta7gzJkLnZYdQJhl0=;
 b=M0MwbE1KtJeYw84JoLIvhVAAD+YoPs9tjq1Uxxoxgcnp6u/mdetUBX+Rsc8qnGutAY
 5lB1gt2OylRUUIstgoHgwUCMLtmMaTMzTxdHAYclUGjN4j/tu+e+f3CGkzkbd34YzqhB
 FhpJMgN43AWbOPNt7J0IxmwaHfrcvcfVxw0Q0jmHTHZYwJ6czCytz75Va38skvPdoLJ2
 Xa45F8w1Q8sKM4Y99ylNJMtmijrVR4CaJtTmk/uoSy9YbszEo2xkyv6A/1wPFogUZRbc
 1X9x36XE4IBrOs4BjgDdZ/+9CmSOm79KjGqaSL4oKUVrAol8uP75QBh2xN/aJi8iwb7E
 QynA==
X-Gm-Message-State: AHQUAuZuq+tRIrYxOU6z20R5P227bI92idZe/a9/Jhi2RBuYvgg9La8l
 z2faCvPS6zuIKZmhwiHy9HNO6w==
X-Google-Smtp-Source: AHgI3IaR8g4CNnlhzVYgQRzBLI1JVXA/2dvwrTWuQaYyILi/hBazVBrmalD7bNSIDHb/BRkJ5U+sNA==
X-Received: by 2002:adf:9f54:: with SMTP id f20mr2423842wrg.88.1549967961439; 
 Tue, 12 Feb 2019 02:39:21 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
 by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 02:39:20 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 21/37] ARM: davinci: aintc: remove unnecessary includes
Date: Tue, 12 Feb 2019 11:38:19 +0100
Message-Id: <20190212103835.7768-22-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_103923_140854_AF23335E 
X-CRM114-Status: GOOD (  12.73  )
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
