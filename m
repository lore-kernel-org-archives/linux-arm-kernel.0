Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30295C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:39:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF953208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qFaxnd+7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ATGF942+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF953208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=U7TnJIu2m9HYsDZ8j3sMVxUHaAM9hfSDn6jzNn89hKU=; b=qFaxnd+7g02HZnxW12UVdLCgJZ
	5hThM678ql/CsPDo8ofArVJC+JbSkZjEuuhU7Q6omaITJrWtF6pCBnJ8rrbwvzVQ8cq7VgNcoHjAT
	UviTekLxwkuOagFBN3s48qXDdl7a8FeiGGj3vMUcg2VL2My36RkW6sNPM5SWTxaoF2r19m2gQKfpt
	Qv26E3fMfQTnHZraxvhwjr3z5UlQEAMrxyo95/qoNh+odpepyz4QmDl1HsX+jjrcgywW+rAf4Dbkw
	Dx5A/XjjWcw1/hQo+mCdxSuGnmO8vWI1inMNjgJYYBpHZlBxK8f1SzO2/kOQd1Ywgs8HDEMBgjnAY
	/B/mDUbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTu47-0005DZ-AB; Mon, 03 Dec 2018 19:39:35 +0000
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTu3t-0004xj-Dd
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 19:39:22 +0000
Received: by mail-ot1-x32c.google.com with SMTP id k98so12807200otk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 11:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FqslBd5YSGGP8orNNdkiokNGNWuFTZE/RznVkpWqvdE=;
 b=ATGF942+UoUtNMWallSlawc9mR8Ud2eOVKZIW23U1KMhR65++4RvkaPd55Oc13s005
 t06UjdPSpwbvxtCV+w61E360gh11RO6HmUmD9HK8ncfzDsduucvYNKGLbD7fnFOkXFWr
 gLZc0JJGB4jPoIxEqnOPuwzfSX/QztCUlTRIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FqslBd5YSGGP8orNNdkiokNGNWuFTZE/RznVkpWqvdE=;
 b=Sx82bV3TQZnuVLiJYTwS8ZU6K/PcD8OpFUCJ0SSoRCSBdKtOkcRoBjQiKYea7el2EA
 I78HCIBJ/9Xv2xQSY+dPtVVu17sMpkOnlwqdhwj4FZdlIHZMHSt0mpDwiSGc/tEXUd1H
 TEtD26UCyzalw6SRAx6eZIg41zyE+3/BmAN9QSGBLuDyGyWWwqeFyElVMiYRtn4cEBld
 xKQFGNL1IhwqreRBc9CPvVxiKaOH/Dsqr1htYvxOKsfWuzES3iEC6Qr80sfezeP/X0Ya
 QnBsHNcEVDfWmw7AQ7jm4aCLjot3jhHDyLPM9o5klC9GEOV8telx8KR07HC2jJlAkMmw
 z7yQ==
X-Gm-Message-State: AA+aEWY0L0HhfWaJ/7bBsiBS+1H/q4D4TbkRDKZ+1EXeY9I/bbnv3ihr
 JdSUCCZZWmgyQxQEeYhDsR2Cxg==
X-Google-Smtp-Source: AFSGD/XCq2LVFCeaNBMt8q8Q12thYN42O/BBfB6sYMf0GSRuH4aIPZcnylsW7nIcxf6o17hRcItlxg==
X-Received: by 2002:a9d:600f:: with SMTP id h15mr10641822otj.42.1543865947587; 
 Mon, 03 Dec 2018 11:39:07 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:60aa:6557:7f4e:5d7d])
 by smtp.gmail.com with ESMTPSA id 52sm26652983oti.30.2018.12.03.11.39.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 11:39:07 -0800 (PST)
From: Andy Gross <andy.gross@linaro.org>
To: arm@kernel.org
Subject: [GIT PULL] Qualcomm ARM64 DT updates for 4.21
Date: Mon,  3 Dec 2018 13:39:02 -0600
Message-Id: <1543865944-3591-2-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543865944-3591-1-git-send-email-andy.gross@linaro.org>
References: <1543865944-3591-1-git-send-email-andy.gross@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_113921_459476_D31C6FD9 
X-CRM114-Status: GOOD (  17.61  )
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

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.21

for you to fetch changes up to 70827d9f6bc4f481fafe790dd6654ba568526768:

  arm64: dts: qcom: msm8998: Fix compatible of scm node (2018-11-30 07:59:02 -0600)

----------------------------------------------------------------
Qualcomm ARM64 Updates for v4.21

* Add QCS404 base platform and nodes
* Add QCS404 EVB boards
* Add external SD and dependencies for MSM8998-mtp
* Add default scm compatible for MSM8998
* Fix XO clk name on MSM8998
* Add prng-ee nodes for SDM845 and MSM8996
* Add ADC die temp node for pm8998
* Fix documentation on QCOM ADC sample

----------------------------------------------------------------
Amit Kucheria (5):
      arm64: dts: msm8916: thermal: split address space into two
      arm64: dts: msm8916: thermal: Add "qcom,sensors" property
      arm64: dts: msm8916: Add gpu thermal zone
      arm64: dts: msm8916: Add camera thermal zone
      arm64: dts: sdm845: enable tsens thermal zones

Andy Gross (4):
      Merge tag 'qcom-fixes-for-4.20-rc1' into arm64-for-4.21
      Merge tag 'qcom-fixes-for-4.20-rc1' into arm64-for-4.21-3
      Merge branch 'arm64-for-4.21' into arm64-for-4.21-3
      Merge branch 'qcs404-topic-revised' into arm64-for-4.21-3

Bjorn Andersson (10):
      arm64: dts: sdm845-mtp: Reserve reserved gpios
      arm64: dts: qcom: msm8998: Reserve gpio ranges on MTP
      arm64: dts: qcom: qcs404: Add reserved-memory regions
      arm64: dts: qcom: qcs404: Add RPM GLINK related nodes
      arm64: dts: qcom: qcs404: Add PMS405 RPM regulators
      arm64: dts: qcom: qcs404: Add TLMM pinctrl node
      arm64: dts: qcom: qcs404: Add sdcc1 node
      arm64: dts: qcom: qcs404: Add scm firmware node
      arm64: dts: qcom: qcs404: Add remoteproc nodes
      arm64: dts: qcom: msm8998: Fix compatible of scm node

Jeffrey Hugo (4):
      arm64: dts: qcom: msm8998: correct xo clock name
      arm64: dts: qcom: msm8998: Add SDCC2
      arm64: dts: qcom: msm8998-mtp: Add external SD
      arm64: dts: qcom: msm8998: Add SDC2 control pins

Matthias Kaehlcke (2):
      dt-bindings: iio: vadc: Add unit address to ADC channel node in example
      arm64: dts: qcom: pm8998: Add die temperature channel node to the ADC

Vinod Koul (13):
      arm64: dts: msm8996: add prng-ee node
      arm64: dts: sdm845: add prng-ee node
      arm64: dts: qcom: qcs404: add base dts files
      arm64: dts: qcom: qcs404-evb: add dts files for EVBs
      arm64: dts: qcom: qcs404: add smp2p nodes
      arm64: dts: qcom: pms405: add spmi node
      arm64: dts: qcom: qcs404: add spmi node
      arm64: dts: qcom: pms405: add rtc node
      arm64: dts: qcom: pms405: add gpios
      arm64: dts: qcom: qcs404: add prng-ee node
      arm64: dts: qcom: qcs404: Add BAM DMA node
      arm64: dts: qcom: qcs404: Use BAM DMA for serial uart2
      arm64: dts: qcom: pms405: Add pon and pwrkey nodes

 .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt |   6 +-
 arch/arm64/boot/dts/qcom/Makefile                  |   2 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  47 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   7 +
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi          |  16 +
 arch/arm64/boot/dts/qcom/msm8998-pins.dtsi         |  78 ++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |  24 +-
 arch/arm64/boot/dts/qcom/pm8998.dtsi               |   5 +
 arch/arm64/boot/dts/qcom/pms405.dtsi               |  55 +++
 arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts       |  11 +
 arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts       |  11 +
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi           | 188 ++++++++
 arch/arm64/boot/dts/qcom/qcs404.dtsi               | 490 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts            |   4 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 178 ++++++++
 15 files changed, 1117 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pms405.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/qcs404.dtsi

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
