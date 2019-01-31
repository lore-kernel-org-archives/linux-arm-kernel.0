Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27972C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:26:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE7D218FC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q/iAGUh4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YWb/z2Yl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE7D218FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9RxIpC3QWAC4ZchhYM8TYcwWeyMy6nzdnIZftJlgvdk=; b=Q/iAGUh4yj7Yyn
	nKVwXLedFdIriDcuEXsobE0ZTBFj9qAgDggGgXabnthbZLj02BSAPEpwiEIJ2VKtOpRNWKMWNT8ED
	ONxxIWUvXv93iqPP7bxgWfibd+99HIfOqYOzlr78j2h7XnSargX8NNWTkMuuTQLIKAnGrN35J/PpK
	wRB489LZTDTm0AC0dC2fHgkuRDhiVpRfDXb5S5vOV/2G16yRC0cEvvFuh1C8wAtVMxg6k1JmYyEEh
	3O2W3E5e0uY0wnAqiJf/fTFdO90gZ7batTP5V+RxBdtAOjhsbSSTbBcc0LYVCgUGjXDnCiRO7QOC7
	T79+5yCkPRNS5U+tZBfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCMj-0007f5-G7; Thu, 31 Jan 2019 13:26:49 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCMh-0007ex-Da
 for linux-arm-kernel@bombadil.infradead.org; Thu, 31 Jan 2019 13:26:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B3m93Bor4eDxXIRSVmocYcy4UvmP/psQ7Rsw8t6auGQ=; b=YWb/z2YltRWIeyj15eoH4o1ugZ
 cyZBnTlK73lbjtLVQC9PY8xPI5kMrbiHfKlLWy4k+GKOIQgFBtocwAlJJ0ja5PrrIQLBZx/TjjpoL
 Nwjg3SCvx+efHh7VWS/FBeHJO3HIoK7FlxozIUafb88DUet6TUWYdQ/LqNgm+ehU9BMJx011KiIds
 WLVeibOfm3aCEunkeaMFnvKsV0OZuylVFjqlGR5gpbiigpqxWHY5YzfpDNIb/1MK+kazrdquUXP42
 xAogX4E5tnX1TIwTMGJS1A1+F+GJ5W7JEPAZ+DeaGTosxsAJzhFpk0u0/E4sx9WK5bGFOeVEHj4Kr
 9X6Sy3ew==;
Received: from relay11.mail.gandi.net ([217.70.178.231])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCMe-0004bg-0g
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:26:45 +0000
Received: from localhost.localdomain
 (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr [90.88.147.226])
 (Authenticated sender: paul.kocialkowski@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id F3809100012;
 Thu, 31 Jan 2019 13:26:11 +0000 (UTC)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH] drm/sun4i: tcon: Prepare and enable TCON channel 0 clock at
 init
Date: Thu, 31 Jan 2019 14:25:50 +0100
Message-Id: <20190131132550.26355-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_132644_106018_FEADE3C2 
X-CRM114-Status: GOOD (  10.45  )
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
Cc: David Airlie <airlied@linux.ie>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When initializing clocks, a reference to the TCON channel 0 clock is
obtained. However, the clock is never prepared and enabled later.
Switching from simplefb to DRM actually disables the clock (that was
usually configured by U-Boot) because of that.

On the V3s, this results in a hang when writing to some mixer registers
when switching over to DRM from simplefb.

Fix this by preparing and enabling the clock when initializing other
clocks. Waiting for sun4i_tcon_channel_enable to enable the clock is
apparently too late and results in the same mixer register access hang.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index e987615c16f1..b31f5d95cadb 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -371,6 +371,7 @@ static int sun4i_tcon_init_clocks(struct device *dev,
 		dev_err(dev, "Couldn't get the TCON channel 0 clock\n");
 		return PTR_ERR(tcon->sclk0);
 	}
+	clk_prepare_enable(tcon->sclk0);
 
 	if (tcon->quirks->has_channel_1) {
 		tcon->sclk1 = devm_clk_get(dev, "tcon-ch1");
@@ -385,6 +386,7 @@ static int sun4i_tcon_init_clocks(struct device *dev,
 
 static void sun4i_tcon_free_clocks(struct sun4i_tcon *tcon)
 {
+	clk_disable_unprepare(tcon->sclk0);
 	clk_disable_unprepare(tcon->clk);
 }
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
