Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39E0C64E79
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D087218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ENlpc7Lh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZ0Xpyz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D087218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=MlvVrYUsNch0lDG9V7yVn0ttueShzeCJMNDxEpKtPDA=; b=ENl
	pc7LhbatiTqclnlTD4hkZJmf9I5/Jsv/vrNfxY1jfls2Gc9IARKV8MFS57pVfP6g2y/c/0ut02MCj
	W8XudyofS/RTd3kldnLWHDBWeheCofAD27//bSYiGSxB5SZ+ctpOn0vNIAPwygBlgiFfwVqCISWHE
	Ef0D9yyHejfkkuwpHJzRpRNSwUHpUPI+yQKB1vmYTadxT01/EIusM71v3YBqZgj28la2VGN2hxVuW
	uXvSFvJH2mLujV1CsZe/ym1Xk6Z7Yt5bPAiLnLVj7Z9S74H8ExKuDAioD0pOirlSAfw7ryU81PSh9
	hV8lBEs05+SzvS6MrxoJUbYVjdFQ5tg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbYHd-0004Jl-95; Mon, 24 Dec 2018 22:01:09 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbYHa-0004HF-8g
 for linux-arm-kernel@lists.infradead.org; Mon, 24 Dec 2018 22:01:07 +0000
Received: by mail-wm1-x344.google.com with SMTP id g67so12631670wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 24 Dec 2018 14:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=wETRVoQwq1FJW2ofgoSV5BYdsGt8DeR49CADrQfmLZQ=;
 b=uZ0Xpyz1noBUtZPxGKJ88kUMB4+4hExjDMX9qwFOotCt/KgmhEvrhd06QkosTAcFXO
 8vi+xlJIrZt5jIyzBvZ3+Q6Btapx2lrEwSl4g2FDulaYcKUUL8xEXNI/JVB/Tnzp9Lom
 HNJrqFbyNjp0QEnDTZxxMHKXL0feL6qwUMyTs18RWriJUjNKDxxOE0YUPxRyYjzQMcKJ
 VVnMP54amhQvIAEsJbOmvf7EphWqpLIzioEk5IIlMnVkAnSAvSN+fJfL0ubQDmyg2uzH
 AdWY8rxb19LM2dM7nUIbiDyTUzD3nVgOdIPhJpLM5i2p+cMJbwaXbbUDpvu422LFKWpL
 w7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=wETRVoQwq1FJW2ofgoSV5BYdsGt8DeR49CADrQfmLZQ=;
 b=crw5MKTdNYL/cLJ9GXDARoKzHpJDOiGVDtWiPvyhWECMCTh+T+4jwdv7yWkdA7XDow
 0wmmxiPboAYFnK2Xq84aR0Z++0CifyIW2vPGMk55sDi/d5oZwnK/axRQzw0My5L4Inn2
 K2D8El02gJhW7mt8aM/QPXV+YcaG/FclOzr9qSDZvr8qx+5R66ldcKdONnw5pQNJvKrn
 LgxT1S0z6AIGVPfrIGdhX2pIitnFR9aZUXnU2gA6QBxxm0z4EidGgK7n9UQUAnZWN/K4
 rLzbyIK4iEfskdFV1avfyAmVkPhZ7RRxfXs37cUWDpHO2M99Fedy4ZY6d+rWGR5QpI8u
 wJMw==
X-Gm-Message-State: AA+aEWamAXCxrMGhC8EftcX0PpOSVM4rVVUji7HeWEagnfiSUqZC6ngb
 w4Kzlz2D9rIIt/YzVXrfMW4=
X-Google-Smtp-Source: ALg8bN6QPiUZSycrwzktCXQiDQnfq6CwkVEziEhl8FcqE9l6gWGjcjn21/n52shhQZmbM0RuFZfxGg==
X-Received: by 2002:a1c:f613:: with SMTP id w19mr13371149wmc.0.1545688852372; 
 Mon, 24 Dec 2018 14:00:52 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (daw20.neoplus.adsl.tpnet.pl.
 [83.23.22.20])
 by smtp.gmail.com with ESMTPSA id d4sm23970153wrp.89.2018.12.24.14.00.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 24 Dec 2018 14:00:51 -0800 (PST)
From: cezary.gapinski@gmail.com
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
 Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v2 00/14] Add support for STM32F4 SPI
Date: Mon, 24 Dec 2018 23:00:26 +0100
Message-Id: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_140106_311027_15CDAACC 
X-CRM114-Status: GOOD (  13.46  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Cezary Gapinski <cezary.gapinski@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

This series of patches adds support for first generation of SPI
interface for STM32F4 family.

This version of driver is mostly different to STM32H7 one. Based on
linux kernel I2C drivers for STM32 where drivers were splited into
STM32F4 and STM32F7 family the same approach seems to be sufficient for
SPI STM32 drivers. Therefore STM32H7 driver was moved to spi-stm32h7.c
file and register and functions were renamed to be more specific to
STM32H7.

For current version master mode with full-duplex and 8/16 bit data
frame format are supported. There is no TX and RX FIFOs like
in STM32H7. DMA capabilility is supported for messages longer than
arbitrary number of bytes (that is set already to 16 bytes) when TX
and RX channels are set at the same time.

v2:
Based on Amelie Delaunay recommendation only one common file
spi-stm32.c is used. Before adding support for STM32F4 driver, first six
patches adds some improvements to actual driver.
Next patches rearrange driver to be more useful for new STM32F4 SPI
and adding support for this family.
This version also supports simplex-tx and 3wire-tx modes.

Cezary Gapinski (14):
  spi: stm32: switch to SPDX identifier
  spi: stm32: use NULL pointer instead of plain integer
  spi: stm32: fix DMA configuration with only one channel
  spi: fix typo in SPI_STM32 help text
  spi: stm32: use explicit CPOL and CPHA mode bits
  spi: stm32: remove SPI LOOP mode
  spi: stm32: rename STM32 SPI registers to STM32H7
  spi: stm32: rename interrupt function
  spi: stm32: split transfer one setup function
  spi: stm32: add start dma transfer function
  spi: stm32: introduce compatible data cfg
  spi: stm32: add support for STM32F4
  ARM: dts: stm32: add SPI support on STM32F429 SoC
  spi: stm32: add description about STM32F4 bindings

 .../devicetree/bindings/spi/spi-stm32.txt          |    9 +-
 arch/arm/boot/dts/stm32f429.dtsi                   |   60 +
 drivers/spi/Kconfig                                |    2 +-
 drivers/spi/spi-stm32.c                            | 1403 +++++++++++++++-----
 4 files changed, 1139 insertions(+), 335 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
