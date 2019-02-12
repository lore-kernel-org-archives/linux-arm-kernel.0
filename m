Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937B6C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:23:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62C4A2186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KxokHB4m";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="o9dUh1Wu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C4A2186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JDiADQq6qZ9mJT8vwaNz+4qXgxwOtc5TaHIAqN80MZY=; b=KxokHB4m4BOTg1
	L9kbu1bWaiEm35VgWA9VjEc3Qiwqp9ayU7E4uoMKzjDTk/ZpC5y0YPIg74U03M6uvxzim6tvBmAoC
	HsbbmocmNa0lihDaKZ5vneh1Hom9nxz6qxTgf8uXtvK0/euGZ7NxSC/DxKQIs6kK6XgVcB7ScwIeE
	4h0bGOBcP5Eep3bRyN+9hZdJcdhY92uRerqzUDIRzqoMo9WRX2nqoRJhV/Jr2hJxcsSmGqJzgdxy/
	4uLM7JV2zekVwaM1kzDTMcBoCF3J3ezFhI5Kfodnv26jJVtol4On5AD1UBG6CZfOBmh4lkUL2BUFq
	kFfB8ibgllJMudgD65KA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtYyW-000374-3I; Tue, 12 Feb 2019 14:23:52 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtYyS-00035Y-3T
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 14:23:50 +0000
Received: by mail-wr1-x441.google.com with SMTP id r2so2854957wrv.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 06:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZG3De299oLFFk5dERNO5JVx+5pMyQTogB9vh2Bdbvnw=;
 b=o9dUh1Wuu24ngMSSyOBxY02FUnv3Fdp8Gl6X2n+1tetyTCMSSHivsSd9WAha1CXsAf
 Oe6+A8J/7HLJ1a7ayNLe28Ujgr37+GFay8S9/aJ9CkkLaZ/SZNomKyh1Rg4AEt1kgRbU
 YLLluatgf7y2J7yIE2wQZHjWT5PXQiimgZBtxe7a+DsUc4BzwT7KBa8U0SXL98mcy2f9
 Z9/zeEx86QX+xZ75QIvPxg3RsS7/ui4WJTi/m4hpn5w/5cABXhEOhQX9L/3GL2sk4WMn
 zS7pAmw+mT+lM+Nvpn8G2ICTRJeoCOunaT1+IZ6mvmcV7ZIK3UKQRmy8Qe/JpQa3SaW4
 YVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZG3De299oLFFk5dERNO5JVx+5pMyQTogB9vh2Bdbvnw=;
 b=GSc4TdR7frWQhgdcWaxo+s+6pK3yfs+AJ3QTnsCugV5BiY547zZRTDvukA1im0Zf1i
 4Wrw3t5GQj+vtTvU9gpm0QmaC2CXpcN+ZVW942oO6vSAlR+p8p+aWRSApz/QNA8DEasZ
 fLHOUR/mSLp+iaRghNPCBWKcmNsCHDUkyi9v6keR5S6vZAa+d6Qgkavg8yewG1YqslGc
 P7b8mJwk50P7ggX677pw0NUuQOBMIffvQaIlzAt9WWPuKAsXo4fo9TUMD0uZ6ASHDWVb
 pZyDY5aZXYnlmFRZbtgpfx6zK8bpC/tTVD1Q8TFQa7eQSIwJ1u0MksCqNUdjq2Wq648D
 9bVA==
X-Gm-Message-State: AHQUAuZJZ+n2+Y/zduF/Jk6KwtF7+SaBBMp241DTKsuKc0uqEI2TyOFv
 DIzWU9jpFxiBtfqQSOoWyUd3/a3gX077Bg==
X-Google-Smtp-Source: AHgI3IbCXBU8Yp+zJ34yAUx1SNdEn3jRMsPv1Fy9to0JPtp1vVW0scNwQdvOLfil0egE64Imk+RufA==
X-Received: by 2002:adf:e641:: with SMTP id b1mr3007847wrn.213.1549981426490; 
 Tue, 12 Feb 2019 06:23:46 -0800 (PST)
Received: from bender.baylibre.local
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id y22sm39043216wrd.45.2019.02.12.06.23.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 12 Feb 2019 06:23:45 -0800 (PST)
From: Neil Armstrong <narmstrong@baylibre.com>
To: khilman@baylibre.com
Subject: [PATCH 0/3] arm64: meson: Add SoC ID detection for G12A
Date: Tue, 12 Feb 2019 15:23:41 +0100
Message-Id: <20190212142344.13634-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_062348_143810_E67DE1AB 
X-CRM114-Status: UNSURE (   8.31  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patchset :
- Fixes the package id detection for S905 variants and AXG packages
- Adds new SoC IDs and Packages IDs for G12A/G12B
- Adds Add AO Secure node for G12A dtsi

Neil Armstrong (3):
  soc: amlogic: gx-socinfo: Add mask for each SoC packages
  soc: amlogic: gx-socinfo: Add new SoC IDs and Packages IDs
  arm64: dts: meson-g12a: Add AO Secure node

 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi |  6 ++++
 drivers/soc/amlogic/meson-gx-socinfo.c      | 37 ++++++++++++---------
 2 files changed, 28 insertions(+), 15 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
