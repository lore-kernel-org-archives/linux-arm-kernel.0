Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013EAC43610
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:47:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8E232082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pmHPQx17";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CfcQVE/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E232082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=hXtmIpqRR1U0OVJCN+BTBuEjVlJetqsZI1yAHTGA3xY=; b=pmHPQx17GMrTcF
	4d25COewvE45ZoJDlF8PpardYr4lds8YkNdxDxFoTeArL5eP61k+L5iK0BbabdRnyZ9gQsrOQ9e02
	aaRIVIf95bOrdt6bmuunxhfsBnhl/CgCGkdcm6dyC85B0AtG22cjxpxa4VOrcgU7GLIRtbGV+Pv+S
	esBlR8NBYKfjupHp8OV6SrPVe3NjJQViQYAEStGa/S8Aow8MK62NUPNn/B0DYfpIuePnNxvU6bK6u
	0hv8afCstHYS4v0+P95MjwrnHMi2KCaMK1joNx1Uxs+5Q7vPJilGlGcFj3h9n5cx3IylWo2FOsugF
	lg9SqRW1mf7AHxw3g1Eg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSTDy-0006wi-OP; Thu, 29 Nov 2018 20:47:50 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSTDt-0006vX-TH
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 20:47:47 +0000
Received: by mail-pf1-x441.google.com with SMTP id b85so1628033pfc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 12:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=EWLxQ5KwP7M3FfM+MEr4y7WTl73hNo4Kn+q8VEr1ki0=;
 b=CfcQVE/xrYBJoeOZouxkJ3W3HJiyXEzX3YAUX4lkIjGXQBZmKz0OAa4YqFkwsjdTWY
 bo8ChpN3TuzFCspZYphQSnHc5Oev4UlxZEylSprKaNKeerZN6XyvM/YsR8mSqnFEuoGd
 lOqPW2Rs443AmUmlGD34sfcocXsnoWPNjNgJ5J8tjG8IN4yQ+jK1O0aIqggREBNlSJit
 TosQm5SL5VhiL7F9ExiCrAPz/SvGZZ5yAs/0lq2E3djx/k62f110D4g557k2Uf9iIX/W
 w2tHEfiqVqCN4zTMAnqM/MXXTDRZq+qqEvifiVhsXVsERVhN7FEXnrYCMyCF+OpTw39h
 4Y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
 bh=EWLxQ5KwP7M3FfM+MEr4y7WTl73hNo4Kn+q8VEr1ki0=;
 b=WOLp0QGUAh+7UFmgoDaaYkI0hjoyQNSVFHmXO+xyQnTniUV5RBs1NcdzTaNP+7OXup
 t/kfFR3TQkYCenX6pJ9uU7lXBNDjX/lgeY6l7n5RhS/kClTwio4JeWxjsb/uek7wwPvf
 rpCZtJqKzHgBU/xnqOMtACQXRHhHM7ejbvE9IiaKWe0f/KUHfWo13p0hR/r25xYKHje4
 VwavMJYAgeNCcJLL1gmWYoUk1gYPkFGwvsvNxqLn7vO1k//dln/zpG+VoZf3z5phfmLn
 ub3un51UQZkQrQkaM6kxTaRypS0FRMgbdcvUiXbshNJM42Tz42h/Hd2T98NwbBR/8RIM
 BN7w==
X-Gm-Message-State: AA+aEWZfp2VTq7TXDLf5fTMQBfzQLe2CfoVQZ+Ifb1L2gwI6xdKvEoEv
 wOsmlJBCYxe42L6PKWaA7Gu5Bg==
X-Google-Smtp-Source: AFSGD/Xh5ZEcz3HWolTWxcnkKHEJ5N/FztzaKwuA1BVhlaM49LIACgQGkiHvaMYwCez1z0vM2ScxSg==
X-Received: by 2002:a62:b15:: with SMTP id t21mr2992026pfi.136.1543524454654; 
 Thu, 29 Nov 2018 12:47:34 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152]) by smtp.googlemail.com with ESMTPSA id
 l5-v6sm4408415pfl.73.2018.11.29.12.47.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 29 Nov 2018 12:47:34 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: arm@kernel.org
Subject: [GIT PULL] Amlogic SoC drivers for v4.21
Date: Thu, 29 Nov 2018 12:47:33 -0800
Message-ID: <7hwoov8vbu.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_124745_944288_40FF3179 
X-CRM114-Status: GOOD (  11.68  )
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

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-drivers

for you to fetch changes up to 2b45ebef39a2caad409f70b22b4a2a41df9815b6:

  soc: amlogic: Add Meson Clock Measure driver (2018-11-28 16:55:35 -0800)

----------------------------------------------------------------
Amlogic SoC drivers for v4.21
- new clock measurement driver and bindings
- COMPILE_TEST fix

----------------------------------------------------------------
Maxime Jourdan (1):
      drivers: soc: Allow building the amlogic drivers without ARCH_MESON

Neil Armstrong (2):
      dt-bindings: amlogic: Add Internal Clock Measurer bindings
      soc: amlogic: Add Meson Clock Measure driver

 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt |  18 ++++++
 drivers/soc/Makefile                                          |   2 +-
 drivers/soc/amlogic/Kconfig                                   |   8 +++
 drivers/soc/amlogic/Makefile                                  |   1 +
 drivers/soc/amlogic/meson-clk-measure.c                       | 350 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 378 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
 create mode 100644 drivers/soc/amlogic/meson-clk-measure.c

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
