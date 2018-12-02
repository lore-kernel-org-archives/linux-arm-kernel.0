Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9A7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 19:23:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B0102082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 19:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ol2ywpm1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ql+oyCc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B0102082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=UnK4QfgACuFaUlool6LC63xmFLB0gZ0VZh9U7WQRdtw=; b=ol2ywpm104dfXK
	tYWgQzNagDB5QX9k6HPhXYvF6pOwEJo0d6h+lHMz3WJITaKqntqH6nIy5n/9M3OZ4TRomysoPIM1u
	VKHsb1L1Ct5vVYFsZvy+YRNgoEDT772MlcF0RVVMQZ/Et8cXuRECcuwcbQG2WCnIpn9xIpwc/pSJ4
	sfZtOzLLO0gX/7glvwcAjqoMZ/HPSfw3jtOqOczXanYyDnlxLuPVW0ny9D6XntaeiArQSuPxhhh93
	s9n1zChivc85GLz9OmTf87hxma8V5tnN4o5vtou7+cfQ+y9StdWH2cesz12ZrJNrHnPQX9+G3Govk
	Jr6kqrMDaGCYYqGC3/dQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTXKw-00047H-By; Sun, 02 Dec 2018 19:23:26 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTXKs-0003uC-ED
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 19:23:24 +0000
Received: by mail-lf1-x141.google.com with SMTP id c16so7527503lfj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 11:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=oWQtvkC4jHttd2nA6F2crVgTyhj04+H6PphOVG/w+WY=;
 b=ql+oyCc3yWJmFc78BznASs8JcwcNFrwZ0XfjEhI4FloGXA5eoCYsxMQjx2IwyII1AY
 T6rZDrksaDcuT5mivIvgqTpdpG7CeoF3O98YJxZiL66SXiKWuYIIW+6EFa1H4g007Z9f
 8E9qzcSAFGbKkEaIrvpyqUpU+r3DRTTYLGTMuzDDtJY5Jqe42pn2ofjLYyxbV8OGn/My
 vAA914jW550Fc7NdeTMrLiSLK1oD1Q9yBfRA6xvc1Z9VTaaczAa+4OWfQC77eYXDyQFI
 lcwCcScgjwer7m5L2Ly+XE3HOezxuZIZGBiJOaTtodDY1E5XbkK6oClVT5vPRcxXdvZ5
 Gj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=oWQtvkC4jHttd2nA6F2crVgTyhj04+H6PphOVG/w+WY=;
 b=GEH5G7fZxsDsGdHT0x8g5kS/6SBCTSNsK27fvJReQgyZvHTGvMTp/RDo2bMQjT/KRD
 boIsjK6yHKMI7MeBcvFV1XzGG53rEKy89tnPq7kx6lGuuuqXBvpXVv2z3UvfU/xqPBbz
 Fh/T6lYA+WCtdNyap3XgN3Zv97Q4Tmhdqt7B4Tf7290DB4OlkldCX42vkYQ8qfeKgT7i
 6hRWkeyx7Q5Oi6xIdc3kLwqbJIpl/7/GsVvbFzg4OenFEEvIzmbbTFvY5FJ4zWJD+7Bb
 fK2g+4cxTTBlqnKRv9Nf0vhgzhLWG4N0hvtL6+V4yf+A0buDwMCKAZWwa9IPlxgSyl4N
 m08A==
X-Gm-Message-State: AA+aEWZ3cl7OLxlJHJA02qM7tMwfG7fmrVORM2dCL5X0cTzI02JCnH5c
 SxUy8USH36ViCDWzi3DeyJVt+g==
X-Google-Smtp-Source: AFSGD/WX+byf3moCVQCy/p8tfthpqhgtl5ILD9a6mLljbtXlEnm2H2XeIOx7Ex1Zp5nrSC2iJau8Uw==
X-Received: by 2002:a19:ced3:: with SMTP id e202mr7599071lfg.13.1543778590176; 
 Sun, 02 Dec 2018 11:23:10 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id p67sm1942529lfe.14.2018.12.02.11.23.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 02 Dec 2018 11:23:08 -0800 (PST)
Date: Sun, 2 Dec 2018 11:23:01 -0800
From: Olof Johansson <olof@lixom.net>
To: torvalds@linux-foundation.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20181202192301.wty5dpqayobx3i67@localhost>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_112322_485123_C7F06E96 
X-CRM114-Status: GOOD (  14.83  )
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
Cc: olof@lixom.net, arm@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Linus,

The following changes since commit a89f84a56ec95fd66b839bf9c545f8a59a4ffcd5:

  Merge tag 'stratix10_dts_fix_for_v4.20' of git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux into fixes (2018-11-07 08:09:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to bfed4d730823440d0da0cd21554efc2de831627d:

  Merge tag 'imx-fixes-4.20-2' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into fixes (2018-11-30 11:57:53 -0800)

----------------------------------------------------------------
ARM: SoC fixes

Volume is a little higher than usual due to a set of gpio fixes for
Davinci platforms that's been around a while, still seemed appropriate
to not hold off until next merge window.

Besides that it's the usual mix of minor fixes, mostly corrections of
small stuff in device trees.

Major stability-related one is the removal of a regulator from DT on
Rock960, since DVFS caused undervoltage. I expect it'll be restored once
they figure out the underlying issue.

----------------------------------------------------------------
Adam Ford (4):
      ARM: dts: am3517: Fix pinmuxing for CD on MMC1
      ARM: dts: LogicPD Torpedo: Fix mmc3_dat1 interrupt
      ARM: dts: logicpd-somlv: Fix interrupt on mmc3_dat1
      ARM: dts: am3517-som: Fix WL127x Wifi interrupt

Andy Gross (1):
      MAINTAINERS: Remove unused Qualcomm SoC mailing list

Bartosz Golaszewski (12):
      ARM: davinci: da8xx: define gpio interrupts as separate resources
      ARM: davinci: dm365: define gpio interrupts as separate resources
      ARM: davinci: dm646x: define gpio interrupts as separate resources
      ARM: davinci: dm355: define gpio interrupts as separate resources
      ARM: davinci: dm644x: define gpio interrupts as separate resources
      gpio: davinci: restore a way to manually specify the GPIO base
      ARM: davinci: da850: set the GPIO base to 0
      ARM: davinci: dm365: set the GPIO base to 0
      ARM: davinci: dm646x: set the GPIO base to 0
      ARM: davinci: dm355: set the GPIO base to 0
      ARM: davinci: da830: set the GPIO base to 0
      ARM: davinci: dm644x: set the GPIO base to 0

Bjorn Andersson (2):
      arm64: dts: sdm845-mtp: Reserve reserved gpios
      arm64: dts: qcom: msm8998: Reserve gpio ranges on MTP

Christoph Muellner (1):
      arm64: dts: rockchip: Fix PCIe reset polarity for rk3399-puma-haikou.

Daniel Lezcano (1):
      arm64: dts: rockchip: remove vdd_log from rock960 to fix a stability issues

Fabio Estevam (1):
      ARM: dts: imx51-zii-rdu1: Remove EEPROM node

Heiko Stuebner (1):
      ARM: dts: rockchip: Remove @0 from the veyron memory node

Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta: Fix possible use of uninitialized field

Jon Mason (1):
      MAINTAINERS: Remove self from Broadcom SoCs

Nathan Chancellor (1):
      ARM: OMAP2+: prm44xx: Fix section annotation on omap44xx_prm_enable_io_wakeup

Olof Johansson (9):
      Merge tag 'qcom-fixes-for-4.20-rc1' of git://git.kernel.org/.../agross/linux into fixes
      Merge tag 'am654-fixes-for-v4.20' of git://git.kernel.org/.../kristo/linux into fixes
      Merge tag 'arm-soc/for-4.20/maintainers-part2' of https://github.com/Broadcom/stblinux into fixes
      Merge tag 'at91-4.20-fixes' of git://git.kernel.org/.../at91/linux into fixes
      Merge tag 'v4.20-rockchip-dts32fixes-1' of git://git.kernel.org/.../mmind/linux-rockchip into fixes
      Merge tag 'v4.20-rockchip-dts64fixes-1' of git://git.kernel.org/.../mmind/linux-rockchip into fixes
      Merge tag 'davinci-fixes-for-v4.20' of git://git.kernel.org/.../nsekhar/linux-davinci into fixes
      Merge tag 'omap-for-v4.20/fixes-rc4' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'imx-fixes-4.20-2' of git://git.kernel.org/.../shawnguo/linux into fixes

Romain Izard (1):
      ARM: dts: at91: sama5d2: use the divided clock for SMC

Tony Lindgren (1):
      Merge branch 'fixes-dts' into omap-for-v4.20/fixes

Vignesh R (1):
      arm64: dts: ti: k3-am654: Fix wakeup_uart reg address

 MAINTAINERS                                        |  3 --
 arch/arm/boot/dts/am3517-evm.dts                   |  2 +-
 arch/arm/boot/dts/am3517-som.dtsi                  |  2 +-
 arch/arm/boot/dts/imx51-zii-rdu1.dts               |  6 ----
 arch/arm/boot/dts/logicpd-som-lv.dtsi              |  2 +-
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts  |  2 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi               |  6 +++-
 arch/arm/boot/dts/sama5d2.dtsi                     |  2 +-
 arch/arm/mach-davinci/da830.c                      |  4 ++-
 arch/arm/mach-davinci/da850.c                      |  4 ++-
 arch/arm/mach-davinci/devices-da8xx.c              | 40 ++++++++++++++++++++++
 arch/arm/mach-davinci/dm355.c                      | 32 +++++++++++++++++
 arch/arm/mach-davinci/dm365.c                      | 37 ++++++++++++++++++++
 arch/arm/mach-davinci/dm644x.c                     | 22 ++++++++++++
 arch/arm/mach-davinci/dm646x.c                     | 12 +++++++
 arch/arm/mach-omap1/board-ams-delta.c              |  3 ++
 arch/arm/mach-omap2/prm44xx.c                      |  2 +-
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi          |  4 +++
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts            |  4 +++
 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi   | 12 -------
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi         |  2 +-
 drivers/gpio/gpio-davinci.c                        |  2 +-
 include/linux/platform_data/gpio-davinci.h         |  2 ++
 24 files changed, 176 insertions(+), 33 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
