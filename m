Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8CCC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:23:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EAC620869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hDWnCfzt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqmSDb0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EAC620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dZWzby1VmwqiomYrkUc38jR6RtKsjaxR6PJPGGW9g9I=; b=hDWnCfztRdlE/v
	rGZ6nfCL+TqcdP6Vy66l7Z5TTte+C+PnorDT+80zb2HIuJcMoyXw2PdBKRHXhbpZVkpBNckQbbpmm
	3aPnMfKSvK1kemfVlvKlL50u+QxdC4GjZKkBkWKVmTg9EuFdxmyq/xlU8mRvv/rG7uMGd6S3Xq5jg
	/tZI6esfCabHOyHtHNOeJefKSzcNm7x74szf3EmaQn/9DckNN1zWYbIThL8GXodGzBsrc6Bcb6pu4
	jaqzcv1xgRLdLAsvByzT8FMbdYN+nAmvBm3/OqHih1GtU1JCfh+U76Y2c9DDUKzgDN/dOqRqP3nF/
	U+dM1cJRtI80TVZx7Yxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpz0Y-00035k-S9; Sat, 02 Feb 2019 17:23:10 +0000
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpz0E-0002iQ-Ev
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 17:22:54 +0000
Received: by mail-oi1-x243.google.com with SMTP id y23so8436636oia.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 02 Feb 2019 09:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XGOt9wF7lbxv0xauLLcCiapDZCXXLYor/t2uqg+pQdU=;
 b=RqmSDb0NyU9bpokTpRedMjltqe1MwQJI5o41PJURY6c7NoeCSUdJl+U3er5DXEuxC1
 zD2nYoIEhbRBrONWM+VEuGTScYAABde1M48ISPnVLEM7/uLgN9ODuMFX8O5YxnQA/EOw
 OY6rSRkVnRQ7PvccFnwF1ifd0JwJxoz9t0xSiQ82ib6AYgjQxdyGw2NW1+aCEzKkk0L+
 encmm0Y9ZiVyaNcB24Zb5k0HrP9l1mTR+WDiiaqfP6YBjpEzGUcSUWC3AjlUzHbBhR0z
 uDJJd1n5km/qvizDK1sXJ2OtlT9eRorVIygWZlOBDxa5rLMIHle4lGFOJAPm1rHNcj+P
 pctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XGOt9wF7lbxv0xauLLcCiapDZCXXLYor/t2uqg+pQdU=;
 b=A6VN2G0pmDs9WSVmz1rMObhJ0HHPF48Y9CkOgHeiIEuYJnxZo9JsI0N3uOB9u2Esan
 fCnus+BKD0U+2aEVLhadx4F6kRhMzNSCQcrTzb2oo6ihkPVpY2c3NfXc8Hzj9Sj2pM7G
 /2Hky+tJExT/a+hW+81EK6MenPBZi/67yqpF/B5LBhHCdk5012CedbufTNW6BASGfh/2
 fbwWOxyBlbOIq48rpFhVun0vmDVV+0oxTuI0kdLvs/iqPYNk+TVQW6/y4kQL2NRwKW+F
 oLJPNTxjnuUxC5lef1cwUAc77DYs447n2mKHOoN/JkebybFJQXNX/5M9I2Ywyqw/CUpX
 eYwg==
X-Gm-Message-State: AHQUAuYhYYprTXdEtTn5viBSOJ6yCEhd7xTYY6C6k/7gIvAlcvV60oY6
 E5Vsl/pJlxUVITRSVZyrFgA=
X-Google-Smtp-Source: ALg8bN48R53aRA2sDE2F6M2zUH5mTjhzq/AbeDdk4lWJgfrchrHUkp/4TuuHFHE7QRePJbq1UCJHXw==
X-Received: by 2002:aca:f306:: with SMTP id r6mr22886255oih.230.1549128169197; 
 Sat, 02 Feb 2019 09:22:49 -0800 (PST)
Received: from bender.lan (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
 by smtp.gmail.com with ESMTPSA id n185sm5056815oih.18.2019.02.02.09.22.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 02 Feb 2019 09:22:48 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: arm@kernel.org
Subject: [GIT PULL 4/4] Broadcom drivers changes for 5.1
Date: Sat,  2 Feb 2019 09:22:37 -0800
Message-Id: <20190202172237.11147-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190202172237.11147-1-f.fainelli@gmail.com>
References: <20190202172237.11147-1-f.fainelli@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_092250_836616_0F8E9BED 
X-CRM114-Status: GOOD (  18.96  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Rob Herring <robh@kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>, arnd@arndb.de,
 Scott Branden <scott.branden@broadcom.com>, khilman@kernel.org,
 Phil Elwell <phil@raspberrypi.org>, Eric Anholt <eric@anholt.net>,
 Wei Yongjun <weiyongjun1@huawei.com>, linux-arm-kernel@lists.infradead.org,
 olof@lixom.net, bcm-kernel-feedback-list@broadcom.com,
 Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-5.1/drivers

for you to fetch changes up to 50de64947f40f869dc5b9306891b750f317135ef:

  Merge tag 'tags/bcm2835-drivers-next-2019-02-01' into drivers/next (2019-02-01 11:29:21 -0800)

----------------------------------------------------------------
This pull request contains Broadcom ARM/ARM64/MIPS based SoCs changes
for 5.1, please pull the following:

- Stefan updates the BCM2835 SoC driver with downstream properties and
  uses that to implement a reboot notifier to tell the VC4 firmware when
  Linux on the ARM CPU is rebooting

- Eric adds a proper power domain driver for the BCM283x SoCs and
  updates a bunch of drivers to have a better and clearer Device Tree
  definition to support power domains/breaking up of functionality. This
  requires converting the existing watchdog driver into a MFD and then
  breaking up the functionality into separate drivers and finally
  updating the DTS files to leverage the power domains information.

- Wei provides a fix for making a symbol static

----------------------------------------------------------------
Eric Anholt (5):
      dt-bindings: soc: Add a new binding for the BCM2835 PM node. (v4)
      bcm2835-pm: Move bcm2835-watchdog's DT probe to an MFD.
      soc: bcm: bcm2835-pm: Add support for power domains under a new binding.
      ARM: bcm283x: Extend the WDT DT node out to cover the whole PM block. (v4)
      ARM: bcm283x: Switch V3D over to using the PM driver instead of firmware.

Florian Fainelli (1):
      Merge tag 'tags/bcm2835-drivers-next-2019-02-01' into drivers/next

Stefan Wahren (3):
      soc: bcm2835: sync firmware properties with downstream
      firmware: raspberrypi: notify VC4 firmware of a reboot
      soc: bcm: Make PM driver default for BCM2835

Wei Yongjun (1):
      soc: bcm: bcm2835-pm: Make local symbol static

 .../bindings/soc/bcm/brcm,bcm2835-pm.txt           |  46 ++
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   4 -
 arch/arm/boot/dts/bcm283x.dtsi                     |  17 +-
 arch/arm/mach-bcm/Kconfig                          |   1 +
 drivers/firmware/raspberrypi.c                     |  11 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/bcm2835-pm.c                           |  92 +++
 drivers/soc/bcm/Kconfig                            |  12 +
 drivers/soc/bcm/Makefile                           |   1 +
 drivers/soc/bcm/bcm2835-power.c                    | 661 +++++++++++++++++++++
 drivers/watchdog/bcm2835_wdt.c                     |  26 +-
 include/dt-bindings/soc/bcm2835-pm.h               |  28 +
 include/linux/mfd/bcm2835-pm.h                     |  14 +
 include/soc/bcm2835/raspberrypi-firmware.h         |   4 +
 14 files changed, 894 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
 create mode 100644 drivers/mfd/bcm2835-pm.c
 create mode 100644 drivers/soc/bcm/bcm2835-power.c
 create mode 100644 include/dt-bindings/soc/bcm2835-pm.h
 create mode 100644 include/linux/mfd/bcm2835-pm.h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
