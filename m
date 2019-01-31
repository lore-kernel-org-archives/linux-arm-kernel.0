Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868E5C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:21:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5990B20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BMi4JfT8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FzYNB9vh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5990B20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xQwMwbnqBiVDsl3DRs3hc6bUqXM596oaZUPprwB7JLU=; b=BMi4JfT8D0XOjf
	b28RkFcQqdVKB0E8kChmvIZiD01899k0KXk0GgAlhI4AMUN2GIZkyY3faGzHdNIYZawVcB0ORa4yD
	3nlcCyxhkIX7SSPpi46ZGKBDePbHlGz1HkxxKaEN33CaO11clTyc9SO/4apuZJZuoZmkKakrErNl8
	LgXnbWCLt0JrK27+57fJQfG0K+WoUR1iJE/xGXikoMsXhE7I5GlrrKaAUDaAc0WulfGak9H2Gh93Y
	OiUGbDxUtilwgJjiS74EOyHor5EoDS9RlEz/QJfxeedobGIHUDO8hHogx+G/yeo81z7OsNrP6Zy9C
	ewCfAM7bxOURZ7BAntCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpE9P-0005il-6c; Thu, 31 Jan 2019 15:21:11 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpE96-0005Se-GP
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 15:20:56 +0000
Received: by mail-pf1-x441.google.com with SMTP id i12so1609164pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 07:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SO2+hNh+R2hjZNepqm+Cb6kTtGpzyd/D4ehTmz8FUkc=;
 b=FzYNB9vhS2LCUsuU8GYXrmhSim8C3MhNXkqQlapiN7bonJ4QZdpjlSeC9S4Vg0uBLj
 a6DBGrVtPnLdEd02Vj6ieQMl3ench8M1MroKxaEfJjsrxrJLk38kvXT1iC0lPRvqOdrZ
 qWK5/RpeneSveKoEd3vzG+ILuOxwyw86iFKt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SO2+hNh+R2hjZNepqm+Cb6kTtGpzyd/D4ehTmz8FUkc=;
 b=mkPvG6UjRyWMww1QrhCH8UUD432Fxs6NVCnlEpglj1NiKmKvCsZNNiFafeZxsFE3VZ
 u/9Me8wATZxZeiP1I0aQJcV8pUqQioJ5XaQeS4hkX2ltXEIzbRvO/Z0vqbgToIWA6x2e
 Um9TIHmyNzoGVd6LbLbiBmWvEkOhSKgRa9DTNpYOHYY5COaO6ERi/DoVS4v0oOwW2M9Y
 JEIm2Ft89Qm4PLPhzlfaqKpmBMMd8XoxyniKq+qEy/qXltwHKws1HK6Assb00L5khdjH
 UYV/kyRwlLdaXDY1fSyXawH/wiZvz1xylUniM0yxu9q5QVfkngnoUh8t/2gh8uLaepNP
 H5eg==
X-Gm-Message-State: AJcUukdhAI8agwVl+BBpXx2mt6f6GpIiAC3SFxKuSKK/VwjYrOI35ozm
 +MKwC0jrCsmSQ23iSlNxkTTEgQ==
X-Google-Smtp-Source: ALg8bN51eKzYXlDOqbuxHYxN2tP+wpZh8Qn72GxxDM9wicOyaEGMz3B22L3Li+/I0eHRzI3TR5irNg==
X-Received: by 2002:a63:1321:: with SMTP id i33mr32408980pgl.380.1548948051950; 
 Thu, 31 Jan 2019 07:20:51 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id u186sm6633664pfu.51.2019.01.31.07.20.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 07:20:51 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 2/2] arm64: defconfig: Enable SUN6I Camera sensor interface
Date: Thu, 31 Jan 2019 20:50:35 +0530
Message-Id: <20190131152035.7138-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190131152035.7138-1-jagan@amarulasolutions.com>
References: <20190131152035.7138-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_072052_913232_800E9A87 
X-CRM114-Status: GOOD (  11.58  )
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
Changes for v2:
- rebase on master

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8f36b1e8017a..67132c1f0072 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -467,12 +467,14 @@ CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
 CONFIG_MEDIA_CONTROLLER=y
 CONFIG_VIDEO_V4L2_SUBDEV_API=y
 # CONFIG_DVB_NET is not set
+CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
 CONFIG_V4L_MEM2MEM_DRIVERS=y
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
