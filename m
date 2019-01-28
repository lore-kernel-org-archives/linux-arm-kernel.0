Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D903C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:23:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D7452147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I9dIzmhz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zjHDbhlk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7452147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KncuINe7A+TCkLeWjOfpWBQqWDqE9Iy98Pgp6oq36NE=; b=I9dIzmhzwOgce+
	qPvBBzPYKgGkRdCqeSbd7QnVQ1pbVkn40j4fRZpQ8agbF8IML6GvoFxM5buSfjAcPvn3Ixj33SyS9
	LQoLqAqXWaAi0Lcvs43VlFlkm55gcMVKLN7oun4GHBwrAdIE7gwHsGDm9t5NrjDf04KRdAIDgVMcq
	53NWkDMgwu6L7szwyVPUe39ubtIqGwOUOWwzyzqpkUJb57ojoSLjchQzxAI+ViFCNOxB7iowcWxla
	cqJcLl8ksR3qyp9B7dNHC3FeKjt7wgBANDC9JorNU/DQcU91H/vucbHOpYx9Lg9byJt8Qeibxp76T
	uR9/Z43i5eVfs2WpqsaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBZX-0000HE-QT; Mon, 28 Jan 2019 18:23:51 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBYk-0007yF-GM
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:23:04 +0000
Received: by mail-wm1-x341.google.com with SMTP id m1so15081976wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 10:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KF36F6q9GQzGHJ20m9zEs0OSKLwz9Wn20oRSDsKSvn8=;
 b=zjHDbhlkRCr07+TN1SMYNQ5eDsCYWPn44MbDZJoK3N4hCs0Ou/GHl8txK4GZCV/UeU
 ONr2lwM40JdODhiJzwQquNRpyDcZ72xiI83sDVIZXMR6wOMuZMn/ikiUdeRN+eVg+kzZ
 qaXTyLwoqZIPX5ubXieyc5QpU9CptnqN2y3RjedjkRTKD1HmroGseXq4y8G9b73VU2zF
 +WVpb2uUJCKXn0PnQFetdRhLWU2NXrJOzcem/6s5KRrHsvzd4nEA7QADgS6rHGeb4y6S
 6fQ7QVrnGa/TaKJmzFmdD60blf26Zwo4TlMZfHGquaTLstW96ReTPiHzAOnf7ewAYxVh
 x8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KF36F6q9GQzGHJ20m9zEs0OSKLwz9Wn20oRSDsKSvn8=;
 b=UcFeuMvr3xikn4cFvLlCsFWUW6FTo22/FO3C0ozukg+2fqyXOP4PBpFAD5cAjVVQgO
 r+scY72/yxCaP4ULjORoOzNVoYJRXNuUL0/lyH6pPiRDRsrNbv94Pqn/IREzFEz1IIoP
 UFG/PHeBVSpBMe7WBajTgbXKgQb5RDr+dFfEhwshfk4Z2AJnvjJW9SaTDLm+kx3Y+BgS
 dKyfWuTQV+Us70DFK0NxQkRpojEqyGYGexBjJRSeFXGS7uJFjz3wtLupLAQwBKXkASXc
 XXXmPhPEdycVybXNeDOsekLLb/23YEaz4l4ZQCNiuUlEWh3cL2Q2KgoOBQM8UlofodBa
 54YA==
X-Gm-Message-State: AJcUukeb3XHgkeXqpfw5w/Zx4DdYFXW+x6x5+tz9+PeJ85f499Kr5Myw
 Oa26LiKftncav8VCUybz+TiMJg==
X-Google-Smtp-Source: ALg8bN49XeLSs+dhj5l9IQ/0Ag8h3yAaNs1LWB9trd1NPYyBk8ti9OKURggjsFGXYvd6jAbnXkQOhA==
X-Received: by 2002:a1c:d00d:: with SMTP id h13mr17657339wmg.13.1548699781116; 
 Mon, 28 Jan 2019 10:23:01 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.googlemail.com with ESMTPSA id s1sm169223758wro.9.2019.01.28.10.22.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 10:23:00 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 2/2] ARM: meson: remove COMMON_CLK_AMLOGIC selection
Date: Mon, 28 Jan 2019 19:22:52 +0100
Message-Id: <20190128182252.32589-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128182252.32589-1-jbrunet@baylibre.com>
References: <20190128182252.32589-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_102302_536816_18669BA5 
X-CRM114-Status: GOOD (  10.76  )
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
Cc: linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Selecting COMMON_CLK_AMLOGIC is not required as it is already selected
by the SoC clock controller driver

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm/mach-meson/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index b16831697183..15e9cb75738e 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -9,7 +9,6 @@ menuconfig ARCH_MESON
 	select PINCTRL
 	select PINCTRL_MESON
 	select COMMON_CLK
-	select COMMON_CLK_AMLOGIC
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
