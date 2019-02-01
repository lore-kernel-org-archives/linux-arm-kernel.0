Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F82C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:45:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62620218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KNlW9KZg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZQdq2pFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62620218EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZVkuVpW9BOTsizDfoK7ZaNB7y1ST2OmdYM1FHmdmGT8=; b=KNlW9KZgYbXiU0
	fBcN8SbXNkoYLGgAAoUSWm5oV1c4m6lolYq6ISVuqJwrGYfcDl6cqY7YhTJJhBk8uO19NQUGkLRRE
	sLl2Ulf06shfMnouSfRxkCYNBuU+WYK/dnV0+k3BNtV/eqxyTfZ/cBi1WaPOWlJHH/yMVJJd4rlwj
	uo7cvr+mafg5FASE1I5TauKuq2975AqiyqMf5GXztF8Zl5sdbeNvKBwF2IGTZ7oF6uOwkwkvLcYVE
	wOjp6bnpZTy9L5WsSlebtMe/lo4o/qsx6gnNu+vXnks+pY167CM2UNVhyMhG1cBkyIxgmmqRK93Xm
	n55fy+L5C5Yqtxa6Zq1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpb0i-00063N-Et; Fri, 01 Feb 2019 15:45:44 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpay8-0002HT-Sq
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:43:09 +0000
Received: by mail-lf1-x143.google.com with SMTP id i26so5421081lfc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 07:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yk/U6hXU4zCg+Op+yVQKMkhjMNz4ubnzKdMp3LxXZ40=;
 b=ZQdq2pFnqDsK++7A+JvhcdHIQD6k/YFnnrrcHPljQGOF9RoZyrKnwp/PwN7RMmJz5X
 2uiQzQogI9miNZvrNYG4CMX8i+KupLfMvG4cJZKduI2Bed1EequW0O8leiVAXKUxV4hR
 RjyU53bgk+CvNDfB2+ANUKyjWfLEENJiVlMWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yk/U6hXU4zCg+Op+yVQKMkhjMNz4ubnzKdMp3LxXZ40=;
 b=Dm9UK/uSd1faoavu2WZV2V9SkLrn63PtbOiQI5z9XuSpOC0Xpy/4gkPABn8GM6UAQw
 TEEQY9APk1FjJVYtbqx0eee1CZw661Rr140Y4d/TXsus4GUndiiYNmEewHccHTdta9Oz
 +PDtLUpoCmcX0iSPBC3Ac0JOPltvjpzjdY7jqcxkEcy2cyfOxpeVmplcSnIEkOnph77H
 nJJB7UaaUTSxTke8MqDWL6f+wfsIoORhp0+qJwbEQMijDRZwK+BLLHTLeeRRX/tKGtCu
 Ffj1JnW9PCRc68K9NzpXl7Hs7CIMzYPdbSoQxZHIUpNmXkRbDPprq6NfWS17FhTAn61f
 KQuA==
X-Gm-Message-State: AHQUAuanIkWHyNZtTNZc62mcXVLh3K07bdg1NoA8oUYIR5X8l16aBId8
 uq2SxcndaqYzp3UcvRA1y6crOw==
X-Google-Smtp-Source: AHgI3IZV4AIj+RosBDNAeANSTISoFIXCUZjjZCxY+J6BXTdc2zait+tt9hGpWbv/8Q5MWbY08Jujlw==
X-Received: by 2002:a19:ae12:: with SMTP id f18mr678396lfc.155.1549035782384; 
 Fri, 01 Feb 2019 07:43:02 -0800 (PST)
Received: from localhost.localdomain ([217.76.202.68])
 by smtp.gmail.com with ESMTPSA id i13-v6sm1305712ljg.82.2019.02.01.07.43.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Feb 2019 07:43:01 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 10/23] drm/sun4i: tcon: Compute DCLK dividers based on
 format, lanes
Date: Fri,  1 Feb 2019 21:12:19 +0530
Message-Id: <20190201154232.10505-11-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190201154232.10505-1-jagan@amarulasolutions.com>
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_074305_631538_168B4634 
X-CRM114-Status: GOOD (  14.97  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
 Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

TCON dotclock compute the desired DCLK register divider based on panel
pixel clock along with input DCLK or DSI clock dividers from tcon driver.

The current code allowing an input DCLK dividers ranging from 4 to 127,
but the existing dclock logic is unable to compute the desired output
DCLK divider value for new panels instead it ended-up producing unknown
divider values which no longer exists.

So, add the computation logic 'format/lanes' to dclk min and max dividers
and indeed it produced the desired DCLK divider even for the new panels.

This computation logic align with Allwinner A64 BSP, hoping that would work
even for A33.

Tested this on 3 different panels, and below are the desired divider values
with respect to pixel clock frequency.

- 55MHz pixel clock with 4-lane panel, and the desired DSI clock divider
  is 6 with the output parent clock rate of 330MHz.
- 30MHz pixel clock with 4-lane panel, and the desired DSI clock divider
  is 6 with parent clock rate of 180MHz.
- 27.5Mhz pixel clock with 2-lane pane, and the desired DSI clock divider
  is 12 with the output parent clock rate of 330MHz.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 3da75a0c5c5d..4d5a158d9a25 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -342,8 +342,8 @@ static void sun4i_tcon0_mode_set_cpu(struct sun4i_tcon *tcon,
 	u32 block_space, start_delay;
 	u32 tcon_div;
 
-	tcon->dclk_min_div = 4;
-	tcon->dclk_max_div = 127;
+	tcon->dclk_min_div = bpp / lanes;
+	tcon->dclk_max_div = bpp / lanes;
 
 	sun4i_tcon0_mode_set_common(tcon, mode);
 
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
