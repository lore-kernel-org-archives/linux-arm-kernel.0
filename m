Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D29FC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 04:11:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E0E1218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 04:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UGbiTp/d";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MoNvlOcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0E1218CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=uLZzjY/YnKVzX67Vw7CAK+Zcjg3qpPtV/fX8nDiMW8g=; b=UGbiTp/d7tZTcjJ4BPopJoBlkH
	G2FwhBuSetElSK0TN/X/QQvsVi10KSMo/yN4tJUJncTvzrLMuezLih+g6xN/dLJOy6RZ7k1ii3n9c
	p/g0h9sINkEcGyq9sPEbLlffKactAcnz69D6DrJYvTq2uLu2vs1OIzYdd92ZzrywSsmIh+ftqBUER
	2mUTTtPAr0zwMJBiKGjppTo0lfg4L8uckEJyqFi0y6D0z+Sd+w8/ImorpIuaApXNboMEooQq5mo42
	jrCQfU6CxinyaCEZwwpFK9iOCXkh5SMZ+/i9OTwySS/u/3YUmNyRgR+xTsEK8VWlHQ4Tfk9+ysMJO
	zGBXdAUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnFJj-0003Zn-KJ; Sat, 26 Jan 2019 04:11:39 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnFJK-0003Ab-2l
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 04:11:16 +0000
Received: by mail-pg1-x543.google.com with SMTP id z11so5025770pgu.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 20:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=DnQG/HiE2U5xeSz8P1vTnKFViPBKRO7Pu6aoK2typAc=;
 b=MoNvlOcOqo37jI4uIVlvzASCJfgdx8CplJe84HYoIlxS0UuX8yPlRNFinxPV9+hYsS
 NcDdOyyEKURW0i8Afk1f3eAzwDmpOaGIk3hhNuwjRk3nXko4lgsL1xHwQ4a0TRj7KI9+
 xXnsP8BQOMbF3r1DJonTn/EeZizlFbRyKyDGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=DnQG/HiE2U5xeSz8P1vTnKFViPBKRO7Pu6aoK2typAc=;
 b=rKD8H6UlehuYkIPmZhZ13KLumcVY5I3FoGSClUDD/SiaPKcNZz+P2e0g8IibgTyiB4
 UuPQJ/xskvLj0dxoCcZmYxrFtq/oL1U8EplpIERboUoFOWh+/Tb396w9kxiADmevRhVW
 YanbsLGvnvxZrDvkkbORLg5d9+9oqmoqrCMKAM8LbGyrsSuOAHSrqe2f1cMcp0zkoNPn
 dERFMdBx5cUAKdlBJJ5zddobWU5dSx+iI1PFMHmTcLARei2ygIpmDdYPwgp2fDgTFqh7
 wyPHUGStYbazb60l6exJze96n39DwbG5Z5V2mHDVpiiPTCG9+tZV9K3D7d/L16inBLff
 HzSA==
X-Gm-Message-State: AJcUukfjzCCsZk1x+YAl1OqUZfEuIikFdXzjZzXl31FS8uL8jevePdpS
 XRKKoWgWGId19OImMyUGVntb
X-Google-Smtp-Source: ALg8bN7cbS+ALU+Gv9LnR4FVM55phzdF9O4D9GZv3oDx/IB1WSCNYO2C0fFU2rWSMVD38hRG2pbQug==
X-Received: by 2002:a63:4c4e:: with SMTP id m14mr12549096pgl.173.1548475872284; 
 Fri, 25 Jan 2019 20:11:12 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:905:e69d:b1bd:9891:c622:302d])
 by smtp.gmail.com with ESMTPSA id h129sm75099676pfb.110.2019.01.25.20.11.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 20:11:11 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: robh+dt@kernel.org,
	arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/5] arm64: Add ARCH_BITMAIN platform
Date: Sat, 26 Jan 2019 09:40:38 +0530
Message-Id: <20190126041041.13173-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
References: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_201114_386762_3C074AFE 
X-CRM114-Status: GOOD (  10.49  )
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
 amit.kucheria@linaro.org, darren.tsao@bitmain.com,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 haitao.suo@bitmain.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add ARCH_BITMAIN for supporting Bitmain SoC platforms.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/Kconfig.platforms | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 251ecf34cb02..6bb7db9126f7 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -52,6 +52,11 @@ config ARCH_BERLIN
 	help
 	  This enables support for Marvell Berlin SoC Family
 
+config ARCH_BITMAIN
+	bool "Bitmain SoC Platforms"
+	help
+	  This enables support for the Bitmain SoC Family.
+
 config ARCH_BRCMSTB
 	bool "Broadcom Set-Top-Box SoCs"
 	select BRCMSTB_L2_IRQ
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
