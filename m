Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6738AC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:54:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3589F20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oMuiWVCb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EO8VTU8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3589F20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ksYidUvCLWzjcsFPR3lKCNX0eJC9A7fhuo0QrzKU2Vg=; b=oMuiWVCbhTO+xk
	KJndOHben+hWuzSN+uyOUbXG+JrV4NMdWXb+cYMnhiwkFPqrTA8d/Zzx6R0qZE4idXSsYaV3dPwE0
	DRJ9T0eJjq7jv3d87y8YjOLsM9G70EFQG07sIiXKw2R/GstEMtkf7IAZ5ulUDCw+Gn24i7wgyU/0W
	5hSlsa5+SHRQJmFLRyMC9bjuon6EwbWUkDk/kJ+bqQ8g/EltzBpqCMoPMl1k9v5OQIb2J7+JoOJj4
	Qdhj5aqZuHxPkyvhHDp6wZ34575Gl7YHVQJ5/IJlvZxlflKYjHThiAecmNUPLSia+txXdP0309hsP
	iiJD22WGhwPUg2fr3QRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpaCc-0003S7-AY; Fri, 01 Feb 2019 14:53:58 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpaCX-0003QT-J4
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 14:53:55 +0000
Received: by mail-wr1-x441.google.com with SMTP id f7so7473942wrp.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 06:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8eEdYNzMTYNh/Q6rC2KUrA/noaDZ+qRIqzEIbeziGHs=;
 b=EO8VTU8+S3rRiziKAMlCUFtrA6MNQaKttQlZLe3Rq0CetsF5MisgygwomPcHKIQgK4
 utC8KaJ04hxFAmSA9OAFdRJLY3+9ift7vOAKHL8Q9l+7OVCcn+tixdWJOk8xyJt7sRCh
 YYGRLj4U1llQgxJErxlpIiSiSH9xmINA/cyIoTi8tnVt/+Osyr3muEBM3uELmqgQqyEM
 hH8kePo03ZOD/pyEpBHXT7Z015QXOEl5FozEkB8x+DFsJrSCnCiBqwwxTH7ac92JCbd9
 3BcAsOofCNstV40QUS66jkwYqnHuJ9EtwRc82h/HIxTxQR7m9u+Ftuo6wscJS6q2ArwU
 q5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8eEdYNzMTYNh/Q6rC2KUrA/noaDZ+qRIqzEIbeziGHs=;
 b=E+rvBmRYJNfSZHUYw/6OxYS2lAnEtTFf/aJl1sN4+nKKub26W7FUNCE/TnPFPBLUNh
 FMIzBqYQcXhh4YBePgSty9ovkXRTrGCxGU390ouNqbEBQUfnvA7XWIuK6Vf/3UhvHG7S
 dfZ5crAzNXlPZVmnU86NLhXA1dWBhY5cii/MaI7C11WWes8FD0omy18Cof1vK8WdkfZy
 10lDKGmECYfFLTa5XStRQKNJ8R7lDqkacgjuTzRbBBNz/tTPJOPKoeIidnsAKkKnv16L
 BZSDcjoqkUuhkRxbaMrKBqT8/dlb0K2ww6OB60vsLObRs1RGBJglXY/3FXjWgTBHxQ1B
 EP/w==
X-Gm-Message-State: AHQUAuYO23+lHwFAbW5xbedby4ciPMoVpedqLBydEBXD1eZNHVC6v9ro
 yYc9djsIKY9KJJRDXjG/bxpJ5A==
X-Google-Smtp-Source: AHgI3IZuERyBKP8OahiXgqpaCWRLiGGMzi4ZUEP8uy6TsXIiOiRKqDK28ODJjhL51DHOVn11yh4nHg==
X-Received: by 2002:a05:6000:14c:: with SMTP id
 r12mr1487232wrx.172.1549032831578; 
 Fri, 01 Feb 2019 06:53:51 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.googlemail.com with ESMTPSA id x186sm4754644wmg.41.2019.02.01.06.53.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 06:53:50 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH v6 0/4] clk: meson-g12a: Add EE clock controller driver
Date: Fri,  1 Feb 2019 15:53:41 +0100
Message-Id: <20190201145345.6795-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_065353_708577_1EFF1FDF 
X-CRM114-Status: GOOD (  12.34  )
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
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This purpose of this patchset is to the main clock controller of the
g12a SoC family

This patchset depends on the recent rework the meson clock directory [7].

Changes since v5 [6]:
 * use clock input driver until something better comes along in CCF
 * fix pll fractional param size
 * fix broken gp0 and hifi pll param (<55)
 * add hdmi pll
 * fix fdiv2p5
 * add mpll_50m
 * fix mpll clock tree (missing fix 2 divider)
 * add missing sdio clocks
 * add vpu clocks
 * add some RO clock gates
 * rabase on clk-meson tree

Changes since v4 [5]:
 * add bypass clock "g12a_ee_core" from DT
 * fix Kconfig description
 * change g12a_mpll0_div/g12a_mpll1_div/g12a_mpll2_div/g12a_mpll3_div
   clock's parent name as fixed_pll_dco
 * drop CLK_SET_RATE_PARENT flag for pll clock
 * drop CLK_GET_RATE_NOCACHE flag for pll_dco clock
 * delete usless note
 * enable G12A clock driver

Changes since v3 [4]:
 * add fixed clocks clk_regmap definition

Changes since v2 [2]:
 * fix fixed clock descriptions
 * fix alignment
 * add enable bit for plls base on [3] patches
 * add fixed clock gate bit

Changes since v1 [1]:
 * fix typo of 'Everything'.
 * change the word 'AmLogic' to 'Amlogic'
 * squash patch 1 and 2.
 * delete usless message of "Trying obsolete regs".
 * delete the empty line in include/dt-bindings/clock/g12a-clkc.h.
 * rebase on top of the "next/drivers" branch, and add g12a clock patch.
 * add CLK_MUX_ROUND_CLOSEST for g12a_sd_emmc_b_clk0_sel and
   g12a_sd_emmc_c_clk0_sel.

[1]: https://lkml.kernel.org/r/1531133549-25806-2-git-send-email-jian.hu@amlogic.com
[2]: https://lkml.kernel.org/r/1531728707-192230-2-git-send-email-jian.hu@amlogic.com
[3]: https://lkml.kernel.org/r/20180717095617.12240-1-jbrunet@baylibre.com
[4]: https://lkml.kernel.org/r/1533890858-113020-1-git-send-email-jian.hu@amlogic.com
[5]: https://lkml.kernel.org/r/1541511349-121152-1-git-send-email-jian.hu@amlogic.com
[6]: https://lkml.kernel.org/r/1543498917-98605-1-git-send-email-jian.hu@amlogic.com
[7]: https://lkml.kernel.org/r/20190201125841.26785-1-jbrunet@baylibre.com

Jerome Brunet (2):
  clk: meson: pll: update driver for the g12a
  clk: meson: factorise meson64 peripheral clock controller drivers

Jian Hu (2):
  dt-bindings: clk: meson: add g12a periph clock controller bindings
  clk: meson: g12a: add peripheral clock controller

 .../bindings/clock/amlogic,gxbb-clkc.txt      |    1 +
 drivers/clk/meson/Kconfig                     |   21 +-
 drivers/clk/meson/Makefile                    |    2 +
 drivers/clk/meson/axg.c                       |   59 +-
 drivers/clk/meson/clk-pll.c                   |  203 +-
 drivers/clk/meson/clk-pll.h                   |   10 +-
 drivers/clk/meson/clk-regmap.h                |    9 +-
 drivers/clk/meson/g12a.c                      | 2359 +++++++++++++++++
 drivers/clk/meson/g12a.h                      |  175 ++
 drivers/clk/meson/gxbb.c                      |  272 +-
 drivers/clk/meson/meson-eeclk.c               |   63 +
 drivers/clk/meson/meson-eeclk.h               |   25 +
 include/dt-bindings/clock/g12a-clkc.h         |  135 +
 13 files changed, 3147 insertions(+), 187 deletions(-)
 create mode 100644 drivers/clk/meson/g12a.c
 create mode 100644 drivers/clk/meson/g12a.h
 create mode 100644 drivers/clk/meson/meson-eeclk.c
 create mode 100644 drivers/clk/meson/meson-eeclk.h
 create mode 100644 include/dt-bindings/clock/g12a-clkc.h

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
