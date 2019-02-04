Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FE5C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:18:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F252087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MFJJ8OXL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pzBVpVAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F252087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=eVYfVb2mgTtZveMVeAlgbFIsUSlI0U7MWQdMDLt0Rw8=; b=MFJJ8OXLuDSlvz
	OO/1OpVa05XJFBskCX/yc62FSahKyfennDJvenc0P9Dw/AULRgVQY9Mw7EV9P6QxGDU1dqSKMttGA
	RJUBqP7A4+GEwK6SLkvtZ20RMCzGN+/SGKh27nzvWqWsOvht8tynCAMq6eLH0SR3wX36ogu574i7b
	AD9MWNQ0YBySjiiW/I57BfmuiAeVApEVWw2h0gM0zJTh19YDMU5Om9i6+0EhRmHqfYMDwSOF+9x0a
	fLA/mu0o8i5w7rpV8qz7iWlunSesk6wcx/FE4Wbs9TN/qkQqrrmtyrOGJt58azoZMKeQbm0gPyTzQ
	5v20WupHzvlDHY1ys0Vw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqhsq-0008Sv-AI; Mon, 04 Feb 2019 17:18:12 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqhsm-0008S3-Qp
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 17:18:10 +0000
Received: by mail-wr1-x444.google.com with SMTP id x10so668455wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 09:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=66nnaKJCVmtQRr3HmoWTmZyWvGHRqZpdMrcRelYSBHQ=;
 b=pzBVpVAUTQ4gygdLB4HxT/hcoU+IzJ/Qbdft8XUGWZDcjdVA7IAS+iFq1jwfqiINtU
 o8YRmN1lzOdXnoMvy34IYLwRg3OENuoqfIEMr59pKkR9SphF0oYntNbkU1tCCYyMgXh5
 sb2WQ1/zT4k8rg7O6OU6sekyYKeXsD4tDccN3dkBnWJ7qWmzzBMYHUX0zePL4SGdzy2p
 u9esKDer64YFa8jfkFdQ15ey4xn9d4oCZz9FFo9Potmo4AynrhmHMHf0GQmIgzb1Yl2L
 bKLONz+DinwowxpZXbyWajL23WImDP28/IgywHgrLKeUpBa3pK3H0d1VxtWKp9l6I6kf
 vo7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=66nnaKJCVmtQRr3HmoWTmZyWvGHRqZpdMrcRelYSBHQ=;
 b=qhb0Lzi6JW5hEfvrjoPJrCpDqNeAQKHc4TeIuOPcTfYaM/Btgaxmqpu4IN/CIDdaaF
 4Kpbr7+bi49lEPTtchwB0jMkohEDDgEqD28IO6VFSdYsqaw2lJPpQNv892ZPI/wiQaWG
 NNNfhwtODSTBramw2Fq/QKrmUdJHV3si8hk2v/asoannCSTZrpntovCYE3aoXzZG/ypf
 qjIjgznbLj+KIDlu3Oygi7fEv+qFHvJs/+nJCSjzPnBoCA4VYNhNdw1u+boNbHlIODDf
 V6aZ9oa2rKezP79QkjMJ8Hg6ojHpBEAE13vAyWoeydQoZr0X+OsrlJ4ykVhvKCKqgpUH
 PjfQ==
X-Gm-Message-State: AHQUAuZOyUF5BMgY3MRk2QWp6TSNadIeKAF99hMIy7caOYis0muX156w
 al2030Y/8AxJwjwjFx3psJyQIQ==
X-Google-Smtp-Source: AHgI3IY3XUrc1SQTEO1Ev7xwwh1xvh3c1t3Lfnv7VYDgatua0fQQSFr1xPY7CqCsJ9sEQ0h9jGbSBg==
X-Received: by 2002:adf:9ec8:: with SMTP id b8mr365216wrf.164.1549300686921;
 Mon, 04 Feb 2019 09:18:06 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-8-223.w90-86.abo.wanadoo.fr. [90.86.125.223])
 by smtp.gmail.com with ESMTPSA id q9sm11197506wrv.26.2019.02.04.09.18.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 09:18:06 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 00/12] ARM: davinci: modernize the timer support
Date: Mon,  4 Feb 2019 18:17:45 +0100
Message-Id: <20190204171757.32073-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_091808_914662_F40BA69A 
X-CRM114-Status: GOOD (  19.18  )
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

This series removes the legacy timer code from mach-davinci in favor of
a new clocksource driver it introduces.

The first patch fixes a device tree bug that's been around for a while.
Unfortunately any systems shipped with the buggy device will stop booting
once they switch to the new clocksource driver.

Patch 2 adds a new clocksource driver for davinci.

Patch 3 enables the new driver for device-tree based systems.

Patch 4 adds a WARN_ON() to the machine code of all davinci boards
which is triggered if clk_get() for the timer clock fails. This is needed
as the new driver expects the clock to be functional and doesn't check it.

Patches 5-6 and 8-11 switch the board files to using the new
clocksource driver while patch 7 moves some necessary defines to
a different place since we'll be removing the file that contains them.

Patch 12 removes legacy timer code.

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

Bartosz Golaszewski (12):
  ARM: dts: da850: fix interrupt numbers for clocksource
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
 arch/arm/boot/dts/da850.dtsi                |   2 +-
 arch/arm/mach-davinci/Makefile              |   3 +-
 arch/arm/mach-davinci/da830.c               |  53 ++-
 arch/arm/mach-davinci/da850.c               |  60 ++-
 arch/arm/mach-davinci/davinci.h             |   3 +
 arch/arm/mach-davinci/devices-da8xx.c       |   1 -
 arch/arm/mach-davinci/devices.c             |  19 -
 arch/arm/mach-davinci/dm355.c               |  40 +-
 arch/arm/mach-davinci/dm365.c               |  34 +-
 arch/arm/mach-davinci/dm644x.c              |  40 +-
 arch/arm/mach-davinci/dm646x.c              |  40 +-
 arch/arm/mach-davinci/include/mach/common.h |  17 -
 arch/arm/mach-davinci/include/mach/time.h   |  35 --
 arch/arm/mach-davinci/time.c                | 414 -------------------
 drivers/clocksource/Kconfig                 |   5 +
 drivers/clocksource/Makefile                |   1 +
 drivers/clocksource/timer-davinci.c         | 431 ++++++++++++++++++++
 include/clocksource/timer-davinci.h         |  44 ++
 19 files changed, 647 insertions(+), 596 deletions(-)
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
