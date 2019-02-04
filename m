Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8DBC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 04:32:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD512147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 04:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q+vCn8fE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e3pVKuKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD512147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=3InkMeYc69PCODu9a3N4nNYr2DZ69vB04WQgVwUVBUQ=; b=Q+vCn8fEkUS5CEntmkubrsnWdS
	EWYdcfebxhnjLyLqjxCkcTNSpUvh4rr5utGfKVulEfyzf1oBmtIS+0K5BV64e8qtw/iUgwUxpVHEN
	ijotn1t2Br2wc8j0aTjBWRC+4uSKNitqnUAVoVIepPoykmE1DzQjTc/uSK60jz6LY4s7NUC3CLffV
	OJI6n8T730SlZwc8h3VY9yJM808u20P+lqRdf3lL4KYbOjXq62ZyuwlOJKynars7Jl3mAdjLEFC0+
	yyxTlr2B0H0SeV6LHgEauan5T5Ag+tgHsRiFYr7dk4Y+wU/dBRHmV16YV4CyP9IX/Skqtzg71anCi
	KfaGtHDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqVvO-0008GA-Bc; Mon, 04 Feb 2019 04:32:02 +0000
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqVux-0007mI-Pg
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 04:31:39 +0000
Received: by mail-oi1-x241.google.com with SMTP id y1so10408292oie.12
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 20:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fhijXkr/F671MJM3fOFN6hoNdSI/z39Cw1jn4kfxMPc=;
 b=e3pVKuKF86RrGNbo8GsGGdZ7hDDXbaYFizLi3WafyVrlIsTZdOdzeWmgeQC7Ll1dLM
 KdtNDG2wMJSNGLIDUcziDzw9QodH2zcT+PvACCGOR1LeZm0EBI1DcIjdSey7LTYUyj7m
 m3KztlrtK2l5ese4b5IwCBdFlZ7sYYE3BuET0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fhijXkr/F671MJM3fOFN6hoNdSI/z39Cw1jn4kfxMPc=;
 b=DahTK+0qzJgZi6QHn7Kr80IWQs07gEbmHT1jtNbBetgASqQe58vDBn6wuTbHKWwVTp
 tZpuM6cCbNAvoPf9mmwPw0y9fi9uGwa4wxP2U+1Q6Q8GdI1/PcujAT+xWBW7Kt5My03C
 //L5MyyLf7JCDWJOUJinW4YYCTlPZLmAYnvm1WNTDEePqPw0+94Z2diMajzhtlq3oVJ8
 zmsOVpUI5LfbnYWp4xgedXW/qMyusn5NX3lj//YRKjoZnGg+vSYZmZVFoef2CmiwqYOL
 cfXk9PN0V5YCromP0AoMdvRbU+9KKmPgQH/vyWUUaxkosfidLSwFcsBWmHFZKLLJybi3
 599A==
X-Gm-Message-State: AJcUukf3j7BC0HbCfjIJ+Px+xO9IERLyHsmwcCTPIPZWh9IaOItBDbQD
 iMDxSQBLc9mqgjS+mPNjGlJB4g==
X-Google-Smtp-Source: ALg8bN6Ph+uCsnd3E26sPhknCqDaGH1J0N6zAYnC4SlwEGLuYfcSrHRAIbKNaOyb+2PSfyjn82N1Vw==
X-Received: by 2002:aca:5c87:: with SMTP id
 q129mr26060302oib.189.1549254694664; 
 Sun, 03 Feb 2019 20:31:34 -0800 (PST)
Received: from localhost (107-207-74-175.lightspeed.austtx.sbcglobal.net.
 [107.207.74.175])
 by smtp.gmail.com with ESMTPSA id c19sm6228897otl.16.2019.02.03.20.31.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 Feb 2019 20:31:33 -0800 (PST)
From: Andy Gross <andy.gross@linaro.org>
To: arm@kernel.org
Subject: [GIT PULL] Qualcomm Device Tree updates for 5.1
Date: Sun,  3 Feb 2019 22:31:20 -0600
Message-Id: <1549254680-1282-3-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549254680-1282-1-git-send-email-andy.gross@linaro.org>
References: <1549254680-1282-1-git-send-email-andy.gross@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_203136_115786_AB288580 
X-CRM114-Status: GOOD (  13.91  )
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

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dts-for-5.1

for you to fetch changes up to 40122db87778970c96062c9f49b42cdf6809bf94:

  ARM: dts: ipq4019: Remove skeleton.dtsi (2019-01-22 15:04:51 -0600)

----------------------------------------------------------------
Qualcomm Device Tree Changes for v5.1

* Fixup GIC IRQ flags and GSBI state on MSM8660
* Add USB OTG, gpio ranges, and Wifi support on MSM8974 Hammerhead
* Remove skeleton.dtsi on IPQ4019

----------------------------------------------------------------
Brian Masney (2):
      ARM: dts: qcom: msm8974: add gpio-ranges
      ARM: dts: qcom: msm8974-hammerhead: add USB OTG support

Jonathan Marek (1):
      ARM: dts: qcom: msm8974-hammerhead: add WiFi support

Linus Walleij (2):
      ARM: dts: msm8660: Mark two GSBI blocks "disabled"
      ARM: dts: msm8660: Fix up GIC IRQ flags

Robert Marko (1):
      ARM: dts: ipq4019: Remove skeleton.dtsi

 arch/arm/boot/dts/qcom-ipq4019.dtsi                |   4 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi                |  16 +--
 .../dts/qcom-msm8974-lge-nexus5-hammerhead.dts     | 130 +++++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  11 ++
 arch/arm/boot/dts/qcom-pm8941.dtsi                 |   1 +
 5 files changed, 154 insertions(+), 8 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
