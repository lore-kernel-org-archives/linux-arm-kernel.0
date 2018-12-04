Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1967C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:59:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94AB82081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y7xekwSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AB82081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=d6AyqRs+tRK/fschmfAdF+Ujjrm/vJZBIeGWaRWEq4w=; b=Y7xekwSen1413+ksdWargCdgIt
	9btgKKpQU7qjXIbtt/Y7DcOeRQJHpM3nx63Ft8BbjQMcMV/97DgweLj7gbaoi51D0OIxZ9sd431pP
	fFjpfTK9cN0Q85qtcssVISpnt7a6Fm+ixe+/Xt3IRSzchcPxqfipK6qDmUSpZGKrU101cJYG08VkV
	vY6Oa7w/hyeU0b8rULaIj5c069BzO/vGkkULiXCteGEn6y4juTjmXa/Nsoj2RKYUjdhOMXWxEwU6C
	MM7JTAxqPtcIX1ale070qdvGn5XJOuN+DYx03At0mj8aaCBr11NKTtB7PyutmcIPnRwGQwz1gW7go
	daDlwlnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUFvB-0007cK-6s; Tue, 04 Dec 2018 18:59:49 +0000
Received: from mout.kundenserver.de ([212.227.126.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUFud-00073L-OI; Tue, 04 Dec 2018 18:59:17 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MFJfN-1gjyQ33mR7-00FlVP; Tue, 04 Dec 2018 19:58:55 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH V3 3/3] arm64: dts: broadcom: Add reference to RPi 3 A+
Date: Tue,  4 Dec 2018 19:58:19 +0100
Message-Id: <1543949899-13380-4-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543949899-13380-1-git-send-email-stefan.wahren@i2se.com>
References: <1543949899-13380-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:FFp5Wh7ZWhwN+0GnOIK4svX/EnE/lyWXYX5Q6pGbgpyE8/BWhkC
 HIozYn/aF1wiPHTyJBUFfAX8Bprfc2VwnJzzw9ujHYvH3l0PaQMDjk5EKXbX3EWjmbQumbE
 uyxkSsnoyLyfEVpoKKGGBgHPfzsATZGmLQj7UEyc5JvQ63IO0mdwywnOuI6LouMSJgs26MV
 +JgfGn5pKNrVStX597aIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:arW5q/kpEak=:fNkvQgi7CQng+s4ZxkqrAl
 Shfn4kUf6kIfer4UddefIfpoKpAvezKz/iNNcd8IyBLFrA++7Igw03sj4to2x9/kBAlIbVINV
 JnAhVKciAu2qdP8xqMbmGrnJGAbkK10jhSsT6ufbHWHJmtxpizWgzDEtqJqbr2nzW0q8WL2dA
 YT1kdC3TCVS9IEJKxyAi26mf/pxvvoheQAygv0WBdtTAsdN6h2JMB7v6CPtGjL8CNOc/OemQK
 3fY/E6rQzoT5vc6F4NGVDje+vTBtMcFX/UhkKkKOnxuzyVpUdWITkeFaumc6q3miLeqpaKzm0
 gnnb7Tg9xKNdmPM/Ng049Qgy9bVJ3dVXaWyq2QleJAAUrhwVvN6zE8ogokYxzYR2pdrHs19gJ
 AhPNAX/QaP1VreCRGzo8D6ZEUJEkyK7mLOOyikqWFCT3kUtsKlmPaUGscn6rckZVU2OlfjijC
 GeEfaGcIEPyc3THhrPF5vbLos5lydlZkvNYUygQ5aTJXELDvt//cC9k+Kad/kOP8I7qa1TCcS
 M5brT1MnDj9qCja12qrxpkjF6Sih/5y2SfQFHLt7YFTX/YkvceXtUq4c9W6rLxHEnZKXm4ryY
 3cuJDYE3oOS4y/WMEhgazm795HJ8heBOv6T1tQPYlQkkKYNH8HKfeVgXBLbgHJLdc9r5AnjyH
 fOMjzqx2WqGT7S9I/oYGpTw7NQjHx45WexYKfhHfsjwSN3P4KgwtpAnl2vE++IIWQGiv+JR5L
 xIzts9r8uBaSUO1QR5qJG0cWqG+/FFdstWp3TsP2SeC0YMgeXSz1im5Ho/4=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_105916_085499_9EF7BF58 
X-CRM114-Status: GOOD (  16.18  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devicetree@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds a reference to the dts of the Raspberry Pi 3 A+,
so we don't need to maintain the content in arm64.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
---
 arch/arm64/boot/dts/broadcom/Makefile                 | 3 ++-
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts

diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index 667ca98..d1d31cc 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_ARCH_BCM2835) += bcm2837-rpi-3-b.dtb \
+dtb-$(CONFIG_ARCH_BCM2835) += bcm2837-rpi-3-a-plus.dtb \
+			      bcm2837-rpi-3-b.dtb \
 			      bcm2837-rpi-3-b-plus.dtb \
 			      bcm2837-rpi-cm3-io3.dtb
 
diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts
new file mode 100644
index 0000000..f0ec56a
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "arm/bcm2837-rpi-3-a-plus.dts"
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
