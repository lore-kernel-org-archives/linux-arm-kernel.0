Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815A3C7112F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:12:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51CF720861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cy4s1s11";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PMn4Uwyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51CF720861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h40Tw4v6Kt/0O0+4Z3t6wAJOa7oHxdIrXYq6r9c3Ezc=; b=Cy4s1s11WhniZK
	KFCCz5pOCzONpBgMizux1zawtfJTarOI3pUZT/BTKktjV203ucltRNncmlZsNxnPcqarZsp7KQGP8
	n2z3oWLzUFlvrlX6acxYQ9DCLnI3vqrh2KScJj1+MEvWsIehrDpCo+ZfFN4/mNIuPqa6DYhh5EP50
	y1xQ5uGurNiI9GX9YjxBwsTmT8Q5JDwPaXau+T35oYUHJY9H120aqH/SiG2CdjqA4lescwhaLCg3x
	PrG5/YgzgTnakE8bKyF6CT5yDD8lMc3/Np9E1u9AeTHjjaalYVMpcmX9yBHMeIsAcbGLE+3gFD9ZL
	zrpciW9fC7x3qjnbdUvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glXVe-0005hh-Le; Mon, 21 Jan 2019 11:12:54 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glXVM-0005PQ-Gc
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 11:12:37 +0000
Received: by mail-pg1-x544.google.com with SMTP id n2so9354873pgm.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 03:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GZZw+Hr+hHbP5sXTJ433pxgAxN3fV6oKqp+6KB31Tb8=;
 b=PMn4Uwyz58/5Um/YnVmGFYmb4HbN+v7xUJ8zjn09cF0rKhN54/UADvAcm3jhYhCQ7E
 gv3Q3p02MDYEu6zQB7VI9/GyUjmeuW6svHBjYlzZPBr4FIli5Xw0pXm9l5ccvB6cBdJP
 +qQRY9vhWBCZQlnh3GFVhH1UTPTYsPeqCcbiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GZZw+Hr+hHbP5sXTJ433pxgAxN3fV6oKqp+6KB31Tb8=;
 b=WG+iuYkpoDxsGf6oDqeE0iZrc8Kn+bvB4jsRZDIifIZuETpOfyx45l6/YN0A/KPBnp
 c6CYb9vZXcZcVkIBtz6SQfXNl7gSvE3FdWBN3ybBb5b1ofAueZO9pIjDu56DUbPBYZcS
 i4VoHjUyCJIkrQAXMjpU1LZ4nBHcUN5muCK0NtLuVayXR8msTiNle4OJeHwf+RZaHtaR
 2ytZSRjGJeSbE4IojtmEjJWyoCQrMUikptqCTXH0Q3WTs4lgQDoKc6vWiihPguUWXEsU
 nime4JAnTs/SROZF8EHe2XiLQuOWISJtG42++blB11EpBv53FDNq+C4FrDlrkp8bRo1J
 LW8w==
X-Gm-Message-State: AJcUukcpF6z7u+EnJYUps0wBNQuV07h5MpV8KUWuCgoJeQY4WDCe6+wW
 E9kCTVecq9j93Nt7isLqL+kDQA==
X-Google-Smtp-Source: ALg8bN6ITrR9sOEzrGQUNC2uzOcqUV5K55w0yPjnlsuVGPMs1ebBtgFOGBm+9mxveJAc5RQTfgcNHA==
X-Received: by 2002:a62:5793:: with SMTP id i19mr29519806pfj.49.1548069155754; 
 Mon, 21 Jan 2019 03:12:35 -0800 (PST)
Received: from jagan-XPS-13-9350.domain.name ([103.81.77.13])
 by smtp.gmail.com with ESMTPSA id a90sm21821288pfj.109.2019.01.21.03.12.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Jan 2019 03:12:35 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH 2/2] arm64: defconfig: Enable SUN6I Camera sensor interface
Date: Mon, 21 Jan 2019 16:42:23 +0530
Message-Id: <20190121111223.18384-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190121111223.18384-1-jagan@amarulasolutions.com>
References: <20190121111223.18384-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_031236_546279_C580C61F 
X-CRM114-Status: GOOD (  11.12  )
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

Enable Camera sensor interface for Allwinner SUN6I SoC's.

This support enable V4L2 platform drivers static and
VIDEO_SUN6I_CSI as module.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Note:
- These change depends on A64 CSI support patches

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index eefc1ff0c1e0..cbcd2a98cd1a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -433,12 +433,14 @@ CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
 CONFIG_MEDIA_CONTROLLER=y
 CONFIG_VIDEO_V4L2_SUBDEV_API=y
 # CONFIG_DVB_NET is not set
+CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
 CONFIG_VIDEO_SAMSUNG_S5P_JPEG=m
 CONFIG_VIDEO_SAMSUNG_S5P_MFC=m
 CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC=m
+CONFIG_VIDEO_SUN6I_CSI=m
 CONFIG_VIDEO_RENESAS_FCP=m
 CONFIG_VIDEO_RENESAS_VSP1=m
 CONFIG_DRM=m
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
