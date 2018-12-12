Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B93EC6786C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:53:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A5E20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B6j4K1gR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KirelXk6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nJFRfLo6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A5E20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=PW2t/qDVHSP1/jg/WSjj+XELIagmxQmgKHCloxVs28U=; b=B6j4K1gR9nhfXv
	WCExrPkUqD79A8bErBadxzT5Yb9WwCb36QB+g9KFG3nZGq7Ve/BrVsLtJF9AcXcbQDXE5Jwb0QIKo
	B5gO0h9X6DkKsW6hTYxrZy2R5sNcxvtHqces4o0NGgkPl6uQGyqo2ipUaDSnGbs56UyzuBZSnX2oC
	VrPD66WAbGVTOzopAtd9AGsmOTgxIpwlh+pvVuJuM2OW3L/R9574dFVCZl8DdflErdNCcOpu1HwF5
	gGpnUN/hEEd4vQK8WXH//Da92RmdWnBKmGhm/1gQnIkBAO+S+HSHEE+MK8cdQOCMzPn1rF5PbMeyz
	39ft1/a75HTf7xY1s4mQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXEK4-0001sy-PP; Wed, 12 Dec 2018 23:53:48 +0000
Received: from casper.infradead.org ([85.118.1.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXEJl-0001fA-AV
 for linux-arm-kernel@bombadil.infradead.org; Wed, 12 Dec 2018 23:53:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5z4MCaDFkjT0GRa/SDnALif67/6+g5XOP06+tm0XC4w=; b=KirelXk69q0Kf8PKpZGiJ69Y8J
 Qy+dPwib4XIy2WJYO/mRTt4LMSkqY93WkhEWjWPpkRBLvMEAURJ4azDF4rhOthBXewKVse7OdvCMl
 NPGJMzgPKEpjAB1Wx8c7erKiFgkn9t8N40+AXT4VuASmJvvPPn1FzJ+e8iGO3QhGzYGNXPu0vd+tZ
 dcQeVGuClWC8zSno7XtG1uT8bfo6T6HsoKtRp/tbMN6F1/WNcs6XpXG1cuzdJtgWaHRn7Q2WU7L3R
 xoj80psIxaJgvDwXEafGI82N8Xy8N6InR+wYKbYzfMM4kYbWRrc9CIVpAOAYveEaiNb9xzIJ+bnfu
 2pcsUxNQ==;
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXEJi-0007eM-0u
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 23:53:27 +0000
Received: by mail-pg1-x541.google.com with SMTP id w6so106990pgl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 15:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=5z4MCaDFkjT0GRa/SDnALif67/6+g5XOP06+tm0XC4w=;
 b=nJFRfLo678gSoTUXA5f0UIHoo5qORc70Ob7IXiXgfMgFNCK6qA6TeYP4lU5rMOyX5S
 fl2/BtkWqo2dSDDeIHTL2GynK83150ClfacXC2epC6u4mRZ0qjVOY7Jo7CC6yg1jpLfX
 yYxxt0ehBr7NSJA5DtBP9jh+lvsPViuzJgWdst2CP1bWNky+GjQMdkW1UEMkLhWn9IS9
 GMCCXeFpr00zxwtVqj6UabTxMvCer8y+SQ6AiNBh/Is+FQyL2rU6TjX/LuIWSozG2uTt
 zinYHTgN4rTgp5uQ3aTlic13e0HnzZmcGe27eVIfLuhbrbLjwQEt/d5/jfP3kCYXH+K/
 rcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
 bh=5z4MCaDFkjT0GRa/SDnALif67/6+g5XOP06+tm0XC4w=;
 b=E0eT69px8GbXzz0WMEqeapfFQlNbJxDjSE/wdkuRy8H81nYYfnlXcdBOnhWptgiSsH
 m3a4nmyP40p2qw0BwdQz1gGzAz92nBS6mZlczpbhFT4IgpFfCdD2u55uPaT28bL/YfbU
 vfclMY6lejUElzmghFea8pxciV4c117q1/I+g4a1eDIUD7kBJS9mDK1heJE4QXoUz7KI
 DjKB1gt/e8cUVW0sQZXR21ZT0dDUxRvztxMRpfvy23bAbAWuN/p6N/mloYMrd0vgGpmZ
 uYjeDWmi3wKlQkCwmOuEC9Jxq1kmrG+WGJPoIPlWJhg097MFrctPoOaUhf1jxr27ilWN
 lxrw==
X-Gm-Message-State: AA+aEWZusKfMVCEOLe3rdEgIzyYYVYx+68CdWo9IONWanMqIkA8hNgEl
 cRSVqH3wv9gIzXHReaP1TCyWLuGCA2g=
X-Google-Smtp-Source: AFSGD/XQl+awbHB8f/fv1AFbRGoTD7jvWEc3/vAkFpjKpzFPlYj2eBeNfipklBygTPxeYWwg9w+Qfw==
X-Received: by 2002:a63:1848:: with SMTP id 8mr19836731pgy.81.1544658793589;
 Wed, 12 Dec 2018 15:53:13 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152])
 by smtp.googlemail.com with ESMTPSA id g5sm131931pgu.57.2018.12.12.15.53.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 15:53:13 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: arm@kernel.org
Subject: [GIT PULL] arm64: dts: Amlogic updates for v4.21, round 2 (redo)
Date: Wed, 12 Dec 2018 15:53:12 -0800
Message-ID: <7hsgz2s3o7.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_235326_168035_654EE542 
X-CRM114-Status: GOOD (  10.38  )
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

Arnd, Olof,

Here's a redo PR.  I dropped the bindings adding resets to Mali which I
mistakenly thought was uncontroversial.  I was wrong.

Kevin

The following changes since commit 5e339a1d7e438b2cc9f46ec9f2682efb58ee2dd3:

  arm64: dts: meson-gx: Add Internal Clock Measurer node (2018-11-29 12:30:09 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-2-redo

for you to fetch changes up to 8b3e6f8999f8d704fccce225b9455b3fa639d1c9:

  arm64: dts: meson: Fix IRQ trigger type for macirq (2018-12-07 13:48:58 -0800)

----------------------------------------------------------------
arm64: dts: Amlogic updates for v4.21, round2

Highlights:
- fix IRQ trigger type
- AXG: enable GPIO IRQs, PHY IRQ, watchdog

----------------------------------------------------------------
Carlo Caione (4):
      arm64: dts: meson-axg: Enable watchdog on Meson AXG SoCs
      arm64: dts: meson-axg: s400: Enable PHY interrupt
      arm64: dts: meson-axg: Enable GPIO interrupt controller
      arm64: dts: meson: Fix IRQ trigger type for macirq

Jerome Brunet (4):
      arm64: dts: meson-axg: remove alternate xtal
      dt-bindings: clk: meson: add ao controller clock inputs
      dt-bindings: clk: meson: add main controller clock input
      arm64: dts: meson: add clock controller clock inputs

 Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt | 10 +++++++++-
 Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt   |  5 +++++
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts                  |  2 ++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi                      | 23 +++++++++++++----------
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                       |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts             |  1 -
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi               |  1 -
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi                     |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                      |  4 ++++
 9 files changed, 38 insertions(+), 14 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
