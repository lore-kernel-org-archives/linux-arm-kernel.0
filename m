Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4614BC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:52:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08A0E20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EgvrZv4e";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="I9UynWzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A0E20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=F1sGViWvvhSNHTR9HXQBeUvACBcCRSU4sKyBEsfqBQI=; b=EgvrZv4evdSjoH
	q82hzwI358B9rWgJiHDeNCnYeIhyj+3ItyeRBXWWq8b4Qnk9Vx+y0mT7gEAMTujA6+b8JhYXT1YZo
	zRzU0XdLYIOta73o1YUG9UPcJg9zEI1JGcUQlVJYNtLGYpP63yQF207KPXM8tFEcYIDFacEIs66gr
	TLFr3WBbJUEZPPi6E1TGlmdQOlx791+hiSyqHnXxp5vh+bB5QF13XZFzNTg7lhbAW3yPLR28FVnPu
	bvHb9wCCceWHOcc2p/L3zCvfpwWKLw6amNBta0l8SkPjHXk/7NB6nuJci3GjYZbBZEXf+4BGVZwU/
	CUfHWdZFjvdFx4EFGU5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVDkZ-0006zj-2P; Fri, 07 Dec 2018 10:52:51 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVDkV-0006xx-PJ
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 10:52:49 +0000
Received: by mail-wr1-x442.google.com with SMTP id c14so3398890wrr.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 02:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YzzlPukRIDBbl29H3I+Hn78F1pKuWKnK/2eIhv+3xQU=;
 b=I9UynWzGo0X9gLuTXk5aZDDM1EgzGFm5Va38AHSZSL9vxnk7jE/9s+UoyW3Q5vb4+l
 Wc1aNzvzGEBTQvDQ0qUmcymTNboZpZxHy7cJRDPoNFJe1vyw8PdHWmO6z+YLj5AjZ+Fw
 MhK4bwlt84/kRlzvm0mLjJADrHKYyRkRd5ra83H4rP9qRtMi0XYftp8OUWlPxPvYMePU
 1kTruYzAD4dzXhUYbwef0D2KBeHLyS2td5yJO97h1YqT/R7965FEXAbEjvtbFmA1tYXs
 jXK90qRdZWM2mwvES+qq4PrhxasT73Nxwh3JtdpaL1RKkP1N4WCB17gFP5Z1dzg146Xo
 IRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YzzlPukRIDBbl29H3I+Hn78F1pKuWKnK/2eIhv+3xQU=;
 b=GMMS9RCp72RRQn9iMWu0sUEWgAOfODAqjyzMl8ZYMnUPSZ9IARLHmCI9/3yHzOPRSi
 DhLHXJ7QCaKGthHpRWR0ybIhZn51V8f/XiaVAFYXkhzl1LBfvPjMP7OIw0xm2ln30gS7
 T+wVHetiRvoi3iIYNO0HglVLLKfIXqg9TpDUIM9deiVWkIMTvW3yUrxNjveYbzGdUy3r
 3PKBdjq7KYAQacnsAU+gY7ydjUyd/TCt4CpXeqxLQZTeYYgbjXDPEDs1X31zzaB23aL0
 jFcsNKQx6K5wqu4aDz3KWxfKt5s9VxaPDoMNv/vXtkkfGyOtYxu9gJRuu5FQJR4yFmwE
 CpSQ==
X-Gm-Message-State: AA+aEWY3/r/mAToUr8tb8Ys0XX7diroXYdvAtZf2C8YwwtnQ1PNOu+ts
 m4w/skmHiDbjC8NJc+7l149A/g==
X-Google-Smtp-Source: AFSGD/XVz6XtnkP2jeUtJOZX62IegNJGiDb3RbXR6x29UzF6xx0F7jQPQdYB4Gg3xjUrp5TIy1wdoQ==
X-Received: by 2002:a5d:6b81:: with SMTP id n1mr1485462wrx.149.1544179955674; 
 Fri, 07 Dec 2018 02:52:35 -0800 (PST)
Received: from xps.home ([2a00:23c4:f7a1:ce00:800d:14be:d1d:88c5])
 by smtp.gmail.com with ESMTPSA id v187sm1234684wme.0.2018.12.07.02.52.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 02:52:34 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, khilman@baylibre.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, martin.blumenstingl@googlemail.com,
 ingrassia@epigenesys.com
Subject: [PATCH v2 0/2] meson: Fix IRQ trigger type
Date: Fri,  7 Dec 2018 10:52:29 +0000
Message-Id: <20181207105231.25593-1-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_025247_821432_202F775D 
X-CRM114-Status: GOOD (  10.84  )
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
Cc: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The wrong IRQ trigger type for the macirq was causing the connection
speed to drop after a few hours when stress testing the DUT. The fix
seems also to fix another long standing issue with EEE.

The fixes are tested on a AXG board but we think that the same fix is
valid also for all the others Amlogic SoC families.

Changelog:

V2:
 - Merge arm64 patches in one single patch
 - Merge arm patches in a different patch
 - Added T/R/A to the arm64 patch

Carlo Caione (2):
  arm64: dts: meson: Fix IRQ trigger type for macirq
  arm: dts: meson: Fix IRQ trigger type for macirq

 arch/arm/boot/dts/meson.dtsi                        | 2 +-
 arch/arm/boot/dts/meson8b-odroidc1.dts              | 1 -
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts      | 1 -
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi          | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi           | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 1 -
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi   | 1 -
 7 files changed, 3 insertions(+), 7 deletions(-)

-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
