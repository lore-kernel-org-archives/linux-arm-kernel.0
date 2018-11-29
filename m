Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF8EC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:50:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C30320868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nuDdNmLY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="l4bJakw2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C30320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=WeyG+/nNPINmtusyt5FmjHIso3xY9/MzQl3TE2YAAoI=; b=nuDdNmLYiwpv68
	0GK5Uw1RnAyifBBtQk0wc09hY9ImqogKOSKKvtIhXSrNGAsZPYgw9y29SzhzCyQHXFJyFI6L+TWnq
	sIW6pmj+3mRaEGuKWAkZLekgPSoxADGFZwkJkARYYRBfGavd1eKwB6j2NGCBZjGdHAjCwRsTKr2Tg
	dnF8HYNf+Tl1r+G1NaF8s57Q2WU/pfnFzEzJAP0enSEVvt1Ld8Ol7ASSdnYxNtg3SToWg1xGQso+l
	DEyPezV2HjfceJlDylUqzND0OfzGN3GTkgU1ThL7BXGmIiw0VedK18Y4Sr0OAALMOlqllmjyXJ85S
	ZGKwbX4d6WwqXzd3ADgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSTGu-0001LQ-Bw; Thu, 29 Nov 2018 20:50:52 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSTGn-0001Bv-Ic
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 20:50:48 +0000
Received: by mail-pg1-x544.google.com with SMTP id s198so1475142pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 12:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=P19rKMIxfeM6GjuA4NudIWk71Q3oidZ1MQ01UPHCgfk=;
 b=l4bJakw224kzjnN+wWanWDhwXIHkNCoCtozyfNOtmbEFuyS3NazoWJY+wpLi7SuD7v
 9jjabiJdYkYNw2hGr0f1zi/287vhNNpmz6LKvzXdQ7ouNiGhpsFn0XBmt76NeM2vT1qU
 WhvxxVCeLDDBEzcNW3iZGi7WCHr7bP45+upjP5qrOBEm8go6ClQuw8YG8jmqcVOghzjO
 +Oglk2WkypYYFJDTmy3T3g822Pw+K0GpQh+sN7FOQDoJnpaHrTOk5Gw2ZU0PxpkcMUDM
 K9bX1y0MsjIB8sPziNXotsoDxO54UY4vNLFkTn4I3gcPRTm/hKL1AIel2m4PlLtUblRE
 cDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
 bh=P19rKMIxfeM6GjuA4NudIWk71Q3oidZ1MQ01UPHCgfk=;
 b=GkxdzPcgPvKXyAg3Pei0X3u5Y64mtiafoS1CA1wfWKMTreWVpaDb9vLujEceWYHZhv
 rSceWAuZx3zhfSiMITCS0MVg+8yo8+oMlZmwvVKcJKaBD9zN74UUnFMuxZPiMOSD33iX
 chOKI2x79lSin3ALlh23/yBU+lzbU6LOUe7aRKa1p1xoKNftPuQVf9okhCY1C6JkWSUx
 vkzluugjsiCMQRk+72I1lKpARkRLOFxRditvU1JMnZgJuaFTnpeHcD/oeSFO9ou+SeJW
 tb8OFqabmjIZR6aod5COkoRaV3DtuENxLTy2DkJrCXAq84oxlFWPCbOgPqihLIwNc7Dp
 8y6Q==
X-Gm-Message-State: AA+aEWYUMHe+ctsX3ONVN2jysRi7aivQVrKejf+1YS0u4ER1NN+2/4yW
 Ja2e5duRnNiNKf3TRZFPIVpKeQCWZiw=
X-Google-Smtp-Source: AFSGD/WXu5BVs15Ij0F5QmgOFdR82eUIUq7s04hyjZEtu+CaTmAgeIOEZ2H1ExLn1kQUGBMs31NL3A==
X-Received: by 2002:a63:2849:: with SMTP id o70mr1299027pgo.155.1543524634609; 
 Thu, 29 Nov 2018 12:50:34 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152])
 by smtp.googlemail.com with ESMTPSA id q5sm4524592pfi.165.2018.11.29.12.50.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 29 Nov 2018 12:50:34 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: arm@kernel.org
Subject: [GIT PULL] arm64: dts: Amlogic updates for v4.21
Date: Thu, 29 Nov 2018 12:50:33 -0800
Message-ID: <7hlg5b8v6u.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_125045_623110_D0F929F6 
X-CRM114-Status: GOOD (  14.54  )
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
Cc: linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64

for you to fetch changes up to 5e339a1d7e438b2cc9f46ec9f2682efb58ee2dd3:

  arm64: dts: meson-gx: Add Internal Clock Measurer node (2018-11-29 12:30:09 -0800)

----------------------------------------------------------------
arm64: Amlogic DT updates for v4.21
Some highlights:
- new boards: Phicomm N1 (S905D), Libretech S805-AC
- fixes for pinmux pad bias, GPIO line names
- AXG: enable SCPI, add secure monitor

----------------------------------------------------------------
Christian Hewitt (1):
      arm64: dts: meson-gxl-s905x-khadas-vim enable Bluetooth

He Yangxuan (4):
      arm64: dts: meson: p230: disable advertisement EEE for GbE.
      arm64: dts: meson-gxl: add support for phicomm n1
      dt-bindings: Add vendor prefix for PHICOMM Co., Ltd.
      dt-bindings: arm: amlogic: Add Phicomm N1

Jerome Brunet (13):
      arm64: dts: meson-gx: add efuse pclk
      arm64: dts: meson-axg: fix dtc warning about unit address
      arm64: dts: meson-axg: s400: add cts-rts to the bluetooth uart
      arm64: dts: meson-axg: add secure monitor
      arm64: dts: meson-axg: fix mailbox address
      arm64: dts: meson-axg: correct sram shared mem unit-address
      Documentation: bindings: Add missing Amlogic SCPI sensor bindings
      arm64: dts: meson-axg: enable SCPI
      arm64: dts: meson: s400: add bcm bluetooth device
      arm64: dts: meson: remove extra subnode in mmc clk_gate pinmux
      arm64: dts: meson: disable pad bias for mmc pinmuxes
      arm64: dts: meson: consistently disable pin bias
      dt-bindings: arm: amlogic: add libretech aml-s805x-ac bindings

Neil Armstrong (7):
      arm64: dts: meson-gxl-libretech-cc: fix GPIO lines names
      arm64: dts: meson-gxbb-nanopi-k2: fix GPIO lines names
      arm64: dts: meson-gxbb-odroidc2: fix GPIO lines names
      arm64: dts: meson-gxl-khadas-vim: fix GPIO lines names
      arm64: dts: meson-gx: Add hdmi_5v regulator as hdmi tx supply
      arm64: dts: meson: add libretech aml-s805x-ac board
      arm64: dts: meson-gx: Add Internal Clock Measurer node

Viresh Kumar (1):
      arm64: dts: amlogic: Add all CPUs in cooling maps

 Documentation/devicetree/bindings/arm/amlogic,scpi.txt       |   7 +++
 Documentation/devicetree/bindings/arm/amlogic.txt            |   2 +
 Documentation/devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm64/boot/dts/amlogic/Makefile                         |   2 +
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts               |  34 ++++++++------
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi                   | 155 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi          |   1 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                    |   5 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts         |   4 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts          |   4 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi                  |  64 ++++++++++++++++++++++----
 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts | 248 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts         |   1 +
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts   |  21 +++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts   |  12 ++++-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts |   5 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts         |   1 +
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                   |  66 +++++++++++++++++++++++----
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts        |  23 ++++------
 19 files changed, 590 insertions(+), 66 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
