Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C572BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:09:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C986217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QD4HZGli";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="cowrJJsD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C986217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=XvdFU491ueRhxW1OMtSDdJNCrNixWEl10zJeuif/jo4=; b=QD4HZGlipeeXl2
	61/6sn+SQsWqxLHu9xpoTakqh9jkIbky5awfqUTWZx61BEG6o68nffuYxZ+g+K6RbYY0yFMvmHffy
	Jj7y4gask4JaIyaQg/gho2b3boy9xqjfDToICBAsPuisDOoKiechfgpg1SHR0Xtk/yJI0tpVOxFP+
	Q/lLUGEpfztLO03zZ9nhyfmNEv67sa+pLVRvAaFNBCJTBw7ZxYDfYc47TWntdMDA0zui8pIlWkSaZ
	4H9XR12KK2wfpZ3mlh97OaSbK5+S4SlVAzAQQ8FYpgeof+0XsjuqhsHA+Bv74TWiU1LNKkw8cjBuO
	9I1P1vB+HxVN8kkb3Ftw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybYP-0003ix-Ru; Tue, 26 Feb 2019 12:09:45 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybWG-0001JA-4c
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:08:07 +0000
Received: by mail-wr1-x443.google.com with SMTP id r5so13649810wrg.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 04:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FEQVTIPbAqJ0YmXHUFQn+jdXrnAfnHEV14C7AUBnqIA=;
 b=cowrJJsDDelXsLlhBRPmUPbMwENlxN2SrTo6msvTYZMdt2A5GTW/T2/EhoEbO7Y1GX
 3T5iNhkSS1Bo3vqaAVJ73mcCMDK4YPt7ba+I+2noatexMKnRmAyS6P0gWyieo2op+Q40
 x4BE8270IXpCnI628gPwnG2iB7CETE0VZ3Nbma82N6Ih+QT2TieffAe8eph10tIOYFUk
 c8bCJOHQIwlJmqYSwtHT6qm4NeJHfjn1mFEhkJnooZgpp39QqvAGJamvnRSpmMpy2JjU
 Xr3F8l0vUKoJ8UNA6r34t9RuKPbastbQwuCkLYN3VMPE3+SB+GGL1qtHrKJqfrUx39dY
 IWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FEQVTIPbAqJ0YmXHUFQn+jdXrnAfnHEV14C7AUBnqIA=;
 b=U3jZIQmM1TPphz/XEIrOeermAB/hAOC6noJEQFlq76dmaKjLAuCo+8QnFBUr2z47Jy
 cxoSC0ljiQeBMuXRSi80TTK9LCh7eVSfRZR3iv1XUrZDWeOS8+/hq7imKApPEcVtg9Ju
 Yj3BpO6+bUFwdiYZBzQskd6Z5iSv39LWKkUSqsKdzR5K37BTc+Yx+x0WdEHnl0+LVCvy
 HtqmpgfS9U8ctPTn7fYFJ6vrHE9zNpN7svSQa71BAWH4IY5MFvSXdxhiUUw8ke5GVpE4
 OeGIeFPqPLihDvxRNxU3QEihogUUQ8QQooQaXpwgTRQOBfO6+toYmeMphngidVw+i9od
 J3HA==
X-Gm-Message-State: AHQUAuY6RUQ/1O29hy54KkaHeVqvtBPU+dVrrCrFyObkxGSWokKRLkYZ
 cejNgQOA5tFoSHwfm5eKSvpN5XQ8y0Q=
X-Google-Smtp-Source: AHgI3IZkCTUnZEIwziSVgR3suW5bULLS6bx2xgnMdqCeQCcg6N+qE+U3frPFzHg6fZMxb0duZRVuhQ==
X-Received: by 2002:a5d:4fc5:: with SMTP id h5mr15822591wrw.84.1551182849727; 
 Tue, 26 Feb 2019 04:07:29 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id a8sm12642158wmh.26.2019.02.26.04.07.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 04:07:28 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 00/11] ARM: davinci: modernize the timer support
Date: Tue, 26 Feb 2019 13:06:22 +0100
Message-Id: <20190226120633.18200-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_040732_922589_23E70B88 
X-CRM114-Status: GOOD (  21.04  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hi Sekhar,

merge window will be later than expected so I'm sending this now rebased
on top of your v5.1/soc branch - that way you'll be able to pick it up
early in the next release cycle.

---

This series removes the legacy timer code from mach-davinci in favor of
a new clocksource driver it introduces.

Patch 1 adds a new clocksource driver for davinci.

Patch 2 enables the new driver for device-tree based systems.

Patch 3 adds a WARN_ON() to the machine code of all davinci boards
which is triggered if clk_get() for the timer clock fails. This is needed
as the new driver expects the clock to be functional and doesn't check it.

Patches 4-5 and 7-10 switch the board files to using the new
clocksource driver while patch 6 moves some necessary defines to
a different place since we'll be removing the file that contains them.

Patch 11 removes legacy timer code.

v1 -> v2:

- changed the license to GPL-only
- dropped regmap usage due to the additional code paths making the
  code too slow
- minor code rearrangement
- fixed the da830 timer configuration
- correctly assign the timer halfs to clocksource and clockevent
- sqashed the commits adding WARN() when clk_get() fails
- used WARN_ON() and added a return when clk_get() fails to avoid
  entering the timer driver without a valid clock
- request the register range before iomapping it
- simplified the configuration structure (dropped the additional cmp struct)

v2 -> v3:

- use readl/writel_relaxed() instead of __raw variants in the clocksource
  driver
- request the memory region before remapping it
- add explanatory comments
- fixed licensing
- used pr_fmt macro
- correctly assign the clocksource name
- use DEFINE_RES_x macros when defining resources to avoid off-by-one
  bugs in resource's size
- tweak the commit messages
- don't delete the comments describing the timer usage
- other minor improvements
- rebased on top of Sekhar's soc branch
- dropped patch fixing the clocksource interrupts in device tree (already
  upstream)

Bartosz Golaszewski (11):
  clocksource: davinci-timer: new driver
  ARM: davinci: enable the clocksource driver for DT mode
  ARM: davinci: WARN_ON() if clk_get() fails
  ARM: davinci: da850: switch to using the clocksource driver
  ARM: davinci: da830: switch to using the clocksource driver
  ARM: davinci: move timer definitions to davinci.h
  ARM: davinci: dm355: switch to using the clocksource driver
  ARM: davinci: dm365: switch to using the clocksource driver
  ARM: davinci: dm644x: switch to using the clocksource driver
  ARM: davinci: dm646x: switch to using the clocksource driver
  ARM: davinci: remove legacy timer support

 arch/arm/Kconfig                            |   1 +
 arch/arm/mach-davinci/Makefile              |   3 +-
 arch/arm/mach-davinci/da830.c               |  40 +-
 arch/arm/mach-davinci/da850.c               |  45 +-
 arch/arm/mach-davinci/davinci.h             |   3 +
 arch/arm/mach-davinci/devices-da8xx.c       |   1 -
 arch/arm/mach-davinci/devices.c             |  19 -
 arch/arm/mach-davinci/dm355.c               |  22 +-
 arch/arm/mach-davinci/dm365.c               |  22 +-
 arch/arm/mach-davinci/dm644x.c              |  28 +-
 arch/arm/mach-davinci/dm646x.c              |  28 +-
 arch/arm/mach-davinci/include/mach/common.h |  17 -
 arch/arm/mach-davinci/include/mach/time.h   |  35 --
 arch/arm/mach-davinci/time.c                | 414 ------------------
 drivers/clocksource/Kconfig                 |   5 +
 drivers/clocksource/Makefile                |   1 +
 drivers/clocksource/timer-davinci.c         | 438 ++++++++++++++++++++
 include/clocksource/timer-davinci.h         |  44 ++
 18 files changed, 584 insertions(+), 582 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/time.h
 delete mode 100644 arch/arm/mach-davinci/time.c
 create mode 100644 drivers/clocksource/timer-davinci.c
 create mode 100644 include/clocksource/timer-davinci.h

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
