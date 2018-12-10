Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B681C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:47:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F110E20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SHNHXqg0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NIGNCo0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F110E20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=uuIloKFwB/hAOWOEYD57aM+A60p/r0LSvRureCTkgc0=; b=SHNHXqg09LOJHm
	lMZcRdYP9+yKuBtmCBWXIye1zb0u1LAFSGUFbw+fz4I71284BwozAzf7pznD2B2s8QkrP8b1nytxA
	NOvAWxbmvO8p1CHEHlpRhtNUS+Sc8IlO36JpIUrCrhJgg+Z2jmF6i+7heGKMbgEpdPWGVDAL6b0II
	XHk9fmFenanpQG+8J00Gu6+49djuovxAr6F8Pde7ABn4N100ojy+GAwk5GqRm1qqodRPxON+C+kqA
	Z9RqTIiw5gAy/awbluFM5MYyELUE2VyqzdQ9tR50duK44O1wAZai/ZD2Af+tlJFYRvyxO/WztNwRI
	UDMRJSAqF0+sCKmEfuPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWSSP-0001N6-2i; Mon, 10 Dec 2018 20:47:13 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWSSM-0001D6-0M
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 20:47:11 +0000
Received: by mail-pg1-x541.google.com with SMTP id w7so5502036pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 12:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=H00Z+KudCaw2SE21tWDOFnCHGtg8lclWR0YeXLHbXkU=;
 b=NIGNCo0oMBotoGr2cd4907iNlF6cFkANtB/hGw6NFLFOXaA0ezI6G2gvabWguVRrTK
 nfkLX/OJcgsi1s2M+4J+18uCPh1wNPz8z2fRhi5cYNeIIlJK0IGOU7S2/yOVb8DadT6o
 RnF5ZeQ/9GpXFH4Ubaz0DSeedN6BArQFZpcrrA+nWm1wfa4Eg2BpowMxJV15GHSav9xK
 2a3INgRxylkY+lWM89Y7CTbA/xjILfJeNygr4TLnezUQZMl8Yx1x2PAYI+P9zBTyKHnM
 Kz/xmIQwaqwEzr8DSAhEnG+mINy7RvRCM+wcNEzUI7oifv8aon3ehyOh8fSQePEHZYBq
 1xkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
 bh=H00Z+KudCaw2SE21tWDOFnCHGtg8lclWR0YeXLHbXkU=;
 b=cVJrepz9HZ9UZrfg78heozWq17zdsUECE0AVLiA7SHPHmhizx2SYZkPmRvPWy+0beP
 +qASUEJ3Uam2C4eKUUt5HWP5d2XCCozB5R7xHM6/DbP85pM5H/gKvTFD3KyoAkol2LBx
 9u3x/jhQWrAp+fEMvlSK3eaI7hp5bQBic0C/G+/ekkyrzPk/sn/b7+3YzPIHVf1JWGIq
 b6Ix+Ex9YGhTHJVl7RyekPFrCt8xYo/PiMOKDpi6zE6nH3K7aGfzZSFKed6BoHKEitt1
 /DpHL8LSJNEY+vY9DKRI/sQlnqTfbFiCYQcll1/DIkcfppfJhANJechxFTLuiW03Kbjq
 3JXQ==
X-Gm-Message-State: AA+aEWay1eCUxNwGptQTkwP1BXy9YCLu7QykWtgnu1g7PhBMF/Apmgnj
 Lk2rDDRQvO8Wf1Ph0XSuPGwlXA==
X-Google-Smtp-Source: AFSGD/Vfo1W+9up51unVq86J4IhkOGrjwPesxZUthTfxsRnJwfJ5wR7YrT9Uj1QmX5VTIt9SzUCgOg==
X-Received: by 2002:a63:2a4a:: with SMTP id q71mr12068260pgq.374.1544474819198; 
 Mon, 10 Dec 2018 12:46:59 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152])
 by smtp.googlemail.com with ESMTPSA id v9sm17270201pfg.144.2018.12.10.12.46.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 12:46:58 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: arm@kernel.org
Subject: [GIT PULL] soc: Amlogic updates for v4.21
Date: Mon, 10 Dec 2018 12:46:58 -0800
Message-ID: <7hh8flw1ml.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_124710_105825_CB8C0C32 
X-CRM114-Status: GOOD (  10.89  )
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

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-soc

for you to fetch changes up to e9e863dc1dc88212b09d279a143027e1521b35d1:

  ARM: meson: select HAVE_ARM_TWD and ARM_GLOBAL_TIMER (2018-12-10 12:43:40 -0800)

----------------------------------------------------------------
soc: Amlogic updates for v4.21
- ARM: meson: Kconfig: select HAVE_ARM_TWD and ARM_GLOBAL_TIMER
- misc MAINTAINERS updates

----------------------------------------------------------------
Carlo Caione (1):
      MAINTAINERS: Remove myself from the list

Corentin Labbe (1):
      MAINTAINERS: add drivers/soc/amlogic/ to amlogic list

Martin Blumenstingl (1):
      ARM: meson: select HAVE_ARM_TWD and ARM_GLOBAL_TIMER

 MAINTAINERS                 | 2 +-
 arch/arm/mach-meson/Kconfig | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
