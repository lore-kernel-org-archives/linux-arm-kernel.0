Return-Path: <SRS0=mu0f=QD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379F1C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:49:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E59F72147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XhGaBMhZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59F72147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=N5+FKq8sc5H4Wr+boO6dOmevuYElynXoCWSHp2iofQY=; b=XhGaBMhZQ0enDh
	SdlZRduPF/gnyem+SDpQQ86kFZIkVeQ+rfOsfrdb2rHaBIr8v3GY45i7HW0alZLc6ZNT7BlgCT7a8
	1LzdTfCZ0Dvq3b5pNuuEL5K1nkj80FH0cdenoz8uDO4vY6i6zJDp3S+DRJrYus7Ln6UApQO0IYP8m
	SKpghZASOMU8Du7jyUn2zIApIU5K5HCdJ35g99s20dMWyRlk/iVRttAfExFJJiiPOnJG0fH3gnZfJ
	VrA1fqjSx9LHZg9mqaM4lmZXSW2U0xLcYC8V2DIlOwJMpvVd/+nQ2UiQqJgRtiaL9+psL1C06SUut
	ilBict+Vko6EdqAqhkrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnlku-0001OI-VC; Sun, 27 Jan 2019 14:49:52 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnljn-0000MV-LC
 for linux-arm-kernel@lists.infradead.org; Sun, 27 Jan 2019 14:48:46 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 55E285FD14; Sun, 27 Jan 2019 22:48:39 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 0/5] ARM: dts: sun5i: q8-tablet: Complete LCD panel description
Date: Sun, 27 Jan 2019 22:48:33 +0800
Message-Id: <20190127144838.3578-1-wens@csie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_064843_874270_6F19B29A 
X-CRM114-Status: GOOD (  10.57  )
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
Cc: devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

This series adds the missing bits for the LCD panel of the A13 Q8
tablets. The panel and backlight were missing their enable GPIOs.
The panel can have its power supply added as well, though it is not
a complete description. See the commit log of that patch for more
details. The backlight's power supply is the unregulator output of
the PMIC, which does not have a device tree representation.

For the Q8 tablets, the backlight GPIO is driven by a GPIO pin from
the PMIC. This needs a fix in the pwm backlight driver to avoid a
runtime warning. This will be sent separately.


Please have a look.

Regards
ChenYu

Chen-Yu Tsai (5):
  ARM: dts: sun5i: Add backlight GPIO for reference design tablet
  ARM: dts: sun5i: q8-tablet: Move panel properties to correct node
    level
  ARM: dts: sun5i: q8-tablet: Add LCD Panel enable GPIO
  ARM: dts: sun5i: q8-tablet: Add LCD Panel power supply
  ARM: dts: sun5i: q8-tablet: Use bananapi,s070wv20-ct16 panel
    compatible

 arch/arm/boot/dts/sun5i-a13-q8-tablet.dts            | 7 ++++---
 arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
