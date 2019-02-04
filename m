Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423AFC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:13:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 100012147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TLQUDvi4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ORVIbuvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100012147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ztUHP2D/rtbq/u+nepErcu4qlTpxV4U/uNSZmvfSq5g=; b=TLQUDvi4DMIpPQ
	QWOy6WaaV6LDhzE7yRhhpldS70f6Xwxm4uj3pXqvae6ewP7pTT5g+O13P5I8pQ2mQbnJXpnlNh0+Z
	7eiE+Egr3ROKwUiWlmSCjf72Qo1vL6Nui3Lwmat2tqD/El8pUREfalDFIkGoG8ocI3Qv6TXOougg7
	UpQfW4arK+0al7tXZbQv/16VYQ8cBeufqy84AQ/IftDA7ooDJzKOTnAi4k0TPID8P7ISGWy4hvT5Z
	9Vu96yx/Tu59iSPNroSsrIYUoKLzYByfw3U+vzUbPmVX2Jq4H3bJMFTvQZG+I/FrB4e7wK/xIfuKf
	qEtR5jNlegFf5im69vgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqaJx-00064E-06; Mon, 04 Feb 2019 09:13:41 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqaJs-00062O-Fe
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 09:13:38 +0000
Received: by mail-wr1-x443.google.com with SMTP id q15so2557971wro.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 01:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z/hN4UZA5/W8njVj2LODqL+qcn1cDZ7HkX1s6BIO7xM=;
 b=ORVIbuvcNN4weMu3n8EQCohEjHyBJlU6oJd+/6215aPa5qykD26XJlfrEyRjv19HlL
 g1YX3R3sCleOgUBpuBxcKFFD8CbQV4eiRXC1j+RFqghhPnu1m8rmdirk1i+15HaklM+B
 8I+2d9987Q6kCLo80Ne5IpgqJ4OwRxjJPu2OIhzdvq3g+m+4fC1nraIoX4vrVPh0HCIS
 xRsA8y9mj3VWxP8tbBUVWFLgqsBwQmBYiQMvJAmUDSwT1dgnoRHqIndL7p//b0V3mVlx
 6SHoOHQkFBidYf/kuTTz6HJR/o5GJogg3cQMefgVtg1ICaPzLqj68FBYFzlKcEkRzwYG
 wjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z/hN4UZA5/W8njVj2LODqL+qcn1cDZ7HkX1s6BIO7xM=;
 b=LdqZcJgq44FMGoFsbiphJuNboe0o5NErwlBfPSXsPBo7HDULisU0sXO471t6G7hswP
 x2/9y8lMdb8I5Zfe573OdnghOnFUjbiWMpRZTjYcq7GXCdJKl9zA56C5l6SPQIdc2CyA
 1DNFbjLDLyrV59eq3IjE/e0Gkjei1DCsStmClSAMCniAFU0GrWiORxdHOxTTRueMh3pz
 yofRb1SOgpFa3aIKmJLeKy+OFKiIi0nVRAnX6egLCA1wZS2XENwSZ9MYbw1mofWToECs
 jliNaql4qhoCEcMHpLWqCufNn2WdDdqI++95dQfmrKwINQYxPVRYEQN3BbXi8A3MrRzH
 nQAA==
X-Gm-Message-State: AHQUAuaoZnulwZ4qP8U6XWFsXiHO9o3BPRSp6EHg31P0K8jndX593Urv
 yVNtQ7tw9ya85c9r2SUAQTD5oTVbWWYbP/x+
X-Google-Smtp-Source: AHgI3IY9No/yQK4EZqRfNK0k8G8wTy4SKiWcWRM9pWkefofm9RpwzKWgcYkQgS34B5Hc+WRGg2z6DA==
X-Received: by 2002:adf:80a9:: with SMTP id 38mr32840375wrl.137.1549271614793; 
 Mon, 04 Feb 2019 01:13:34 -0800 (PST)
Received: from bender.baylibre.local
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id m21sm9371390wmi.43.2019.02.04.01.13.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 04 Feb 2019 01:13:34 -0800 (PST)
From: Neil Armstrong <narmstrong@baylibre.com>
To: jbrunet@baylibre.com
Subject: [PATCH 0/2] clk: meson: Add G12A AO Clock + Reset Controller
Date: Mon,  4 Feb 2019 10:13:28 +0100
Message-Id: <20190204091331.9298-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_011336_526630_EA94D800 
X-CRM114-Status: GOOD (  11.98  )
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
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patchset add support for the Amlogic G12A SoC family Always-On
clock and reset controller.

This adds support for clocks on the Always-On domain like :
- Always-On UARTS & I2C Controllers
- CEC Controllers
- SARADC source and bus clock
- Infrared Decoder/Encoder bus clock
- USB 32K reference clock

This also adds resets lines for :
- Always-On UARTS & I2C Controllers
- SARADC, Infrared Decoder/Encoder

This patchset depends on the ("clk: meson: rework drivers dependencies")
from Jerome Brunet at [1].

[1] https://lkml.kernel.org/r/20190201125841.26785-1-jbrunet@baylibre.com

Neil Armstrong (2):
  dt-bindings: clk: add G12A AO Clock and Reset Bindings
  clk: meson: Add G12A AO Clock + Reset Controller

 .../bindings/clock/amlogic,gxbb-aoclkc.txt    |   1 +
 drivers/clk/meson/Kconfig                     |   2 +
 drivers/clk/meson/Makefile                    |   2 +-
 drivers/clk/meson/g12a-aoclk.c                | 448 ++++++++++++++++++
 drivers/clk/meson/g12a-aoclk.h                |  15 +
 include/dt-bindings/clock/g12a-aoclkc.h       |  43 ++
 include/dt-bindings/reset/g12a-aoclkc.h       |  18 +
 7 files changed, 528 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/meson/g12a-aoclk.c
 create mode 100644 drivers/clk/meson/g12a-aoclk.h
 create mode 100644 include/dt-bindings/clock/g12a-aoclkc.h
 create mode 100644 include/dt-bindings/reset/g12a-aoclkc.h

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
