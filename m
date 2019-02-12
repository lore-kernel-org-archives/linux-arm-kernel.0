Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0141C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:03:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F02A214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fLNBrq2e";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="W1sObXA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F02A214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GXaPj3h58fw+31HPiXIkYfSSVMUt9J2uXCklqCyYAT8=; b=fLNBrq2eq4NAjI
	LlofSIDwyCvW0jIz3J+TYmet565znH+kHHx7/uY1Nz54AKKRlQ63UBydtoj3gj9oCpaIa/ChqnPBU
	2AmzeP6lmquGx4uvZ5z7bukylaCRiI1V0X72vrKcoYI94drsTYR3u2JDMTuS0GRmUnVZGIh7/ZMpW
	1YowjRc68iQ3TOD5ETQKrKPuCmLAM+Wb/cK95DbJ5KEj1MpLU+RBwHzfFT0IMshOw06Dr3mrJRQdp
	VpIiMnp/GfGXq5b+gJ44FwfrbY5cSUPjvJIjWlaKlUPSXeKj2ybRRQz25Ka+BN5ECiDs4Q0IxITDx
	CMlqxpDcBFlFF7tir44Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtYeS-0003aP-3c; Tue, 12 Feb 2019 14:03:08 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtYeO-0003Yj-JY
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 14:03:06 +0000
Received: by mail-wr1-x443.google.com with SMTP id v13so2811844wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 06:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Tckqtzwjj5TWT5FFf8VcTFGwnA9DW5qTKhzDQO+xdxw=;
 b=W1sObXA3tijnRtq9ZeKEd1a75IWHrsZI6GOydysmPtdFkNrb1mpavtyiNFnnj1LT29
 sGFOTlB6WBew55Q9rf/0rwjIkNKA5oTmeh9DaL+0WPj+E2hlRF1oqEZKQLLUbaDZO7w0
 vkYcM20JhjxbJqEZKmE4DFygCXGsET/WFZDnOnkjbrXqairEyKGkwcsSg5oPQ8sbUrAO
 SMWzQEVkr5wab6zZ26zYje/y3t+MYUll+lQgK1eMMjKWMkekZ5duEYNpK45ZbN9Ztjya
 v/bG7DgKK3P0N1HB/JsxPPEdiqkOvYnakAaSiNoFJLYsVbLZMbzN9fluCGJLynWw1Amc
 lJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Tckqtzwjj5TWT5FFf8VcTFGwnA9DW5qTKhzDQO+xdxw=;
 b=nAsIyBY0vQj/744te/3CPFt2BOYZo1i5qbjXd8jq+C42fHjeP8EYqpHglVk1B27S0I
 BANpaftbZAmInLsJMwLQYbewg+EWTbXqBl5oD/QdFF3YwsTIJZNt6gPs4p/bfuyH0IrP
 5fIVVBS9xsx0aoAzTV5sXrk0Su8uZBtRBcLcw3DN4tD/QpzziCMxjmzDAwaFTxqIUXdO
 7GitNA+HgZSlzvZbDha4W3+HVJPawgVrq6FKpxVpmbl7Pwz9LhojZbaTTcVpkk7BUHtK
 wiUHzrsU8RsSRzSPNdPBJs/d2aMW734jvyTEN8SLxIgkAgnU5Fv9qnQ5R3mByVRApY2E
 CAoA==
X-Gm-Message-State: AHQUAuZ9896luG/ZJTrfyS1+VY4mzOLmtBwqbQCcwwT3vTOwj8lBoIqF
 HTbsrz2nJUBq0Z1LnNPcT+4OaQ==
X-Google-Smtp-Source: AHgI3IZXFnjSZ5BPU3aN3v4F9GfPm4trRAXctnT/G05Fl6rThVrcy7XUfNNfZagCOnrgMLkrOkfChg==
X-Received: by 2002:a5d:52cc:: with SMTP id r12mr2954715wrv.277.1549980182633; 
 Tue, 12 Feb 2019 06:03:02 -0800 (PST)
Received: from bender.baylibre.local
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id g10sm23435678wrq.81.2019.02.12.06.03.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 12 Feb 2019 06:03:01 -0800 (PST)
From: Neil Armstrong <narmstrong@baylibre.com>
To: khilman@baylibre.com
Subject: [PATCH 0/2] arm64: dts: Add SEI Robotics SEI510 Board support
Date: Tue, 12 Feb 2019 15:02:57 +0100
Message-Id: <20190212140259.9537-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_060304_669220_1832093D 
X-CRM114-Status: GOOD (  11.30  )
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
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patchset adds minimal support for the SEI Robotics SEI510 Board,
which is based on the Amlogic G12A S905X2 :
and has the following features :
- Amlogic G12A S905X2 SoC
- 10/100 Ethernet
- USB2 + USB3 ports
- Micro SDCard Port
- Audio + CVBS AV Jack port
- HDMI 2.1 + CEC Port
- ADC Touch Button
- Far-Field Microphone Array + Mono HP
- IR Sensor
- IR Emmiter LED Array
- RGB Led

The first patch adds the Shenzhen SEI Robotics Co., Ltd vendor prefix.

Neil Armstrong (2):
  vendor-prefixes: Add prefix for Shenzhen SEI Robotics Co., Ltd
  arm64: dts: Add SEI Robotics SEI510 Board

 .../devicetree/bindings/arm/amlogic.txt       |  1 +
 .../devicetree/bindings/vendor-prefixes.txt   |  1 +
 arch/arm64/boot/dts/amlogic/Makefile          |  1 +
 .../boot/dts/amlogic/meson-g12a-sei510.dts    | 38 +++++++++++++++++++
 4 files changed, 41 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
