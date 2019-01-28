Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFB0C282CF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:33:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A61721841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ba7+eCGl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZkkgjNoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A61721841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=bB9doMPFsI6L02G1fvQb08WS2qHjnf1mDSNrITLnEjo=; b=ba7
	+eCGlIH0zGs6R3jgXshQp33TsejgDOcw0deJkta3NaijeSYjnldO8+92Z+7NBxZD5CkKJNwXGbvCU
	LLylX/OLoO7OE5ANx4lSiZB+IWDOBGh/dOSlVDerNY2Uo1xJ0drMPB7O93ZpXpi3i1cUOy1+roOHO
	0BxB2VccypdPba+UxwitylHFvgwU/nBQGcnENrR88+oxDlS+oO4wDAMhTEWu12JS/aEZOUWzeckbh
	+5YXcgTkSw0dj4/k+WDQTXskpUImcwLI1fdXK9SlWBhSi+Y2rZpeywGb1cxXrNmbvJ06z4ugnyVFo
	nqTUAlnLRcY7/FNL6X9x782Y8CWZEBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBii-0005YV-EL; Mon, 28 Jan 2019 18:33:20 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBif-0005Xs-IR
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:33:19 +0000
Received: by mail-wr1-x444.google.com with SMTP id v13so19201588wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 10:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=ePCCBTV1D/rgy7QpQRMhWU66DEdJXmEhHQjyHV5CCKE=;
 b=ZkkgjNoFWO4eaFliYBVr2XLSoTnkWguoBC13eb+U+cHvWebKhZdtAokMzI4eQEsEyq
 jau2pa2nXCsKPsrjFRFPAHvZMc4IqVY98wAAqy9blZc4nOayUFgq6Nb51l/R0+Cb6Ve1
 kCH9gNAxfyuYiX5p5WNW6lSjmAVQTHCZken4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ePCCBTV1D/rgy7QpQRMhWU66DEdJXmEhHQjyHV5CCKE=;
 b=ZayOQgLZCHyB0PJMQC7SEK6Pv4j06+ewp6reazVhfs+CAqv2L0s+V35ZGhcr8l7naI
 Hkl2cAeDgG8eqa1So7JmoLRkL2qI7jzyv5aYc2XA5rrRtpP1unZZxRdW6pzYpmDSOJuA
 xxyQYYrUi0M6LTEbNPmOo/fnC+ycauEsNNu4hmqPiyzKryeT3pqqIaUqMMWa0xkKIQgy
 b3iIdr10y4YQs9XIgykLEEwOFoWicWeo56ZDauWLrXMrkJ7Hmg6UyYsEkjSmpi0lb0qK
 TOZ9P8K6/FcZyNPxkBFOeK+Coq7yMCZZbeETfxGUvCXVNl4lH1RddLe7KW3xacXVcYqL
 UmSw==
X-Gm-Message-State: AHQUAuZaz0KkpNzb+vRnefchwyjX4iFz8HMZ3p9hWsU0OEcLsPDj3J9d
 OUrz8CC+PD6gK4M/9rwLTOs3hQ==
X-Google-Smtp-Source: AHgI3IY34tRbxoM7z3ib5Ve8alip7z6s718Di/W0laJ0rCyBPVKSo2JgL/EjAQIEZk8ASfp8H0UBCw==
X-Received: by 2002:adf:be0f:: with SMTP id n15mr9993608wrh.267.1548700395986; 
 Mon, 28 Jan 2019 10:33:15 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.233])
 by smtp.gmail.com with ESMTPSA id l19sm270082wme.21.2019.01.28.10.33.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 28 Jan 2019 10:33:15 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
 bjorn.andersson@linaro.org, andy.gross@linaro.org, david.brown@linaro.org,
 jassisinghbrar@gmail.com, mark.rutland@arm.com, mturquette@baylibre.com,
 robh+dt@kernel.org, will.deacon@arm.com, arnd@arndb.de,
 horms+renesas@verge.net.au, heiko@sntech.de, sibis@codeaurora.org,
 enric.balletbo@collabora.com, jagan@amarulasolutions.com, olof@lixom.net
Subject: [PATCH v2 00/14] Support CPU frequency scaling on QCS404
Date: Mon, 28 Jan 2019 19:32:47 +0100
Message-Id: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_103317_608776_001DC670 
X-CRM114-Status: GOOD (  11.26  )
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
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 khasim.mohammed@linaro.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, linux-clk@vger.kernel.org, vkoul@kernel.org,
 niklas.cassel@linaro.org, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following patchset enables CPU frequency scaling support on the
QCS404.

Patch 8 "clk: qcom: hfpll: CLK_IGNORE_UNUSED" is a bit controversial;
in this platform, this PLL provides the clock signal to a CPU
core. But in others it might not.

I opted for the minimal ammount of changes without affecting the
default functionality: simply bypassing the COMMON_CLK_DISABLE_UNUSED
framework and letting the firwmare chose whether to enable or disable
the clock at boot. However maybe a DT property and marking the clock
as critical would be more appropriate for this PLL. I'd appreciate the
maintainer's input on this topic.

v2:
   - dts: ms8916: apcs mux/divider: new bindings
     (the driver can still support the old bindings)
     
   - qcs404.dtsi
     fix apcs-hfpll definition
     fix cpu_opp_table definition
     
   - GPLL0_AO_OUT operating frequency
     define new alpha_pll_fixed_ops to limit the operating frequency
   
Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

Jorge Ramirez-Ortiz (14):
  clk: qcom: gcc: limit GPLL0_AO_OUT operating frequency
  mbox: qcom: add APCS child device for QCS404
  mbox: qcom: replace integer with valid macro
  dt-bindings: mailbox: qcom: Add clock-name optional property
  clk: qcom: apcs-msm8916: get parent clock names from DT
  clk: qcom: hfpll: get parent clock names from DT
  clk: qcom: hfpll: register as clock provider
  clk: qcom: hfpll: CLK_IGNORE_UNUSED
  arm64: dts: qcom: msm8916: Add the clocks for the APCS mux/divider
  arm64: dts: qcom: qcs404: Add OPP table
  arm64: dts: qcom: qcs404: Add HFPLL node
  arm64: dts: qcom: qcs404: Add the clocks for APCS mux/divider
  arm64: dts: qcom: qcs404: Add cpufreq support
  arm64: defconfig: Enable HFPLL

 .../bindings/mailbox/qcom,apcs-kpss-global.txt     | 24 +++++++++++++--
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  3 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi               | 35 ++++++++++++++++++++++
 arch/arm64/configs/defconfig                       |  1 +
 drivers/clk/qcom/apcs-msm8916.c                    | 32 +++++++++++++++-----
 drivers/clk/qcom/clk-alpha-pll.c                   |  8 +++++
 drivers/clk/qcom/clk-alpha-pll.h                   |  1 +
 drivers/clk/qcom/gcc-qcs404.c                      |  3 +-
 drivers/clk/qcom/hfpll.c                           | 19 +++++++++++-
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            | 21 ++++++++-----
 10 files changed, 125 insertions(+), 22 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
