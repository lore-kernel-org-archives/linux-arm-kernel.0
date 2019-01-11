Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E17C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:21:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D107720872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iV3PUZTo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZqWKruDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D107720872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=wcXhy/q4P5P9XLLkAOgML4SA3TcHIiN1qwCnwgmqVnY=; b=iV3PUZToY2mgzB
	JrZf5b21NLlubQdKdHgeE5Au7ICO7MlO8Hyyw5TvUszGr18QpgAvBCyAQuc98EdC014IC1hixnygl
	N43pZJbxoJzQhw1GH9HY6WcOqJwmmiwqP+Cp5uyONYizTNz5VR+z0J0rI6xB+WlFZV5PLtqh8hXGA
	UVTLYEvNgiH7BMiKFUTbEN1qx6FJanl5lb/HrGygMbGdQ2QOgYJXTY3lzrKypuN0dcALjSW7l9f5H
	kv1dQKpTMrnYWksZ2XlrQVJLM37m7amfMeufrJsCgkROlWezB8lcX2no/EommiYNXkJ/zrJUH1zcJ
	LkUZvTZsdeB4y5Ot+qaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi0VI-0000Ju-77; Fri, 11 Jan 2019 17:21:56 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi0VD-0000Ih-Ps
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 17:21:53 +0000
Received: by mail-wr1-x442.google.com with SMTP id c14so16096565wrr.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 09:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OQntVF2/bk1rgld5/bEFikPpbtRSdjHYK/hVaJqDrb4=;
 b=ZqWKruDoW+J+Ip44e2nSxWkwlREHDU8lp0MVmydauHfccYKIokrxgEujmppFHqUAqC
 y2LJbKl38mKTiAEkFP/Ms5hdV5PCjWUFZDIRrLlyCKV4NQ/+EleIClB90nqytxl12t+Y
 cRtDwe2i4carz3HtxdPU2Wb0l/5HjioMelaBi3MKXXAZvYUlHC1aenarip0bx56vvYmm
 jzvLFLh+dROqM2ulLCZ8KhMwG1uG2XxLO8h1KX7JCSOF6XGD3ICahbxU+QkVyha4vHz5
 jLxdSFpK77Aw70dPcV0tpwe1b8OtxaAn/FbNwqaMSBtwGP+k39+vm39fbwe1xmIeFT79
 BhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OQntVF2/bk1rgld5/bEFikPpbtRSdjHYK/hVaJqDrb4=;
 b=D4TAIElYgrBPh+An2j9eqFCz7/Z3BjwDVGah7VRLsNpO8bs/tHoWDgASQRjLeLTnti
 QVvYqGaa90pjnnJAqMYnjA3LtCferGuCRbI3B/b3Aj7hxz4E+yz8iCqDtkCrNkkM9tcc
 fWSyYZXAr3icr7Mzsj3jiQDfs9DkP9L0t33mwyAUIYXjd5pNESYTlnt0Qtih9C9djlhA
 CZW2CHISb/ip4voARViXBA2ZKaLwTuVXvKa7QSZqw89BivLVWvj/xONELOe3UMJCtL5Y
 6A6rCDxoKh3KJImcU/0HdMB7uQ+LGN49XE2RMR+mCzoOLrWy94hV1g6Gx8vGaeeihNIW
 UtTw==
X-Gm-Message-State: AJcUukfn47Xe2P/WMc9QvV+cut6Q5DusWN6r3jtLanqFzvoMvp2Oypbj
 Fax9vcQ8mSWWJcBnH0WINOPAyg==
X-Google-Smtp-Source: ALg8bN571A1SecWwIB/aXwjhDOUXWCNsWqPrpJk8vt3h4PZNU1y9RN7dvcG7lEyyGdCi0L0K50SRsw==
X-Received: by 2002:adf:97d1:: with SMTP id t17mr14424248wrb.283.1547227309639; 
 Fri, 11 Jan 2019 09:21:49 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.21.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 09:21:48 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 00/17] ARM: davinci: modernize the timer support
Date: Fri, 11 Jan 2019 18:21:17 +0100
Message-Id: <20190111172134.30147-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_092151_905177_A82C55FB 
X-CRM114-Status: GOOD (  16.24  )
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

Patches 4-9 add a WARN() to the machine code of all davinci boards
which is triggered if clk_get() for the timer clock fails. This is needed
as the new driver expects the clock to be functional and doesn't check it.

Patches 10-11 and 13-16 switch the board files to using the new
clocksource driver while patch 12 moves some necessary defines to
a different place since we'll be removing the file that contains them.

Patch 17 removes legacy timer code.

Bartosz Golaszewski (17):
  ARM: dts: da850: fix interrupt numbers for clocksource
  clocksource: davinci-timer: new driver
  ARM: davinci: enable the clocksource driver for DT mode
  ARM: davinci: da850: WARN() if clk_get() fails
  ARM: davinci: da830: WARN() if clk_get() fails
  ARM: davinci: dm355: WARN() if clk_get() fails
  ARM: davinci: dm365: WARN() if clk_get() fails
  ARM: davinci: dm644x: WARN() if clk_get() fails
  ARM: davinci: dm646x: WARN() if clk_get() fails
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
 arch/arm/mach-davinci/da830.c               |  57 +--
 arch/arm/mach-davinci/da850.c               |  57 ++-
 arch/arm/mach-davinci/davinci.h             |   3 +
 arch/arm/mach-davinci/devices-da8xx.c       |   1 -
 arch/arm/mach-davinci/devices.c             |  19 -
 arch/arm/mach-davinci/dm355.c               |  37 +-
 arch/arm/mach-davinci/dm365.c               |  31 +-
 arch/arm/mach-davinci/dm644x.c              |  37 +-
 arch/arm/mach-davinci/dm646x.c              |  37 +-
 arch/arm/mach-davinci/include/mach/common.h |  17 -
 arch/arm/mach-davinci/include/mach/time.h   |  35 --
 arch/arm/mach-davinci/time.c                | 414 -------------------
 drivers/clocksource/Kconfig                 |   5 +
 drivers/clocksource/Makefile                |   1 +
 drivers/clocksource/timer-davinci.c         | 415 ++++++++++++++++++++
 include/clocksource/timer-davinci.h         |  35 ++
 19 files changed, 611 insertions(+), 596 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/time.h
 delete mode 100644 arch/arm/mach-davinci/time.c
 create mode 100644 drivers/clocksource/timer-davinci.c
 create mode 100644 include/clocksource/timer-davinci.h

-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
