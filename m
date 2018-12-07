Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5A1C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:18:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2017A20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ArQ86D94";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MU9WvnwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2017A20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BQzNjScSTgQ14YPLXJ6E63p9Jhxkw4q2vjVEUunQcAc=; b=ArQ86D94q1ewsE
	E0Lh7zwzEU/g+9frmIZk4Bbzx3f1wv7bJIeS3cKVS6rg887ro/JhnngFXqs5cGUiZWORlZKGgDfOm
	vWDRi3yuqHS90Rz3NsTWh2E1IO+WtaGE0RfscUR5BappffwpNMGF8cveIFg/hTznYx0xUhUS/wRa7
	TUENsO8wMfoQ0LMF8osnzBG40FYWLh8QIUMK3vqzZ0fLZq+OJrLTp6SUvX+QdLG/64Q15y8//vSiB
	+Zf6wgM8TQC/DLY0xtGE7i/rgcxPcI6iRwgGkrleZqpAfr0xgaeLo1HtMLYPrpqxkrX9GcAXzoMAF
	CvhFBMuSZb8XJP767Xiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVGxI-0001S3-Ip; Fri, 07 Dec 2018 14:18:12 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVGwz-000191-AG
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 14:17:56 +0000
Received: by mail-ed1-x541.google.com with SMTP id b3so3860172ede.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 06:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E63Oi1rYFfDUh1Jdxlykxvm2bhZ99JkkwzHdmXnuD0Y=;
 b=MU9WvnwLR0eMnPQjpVTKgsCMdNmFyoA0fRHHvcJ4kbue4e37DWeaFtWF7zuiLqiQ/p
 k/xeEwABP1Tjnw+O3Onk4lCrBgentPGWDxWv5M+aN3lWGpr8OznhapFD7u+G/H8Mtz/Q
 X4DcjiETCryNBk2fogm4N+YvU4TaIJpjnMMPVACIJrRsV4nHyGcbJbGiaaKd50tgWugi
 02joNg7jGAhaTLxHaKng3OWvR2yZVLsfV+saMXzFpIKi8cJxe3k2PjjCDWBndzEA9boa
 RKUsrgQhDzqmDHj2ESVbILOllJKMipqw9C1LblgXoS9RJGGdiPJ5eish9PyzOe2lHKRP
 c9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E63Oi1rYFfDUh1Jdxlykxvm2bhZ99JkkwzHdmXnuD0Y=;
 b=IUtDuVqHADr+2McFZGVclehBlzOIqWUmAuBaQ5wdsD7Bo3TTsfYcHctKUUaPm4iwTM
 aWnpoOFVTvKnTbHV90vAmSHgtnAUYBgrxGyIsZ9ZtTTJoNQPmLk25yQrrgb2JJylqXYm
 pr+CxiV9v6euQ0KYsCGqtYsW5jspSnrJqN1BbOdsOx1luIs1IWu+WAOM4W8MAXZO7jH2
 /exZ6F4CGbRskEfCbePIjeDkXYigEdpPr6QoLOa88dfQTah+kWQ50my/4MCpKfsOgxrT
 os/XxKrMLNcbPaL8fSH205/Ut8KtfUGBUQ2Y0VY/Xi04kEkWQAfUPeNxCqqVF2FVKAM0
 X0/w==
X-Gm-Message-State: AA+aEWYL/coFv8NEk8BlBhNpkQnKKSuXd/Za6qE0zFiSZqCYo44ON/pk
 65HjJsewFsgKkWRgWGWpIUgsgcYp
X-Google-Smtp-Source: AFSGD/VPeackJvR8rpfxToh2BBh2WoPQqz3S1BfKEL3SO8omINJx56mjt4HzcpABupgG0HKeXrTlMw==
X-Received: by 2002:a50:a1e5:: with SMTP id 92mr2431815edk.181.1544192269057; 
 Fri, 07 Dec 2018 06:17:49 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id k31sm1085235ede.5.2018.12.07.06.17.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 06:17:48 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: arm@kernel.org
Subject: [GIT PULL 6/6] arm64: tegra: Device tree change for v4.21-rc1
Date: Fri,  7 Dec 2018 15:17:39 +0100
Message-Id: <20181207141739.9085-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181207141739.9085-1-thierry.reding@gmail.com>
References: <20181207141739.9085-1-thierry.reding@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_061753_373214_FD4B9915 
X-CRM114-Status: GOOD (  14.08  )
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
Cc: linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.21-arm64-dt

for you to fetch changes up to 611a1c69f8ca85fc656f09d0cd56f5934e2af5fb:

  arm64: tegra: Set reg property for display-hub on Tegra194 (2018-12-07 12:57:26 +0100)

Note that this pulls in a subset of the code that is also part of the
first pull request in this series in order to satisfy some build-time
dependencies.

Thanks,
Thierry

----------------------------------------------------------------
arm64: tegra: Device tree change for v4.21-rc1

These changes add a bunch of features for Tegra194 and Tegra186, such as
wake events, on-die RTC, temperature sensors, HDA for audio over HDMI
and fan support on Jetson Xavier to allow cooling of the device.

----------------------------------------------------------------
Dmitry Osipenko (3):
      dt: bindings: tegra20-emc: Document interrupt property
      dt: bindings: tegra20-emc: Document clock property
      dt: bindings: Move tegra20-emc binding to memory-controllers directory

Jon Hunter (2):
      dt-bindings: usb: xhci-tegra: Add power-domain details
      arm64: dts: tegra210: Add power-domains for xHCI

Krishna Reddy (1):
      arm64: dts: tegra186: Enable IOMMU for SDHCI

Sameer Pujar (1):
      arm64: tegra: Add HDA controller on Tegra194

Thierry Reding (30):
      dt-bindings: thermal: tegra-bpmp: Add Tegra194 support
      Merge branch 'for-4.21/dt-bindings' into for-4.21/arm64/dt
      dt-bindings: tegra186-pmc: Add interrupt controller properties
      Merge branch 'for-4.21/dt-bindings' into for-4.21/arm64/dt
      arm64: tegra: Add PWM controllers on Tegra194
      arm64: tegra: Add PWM fan support on Jetson Xavier
      arm64: tegra: Clarify that P2972-0000 is Jetson Xavier
      arm64: tegra: Add display support on Tegra194
      arm64: tegra: Add VIC support on Tegra194
      arm64: tegra: Enable HDMI on P2972-0000
      arm64: tegra: Add thermal zones on Tegra194
      arm64: tegra: p2972: Enable the CPU, GPU and AUX thermal zones
      arm64: tegra: Fix power key interrupt type on Jetson TX2
      arm64: tegra: Enable PMC wake events on Tegra186
      arm64: tegra: Add RTC support on Tegra186
      arm64: tegra: p3310: Enable on-die RTC
      arm64: tegra: Enable PMC wake events on Tegra194
      arm64: tegra: Add RTC support on Tegra194
      arm64: tegra: p2888: Enable on-die RTC
      arm64: tegra: Add AON GPIO controller on Tegra194
      arm64: tegra: Add gpio-keys on Jetson Xavier
      arm64: tegra: Add temperature sensor on P2888
      arm64: tegra: Add HDA controller on Tegra186
      arm64: tegra: Enable HDA on Jetson TX2
      arm64: tegra: Add CEC controller on Tegra186
      arm64: tegra: Enable HDA on Jetson Xavier
      arm64: tegra: Add CEC controller on Tegra194
      arm64: tegra: Enable HDA controller on Jetson TX1
      arm64: tegra: Set reg property for display-hub on Tegra186
      arm64: tegra: Set reg property for display-hub on Tegra194

 .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     |   3 +
 .../nvidia,tegra20-emc.txt                         |   4 +
 .../thermal/nvidia,tegra186-bpmp-thermal.txt       |   3 +-
 .../bindings/usb/nvidia,tegra124-xusb.txt          |   8 +
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |   6 +
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi     |   4 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  45 +-
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |  30 +-
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 157 +++++-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           | 538 ++++++++++++++++++++-
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |   4 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   2 +
 .../dt-bindings/thermal/tegra194-bpmp-thermal.h    |  15 +
 13 files changed, 813 insertions(+), 6 deletions(-)
 rename Documentation/devicetree/bindings/{arm/tegra => memory-controllers}/nvidia,tegra20-emc.txt (95%)
 create mode 100644 include/dt-bindings/thermal/tegra194-bpmp-thermal.h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
