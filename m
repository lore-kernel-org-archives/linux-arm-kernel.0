Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3EFC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:21:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EC2520882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VnL+KKkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC2520882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3kIAyUybCFfvOgsLdDJ5vfKxcJWCa+m355kRDzP8W4M=; b=VnL+KKkV8vif/t
	cNuMMxtg5/qzatfSL6OnxHaskmtpkvf2LP7SzA4tseesImvdBqnveBN8dZN5fYz+OWy5qaenkLbuk
	D6xdnQDolLFz+q7wINgDuoGgrM6mspxcgFXJSyPcQNfkJgJ46l6TkPow20zjK0k/QxwhXOqv/YYtK
	sgFqLHrxEkL2qFaTAAjlYWTxaOAQnNIDuZud46wU8EblYL2x7HrpDNlE0nQR9vnvoJgLA+2d8mkjb
	5xNgom3+TbbDgHn1uVCw1sLcKQY4lZRzmcyMfawA7r27BDk12Uw+vjV7fjTEFB+llLQe1pn/W+9Nk
	PCidHfxTVysHH+O+VsAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goYwW-0001ps-8g; Tue, 29 Jan 2019 19:21:08 +0000
Received: from mleia.com ([178.79.152.223] helo=mail.mleia.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYwP-0001o4-0s
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 19:21:04 +0000
Received: from mail.mleia.com (localhost [127.0.0.1])
 by mail.mleia.com (Postfix) with ESMTP id 53F2443EF1B;
 Tue, 29 Jan 2019 19:20:57 +0000 (GMT)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Sylvain Lemieux <slemieux.tyco@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Subject: [PATCH 02/13] ARM: defconfig: lpc32xx: enable DRM simple panel driver
Date: Tue, 29 Jan 2019 21:20:38 +0200
Message-Id: <20190129192049.11223-3-vz@mleia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129192049.11223-1-vz@mleia.com>
References: <20190129192049.11223-1-vz@mleia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190129_192057_363354_5750D86E 
X-CRM114-Status: UNSURE (   9.60  )
X-CRM114-Notice: Please train this message. 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_192057_363354_5750D86E 
X-CRM114-Status: UNSURE (   9.21  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Phytec phyCORE-LPC3250 board is equipped with a Sharp LQ035Q7DB03
3.5" QVGA TFT panel, enable simple panel device driver to get it
supported in the kernel image by default.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/configs/lpc32xx_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
index 23b4d5348e39..e752fb704df0 100644
--- a/arch/arm/configs/lpc32xx_defconfig
+++ b/arch/arm/configs/lpc32xx_defconfig
@@ -107,6 +107,7 @@ CONFIG_PNX4008_WATCHDOG=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_DRM=y
+CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PL111=y
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
