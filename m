Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92EBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:04:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA47C2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HWjw4qgX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mathembedded-com.20150623.gappssmtp.com header.i=@mathembedded-com.20150623.gappssmtp.com header.b="k1r0V9pz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA47C2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mathembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fqyVs3CRTw2oi4ZtpMIYgaUmBFXX96cgg8Bo6V5zRIs=; b=HWjw4qgXewQd+S
	tRrlp+eaFxvzBkvynPCiyjz4cfBeH/3w20IIZ2pgEWlac2ua/wQ9TOGJRbSp2fEiOq0/pQ6Ds1XTs
	dT63dEQHo3BGzGffR42kjE08GaZmLPglCXuCmI40yxRsmXWoNmk3ar8hwt1jPQSJd8kx6j3qMwUDG
	pa2QgR0nm4aCG/PJM0dYXUVaWDLi4YiEEkcHUFAYvpnyz8S0c0BRkrmQg9fUz1iJGM5LND+SEcCz5
	jbZQRTdHDQNEfeYS7gM3H9FalM4RBbbqNQDxSiC3xErGLa8db/C7UcHXzzJVwB1AN347PxXF3/O7u
	vWp0167j/WIb2xJW8JxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw54G-0005Up-Dd; Tue, 19 Feb 2019 13:04:12 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw53p-00050q-Ku
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 13:03:47 +0000
Received: by mail-wm1-x344.google.com with SMTP id y185so2215613wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 05:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mathembedded-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=EertYF60nStrNT1pM/X5LNwETvlDNxIyb8iUT32CCOc=;
 b=k1r0V9pzqPf1k7YkvK+Mnc+vNjIU1GBIaNunGV37gSaX1P4AMXW+Icvikk/vHx3AWu
 NJntWhXNfJAbuRhVzVg5M+ANzfcWhGKhJHxRAebEU/omqNK4wFjXlntQhtU+e5VY/4vN
 Mq9WdeweQ4bCjC81ClZ4i6d77vsxhvqleBjcHTJwlDlUszPqmzCcw8dPE4v974PGqVTg
 uLhQEkTxOB7AV3DhnPKlKkROcIjMdIkjebk+CMuLorzGkEMa4a94jpQ7UV3z+g3+JfGZ
 TN7RGNmf5UHd9q7Rb3LqXM7UlQOBMNeEgQTqLY2SCK5py/yXAeM91R4QUDU3NcGldrV3
 ZvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=EertYF60nStrNT1pM/X5LNwETvlDNxIyb8iUT32CCOc=;
 b=VkXGM9+5bvg4hEHhXOathplq+gf+YqBF5v54SwpB9ypLZR8ULmovF0o9iB99v0WHhj
 X0XV9htrtMPXDmxVGM9zvAZFHFhdFjg0G2qeJuNebCHHFiILSEYms+8zDA40gLAcjO/m
 qEQQruhUHrfuWGZcY9rwXmOJjO9XaKjJSOWY9luMNxcVglPZbuc77jGpXX3kJMLX73/F
 n2eeoANvUZURc+soou3bFDRvveyqX7g/mQDOqrj/7kIJn3ffZGeI7lFmKPOWJQL/P6GQ
 71LNlefJzbXGfqUoFyje6KYsJ4O9FLb5hLfrtqlUgkNJZi94hb7k8GuQ6u4aBME81yhs
 A3jA==
X-Gm-Message-State: AHQUAuaJmwkDSXSIaD7hT5L40PcsUpqZeVtT0gS88f95/ym/L/d/dRRY
 9A7K43OHQidNYxA+rj2dp0oJJA==
X-Google-Smtp-Source: AHgI3IahmvczfF6HiUC5cZZcrTMX3conJgIDIOKJ6IdgWS6h591ZBz0sh6VnyCcCDLAG9Vi5S8HNOg==
X-Received: by 2002:a1c:99c3:: with SMTP id b186mr2738670wme.79.1550581424034; 
 Tue, 19 Feb 2019 05:03:44 -0800 (PST)
Received: from diamond.mathembedded.com
 (host86-137-106-133.range86-137.btcentralplus.com. [86.137.106.133])
 by smtp.gmail.com with ESMTPSA id y22sm61899811wrd.45.2019.02.19.05.03.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 19 Feb 2019 05:03:43 -0800 (PST)
From: Stuart Menefy <stuart.menefy@mathembedded.com>
X-Google-Original-From: Stuart Menefy <stuart@menefy.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] ARM: dts: exynos: Add interrupts for dedicated EINTs
 on Exynos5260
Date: Tue, 19 Feb 2019 13:03:36 +0000
Message-Id: <20190219130337.21353-4-stuart@menefy.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190219130337.21353-1-stuart@menefy.org>
References: <20190219130337.21353-1-stuart@menefy.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_050345_685927_053EDD45 
X-CRM114-Status: GOOD (  13.24  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Stuart Menefy <stuart.menefy@mathembedded.com>

Add the missing interrupt information for the GPIO lines with
dedicated EINT interrupts.

Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
---
 arch/arm/boot/dts/exynos5260-pinctrl.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5260-pinctrl.dtsi b/arch/arm/boot/dts/exynos5260-pinctrl.dtsi
index b1edb20b789e..17e2f3e0d71e 100644
--- a/arch/arm/boot/dts/exynos5260-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5260-pinctrl.dtsi
@@ -153,6 +153,14 @@
 		#gpio-cells = <2>;
 
 		interrupt-controller;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 		#interrupt-cells = <2>;
 	};
 
@@ -161,6 +169,14 @@
 		#gpio-cells = <2>;
 
 		interrupt-controller;
+		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 		#interrupt-cells = <2>;
 	};
 
-- 
2.13.6


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
