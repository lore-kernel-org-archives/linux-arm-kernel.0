Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98622C61CE4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 14:44:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C0B2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 14:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NaJpPscq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RVCm9poN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C0B2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=wVf9Bob1dgW7NMQyi/6Tlr0ZM52TEaUXDFl4Zjm4rn4=; b=NaJpPscq4/PIIT
	q9xmv0ibvZbtzaWFOiV+rBBgIIbwoJIbBLU7MqPYJwmIoL/6miwmrFuEp3BbXAp/89g4+1jXaaOfn
	/4Gqb38NmpEG34eMHbbpBccK+w3n7Q8attWBcJPqxZmhFnT0ItiaFZlFULIYp0f0ArvYPaOFO35Ho
	9IN+wjYKPXvHcFJpVFvkTBEQjNWkqvtlYcvd9AE16i0MfuHddSbbekAiJ9g5Qy9bkb+WuasXEdHZR
	cjjGq82bS2xh81FjvasWLdU9oXhv6SKUfiCukaMu1O8O5EMc1y3u2DUppXvYHJkfStUBUOKQEu9cE
	bT0HHOG/RhOfsTXb3M7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkrr3-0005jD-Ii; Sat, 19 Jan 2019 14:44:13 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkrqy-0005hj-Ic; Sat, 19 Jan 2019 14:44:10 +0000
Received: by mail-wm1-x341.google.com with SMTP id t200so7078356wmt.0;
 Sat, 19 Jan 2019 06:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/Ozus3BivcOK8itZMfeG08VWoPokGwR0TyZe9F4Jeso=;
 b=RVCm9poNqeGO0XaOQsekVrBPk0GVIVBV0TKKizJQX72qm+6J0y7SBg9KrIw5MUzqxm
 zqYYUMK2Phu+a/QMVXpbdxqmBvGqiaANPJrZj8VwY1oWzgtASWg5kQGBS7DhEOb2swgw
 MPiHenHOAc6Id3q6f1BI5mX4jmzu7t+L5E3Mu1mlMaPyFIMWUBn9MijC+Mpr7+aqszQ/
 WwhrkApj+NikrwEjIq1lM+ivieDTHBoCJ8A6b5ODiBRpCNip85HQ4ez017BbxvZ/E6Zr
 fXO1UKpqRT6BYK+FyOADn/iRCo5jUeV/FmR2Kq7tI2TB5YU4Z1FR88V/rhma444O2nW4
 z6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/Ozus3BivcOK8itZMfeG08VWoPokGwR0TyZe9F4Jeso=;
 b=sx2x2j1Vq5TV2zdkfaLzPtupLLxHXaFgDO94F0ytqUZhlCjZMTR5M2Fd7RLhq7q2s4
 E6IEhRrFL1vKyHmLgt7BXGrwDKMgBJAHakOyd+mLf9d/J1McDfpcwor3wG41HuEr+n0W
 UbKXIAcb6EN3VRivUv4HgeHbZaFmAO3QBsrcnPUi5KWERPpXtdIL227bxzYqo6SetYMj
 SLAjotM9CMAAQdMKkJvSJbndKa/bTQj5wjo7N1rytJx+kwjBcf+6CB/U0waiQheJb+Qf
 92jlTCXoEULdw8O/22i5iCnsgzGPAWddNSDHI5wDkBLOKsETrGnoIQP450b7wx86InSP
 mNVg==
X-Gm-Message-State: AJcUukfih76wbVjoQ8IqAEXuX27PzgSgtGvA3+vssZHuAtCrxJU8DgeM
 Ly/8y95R4eRODK1IeO8x1Sz+I5at
X-Google-Smtp-Source: ALg8bN4p4IfQL++SQBe0pA1973D4G5SDBovaqtlVTU4LWq5/7fgzfuGe6lVdeThrHVBMn1R00p6sPA==
X-Received: by 2002:a1c:e18a:: with SMTP id y132mr20259510wmg.48.1547909045808; 
 Sat, 19 Jan 2019 06:44:05 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73A8100FDA9BD4E9DEACC2C.dip0.t-ipconnect.de.
 [2003:dc:d73a:8100:fda9:bd4e:9dea:cc2c])
 by smtp.googlemail.com with ESMTPSA id b7sm80452772wrs.47.2019.01.19.06.44.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 19 Jan 2019 06:44:05 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
 alexandre.belloni@bootlin.com, a.zummo@towertech.it
Subject: [PATCH v6 0/2] Amlogic Meson6/8/8b/8m2 SoC RTC driver
Date: Sat, 19 Jan 2019 15:43:30 +0100
Message-Id: <20190119144332.11984-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_064408_649701_9A6ACB30 
X-CRM114-Status: GOOD (  16.85  )
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


Changes since v5 at [1]:
- get rid of a dependency on the SZ_16 macro (fixes a kbuild test robot
  compile error)
- rebased on top of v5.0-rc1
- I kept the copyrights / author as in v4 because Ben didn't ask me to
  do it yet (please speak up if I should change it)

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
[1] https://patchwork.ozlabs.org/cover/1006597/


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
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
