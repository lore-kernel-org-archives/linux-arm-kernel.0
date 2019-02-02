Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A96C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:48:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1EE120857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bcRqR0hQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QrMmENJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1EE120857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Subject:To:
	MIME-Version:From:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0uioowIG4zG+stAxTMAMZD7oWY/JY19tBaMQeLe7KTQ=; b=bcRqR0hQexv+9W
	Hg61bAlWi97VWZoV9RyGo8IjymFnAnPX/HtxV782xaHAy4paAsYfY7kyYIr6V9ri+s3yGOndRbF8k
	paYKhx5n/D8Ot9E2wURwTTpiVmx/STIla7wgZ3vcthmEAleioNw04nRYYdq50rW0PW2tzkECL0rJA
	gSaL1F6PwaiRglZsB2pRwqXwQ6+BQe9ihWZvEGnFoj6Po5l2Kofjg8/l4qjLRNVlmAw2UGUrc22Kf
	JJwpBHFHPhpwJC/tlKz+IpisyqWsHXsZTw5tyegfftgOHw90qzQxy8ul1lHWl8V7abrWyJ67Obx0W
	sZlLJcLSwGpHC4MG/epQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpySg-0007Vj-Hl; Sat, 02 Feb 2019 16:48:10 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpySc-0007V4-4b
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 16:48:08 +0000
Received: by mail-wm1-x343.google.com with SMTP id f188so9191759wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 02 Feb 2019 08:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:date:from:user-agent:mime-version:to:cc:subject
 :references:in-reply-to:content-transfer-encoding;
 bh=/E5cseiCf2VM6go13DtJ3Cj3nH7FX5EvWBwvS1pknUI=;
 b=QrMmENJRGEIBYdxjRsjbis576AVFShyezLUjyCSc53smhH/C0DAqCHF7siuJmpY8+7
 mqrSE3WDbyiZx6DSI3N9KccNY5woGuibjrsIWv8c3FdDD5iY1xTrfv4Ls4+yDyc05OjV
 1ruETTQnChwgPZF9AOEqi9KDNdG7YRnKnKrr7RHWCnGxysXn/gnIMgetNzEbFu/YaUnp
 Qjb9Gh2GQ+CEOpDjXe/2ff4DHY3shXDyE5xKXH/rdVrcUq/VRNIJu0zQzCRlluBPEwuP
 RX8QlQfhKGnUEpdJ0i+uSrGfCcQdMnGz6Rsxjkf0QNLBy32eLjHmgsLkG+8t13vxEiaV
 iVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
 :cc:subject:references:in-reply-to:content-transfer-encoding;
 bh=/E5cseiCf2VM6go13DtJ3Cj3nH7FX5EvWBwvS1pknUI=;
 b=mAZvz8/vPT2dq/sQODt9NiteR/Wd4MegPOOowY9X7SXH1dicONGXLxZAnRw4G9InR7
 +xp5Xs67Kg7zF/GWGAB24P4DQhA+sK3b0OO4Pfi6oGAieWdbTSjqp0TwxyJMfzunLZxu
 rUVWrv6+5XmtCUjVHJXi74gzPtuzYxhoXd57rojZkgOCEuP1DhY1/ohfLQHPEM0+3aZq
 x111If6PTTPhz4RtIvWQm2HPPMIkc0P+RclIkUWdpdTDQqXQutv5fdB85bo3d4GzD+6D
 sYC02Xc8xc1mIldbVoLUuyFr+dzP7+9o7RdlMNc03rbmidww0Dt9r7J3OgJNzm9KyEbt
 0CBw==
X-Gm-Message-State: AHQUAuaGjoWRnqBiS/sL4V4jmliTa2KUWw9MgMed6PBLylJBtPU75bwd
 J5sUMrwYoOYU3woIfJ2fboIKYA==
X-Google-Smtp-Source: AHgI3Ib3J5KjmLUBVR6Z/IE1P7jTdJKc1XMJyuL8ut3ezKO14F7qT7W9I/gad4AzcctVmoKIhPRKOA==
X-Received: by 2002:a1c:7706:: with SMTP id t6mr6529365wmi.57.1549126081536;
 Sat, 02 Feb 2019 08:48:01 -0800 (PST)
Received: from Armstrongs-MacBook-Pro.local ([151.216.141.110])
 by smtp.gmail.com with ESMTPSA id 202sm9071110wmt.8.2019.02.02.08.48.00
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 02 Feb 2019 08:48:00 -0800 (PST)
Message-ID: <5C55C9BE.9080404@baylibre.com>
Date: Sat, 02 Feb 2019 17:47:58 +0100
From: Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13;
 rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To: Jerome Brunet <jbrunet@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v2 0/4] clk: meson: rework drivers dependencies
References: <20190201125841.26785-1-jbrunet@baylibre.com>
In-Reply-To: <20190201125841.26785-1-jbrunet@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_084806_275873_234C19EE 
X-CRM114-Status: GOOD (  16.06  )
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
Cc: Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Le 01/02/2019 13:58, Jerome Brunet a =E9crit :
> The goal of this patchset to clean-up the dependencies between
> the controllers and the different clock drivers provided in the meson
> directory. The expected result is that each controllers can pick the
> the clock drivers they need, without necessarily pulling everything.
> =

> This is becoming important as we are adding more and more controllers
> to support new amlogic SoC.
> =

> Patch 1 and 2 are out of the meson directory but have been acked by
> Stephen.
> =

> Changes since v1 [0]:
>  * Squashed patch 4 to 14
>  * Sort Makefile alphanumerically
> =

> [0]: https://lkml.kernel.org/r/20190128180430.28689-1-jbrunet@baylibre.com
> =

> Jerome Brunet (4):
>   clk: export some clk_hw function symbols for module drivers
>   clk: meson: use CONFIG_ARCH_MESON to enter meson clk directory
>   clk: meson: axg-audio does not require syscon
>   clk: meson: rework and clean drivers dependencies
> =

>  drivers/clk/Makefile                          |   2 +-
>  drivers/clk/clk.c                             |   3 +
>  drivers/clk/meson/Kconfig                     |  84 +++++++---
>  drivers/clk/meson/Makefile                    |  27 ++--
>  drivers/clk/meson/axg-aoclk.c                 |   4 +-
>  drivers/clk/meson/axg-audio.c                 |   5 +-
>  drivers/clk/meson/axg.c                       |   5 +-
>  drivers/clk/meson/clk-dualdiv.c               |  10 +-
>  drivers/clk/meson/clk-dualdiv.h               |  33 ++++
>  drivers/clk/meson/clk-input.c                 |   7 +-
>  drivers/clk/meson/clk-input.h                 |  19 +++
>  drivers/clk/meson/clk-mpll.c                  |  12 +-
>  drivers/clk/meson/clk-mpll.h                  |  30 ++++
>  drivers/clk/meson/clk-phase.c                 |  75 ++++++++-
>  drivers/clk/meson/clk-phase.h                 |  26 ++++
>  drivers/clk/meson/clk-pll.c                   |  13 +-
>  drivers/clk/meson/clk-pll.h                   |  43 ++++++
>  drivers/clk/meson/clk-regmap.c                |   5 +
>  drivers/clk/meson/clk-regmap.h                |  15 ++
>  drivers/clk/meson/clk-triphase.c              |  68 --------
>  drivers/clk/meson/clkc.h                      | 146 ------------------
>  drivers/clk/meson/gxbb-aoclk.c                |   4 +-
>  drivers/clk/meson/gxbb.c                      |   5 +-
>  drivers/clk/meson/meson-aoclk.c               |   2 +
>  drivers/clk/meson/meson-aoclk.h               |   5 +-
>  drivers/clk/meson/meson8b.c                   |   3 +-
>  drivers/clk/meson/parm.h                      |  46 ++++++
>  drivers/clk/meson/sclk-div.c                  |  10 +-
>  .../clk/meson/{clkc-audio.h =3D> sclk-div.h}    |  16 +-
>  drivers/clk/meson/vid-pll-div.c               |  10 +-
>  drivers/clk/meson/vid-pll-div.h               |  20 +++
>  31 files changed, 470 insertions(+), 283 deletions(-)
>  create mode 100644 drivers/clk/meson/clk-dualdiv.h
>  create mode 100644 drivers/clk/meson/clk-input.h
>  create mode 100644 drivers/clk/meson/clk-mpll.h
>  create mode 100644 drivers/clk/meson/clk-phase.h
>  create mode 100644 drivers/clk/meson/clk-pll.h
>  delete mode 100644 drivers/clk/meson/clk-triphase.c
>  delete mode 100644 drivers/clk/meson/clkc.h
>  create mode 100644 drivers/clk/meson/parm.h
>  rename drivers/clk/meson/{clkc-audio.h =3D> sclk-div.h} (54%)
>  create mode 100644 drivers/clk/meson/vid-pll-div.h
> =


Applied to next/drivers for Linux 5.1-rc1

Neil

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
