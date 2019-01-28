Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548ABC282CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:06:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CDF22175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IQg5EFM+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ywwqSiGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CDF22175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=SnX035yCnLqG3KmjRXnDXRCG72A1REi+/e7BdTUb0nM=; b=IQg5EFM+O4JFWg
	NDyEfY14Q63HycgnA0QTHr2yn++ggmm2F5AGRm48hk6gGecmkbOKXu5ypENLv8LNQmZ0nsIlwsL7z
	Epg/CwREk5CZQjIPGS//GSCkNxWyj8FEnWPDyXwz17aPcf097NcwEaFOGyBxcYTOM3Boh/KM9wc5r
	4T5b0U99lAo1SUR2lf2CWJYDOKu7Yzl/pXHZhM+Zi9DCOnHVe2+zmbSom6yh+0k3nYZJ6VoMD/eBb
	jTLTm9YHE8RF0jJUv2bptI/PMzry2z1k/TSaks0ySyBjTG9BVNUE4nfvAa8YG+vM9Xyo9eq6VW5Ez
	y64nMeke9MpRHUO+rrMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBII-0005v0-DK; Mon, 28 Jan 2019 18:06:02 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBH6-0003fj-Qs
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:04:54 +0000
Received: by mail-wr1-x42e.google.com with SMTP id q18so19116730wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 10:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KzNtDTjaKqI9Jv9d2VdDxDqv10i26x5+1d6Xbas7BmE=;
 b=ywwqSiGBHHAMtivWCMTz63VvsWcJkDVuOu444eYcJxyOXM6l7QHo7SR0kZ7trWAw6Z
 Dj+uUKwJJYCkvtwYvdKlcUFcjXLd8ZJHirfZvJ20LLdIRLoRguGYDzffDF6jEPbTpAdS
 44eKxUr14k4zPQvaIRaxfZ5RlmPFKRRGN4fNvKm/yCykYiQVFaRV/xE8y6RPmD3W8v44
 ABgsKWTucN4WWa6OJ2zAdIQDoM8vlHhGRGz43uto4bpMR23FOJDYEyH5PGHxJ8BrsSUW
 RhgTq0yp9jCpYnJlUVLULFDJg3ruabzynNmIK3cYV6WTUO1Y7y68QcEq4YwdyZyIm1P1
 wT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KzNtDTjaKqI9Jv9d2VdDxDqv10i26x5+1d6Xbas7BmE=;
 b=b8kuAgn1N9+0Bu+Br7PO5LKESUp0Ygnccq8RIoQRBJGsfnyOipwV1l/eYMhV07JDNm
 IZpXoUiGny/wSL/Bk0HrBoYAHbShibUZMyArJrhwz37D6m+ni8ZbTKBiULYoNtEnu7VT
 fVaf0ZHZQ84Y8TJNjFpbUeVQsb8i19Va7WxDAwrg5I1p7oBDznwtY45fnYtDwlhUCSPl
 f6qn+V6+h8mh8MM+7S2s/wDQJ4qX97eZG2XkMR+Gh/O0f7bIpqLFDdsybsTcylgoSyPL
 ZrdkN/KFhhee9zUzEsIlZnvrLurVzbRy3f1MslInloLSL/IRYb9n48McZt1CZTBC2hNT
 lCSQ==
X-Gm-Message-State: AJcUukeTlT8fiDJxsTmQGW6k83ffnzAAl0f0SvcRILLr/k49gevdmM4Y
 U5A4epiNydbFHllOlo8naAo0KY7+g7M=
X-Google-Smtp-Source: ALg8bN6zuRuRmfEXj8PNM1eMQnbaZgjGdXS3lvonydlFr2RVbkqMa03NB99Vho7Hoz7TdM3JKkCmpw==
X-Received: by 2002:a5d:6647:: with SMTP id f7mr22600477wrw.225.1548698681545; 
 Mon, 28 Jan 2019 10:04:41 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.googlemail.com with ESMTPSA id p6sm145548193wrx.50.2019.01.28.10.04.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 10:04:40 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH 00/14] clk: meson: rework drivers dependencies
Date: Mon, 28 Jan 2019 19:04:16 +0100
Message-Id: <20190128180430.28689-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_100449_044880_8EFC05B2 
X-CRM114-Status: GOOD (  13.81  )
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
Cc: Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The goal of this patchset to clean-up the dependencies between
the controllers and the different clock drivers provided in the meson
directory. The expected result is that each controllers can pick the
the clock drivers they need, without necessarily pulling everything.

This is becoming important as we are adding more and more controllers
to support new amlogic SoC.

Patch 1 and 2 are out of the meson directory, so we need an Ack from
Stephen or Mike on this.

Patch 4 to 14 is the actual rework. The intermediate state are provided
to make it a little less painful to review. In the end, Patch 4 to 14
should be squashed, keeping the commit message of patch 14.


Jerome Brunet (14):
  clk: export some clk_hw function symbols for module drivers
  clk: meson: use CONFIG_ARCH_MESON to enter meson clk directory
  clk: meson: axg-audio does not require syscon
  clk: meson: move MESON_GATE to clk-regmap.h
  clk: meson: move parm out of clkc
  clk: meson: take the pll driver out of clkc
  clk: meson: take the mpll driver out of clkc
  clk: meson: merge phase driver and remove from clkc
  clk: meson: take vid-pll-div out of clkc
  clk: meson: take dualdiv out of clkc
  clk: meson: take clk-input out of clkc
  clk: meson: clkc must die
  clk: meson: move sclk-div out of clkc-audio
  clk: meson: rework and clean drivers dependencies

 drivers/clk/Makefile                          |   2 +-
 drivers/clk/clk.c                             |   3 +
 drivers/clk/meson/Kconfig                     |  84 +++++++---
 drivers/clk/meson/Makefile                    |  21 ++-
 drivers/clk/meson/axg-aoclk.c                 |   4 +-
 drivers/clk/meson/axg-audio.c                 |   5 +-
 drivers/clk/meson/axg.c                       |   5 +-
 drivers/clk/meson/clk-dualdiv.c               |  10 +-
 drivers/clk/meson/clk-dualdiv.h               |  33 ++++
 drivers/clk/meson/clk-input.c                 |   7 +-
 drivers/clk/meson/clk-input.h                 |  19 +++
 drivers/clk/meson/clk-mpll.c                  |  12 +-
 drivers/clk/meson/clk-mpll.h                  |  30 ++++
 drivers/clk/meson/clk-phase.c                 |  75 ++++++++-
 drivers/clk/meson/clk-phase.h                 |  26 ++++
 drivers/clk/meson/clk-pll.c                   |  13 +-
 drivers/clk/meson/clk-pll.h                   |  43 ++++++
 drivers/clk/meson/clk-regmap.c                |   5 +
 drivers/clk/meson/clk-regmap.h                |  15 ++
 drivers/clk/meson/clk-triphase.c              |  68 --------
 drivers/clk/meson/clkc.h                      | 146 ------------------
 drivers/clk/meson/gxbb-aoclk.c                |   4 +-
 drivers/clk/meson/gxbb.c                      |   5 +-
 drivers/clk/meson/meson-aoclk.c               |   2 +
 drivers/clk/meson/meson-aoclk.h               |   5 +-
 drivers/clk/meson/meson8b.c                   |   3 +-
 drivers/clk/meson/parm.h                      |  46 ++++++
 drivers/clk/meson/sclk-div.c                  |  10 +-
 .../clk/meson/{clkc-audio.h => sclk-div.h}    |  16 +-
 drivers/clk/meson/vid-pll-div.c               |  10 +-
 drivers/clk/meson/vid-pll-div.h               |  20 +++
 31 files changed, 467 insertions(+), 280 deletions(-)
 create mode 100644 drivers/clk/meson/clk-dualdiv.h
 create mode 100644 drivers/clk/meson/clk-input.h
 create mode 100644 drivers/clk/meson/clk-mpll.h
 create mode 100644 drivers/clk/meson/clk-phase.h
 create mode 100644 drivers/clk/meson/clk-pll.h
 delete mode 100644 drivers/clk/meson/clk-triphase.c
 delete mode 100644 drivers/clk/meson/clkc.h
 create mode 100644 drivers/clk/meson/parm.h
 rename drivers/clk/meson/{clkc-audio.h => sclk-div.h} (54%)
 create mode 100644 drivers/clk/meson/vid-pll-div.h

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
