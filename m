Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD42EC7113B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:12:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B8B520861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qJoQ+z5J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QNn6woVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8B520861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=goCRzlNVBLTSmsvUtbyuXXkt/rftYMUICh10mTOsdwk=; b=qJoQ+z5JMpfh3O
	LdAdO+tf8ub0BcGOsTCFrDX0ke9xqor7U0UPbglXqs0gZOg4VOMAEdxTUFl0AbQ8BEo6a9JgHZMnl
	kfasBanPUCYQgffDgP7lGEOOO/uXwdK11p5aSWpCL/mbvU6v8T70dxojA9MARUp6R3eDEjMfAJH+1
	iJYiW0zYwucXvmclHaICG3WSoX+vhppsy456NsqZC5gUCiyRQ4kVYCpxeTA5EMUIxUjG3cAO6KQu4
	PNdKSzy6dKUc1nAE3Zp4cHWKmI1DAcg4aJR8VN1iJgwzGp9d7DH5xOuEXKD+2P9sjqNT3UrPPDEvc
	V40lXsOrK8nc27uetZJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glXVO-0005Pk-4k; Mon, 21 Jan 2019 11:12:38 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glXVK-0005Lt-Eh
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 11:12:36 +0000
Received: by mail-pg1-x542.google.com with SMTP id c25so9350586pgb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 03:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mnGAbei/QrtULUg0QvoNQpL5YKEkHiuSC510n/3AaPU=;
 b=QNn6woViz7BHLyK6FQs7k8AmeuYAJlP1WIqegDi5CWolZqCuPU1mDsKbOQIeg/7z/o
 Ctws+5gMeP0Nu9yCx76dIrfzyRRPCxTUtvwZYtPht4eDivjWe4QgtKpt6WovMnPc+zxv
 N51Y562g04QmkNMH1YqNMipFzK73WZNo3C8e8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mnGAbei/QrtULUg0QvoNQpL5YKEkHiuSC510n/3AaPU=;
 b=HnwLLKQe5KNo+PbOMgKGxnMqyeyZlp1NlOtHy0GU+Azay0Fhn6vd7bNQSaPNKbxZ/W
 51tJ0IDDohmmKYbEr9uDh0cERaaoBjY1gkV/XwIKTNa4QwF2Ec1yfnponX9jD3cw5wkh
 UUD+Rk2VpRfpVbBFuBNiX+Q95CKqlwZiODDvIKDj/FipvGya1LozLK9Se/3a5JpDJMEL
 g/1CH6SXvStPmljIM/jqpQ3Vh4mpFywvbV7LW5fAnyA5cP9a9m9PGGtvZNGiclRI1e0a
 Z579gf+yCPz+079epZxC3CMIFwjxNWSrJJ//odB/gI9H40hYevc0w4Lbuu4z0sD10ygk
 GSwQ==
X-Gm-Message-State: AJcUukcy+XymnsGRhQNji9k7v6sxp5srsUT4LHa20BfWppQhMn/ko2nc
 rdkgdFwZTs78lDNOikHiLdv6CA==
X-Google-Smtp-Source: ALg8bN6cg4/uKCarseArTuNyXxaoh2sgw6MxKtglvupRqGd+AN8UGnhEi+imN9jdhf3hYov5Uz2l6Q==
X-Received: by 2002:a62:c185:: with SMTP id i127mr29598788pfg.43.1548069152920; 
 Mon, 21 Jan 2019 03:12:32 -0800 (PST)
Received: from jagan-XPS-13-9350.domain.name ([103.81.77.13])
 by smtp.gmail.com with ESMTPSA id a90sm21821288pfj.109.2019.01.21.03.12.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Jan 2019 03:12:32 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH 1/2] arm64: defconfig: Enable I2C_GPIO
Date: Mon, 21 Jan 2019 16:42:22 +0530
Message-Id: <20190121111223.18384-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_031234_538921_06C38910 
X-CRM114-Status: GOOD (  10.28  )
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
Cc: linux-sunxi <linux-sunxi@googlegroups.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The GPIO-based bitbanging I2C driver is required to configure
CSI data, clock pins on CSI block in Allwinner A64 SoC.

Let build it as module.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Note:
- These change depends on A64 CSI support patches

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 1f1f4eab89df..eefc1ff0c1e0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -318,6 +318,7 @@ CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_PCA954x=y
 CONFIG_I2C_BCM2835=m
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
+CONFIG_I2C_GPIO=m
 CONFIG_I2C_IMX=y
 CONFIG_I2C_MESON=y
 CONFIG_I2C_MV64XXX=y
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
