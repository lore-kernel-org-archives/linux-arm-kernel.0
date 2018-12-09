Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C82C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 13:54:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 388DD2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 13:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HyT0y+RM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3isnTBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388DD2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=dfALFryrzXuoP+sOK5fo7uUBsMVJhYUAu4COlTOMf68=; b=HyT
	0y+RMkBtCeBuubNUTko9Fg3CoPPgjr8jpNKgpg7qgrIrLhTHW94hGC3IZE+Hdxi614MAbfxg6Xfo/
	WsgU8E3rvKJQ6lbco6sKgxtdVmEiVHQNVSWAYNPcuQBldF8tFLuqD9OsLHT2TryTiLtNWG8X3yUbV
	+vpMN1+T94JjOcxbIszz+dWqezvvy69+E+b/235AgY9nxYvkkPHO6GwR2taq9UVLOzyAvL3I17y+m
	oi+I8BLOP5HR5sj6LYqyflUDb1uwfBhKHmy7Z95ojNFyvO++0GO7SKZl2j/cf3vo28NzTxrO17A1c
	DM+b3VWRbbaSjw17jKErAlJjswAlPPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVzXZ-0005mr-0s; Sun, 09 Dec 2018 13:54:37 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVzXV-0005lQ-Gp
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 13:54:34 +0000
Received: by mail-wm1-x343.google.com with SMTP id q26so8592862wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 05:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=TcU5f/V8rP5wLgNb/i4F20N0yPSWixrtOv2pV4ZERPY=;
 b=g3isnTBVbC5cQrkjJmAgpM3v3+xeGsi/GysE0ep94hyITJsRBlSeH4tJ7l0MT1oAtm
 uYbZrLK9+40nrz+0KAiuP2cLCKkUJb3RUuWpYoifP9/bFdxLXFJf0goqGcAJ1d/02pLD
 hmoFb9zzCmTio1WN6AA5LdU/xKjpYEFXlRvdJcoZhKUpVBR6VU+c7hVZFhYv1lGhyZMu
 BDIABackbmqKWDGX1dynm4NtZeJ6KfTploLPrA6dSrco57U7AVDDsFinQdbv3e/a0R/c
 Jk2MaXR0mLFTAtePJOJP9aTbfh3NUEzh9UlEgRabjsKdzqHvPQ/NNg9tGplX7oYj0Sys
 h44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=TcU5f/V8rP5wLgNb/i4F20N0yPSWixrtOv2pV4ZERPY=;
 b=ev+L0He50tCC8eUuDdVT2zmJ0jqjMYeNiqwci2Zy93KnTySYTd4jD1Aj5doTaZjghc
 s80iQsmGRvhD6JFBTRh9IkpmRYWWtI8rSF7+L+Ah3oEiZQ52/FCJnOoiUR4b6XqzXW/F
 Owl+TXyLDc83RkejBGf8bNkqlR6bkL3G2MwodXbzgHItojSFgx33SlP2XSYOBKb9nkU3
 aUEZR9Fhnm3S3ESI3uwms/ktU2yYtxHzNFcfYdvarRjeno7JMwocA4p1FsMWajpYXHUc
 PeaZ6HEyR0u5jbk90YrBVNP1eistHi0fJHlkYc9Xkyh++DwsbgT9VmuI540evR2OMVYa
 Ebrg==
X-Gm-Message-State: AA+aEWbCJBzblR5E1KHnkJhsYO7etU3Xa3Jeb1q65epbQcp/RqZr0FsE
 8QiB/F0JL5qW6pjkFXfHk/Q=
X-Google-Smtp-Source: AFSGD/Wv1WuyM2jT4/F1O59lS0S2uqsdPSc3qb/9Ix75YU8vkrJE7pnb4Gygvpc3WupmmeSBg2ShLA==
X-Received: by 2002:a7b:c191:: with SMTP id y17mr7677752wmi.10.1544363661170; 
 Sun, 09 Dec 2018 05:54:21 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (dgv239.neoplus.adsl.tpnet.pl.
 [83.23.177.239])
 by smtp.gmail.com with ESMTPSA id k128sm12271795wmd.37.2018.12.09.05.54.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 09 Dec 2018 05:54:20 -0800 (PST)
From: cezary.gapinski@gmail.com
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 0/5] Add support for STM32F4 SPI
Date: Sun,  9 Dec 2018 14:53:51 +0100
Message-Id: <1544363636-12161-1-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_055433_560659_A32D9C5B 
X-CRM114-Status: GOOD (  13.07  )
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
 Amelie Delaunay <amelie.delaunay@st.com>,
 Cezary Gapinski <cezary.gapinski@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

This series of patches adds support for first generation of SPI interface
for STM32F4 family.

This version of driver is mostly different to STM32H7 one. Based on linux
kernel I2C drivers for STM32 where drivers were splited into STM32F4 and
STM32F7 family the same approach seems to be sufficient for SPI STM32
drivers. Therefore STM32H7 driver was moved to spi-stm32h7.c file and
register and functions were renamed to be more specific to STM32H7.

For current version master mode with full-duplex and 8/16 bit data frame
format are supported. There is no TX and RX FIFOs like in STM32H7.
DMA capabilility is supported for messages longer than arbitrary number
of bytes (that is set already to 16 bytes) when TX and RX channels are
set at the same time.

Cezary Gapinski (5):
  spi: stm32: rename STM32 SPI registers and functions to STM32H7
  spi: stm32: rename spi-stm32 to spi-stm32h7
  spi: stm32: add driver for STM32F4 controller
  ARM: dts: stm32: add SPI support on STM32F429 SoC
  spi: stm32: add description about STM32F4 bindings

 .../devicetree/bindings/spi/spi-stm32.txt          |    9 +-
 arch/arm/boot/dts/stm32f429.dtsi                   |   60 +
 drivers/spi/Kconfig                                |   18 +-
 drivers/spi/Makefile                               |    3 +-
 drivers/spi/spi-stm32.c                            | 1322 -------------------
 drivers/spi/spi-stm32f4.c                          | 1002 +++++++++++++++
 drivers/spi/spi-stm32h7.c                          | 1340 ++++++++++++++++++++
 7 files changed, 2424 insertions(+), 1330 deletions(-)
 delete mode 100644 drivers/spi/spi-stm32.c
 create mode 100644 drivers/spi/spi-stm32f4.c
 create mode 100644 drivers/spi/spi-stm32h7.c

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
