Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63B2C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:24:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF58D20856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OdVt8MKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF58D20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=U2UQdR4oCQvLtlTkJ/xaZ25pTqk5vnFNasAzoHey+6s=; b=OdV
	t8MKm7AqKsG4MrgVMr265B4YwSrGOGIkXbjgczBouzhpViOm9ClkLfCzmdG2mc8G9gL4aoXkbPA4a
	3N6BB3w11LG6aqLduUD9Zhy/0JZOSZNOVVwhqcogpyL9XPStrYPyFx+fsQ6fN23pdGZKwSo2Glugo
	sf0ZWIIJY6GbPqsY0QBqucj3UsrdF57aiKXNxLvqMnG4VNV1uNwEVHntpyv+ghU93U2T2z4/eiqSb
	EFYmzZ833bwgJHekfCuWBwDsXHh8A/iMzuA0j2qTt5kCdspKE+oCjIX3vYUlTaMYU+H3sddw8VkWd
	bC3onnBoV0ks1UAgCDvr4UJq9vpreiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmQwT-0001Kv-AO; Wed, 23 Jan 2019 22:24:17 +0000
Received: from mout.kundenserver.de ([212.227.126.135])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmQwP-0001JM-3e; Wed, 23 Jan 2019 22:24:15 +0000
Received: from localhost.localdomain ([37.4.249.120]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M4s91-1goMc73Qud-0020F0; Wed, 23 Jan 2019 23:24:04 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
Subject: [PATCH 1/2] ARM: BCM2835: Enable PM driver
Date: Wed, 23 Jan 2019 23:23:55 +0100
Message-Id: <1548282236-3962-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:njZZWKmkBLblU62+RMmzV1F6dcVgAzfEW36HFWSAsQEoRoO05GF
 tGf5KBVvHFTR9IIbmAd996XIkf9+Fv36691Vv72XwzfRxADlQmhX/kLNSlswrmw1X9UdgQH
 b1l/A8BLYLcncWVG4PlloYO+1020u4Wvltt6KeexRA5YgtfO3NCuecUNKcXcK4U151YlyFq
 5XLpFORrPOQgl0o2mOPAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9T+PF6aexlE=:J2UUlv1r4npTNAZyKD3yHo
 J2Tg4+mkCPPyskqR822qaYAld+JNfV/IKFPsKeLj4ZDscs5ZnCkzZaG3mfMo6XzvALF8/7bG+
 rjENnu7rBJdhZCEG137jhMk1Q8ax2s4JQQcV6r+re+oGtttC3Uj9jZwcT+xQfq6GUVM2EXXqq
 4QEiMvZfjrEGbNqneRkZp385j3uQstCTsv5CoecrydCF7eZrix+N63O2qwYJrDictTcObVqiy
 W79Mjl3+DgwjpuLZcGw4kVtoQSQLvFxgH6hBWo3UOm3Oo5tNRWSxYuCQPyw4wXcMBGCw1/wea
 Fwfkr48H/mNT7HH2PSOc+dHTCWCww7Az0+8694fmAkyspHJqQa5wjlSeEM3ZQsHhKlygIlbje
 R1NkZU9qMs96XVJL3xA4/ECObJbhWpjKvtg5yD5915dAJ9BgAxDnQlw4ADEZO5evzaVe4bIfz
 EfYCm4wo29P0DvwAAkLOii6my1Y+FMHeMOM8ANHHnWD7Fd5+8PkaId7GNzNJStZVgiLpmYIW0
 aUSJxPRcS0R5kSYiO/p/t+43+zfhE8OiA+xGcd72ydK9hYlMg83L7sodiqqRGAFIT8YjixuLV
 WaR1hGQa5teWE6bWS79SWW7lzrVQx0PxwEva83hPqCtAre5SdQ7uIUq6HglilLQy7X0Kr5kg0
 aJiq73oYrJMyTaZY/evTl3sjfn73ziPNc5ss1ji7s/vTQPJEKPibZpYxdhzWIGozj4paXh+pb
 U8eE9f80KUikNxGBt3ainR8ArBreRe0djRHiKmhxPTzZUB1jFbmgEZdnl9I=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_142413_450254_EDD004EE 
X-CRM114-Status: GOOD (  13.08  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Since commit 52a4adbaebcc ("ARM: bcm283x: Switch V3D over to using the
PM driver instead of firmware.") VC4 on BCM2835 requires the power driver.

Otherwise the driver won't probe and HDMI output stays black:
vc4_v3d 20c00000.v3d: ignoring dependency for device, assuming no driver

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/mach-bcm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

Hi, please ignore the preceding defconfig changes.

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 4ef1e55..b7dbfbc 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -165,6 +165,7 @@ config ARCH_BCM2835
 	select HAVE_ARM_ARCH_TIMER if ARCH_MULTI_V7
 	select TIMER_OF
 	select BCM2835_TIMER
+	select BCM2835_POWER
 	select PINCTRL
 	select PINCTRL_BCM2835
 	select MFD_CORE
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
