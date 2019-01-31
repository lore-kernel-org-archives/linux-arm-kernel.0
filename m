Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E84C282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:20:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4927620863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fU5ZKz40";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QVxvtZ1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4927620863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4ihkRiMjxAnNVd0eX7gFgJoGlJzpM7L5EXMzcjVCDQo=; b=fU5ZKz40nUuHxH
	CbgT+yxMOLVbv0/HXkrYPM+7UIdiGsMeqLpF5eH0DuEk+M3CwbwH44mzvJlj2ib9msvdqYRIpOkXX
	bYS01G0bttXrenRNG0q4zVDpOcFHo6aHEurGUHAWTgeMtfGjl57wS4NJP5SllNdfuS83KXzlXDU1i
	42cUPNl4ho4wjJBIOKeKCmqctoiwlkRZ3wudUEymKApLrDPSfvH56HdlDlBfPYZqiQE2hY3Rtlund
	A47H984+DFra2XSpxho25Sc92KG/4PH8xo48VuEhY/uE0FiRKmFcLuCiVf8X966wyGYr6e6vKBSyh
	dnGsMiXFQIflV/tqSt5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpE96-0005SJ-74; Thu, 31 Jan 2019 15:20:52 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpE93-0005S0-8p
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 15:20:50 +0000
Received: by mail-pg1-x541.google.com with SMTP id z11so1497479pgu.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 07:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ITDyul5zig3PGH8GrA3owY3o+NpX5a3M/wI7nP9lJaE=;
 b=QVxvtZ1eQRMWkF//cZXkKT3CkkRMhs13BoaWYdzLjO/yb/hiH2lEoDWlUJLni4THo4
 iPtg+oXRUKFN1/D5U5/WvHY2odUdap4mwl6Ne+TstB3AUf9MEviOs3grqTnJH85+xLcr
 rrrhuT9eoypbODOv5aHazROL5jrEypcdl+A0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ITDyul5zig3PGH8GrA3owY3o+NpX5a3M/wI7nP9lJaE=;
 b=OQGcOUMdNk9C15Dsqq9f10CZXoiZK42fWW8NJCMoMRJnz8Adj93oFasmC4C6f8yfr5
 YJU5uaaCC6n89pcLxAB7canK2JTtBR5P3Qv2ny95cB0vdtHy/Ktn89kd28pYh03T0Q2z
 kM2ziLc8CiFiKtEBDhpJwTXu74x4xn7KfwUl6xxm8Tta1bDZNFFwaAob1lzyISCCxS8D
 RSlZLTcsGi9bhYeqAM/jI7ygMquHkTTip1kRkwArlgBWtod4ZExsnesf6VafrtIurSnX
 D1RwEbnP80p7ic06Ag47dJ48SZReFSgAfpOpoVzcFJzLSwgzoCUpvZKX2TmZfbSMH1dA
 IK5g==
X-Gm-Message-State: AJcUukfQc5WHWarC9VGYK3X02cdnccpf4FeYnbuY1R6u10Ia0P+ihMs4
 BzhmglmYhr0Qh86PLP0eh/G0MzdBXao=
X-Google-Smtp-Source: ALg8bN7dVdxsD3j5WxY8KwQm4KtRPlX5fGZOb+YR6ofE8siYCCvcMtQM0NAzJ8c730McTKp33ELbFg==
X-Received: by 2002:a63:d450:: with SMTP id i16mr31369473pgj.246.1548948048231; 
 Thu, 31 Jan 2019 07:20:48 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id u186sm6633664pfu.51.2019.01.31.07.20.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 07:20:47 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 1/2] arm64: defconfig: Enable I2C_GPIO
Date: Thu, 31 Jan 2019 20:50:34 +0530
Message-Id: <20190131152035.7138-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_072049_463070_1E11233E 
X-CRM114-Status: GOOD (  10.55  )
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

The GPIO-based bitbanging I2C driver is required to configure
CSI data, clock pins on CSI block in Allwinner A64 SoC.

Let build it as module.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- rebase on master

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6e5af2563ef5..8f36b1e8017a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -347,6 +347,7 @@ CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_PCA954x=y
 CONFIG_I2C_BCM2835=m
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
+CONFIG_I2C_GPIO=m
 CONFIG_I2C_IMX=y
 CONFIG_I2C_MESON=y
 CONFIG_I2C_MV64XXX=y
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
