Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5014C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:09:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F1ED20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CRdS7z0v";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="K1tWG2B4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1ED20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=s+pxjVv95frKW+FwQi1w1fWSJhil5bSPwRTI4zsk6Yw=; b=CRdS7z0vty4Ueu
	/vyZdV2MX/Q4p8neXcK9Pw4H5P7ATvjUKZ2boMqlnZXQz7yxCPWQQcmIiMdKWjF70TKuuvPe74AZa
	kQx/ithX4w02YGllWvj4QJLjxljD/Rz+4NpWA7tIeJG/e+mFJb8zzqQFgjkLOCc6O5vtdlv2CuYCs
	qQXDxxb7+BmrhymgTRdawMu1Bb3ZPDbF0HiMYCDG0lzfG+4I/38n2EoNDHSbJ7pmz8hLIG+c327YF
	07qetgZSBF+CPeEBrQUh3sIyyoqGiGNnng42xsprAWGwntQvUZLjLAa8xw8Yd5LVm5XM3IJESnuGe
	3Sg3uCmx3rmYVyRZSvcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTZvN-00067x-4s; Sun, 02 Dec 2018 22:09:13 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZvI-00065D-Gj; Sun, 02 Dec 2018 22:09:10 +0000
Received: by mail-wm1-x344.google.com with SMTP id r24so5620726wmh.0;
 Sun, 02 Dec 2018 14:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sVFm4iQFARb7LSpeEYqu6l+42fPoWzaNkx6zpzMl+0I=;
 b=K1tWG2B4/2q6qBnbeh5tSNzG+hXAYd+XsWRhHn/ZtANd09DBEFd1fEPsPGOCBt59eO
 toGQGVaeV6NgFtNOUhfL2kuWZIYTGyWB+wUxwPlaW5evhav1DKjDTuiP/Jc0Kmw4l5bq
 Pg/gcxGBLq9351OUvlVoE0p+qqeyo7IyLzzfrMfe2XoY2xbugDzoLn5b3mnkYwoZYX0T
 Maff9JbGsBxY4zqKAnaCpWMPKx2dYwKhcsLxU/yMaIbSywgQwonDg7nNNoQGPm4rbvGz
 L3gQaHkjP2vXJanla3dz9TlTQjiJFFUNDe7TAS4BPNXPDgUAYBczBSIIhiiagAWETuMN
 VGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sVFm4iQFARb7LSpeEYqu6l+42fPoWzaNkx6zpzMl+0I=;
 b=Q7yB8KA+YVYbH28Z60At/Q25P/hfPaZKZyt+Xs8wv0w1GM1lwWbZ6tRzys4SJxqzfP
 Fho6sCZkLwjfUCDHBU9mIuQckNZDpAjE3QuFgyMGZx6wggQ5WhLHfRBBQAjc87vH3RSI
 oskepuMcfKA0VH4nEAkR72dYnoxfctb3UU3Mn4trMcs0blR4KR1rGE+Y/gQs4WlupOhX
 f16eKAy5dzkEUPBX9eLzJZYP8ONIXrPDKz9elEEQVuDGdHvA2VKCiJyTCDK3jrEJVv1T
 kAuHBFWZhvkufhpFWBtX0zhieEXKKRU4M957cQ5d3XvjtI7iDHkrgtkquoBwuzw49OAb
 zmRw==
X-Gm-Message-State: AA+aEWZD18Ex8C3xCPe3Og/bZxmqef4537UC/hSDEGIOBfsMZjBQ1mrv
 VqX/MCU36bml63tuzhxlK+0LZXon
X-Google-Smtp-Source: AFSGD/VFDdu+XpEtmybrNxO2yDzk+pu1fJsQJjF2YxYrJy4CXKcyNH399hdbb18P2N6ydbzJyg6Mjw==
X-Received: by 2002:a1c:cc3:: with SMTP id 186mr437276wmm.143.1543788536654;
 Sun, 02 Dec 2018 14:08:56 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73FBA00B1CC0EB38CD20A4E.dip0.t-ipconnect.de.
 [2003:dc:d73f:ba00:b1cc:eb3:8cd2:a4e])
 by smtp.googlemail.com with ESMTPSA id m15sm8503351wrr.95.2018.12.02.14.08.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 02 Dec 2018 14:08:56 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
 alexandre.belloni@bootlin.com, a.zummo@towertech.it
Subject: [PATCH v5 0/2] Amlogic Meson6/8/8b/8m2 SoC RTC driver
Date: Sun,  2 Dec 2018 23:08:45 +0100
Message-Id: <20181202220847.24364-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_140908_554696_8C532F2C 
X-CRM114-Status: GOOD (  15.60  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 ben.dooks@codethink.co.uk, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, ccaione@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series adds support for the RTC on the 32-bit Amlogic Meson SoCs.

The series does not have any build dependencies, but does require
device-tree entries for the relevant boards.

The series is tested by myself on the Meson8b EC-100 board. Earlier
versions of this series were tested on an Odroid-C1 board with a
battery pack attached by Ben Dooks and Kevin Hilman.

I will send the DT changes in a second series so that they can be
merged once the dependencies have been satisfied.


Changes since v4 at [0]:
- resurrected Ben's patches after 2 years: first I made it apply
  onto linux-next again
- I decided to update the author of the patch to my own name since I
  made a lot of changes compared to Ben's implementation (list of
  changes below, the diff-stat was: 223 insertions, 163 deletions)
- make the dt-bindings file name (rtc-meson.txt) match the driver name
- add a Meson8m2 compatible
- add the clocks and vdd-supply properties to the match the actual IP
  block implementation
- make the resets and interrupts properties mandatory to match the
  actual IP block implementation
- removed the status property from the dt-bindings example
- fix MODULE_LICENSE to match the actual license (GPL v2)
- switch to SPDX-License-Identifier
- sort the Kconfig option alphabetically
- use BIT() and GENMASK() macros consistenly
- replace #define RTC_REG(x) with actual #defines which match the names
  from the public S805 datasheet
- adjust existing #defines to align with the public S805 datasheet
- add support for the 4x32bit NVMEM (regmem) data
- implement regmap_bus to access the serial registers. this allows
  getting rid of the custom locking code and makes the NVMEM
  implementation much easier.
- use regmap also for accessing the peripheral registers to make the
  code shorter
- add support for the vdd-supply regulator
- switch from devm_rtc_device_register to devm_rtc_allocate_device and
  rtc_register_device
- set range_max to U32_MAX
- use rtc_time64_to_tm and rtc_tm_to_time64
- simplify timeout handling and use shorter timeouts (the driver from
  the 3.10 BSP kernel uses udelay resolution (100us after the reset, 5us
  for the "comm delay") as well as busy-looping from 0..40000 to wait
  for "s_ready"
- removed debug messages which are only printing register values (as
  these can now be seen in
  <debugfs>/regmap/c8100740.rtc-peripheral-registers/registers)


[0] https://www.spinics.net/lists/devicetree/msg135413.html


Martin Blumenstingl (2):
  dt-bindings: rtc: add device-tree bindings for the Amlogic Meson RTC
  rtc: support for the Amlogic Meson RTC

 .../devicetree/bindings/rtc/rtc-meson.txt     |  32 ++
 drivers/rtc/Kconfig                           |  11 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-meson.c                       | 409 ++++++++++++++++++
 4 files changed, 453 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-meson.txt
 create mode 100644 drivers/rtc/rtc-meson.c

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
