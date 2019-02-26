Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C43C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:28:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36F89217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fEgqQUMn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Y2oYjNTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F89217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=H52nlIupGhTYqMHTHblYXZG4g02JxQw2TnUgC2cfI5o=; b=fEgqQUMnmcEkZj
	xAX4x5V9xF3bXTXzOBHTRSeh6q0MwOXiRUd9XDsANXw49sZ9k1i03HuPzUFrAGR+p4Q9jLHPW9n3q
	LxVy1K1DAtC1kdAWHdyAN1fn/BivXnwl23SjmK1PRPFNHMB+hnEwqGVjwAEe23Wy3+PeOKbzX8D1j
	+TbXm6V1uF29ifuVrBFO1fU8ajONXz0x4LSO/FtWfdtx1fwN+8bKcsk4WG7Mo+7DnyB//BX5COOmz
	lGYROWGFWOSpjGr3FU5Tk2UcJrXWwqVCzPf6y1Ui0h8VhgSxSHfqPba8fnTHlIiHUmG5SNAn7efwZ
	mMb4Ft8w8D30so/JJH8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyXAF-0007AV-G5; Tue, 26 Feb 2019 07:28:31 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyXAC-00079j-A3
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 07:28:30 +0000
Received: by mail-pl1-x644.google.com with SMTP id p19so5810672plo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 23:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CR7bGhJ8X3S3X+Ftt56vfvyr81HKGdBtyFJexoNFZWs=;
 b=Y2oYjNTvtPqBJYeI5TS0Tvs9RXv1SfueahV/wazvcMSCO5umwCTVQyMi/kpaHs/Wm8
 n8j/Z0TF15MVAez+y8xKFhM0Uliq2tJVgBIpRbE3qN3tnCWZUilYqxdHXKsVy2Ytc36h
 TjUOqVAhf2kFnlyPaJ+rO82SWmt+21MZMX4Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CR7bGhJ8X3S3X+Ftt56vfvyr81HKGdBtyFJexoNFZWs=;
 b=Ulq4ngD8I5N6o3vjF3g4LiC5KZpAAGkjfuT+NCqQH3sTkea/9gKR2JCw/8vuaKhSyf
 4gDFO3hE/4Aqq4cS7LK6mMFXJ9CfXKRT/o1VIXw/D1WqSc2gl2/4xDsKBhlQpueUPKoO
 87Gyr7RYLQfHJeJGWmL1Hr4lB0ExHDwAGzGhN3ZkQk+H7t7XcoMP2nSVUY5XHTCYhaEm
 uzAlhCihLxnboQUGE0/TIGQYTp3io9qFc+7EaJOh2+2M4haIQ92XyleumWipZLnLQnYF
 vqusvRvTBJmazEnw66cxO7WOvrKZQJGEfY62TawxwtYI70a+LFX1Ji94grWr94PeX1WC
 Kopg==
X-Gm-Message-State: AHQUAubDLOREFTsunAZjfo9DRiK6MIwnZvjJ3J0x0/ayahpPItaC5AhH
 cPp/ndFgpYiN2FUW7yK9mVrH4w==
X-Google-Smtp-Source: AHgI3IZtoP2cvWNml23Ak+skdR9rONyx90EOkMKmkBYneORB1vnk0btELoZbLNPDvLV11rePyY/KFw==
X-Received: by 2002:a17:902:9b90:: with SMTP id
 y16mr25031117plp.0.1551166106884; 
 Mon, 25 Feb 2019 23:28:26 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
 by smtp.gmail.com with ESMTPSA id p11sm29401365pfi.10.2019.02.25.23.28.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 23:28:26 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH] arm64: defconfig: Enable SPI_SUN6I
Date: Tue, 26 Feb 2019 12:58:12 +0530
Message-Id: <20190226072812.10628-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_232828_850325_DAF65207 
X-CRM114-Status: GOOD (  11.48  )
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
Cc: linux-sunxi <linux-sunxi@googlegroups.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable SUN6I SPI controller for Allwinner ARM64 SoC's.

This would helpful to setup spi flash, for another booting source.
mark it as static since it require during boot.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c39033c1a..d45e032c4d98 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -372,6 +372,7 @@ CONFIG_SPI_ROCKCHIP=y
 CONFIG_SPI_QUP=y
 CONFIG_SPI_S3C64XX=y
 CONFIG_SPI_SPIDEV=m
+CONFIG_SPI_SUN6I=y
 CONFIG_SPI_NXP_FLEXSPI=y
 CONFIG_SPMI=y
 CONFIG_PINCTRL_SINGLE=y
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
