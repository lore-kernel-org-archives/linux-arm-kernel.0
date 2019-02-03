Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E647C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 18:57:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C258217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 18:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MpItcUHK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzrQ0U0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C258217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=McQPQD/HeKs0i+3XmamFNrOKgNCCVQyu4+z4810LVFc=; b=MpItcUHKhz3Evy
	9OmVnsoo0H3CL/IWV2uZVLrmqiOXuCWpv7gnyCNNCL+LP9BcrE4t/0bY3S/SsFNh5zFuVGz2j/BpG
	LnkFvUI6ZPLLkyIlpncJP1cir6oKFtUk07qbgj4JQQR0nAt4invA16YbVidZZcaTNY8Uhw32cEvtW
	Ehc7ah01q49HIQpGe6ig9lzQS69RWc13gYnnkerYjwRZi4FvJ2piLO/h4C32Sd6bOGH2+QNDnXBXI
	diMj8cRc+EWX0vwExGx+DHEfcn7ZIp1BJBmaaCGBmCoW3HuIm3ucbkfJf4QEwhyChsC/s9ER3jIkM
	csTdq5mkerCTwgJzc3Xg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqMxj-0007IE-2u; Sun, 03 Feb 2019 18:57:51 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqMvh-0005Ho-DT
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 18:55:54 +0000
Received: by mail-pf1-x444.google.com with SMTP id b7so5714329pfi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 10:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JXna/PKJx8iZ1/h/UpVLA2d4bN5zqtBh3+Z+QQelLRs=;
 b=LzrQ0U0vJ9MY2N7rISkI0LywYCiMOgMCyeu/cl/zb7wl0/7SJNhJahupTLX+f2hd36
 3zDQPC7ZMlGVl+Txc/H/PiTcb5kgDT9oLGhcMDHhzhMGD2Pn+sOdkXVEXxDdtoOppsxB
 7n0OhLtHv97Zp3BEWH1fMezymlXIb5oX7mjkMnkvGloRkuILu1FwZG5hHukhB+l+Kbee
 zOyDu2euU7Hbb6LGEFkyMajvGuR+H/vrAQ+UcxY/S3eQqTmHk/Hpm92bU2Caiyz0B9D9
 XclKgfUkr1H2KIPTBUQyEYi8MBmCFZRNM4eBlS8AoXSt3xc28tEeMp1FYIhxKFBmlCDy
 GdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JXna/PKJx8iZ1/h/UpVLA2d4bN5zqtBh3+Z+QQelLRs=;
 b=MyYOhCugMMBqrJ+WLTw/YjBFvCJsvHqM63Gf4W+r4MSkSnG0EbNFW4xW2nk2BX+G3C
 rMbGwfCEyKZOiMlNgWh71GjT/xEYs8S7hOq/czyWYrxUHVs7hVs3iQzReCJe4gNfdKz5
 rKg+85dT44dZYuKosLjZbvpHssLI/XGyX2BfgmA7EGMjH3tG+NoJ8cfhXE3XjEf/QzjC
 YUBZczxNPQZUmdwahTiCuy0aEyQVY+0nHyZn2Dh+hfdKokQf/1tISz3MBX+jbeEW6xRu
 7Ujd9BkBo7B2Rpi16D2aKsmgGM07JZT6rll2035Zl2Bp3RIJcaWTCgbwv53Q5D3iqnLu
 GAeA==
X-Gm-Message-State: AJcUukc+YQIvm6JxDfcw1e84n93LqrxdgmwPsUGUAyUpVgX38gdiCN1J
 0obwUj6Pgx4Dr09/B/sUzZs=
X-Google-Smtp-Source: ALg8bN4fUwIFgj9n18VVIXKsCceVoMkcienuhAU0LGUUh8HmVQ63praAF2+1yHMch2Sr5e8Pq/B0SQ==
X-Received: by 2002:a62:ca9c:: with SMTP id y28mr47778752pfk.236.1549220144789; 
 Sun, 03 Feb 2019 10:55:44 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net.
 [216.71.213.236])
 by smtp.gmail.com with ESMTPSA id g28sm19524553pfd.100.2019.02.03.10.55.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 Feb 2019 10:55:44 -0800 (PST)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Archit Taneja <architt@codeaurora.org>,
 Andrzej Hajda <a.hajda@samsung.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Icenowy Zheng <icenowy@aosc.io>, Sean Paul <seanpaul@chromium.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Subject: [PATCH RESEND v2 09/12] drm/panel: simple: add generic eDP panel
Date: Sun,  3 Feb 2019 10:54:58 -0800
Message-Id: <20190203185501.8958-10-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203185501.8958-1-anarsoul@gmail.com>
References: <20190203185501.8958-1-anarsoul@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_105546_185253_D94ACC37 
X-CRM114-Status: GOOD (  13.11  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

eDP panels usually have EDID EEPROM, so there's no need to define panel
width/height or any modes/timings in dts. But this panel still has
regulator and backlight.

Add compatible for generic eDP panel so such kind of panel can be
defined in dts.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 2f2cb2d81f2b..9698f5819930 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2759,6 +2759,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "winstar,wf35ltiacd",
 		.data = &winstar_wf35ltiacd,
+	}, {
+		.compatible = "panel-edp",
+		.data = NULL,
 	}, {
 		/* sentinel */
 	}
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
