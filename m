Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3042FC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 04:31:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5882147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 04:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QRQYxmh+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ifMby+g+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5882147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=EWb3HzcD8XqoiEjTqNdnaKwX48gXHxfKyVJpkdXguaM=; b=QRQ
	Yxmh+QNLk9iTDi9IxFRBpkMr/V/hxWoQ37J3ghzMxgMVyx4sAfPKA8Jx+mwWl5g2wob9SzZ4MnIlE
	VtgbEYfJI+BFFmWd9bTM57xWFlyZ9bIzLfdM28T09lQoGK8wJ9GdMddTBNBXZgd9aZyNLNgTfodZA
	pYXex0Wz0T7UqUGcwfekewhRetNyLWw8vPIIudfTJEDcjpXpRqiY8q58B/A4gEGKOdRhRScw4Pp0B
	QMroLvWE/AhrI9Uj2Oegfr5R/JTgqzNxaQV1A4z7BTrxnUG6TxkUmWSeWrQFm7p/8p+OY3b+UJ/BC
	cEW9dljmHpZ9eRmVlUluOoD7jOlapqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqVuu-0007ju-Iz; Mon, 04 Feb 2019 04:31:32 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqVuq-0007iO-Lq
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 04:31:30 +0000
Received: by mail-ot1-x344.google.com with SMTP id e12so11045492otl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 20:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=qEzKBKR16O+a7aFr7X7ANpIIB/owQ0L/InSlFqZvDMg=;
 b=ifMby+g+V5X9N2c+F2yuDWmw9E1FGXIDBgRcErkzO2nYnhlgDatnFcYCa0AasGgSkM
 sZ2TbHkrPcc7gPeHfmxgXOKrOzQ0cdtPaTXe3lajfIW1YCWUc6deYzcsLVglE9VTJMAY
 k1JTYCvMMtesric+Xn9OKbYSlPi30PSclUHo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=qEzKBKR16O+a7aFr7X7ANpIIB/owQ0L/InSlFqZvDMg=;
 b=o7Qh3qs9WlJfiBwO7bDQn+B5eGusfgGiX1hY3CnBu9J9/ACzdFCIPtxTWt52dMKfmw
 lwt89FsRfNSGJtq7X4tiNQjeodsdXX+DPcZ99nHdO8MVIjkRBwGViqPHWWWUGXUqpYn1
 /JrY/Xd+pA6To4BF57CsDWbooCr7pTIUkqoyYW0y74L/hmHMEBmVMzJn33ppMFLk1Jsx
 oWfWw5c8jnP325/jkcmvS86vHCu91uExkG7rWspdPMMmIUyM7wbepkAq8tZob/6mcl8g
 bUQONrVkbrFywz9WEmfNNOZHkCj+5uISszdx4XgmQeTHK+dgDhWpJNRIyvY00XCnmWTy
 COig==
X-Gm-Message-State: AJcUukeBSrwMwHw7JUr0SC9EoSj25+4QPkYvEvDwOng/Ed+jMdHlHm6y
 MetfMN4o6bOVCLx6xE5anbm/3A==
X-Google-Smtp-Source: ALg8bN5EYxqs67gzrbLkqxrnawKkHCyELeBANbnVk0Mgf8jVJIYD+/GlvYoW501Wdm7sp6CwXnq+WQ==
X-Received: by 2002:a9d:7059:: with SMTP id x25mr37324622otj.35.1549254685724; 
 Sun, 03 Feb 2019 20:31:25 -0800 (PST)
Received: from localhost (107-207-74-175.lightspeed.austtx.sbcglobal.net.
 [107.207.74.175])
 by smtp.gmail.com with ESMTPSA id r1sm6972741oie.44.2019.02.03.20.31.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 Feb 2019 20:31:24 -0800 (PST)
From: Andy Gross <andy.gross@linaro.org>
To: arm@kernel.org
Subject: [GIT PULL] Qualcomm ARM64 DT updates for 5.1
Date: Sun,  3 Feb 2019 22:31:18 -0600
Message-Id: <1549254680-1282-1-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_203128_739665_0AAF7EE3 
X-CRM114-Status: GOOD (  13.60  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Olof Johansson <olof@lixom.net>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-5.1

for you to fetch changes up to 5e8204893f62792ebeed88ae505cf658b216eaa0:

  arm64: dts: sdm845: Add interconnect provider DT nodes (2019-02-01 20:16:27 -0600)

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

----------------------------------------------------------------
Amit Kucheria (1):
      arm64: dts: pms405: Export PMIC temperature to thermal framework

Andy Gross (2):
      Merge tag 'qcom-fixes-for-5.0-rc3' into arm64-for-5.1-2
      Merge branch 'arm64-for-5.1' into arm64-for-5.1-2

Bjorn Andersson (8):
      arm64: dts: qcom: sdm845: Increase address and size cells for soc
      arm64: dts: qcom: sdm845: Extend ranges and describe DMA space
      arm64: dts: qcom: sdm845: Fix lpasscc reg
      arm64: dts: qcom: qcs404: Specify pinctrl state for UART
      arm64: dts: qcom: qcs404: Define remaining UARTs
      arm64: dts: qcom: qcs404: Add QUP I2C and SPI nodes
      arm64: dts: qcom: qcs404: Add rpmcc node
      arm64: dts: qcom: msm8996: Disabled VFE SMMU

Can Guo (1):
      arm64: dts: qcom: sdm845: Add UFS nodes for sdm845-mtp

David Dai (1):
      arm64: dts: sdm845: Add interconnect provider DT nodes

Douglas Anderson (2):
      arm64: dts: qcom: sdm845: Add qspi (quad SPI) node
      arm64: dts: sdm845: Add gpu clock controller node

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

 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi  |   2 +
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi |   2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi      |  38 +-
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi  |  24 +
 arch/arm64/boot/dts/qcom/msm8998.dtsi      | 278 ++++++++++
 arch/arm64/boot/dts/qcom/pm8916.dtsi       |   6 +
 arch/arm64/boot/dts/qcom/pms405.dtsi       |  79 +++
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi   |  19 +
 arch/arm64/boot/dts/qcom/qcs404.dtsi       | 359 +++++++++++++
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts    |  84 ++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi       | 799 ++++++++++++++++++++++++-----
 11 files changed, 1564 insertions(+), 126 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
