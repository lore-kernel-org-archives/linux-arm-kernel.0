Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E62C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:21:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2461821B18
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o5ENwPhW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l/tvgEOn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2461821B18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=iCTRPg8vVoF+h7TuFK08wfxRxGLG8EP4zCyoQ5IfFak=; b=o5E
	NwPhW55f2hD1QsHyZOF3KHj/pDVxTDhr4j18LbMnf5NuciPaHuATR5FKDbHmGqg6gVKmaF+HEF0HX
	VRpaPzgiBirwt+K0Q1N+pFqTyy7sP5pxx9N14iNb7hvMMGE3zAgrQL6FCfvEkl0rXmh67L7yRuwsk
	KhE7hqlcD32wLGgsQOtFfK7A9h3c32+Q5wDOThTV/z/ALX5Y01pO4ds5ezZ0+CUCNJ55FgP4DJshz
	VJMiaILXUDN7WMXJeI/2Ptuqb4WWRvQtfV7LZY1mID9vl51gYxDLdw89w2gVfRhyMruprUio3PAUm
	t0kd2daucMVuEDAfVvH1BxMDK8o6s1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guj3U-0001Xa-SU; Fri, 15 Feb 2019 19:21:48 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guj3R-0001X6-RW
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 19:21:47 +0000
Received: by mail-ot1-x344.google.com with SMTP id n71so18339553ota.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 11:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=nucSk5NnOC8q2dC8Ro2HCytGqzXLWxDUb/7L5sopsz0=;
 b=l/tvgEOnfVS5BZWoI8F0HBIeELIelYGOHYCyOvGfDfhsX/b/FfLmZS5bBcpHuL9AQa
 9owbGdJJ/seRm2duE2XeghWtO4EXK5hPkQO74lAC+aiXFYEMqIlXYa6CF/sqL5cEYe2N
 JGoTfoa146e9ntut4FuU12sZCdmZX+yGq8gJZ3z6H/V4YX2ick7e6OeEqfSRStr0zTwq
 1QO/cooDaK8AI93HQhbtHV3Snp16h3OnuNuBJJXV91eYeMnJqmIRxZjLAVCDR7fnhOrs
 otJADvflhB+3QslGtpjIzug5gff4gZlz7xsM3qjfBCSp1MNje/Kvbvh6YbeDZ/B3KXS/
 1+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=nucSk5NnOC8q2dC8Ro2HCytGqzXLWxDUb/7L5sopsz0=;
 b=oAkCIHWdjTzA2wFaf3FCJmcbNodZOAfPQFQnoQVWTjxH9ma+BBzlE1Heux40FMBFI7
 H3dlumG4SCwF3sYdpn+VzdlQGmfZHLtIB+/Feu/mgfWgqgFFs3HZSxjCxHHOBBEIvG+k
 7Whc+qUuXPbTMA5loSvD5u6qRnOHDjlbSvtSTpG8q0r5OpXFeagYRRTNPy1A25db3Jni
 1fqfpOypEG8uj/LefigKhEcHUHl1G+Zb7beTFMlRuKjP7B0bWI1py9xnznJweQg9C8X/
 k6f9w53ENUt6otI6zavQq2ieJdFQ3G3fNvwuhZ8EqSajj0yMmULGnrEyLGFKvZMxOkG/
 zILg==
X-Gm-Message-State: AHQUAuaWK+L75jksBKIal9kj+73+NBQ4QT/86euSeh+rNz6leHbOBcw8
 OUj/CKvkK3kOW/IfR4TFyv5OCQ==
X-Google-Smtp-Source: AHgI3IY8Zav0WZFXEJ2LmRgjldSKzPqKbz5i9uoCrESAkHE3xFKNi4RyOkTXrfw/NNjV/DXjLjUfsA==
X-Received: by 2002:aca:1e12:: with SMTP id m18mr6209250oic.113.1550258504701; 
 Fri, 15 Feb 2019 11:21:44 -0800 (PST)
Received: from localhost (107-207-74-175.lightspeed.austtx.sbcglobal.net.
 [107.207.74.175])
 by smtp.gmail.com with ESMTPSA id q128sm2727267oia.4.2019.02.15.11.21.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Feb 2019 11:21:43 -0800 (PST)
From: Andy Gross <andy.gross@linaro.org>
To: arm@kernel.org
Subject: [GIT PULL] Qualcomm ARM64 DT updates for 5.1 - REVISED
Date: Fri, 15 Feb 2019 13:21:40 -0600
Message-Id: <1550258500-19904-1-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_112145_897649_B5141752 
X-CRM114-Status: GOOD (  14.59  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@baylibre.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, linux-arm-msm@vger.kernel.org,
 Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-5.1

for you to fetch changes up to 08585d21de9875a6064b350957faa0460a4c69a6:

  arm64: dts: sdm845: Fixup dependency on RPMPD includes (2019-02-15 13:13:51 -0600)

----------------------------------------------------------------
Qualcomm ARM64 Updates for v5.1

* Add MSM8998 RPMCC, I2C, and USB related nodes
* Add MSM8996 rpmpd node
* Fix typo in MSM8996 pin definitions
* Disable MSM8996 VFE smmu to fix security violation
* Add I2C, SPI, rpmcc, uart, and WCN3990 wlan nodes on QCS404
* Enable SDCC1 HS400 support on QCS404
* Add a multitude of nodes on SDM845:
  SD, UFS, USB, LPASS, SCM, QSPI, PDC, DPU, videocc, GPU, RPMh
  bus interconnect, WCN3990 WLAN
* Add gpio ranges to SDM845 TLMM
* Fix regulator load on sdcard on MSM8998-mtp board
* Add thermal trip points to cpufreq
* Add SDM845 IOMMU info for SDHC, USB, and WLAN
* Fix MSM8916 clock cell argument

----------------------------------------------------------------
Amit Kucheria (2):
      arm64: dts: pms405: Export PMIC temperature to thermal framework
      arm64: dts: sdm845: wireup the thermal trip points to cpufreq

Andy Gross (3):
      Merge tag 'qcom-fixes-for-5.0-rc3' into arm64-for-5.1-2
      Merge branch 'arm64-for-5.1' into arm64-for-5.1-2
      arm64: dts: sdm845: Fixup dependency on RPMPD includes

Bjorn Andersson (10):
      arm64: dts: qcom: sdm845: Increase address and size cells for soc
      arm64: dts: qcom: sdm845: Extend ranges and describe DMA space
      arm64: dts: qcom: sdm845: Fix lpasscc reg
      arm64: dts: qcom: qcs404: Specify pinctrl state for UART
      arm64: dts: qcom: qcs404: Define remaining UARTs
      arm64: dts: qcom: qcs404: Add QUP I2C and SPI nodes
      arm64: dts: qcom: qcs404: Add rpmcc node
      arm64: dts: qcom: msm8996: Disabled VFE SMMU
      arm64: dts: qcom: sdm845: Define IOMMU for sdhc 2
      arm64: dts: qcom: sdm845: Define iommus for USB controllers

Can Guo (1):
      arm64: dts: qcom: sdm845: Add UFS nodes for sdm845-mtp

David Dai (1):
      arm64: dts: sdm845: Add interconnect provider DT nodes

Douglas Anderson (3):
      arm64: dts: qcom: sdm845: Add qspi (quad SPI) node
      arm64: dts: sdm845: Add gpu clock controller node
      arm64: dts: sdm845: Add clocks and iommus to WCN3990 WLAN node

Evan Green (5):
      arm64: dts: qcom: sdm845: Add SD node
      arm64: dts: qcom: sdm845: Add SD nodes for sdm845-mtp
      arm64: dts: qcom: sdm845: add UFS controller
      arm64: dts: qcom: sdm845: Add USB PHY lane two
      arm64: dts: qcom: sdm845: Add gpio-ranges to TLMM node

Govind Singh (2):
      arm64: dts: qcom: qcs404: Add WCN3990 WLAN module device node
      arm64: dts: sdm845: Add WCN3990 WLAN module device node

Jakob Wuhrer (1):
      arm64: dts: qcom: Correct "gpiio" typo in msm8996-pins

Jeffrey Hugo (3):
      arm64: dts: qcom: msm8998-mtp: Increase load on l21 for sdcard
      arm64: dts: qcom: msm8998: Enumerate i2c controllers
      arm64: dts: qcom: msm8998: Add USB-related nodes

Jeykumar Sankaran (1):
      arm64: dts: qcom: sdm845: Add dpu to sdm845 dts file

Jorge Ramirez-Ortiz (1):
      arm64: dts: qcom: qcs404: sdcc1: enable HS400

Loic Poulain (2):
      arm64: dts: apq8016-sbc: Increase load on l11 for SDCARD
      arm64: dts: qcom: pm8916: Add PON watchdog node

Manu Gautam (1):
      arm64: dts: qcom: sdm845: Fix pcs_misc region address for UNI PHY

Marc Gonzalez (1):
      arm64: dts: qcom: msm8998: Add rpmcc node

Niklas Cassel (1):
      arm64: dts: msm8916: remove bogus argument to the cpu clock

Rajendra Nayak (2):
      arm64: dts: msm8996: Add rpmpd device node
      arm64: dts: sdm845: Add rpmh powercontroller node

Sai Prakash Ranjan (1):
      arm64: dts: qcom: sdm845: Remove the duplicate header inclusion

Sibi Sankar (3):
      arm64: dts: qcom: sdm845: Add SCM DT node
      arm64: dts: qcom: sdm845: Add PDC Global reset driver node
      arm64: dts: qcom: sdm845: Add reserve-memory nodes

Srinivas Kandagatla (1):
      arm64: dts: add msm8996 compatible to gicv3

Taniya Das (3):
      arm64: dts: sdm845: Add cpufreq device node
      arm64: dts: sdm845: Add videocc node
      arm64: dts: sdm845: Add lpasscc node

Vivek Gautam (1):
      arm64: dts: sdm845: Add node for arm,mmu-500

 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi  |    2 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi      |    8 +-
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi |    2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi      |   38 +-
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi  |   24 +
 arch/arm64/boot/dts/qcom/msm8998.dtsi      |  278 ++++++++
 arch/arm64/boot/dts/qcom/pm8916.dtsi       |    6 +
 arch/arm64/boot/dts/qcom/pms405.dtsi       |   79 +++
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi   |   19 +
 arch/arm64/boot/dts/qcom/qcs404.dtsi       |  359 ++++++++++
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts    |   84 ++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi       | 1046 ++++++++++++++++++++++++----
 12 files changed, 1792 insertions(+), 153 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
