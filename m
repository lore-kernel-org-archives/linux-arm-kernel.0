Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE59EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:43:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB9502081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t1pifGtr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="SSlONadq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB9502081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IeQNSs3PhOUVBy1hZzfxuBWXvFMOS5GYmuJPvEeH5Wk=; b=t1pifGtrsG1nyD
	eEcQH370TTBn9KK2PASxXymKsI6YWkcypn9kaFQRZYW6cbFuNoHVdCH/tTyJui9ZHpS1AMYV/8XxU
	DGI9aLlw1Wap7TCbDz/W5Dg+eG6kqSHV44qqVPLMxoxJ3r5J5462/hIPNtpoD+BPf6USnAWFmEyDy
	G/lTd7L6NZwMDixChL3/iDSyDvzoFM+UYbx6UYHXD3GCakhktgyfHP6ZoFy4zt5ykvFY9qnWVH84c
	DJ+NvT2vN0rJnIQ/HVEo3e2YIfmM40c1VY46FBIXTbL9khvZwTl7xz8F2OZEwQ+DXv1RLdqVwtnFR
	vkcDjssIopDGp+Nvc87g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWQWm-0003wd-8X; Mon, 10 Dec 2018 18:43:36 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWQW4-00033A-SQ
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 18:42:54 +0000
Received: from localhost (unknown [213.204.46.240])
 by plaes.org (Postfix) with ESMTPSA id 4325B41A4E;
 Mon, 10 Dec 2018 18:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1544467349; bh=vgPjZKkLtR2foKSb2/aM4T0Y7TjESGFmLL0vu1Bjlms=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SSlONadqlrWBkWFxCwIDBGKMqR2fOnLh6DiMMPI1+GERy527ZbbyHi5k2tgL6EiQz
 g+zoaz1Vjz8OauAvYxz4zGpKR6vZD5bhYw3S9Mo7r/cwfnfQ9DEbzoPlntPpcwktPv
 WtvAOoW481at0T+dWPXQ9BQ1+cej9rGiDaYYeggIO8mkw2/gKU63lo+pYXRbyn+B1L
 g6MHz5a7PD/KcYJHTO9Zc79lTStwJnQ/tQci6Rcz5NBlRWg7Kt//IFsGEWBeAvGhKv
 LM79EGbxf2wAksGr7hk1DD3MZ+Km32PjhwJ7BrLnp29YEFUmJkFWPgYJOxo7lGXkLr
 1j5s117nrDs/w==
From: Priit Laes <plaes@plaes.org>
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Olliver Schinagl <oliver@schinagl.nl>,
 linux-sunxi <linux-sunxi@googlegroups.com>
Subject: [PATCH 8/8] mfd: axp20x: use explicit bit defines
Date: Mon, 10 Dec 2018 20:42:19 +0200
Message-Id: <2098c0aece09761bf975e72eaa75cba92a4e463d.1544466940.git-series.plaes@plaes.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
References: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_104253_056172_281F600E 
X-CRM114-Status: UNSURE (   9.84  )
X-CRM114-Notice: Please train this message.
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
Cc: Priit Laes <plaes@plaes.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Olliver Schinagl <oliver@schinagl.nl>

The AXP20X_OFF define is an actual specific bit, define it as such.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/axp20x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index c3f3dbd..d183ed8 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -30,7 +30,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
-#define AXP20X_OFF	0x80
+#define AXP20X_OFF	BIT(7)
 
 #define AXP806_REG_ADDR_EXT_ADDR_MASTER_MODE	0
 #define AXP806_REG_ADDR_EXT_ADDR_SLAVE_MODE	BIT(4)
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
