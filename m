Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869F5C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:05:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54B4F20856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KsOjypFW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Qlip9jCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B4F20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Subject:To:
	MIME-Version:From:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RHUlprQgma2VRBSbVcELM7otEAtRaEyhXqIe42CXcBs=; b=KsOjypFWxIqGyv
	F3drXxIpOfWZ2luei/P28SPrr2DMKmAvD+14V80KHd233+aMupBvyTxThzDs5jHVq7pMv2PQQHoLG
	WoOf+OZJqqS2DH1w5PSC+XbiT45cN7M4zE29qSGL62yI3q5qqzHN2Ndkm5NCPriyz/0CixIrkuz7S
	ATpBNv4K8+thlXLOp/Jz0rPQwebFezYWDnFhqcUQM99P1OhODPMsBNFzqCcdcRAWaKI7TtInQCOW1
	XvViR1ZUh0col8p6pJCViR5x8F0nHLQ0F69kfPHf1gYR5W2XHmeCU/uwSkW5JbmLhN+e9icfr/7mD
	jMbFvJ0qn5h2FKhSiPWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpyjR-0004yq-57; Sat, 02 Feb 2019 17:05:29 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpyjM-0004xm-Gb
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 17:05:26 +0000
Received: by mail-wm1-x341.google.com with SMTP id m22so9277963wml.3
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 02 Feb 2019 09:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:date:from:user-agent:mime-version:to:cc:subject
 :references:in-reply-to:content-transfer-encoding;
 bh=1IqL4YH7JRK6UqQ4jzCJZZjsOuQR5UOkILRC9TNDD6Y=;
 b=Qlip9jCJpYOSk7slxaN+KL7agD3/IAQCgTOU3KDGTIaNhXxqprd57EP8sNvYuwxZc2
 ryXq86fq2GlgbG+GXqNws1nRcTA3rOc8XZGgHJ4n5PYjlOlzFXQltcxJzyKSMxVk/KbV
 fLnLvIAJlazNR3H8httcGVrqhISbj7teZnCU5uRf9L6dG2pzlf+zI9lN3xW/wlyl/9Hw
 t/63wMT5Qg+es4EgNRL6ed+pQ9hIuATOGY0IIZLJ1hP1a0XvHKC3nshYMiHcwLgSasqN
 ViSLqsm2Xvgn2IGrUCKD24GZHbyhvogf6hFsrGOljZG+AYKNBBzjYD5Sgpq1/yuFlZWV
 o3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
 :cc:subject:references:in-reply-to:content-transfer-encoding;
 bh=1IqL4YH7JRK6UqQ4jzCJZZjsOuQR5UOkILRC9TNDD6Y=;
 b=pHk6K/T/rfOvTEz1L+8m8vjJu2zErsnI5k9YJHd/faQkiF6RQ0c4FDoVL1ipaLbdc3
 7ZNhuw5RMOGlcAalbW0jCisFZg98WwOXhigXZPkVuM2C4LHaraNyj/AvVCLvcIB1bLgg
 I7KOTh2IXw4BuCXM7sfzVlrz1u03rxrP+3R/de/S81IemdZNWqBEhruG9MqVCsNuOx78
 OmEiqr/npmuEI6hfAVcTS8ga5PMDh2qtBjW9Nx4oqAvLn9WbCgQJrjHygLboDItQ8AjS
 y6gR9ZiG2DAYA/b16dvDAKGlKcUu7l9jUXWv4uou0q31whw3qKLRbuYyXDJTevGT87wU
 zdUg==
X-Gm-Message-State: AHQUAuZAWMUlG0Z2lDcMzgYR5kolUimCzKlcMNJ3ZZPZ90vD8dZcRZig
 fwnyDuSK9pxmr4oRLy5hQMNthA==
X-Google-Smtp-Source: AHgI3Ia9CCQAbf5xrzvNuyXB59dZY/GA1c2gME42bNFXpfH6sUICZwxdrKURnR7zeQlDbPslonrANw==
X-Received: by 2002:a1c:8054:: with SMTP id b81mr6645486wmd.65.1549127122309; 
 Sat, 02 Feb 2019 09:05:22 -0800 (PST)
Received: from Armstrongs-MacBook-Pro.local ([151.216.141.110])
 by smtp.gmail.com with ESMTPSA id t18sm3645527wmt.35.2019.02.02.09.05.19
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 02 Feb 2019 09:05:20 -0800 (PST)
Message-ID: <5C55CDCE.9030502@baylibre.com>
Date: Sat, 02 Feb 2019 18:05:18 +0100
From: Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13;
 rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To: Jerome Brunet <jbrunet@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v6 0/4] clk: meson-g12a: Add EE clock controller driver
References: <20190201145345.6795-1-jbrunet@baylibre.com>
In-Reply-To: <20190201145345.6795-1-jbrunet@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_090524_554360_305EF969 
X-CRM114-Status: GOOD (  16.83  )
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
 Jian Hu <jian.hu@amlogic.com>, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Le 01/02/2019 15:53, Jerome Brunet a =E9crit :
> This purpose of this patchset is to the main clock controller of the
> g12a SoC family
> =

> This patchset depends on the recent rework the meson clock directory [7].
> =

> Changes since v5 [6]:
>  * use clock input driver until something better comes along in CCF
>  * fix pll fractional param size
>  * fix broken gp0 and hifi pll param (<55)
>  * add hdmi pll
>  * fix fdiv2p5
>  * add mpll_50m
>  * fix mpll clock tree (missing fix 2 divider)
>  * add missing sdio clocks
>  * add vpu clocks
>  * add some RO clock gates
>  * rabase on clk-meson tree
> =

> Changes since v4 [5]:
>  * add bypass clock "g12a_ee_core" from DT
>  * fix Kconfig description
>  * change g12a_mpll0_div/g12a_mpll1_div/g12a_mpll2_div/g12a_mpll3_div
>    clock's parent name as fixed_pll_dco
>  * drop CLK_SET_RATE_PARENT flag for pll clock
>  * drop CLK_GET_RATE_NOCACHE flag for pll_dco clock
>  * delete usless note
>  * enable G12A clock driver
> =

> Changes since v3 [4]:
>  * add fixed clocks clk_regmap definition
> =

> Changes since v2 [2]:
>  * fix fixed clock descriptions
>  * fix alignment
>  * add enable bit for plls base on [3] patches
>  * add fixed clock gate bit
> =

> Changes since v1 [1]:
>  * fix typo of 'Everything'.
>  * change the word 'AmLogic' to 'Amlogic'
>  * squash patch 1 and 2.
>  * delete usless message of "Trying obsolete regs".
>  * delete the empty line in include/dt-bindings/clock/g12a-clkc.h.
>  * rebase on top of the "next/drivers" branch, and add g12a clock patch.
>  * add CLK_MUX_ROUND_CLOSEST for g12a_sd_emmc_b_clk0_sel and
>    g12a_sd_emmc_c_clk0_sel.
> =

> [1]: https://lkml.kernel.org/r/1531133549-25806-2-git-send-email-jian.hu@=
amlogic.com
> [2]: https://lkml.kernel.org/r/1531728707-192230-2-git-send-email-jian.hu=
@amlogic.com
> [3]: https://lkml.kernel.org/r/20180717095617.12240-1-jbrunet@baylibre.com
> [4]: https://lkml.kernel.org/r/1533890858-113020-1-git-send-email-jian.hu=
@amlogic.com
> [5]: https://lkml.kernel.org/r/1541511349-121152-1-git-send-email-jian.hu=
@amlogic.com
> [6]: https://lkml.kernel.org/r/1543498917-98605-1-git-send-email-jian.hu@=
amlogic.com
> [7]: https://lkml.kernel.org/r/20190201125841.26785-1-jbrunet@baylibre.com
> =

> Jerome Brunet (2):
>   clk: meson: pll: update driver for the g12a
>   clk: meson: factorise meson64 peripheral clock controller drivers
> =

> Jian Hu (2):
>   dt-bindings: clk: meson: add g12a periph clock controller bindings
>   clk: meson: g12a: add peripheral clock controller
> =

>  .../bindings/clock/amlogic,gxbb-clkc.txt      |    1 +
>  drivers/clk/meson/Kconfig                     |   21 +-
>  drivers/clk/meson/Makefile                    |    2 +
>  drivers/clk/meson/axg.c                       |   59 +-
>  drivers/clk/meson/clk-pll.c                   |  203 +-
>  drivers/clk/meson/clk-pll.h                   |   10 +-
>  drivers/clk/meson/clk-regmap.h                |    9 +-
>  drivers/clk/meson/g12a.c                      | 2359 +++++++++++++++++
>  drivers/clk/meson/g12a.h                      |  175 ++
>  drivers/clk/meson/gxbb.c                      |  272 +-
>  drivers/clk/meson/meson-eeclk.c               |   63 +
>  drivers/clk/meson/meson-eeclk.h               |   25 +
>  include/dt-bindings/clock/g12a-clkc.h         |  135 +
>  13 files changed, 3147 insertions(+), 187 deletions(-)
>  create mode 100644 drivers/clk/meson/g12a.c
>  create mode 100644 drivers/clk/meson/g12a.h
>  create mode 100644 drivers/clk/meson/meson-eeclk.c
>  create mode 100644 drivers/clk/meson/meson-eeclk.h
>  create mode 100644 include/dt-bindings/clock/g12a-clkc.h
> =


Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

I'm applying these to next/drivers for Linux 5.1-rc1, is it necessary to
have a tag for the headers ?

Neil

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
