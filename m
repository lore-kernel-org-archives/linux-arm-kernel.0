Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126EEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:32:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6040222D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N9POxvRv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LXix7LMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6040222D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JsTaIk4evN+K2amLPfChncoOPv6nl+NO67UMFOP4x/o=; b=N9POxvRv3q1JUv
	ei7TQ5v09h3VaBIzwhH0FTNBGn7q5GNCkOfdvDCld1jj2fnVAtwVjNJt7FKm3FLt0s482+y3oeVrS
	akAMaC/O4HipoBypuCFq6NlDeusVLXjjB7eWBeupIc2lOiIMP4svTo8YxMVoQ+Hm4liS8wB9IejXn
	y0bSSQcXXVZki7ClCE+fQZoVLPJv+UJ2wWTuyQG7VP490Se+Idpo2PEjvpxIG9/AXOh0oUGH7N10w
	mnagayuRa7h/oEovBXivr4tZ5HYg5H6vsxFmzcwitkYd2+wvXGM+ARxjXicx7acle2LDawkbH++d+
	pK0+UmcG2vSZo4cKQsaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guMkg-0005Vu-NS; Thu, 14 Feb 2019 19:32:54 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guMkd-0005Vb-KC
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 19:32:53 +0000
Received: by mail-pg1-x544.google.com with SMTP id s198so3568047pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 11:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BZL+CSDR6gHJLSLkIhVG72Bv6twb5BsbEPP+vcprd2o=;
 b=LXix7LMmfq5hGoeLnzxUxHoG533C7LuIgqDL7NApe5c+M+1Uc1ynmH6s5H3b+AQ195
 oWYIeUgb4+PqwiXn+BkH+KNlznPKqcf5brlcsdNswCUyT2Gqw/9GnNk2aO2u1KeI9u8/
 jNZAyNDEioj/JaQ+u2v2/0nf0s5qw5UuBq9ZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BZL+CSDR6gHJLSLkIhVG72Bv6twb5BsbEPP+vcprd2o=;
 b=pR3ON1ajrsuM8ixELMMavUIgmkkoGwM3XN3Gn8VJEm1d7IlmkLUWpBihd8r6WDNKXg
 ZJ7+7ZO7Vlvz/qZsKwLApDrIsb3u28MMChSFu1jHZodC9jHWEh75hHWio5uu3SwFpNEC
 OUxkT0/yqCmssFmF6hVMaRkf/ZQdfP7Lj+bjas7Q531OXX/1r5dTOPch+xHRIrr8+pHi
 LdGSrt3YZjGWd4Uhba/Z/FdoEX9/ByDLUDW28SBBKNpzRbfmHYV+l/HFS3c1hDlEjLM8
 Bky6X/BurEV0xIwZqIbAfBlTP5X8YUzq8wiTvnx+gbfAE+j5zre0c5wJOsMEym9Nhgzr
 PAsQ==
X-Gm-Message-State: AHQUAuYB2Erh77OZkhh9g3Z65juuWiCTNVlTT6wbNIvBA3sCkq4cTS4X
 szhtD01+mDncQPwlAxRIfTknBw==
X-Google-Smtp-Source: AHgI3IbV+bc8nAxVayJcVao6/02seww1jKGdVVMBFBYG8yi7ZxWKrnPjnOexYpCyI6YSZIosvpTPHg==
X-Received: by 2002:a63:2e06:: with SMTP id u6mr1471903pgu.71.1550172771021;
 Thu, 14 Feb 2019 11:32:51 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
 by smtp.gmail.com with ESMTPSA id o23sm10808832pfa.140.2019.02.14.11.32.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 11:32:50 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v8 00/10] drm/sun4i: Allwinner MIPI-DSI Burst mode support 
Date: Fri, 15 Feb 2019 01:02:27 +0530
Message-Id: <20190214193236.7504-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_113251_665969_D0533D9A 
X-CRM114-Status: GOOD (  10.57  )
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
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is next version changes for Allwinner MIPI-DSI Burst mode support.

All these changes are grabbed from previous versions[1][2] and grouped
it in a proper order so-that it can help to review and merge easy.

Changes for v8:
- rebase on master
- rework on commit messages
- include drq changes from previous version
Changes for v7:
- rebase on master
- collect Merlijn Wajer Tested-by credits.
Changes for v6:
- fixed all burst mode patches as per previous version comments
- rebase on master
- update proper commit message
- dropped unneeded comments
- order the patches that make review easy
Changes for v5, v4, v3, v2:
- use proper return value for tcon0 probe
- add logic to get tcon0 divider values
- simplify timings code to support burst mode
- fix drq computation return values
- update proper commit messages
- rebase on master

[1] https://patchwork.kernel.org/cover/10792981/
[2] https://patchwork.kernel.org/cover/10686655/

Any inputs?
Jagan.

Jagan Teki (10):
  drm/sun4i: sun6i_mipi_dsi: Compute burst mode loop N1 instruction
    delay
  drm/sun4i: sun6i_mipi_dsi: Support instruction loop selection
  drm/sun4i: sun6i_mipi_dsi: Setup burst mode timings
  drm/sun4i: sun6i_mipi_dsi: Fix TCON DRQ set bits
  drm/sun4i: sun6i_mipi_dsi: Simplify drq to support all modes
  drm/sun4i: tcon: Export get tcon0 routine
  drm/sun4i: sun6i_mipi_dsi: Probe tcon0 during dsi_bind
  drm/sun4i: sun6i_mipi_dsi: Setup burst mode
  drm/sun4i: sun6i_mipi_dsi: Enable trail_inv and trail_fill controls
  drm/sun4i: sun6i_mipi_dsi: Enable HBP, HSA_HSE for burst mode

 drivers/gpu/drm/sun4i/sun4i_tcon.c     |   3 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.h     |   1 +
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 149 ++++++++++++++++++++++---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |   1 +
 4 files changed, 138 insertions(+), 16 deletions(-)

-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
