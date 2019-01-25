Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B709C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:05:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09C0221855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CWl3I4xY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C0221855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UOyCE5oTwHqL/RkOc4hvNm7wYzKB3iLgkx1elZSF4l8=; b=CWl3I4xY5s2IIX
	NENjS2VF+pIGHpa1BdeWnhjLm5tQ9szHdJDLCkizMYgRGwxFHjYht6DqglcFHnxfDs3Qgc9k+W/K4
	/MPPxewoTmN3M5HV6JX/dqfrN4YL+jrgFZ8RKh6YGGDB/6atcDBel5FVXnageCLCnZ3dHeCVAnIAc
	swyt1XT/JjYyKnhiMzYuZrvsA9wUxRgB6JnDUe0g+gH5tBby5YZvAi/Y9zFqjRHRj9OWcgWSvL+Dw
	Kzkofivc01/oY3hhDilI2RAFJOTKzMSU/OWW2Aopn/s3F9VZUQs/ElWl43y/IuI3pVXg2kx6csxlM
	AoukgAFTRbqEYKo9NmRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn9bE-0001pI-SE; Fri, 25 Jan 2019 22:05:20 +0000
Received: from mleia.com ([178.79.152.223] helo=mail.mleia.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn9Zu-0008Ig-UX
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 22:04:00 +0000
Received: from mail.mleia.com (localhost [127.0.0.1])
 by mail.mleia.com (Postfix) with ESMTP id 0D27543DC2E;
 Fri, 25 Jan 2019 22:03:54 +0000 (GMT)
From: Vladimir Zapolskiy <vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/6] ARM: defconfig: lpc32xx: disable superfluous GPIO
 controllers
Date: Sat, 26 Jan 2019 00:03:48 +0200
Message-Id: <20190125220348.5357-7-vz@mleia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125220348.5357-1-vz@mleia.com>
References: <20190125220348.5357-1-vz@mleia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190125_220354_071340_D2EA6220 
X-CRM114-Status: UNSURE (   7.04  )
X-CRM114-Notice: Please train this message. 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_220354_071340_D2EA6220 
X-CRM114-Status: UNSURE (   7.07  )
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
Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The change disables a list of GPIO controllers, which to the best
knowledge are not found on any supported NXP LPC32xx powered board.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/configs/lpc32xx_defconfig | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
index 154bdeefa1a9..19a5e5e742d4 100644
--- a/arch/arm/configs/lpc32xx_defconfig
+++ b/arch/arm/configs/lpc32xx_defconfig
@@ -98,16 +98,8 @@ CONFIG_SPI=y
 CONFIG_SPI_PL022=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_GENERIC_PLATFORM=y
-CONFIG_GPIO_PL061=y
-CONFIG_GPIO_ADP5588=y
-CONFIG_GPIO_ADNP=y
-CONFIG_GPIO_MAX7300=y
-CONFIG_GPIO_MAX732X=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCF857X=y
-CONFIG_GPIO_74X164=y
-CONFIG_GPIO_MAX7301=y
-CONFIG_GPIO_MC33880=y
 CONFIG_SENSORS_DS620=y
 CONFIG_SENSORS_MAX6639=y
 CONFIG_WATCHDOG=y
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
