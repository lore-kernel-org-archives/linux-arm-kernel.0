Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA482C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:05:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870A92082C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oSKAlXRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870A92082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=DMwqgYfrnxF6bP7CM8dFO80Ekj2qsptX/fx0gUwGjwQ=; b=oSK
	AlXRVpe15Loost4BWIOpwg4G6ZtzpdhUiO9qCv8/p/D6Zq5gBSvFJSSQn30XtI+jhz+CCap1/zfaX
	/jKgqducetZ60xFpl4qNyAbLSJNEPjflk0SxSdUqH8522nE8ZlCNXHPMNGfEM8OXWJ1lv7ZqEnqys
	sRit7eNRvt9GuJSRlDfHeXFbKOedyPLvzs+9gFDU/COU2ifeqkz9aXPofSnPD6sLuVawCcSaNF3Hl
	Ub7ctYrVto7PzEEwas/Q/fBIlVR7apKFfPnicQTWV4asYyXu7GvI3IvTTp4hFw4gdBKf+7kr9wMX0
	82lwvBTY+XCGkUMZ0lWRrUdDIVz3dUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmjN8-0008Ew-TM; Thu, 24 Jan 2019 18:05:02 +0000
Received: from mout.kundenserver.de ([212.227.126.133])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmjN5-00085n-09; Thu, 24 Jan 2019 18:05:00 +0000
Received: from localhost.localdomain ([37.4.249.120]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Moewz-1hWSMp0gXJ-00p8Ds; Thu, 24 Jan 2019 19:04:46 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
Subject: [PATCH V2] soc: bcm: Make PM driver default for BCM2835
Date: Thu, 24 Jan 2019 19:04:20 +0100
Message-Id: <1548353060-4900-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:Uyp7qWMRttDBEQxKAssbi/Mzdvd0eWI8cdufGXgmYcKZSIwU0QG
 /0C1hPAu9lrDnw9EihwSFQwbd/PQ0xRft1V2FWiiwSHJgLFAy8Lf5EVofq/Vu+DHS9dLQqY
 ERPmz6/zMo6RIQXRMOsO5WJC1QGO0yG/vCeKkf1eTP3+MYIRDn89Y8aL85ZdcGwGST/qYhw
 28oo8NvWVfbxWYBB4Q0QA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sSQL4TdlRes=:7S+6ao/v2I48/YNrFDr8W9
 9yJvdzTdCU6jfGfOh2JlvitPZHsrtPf/3zDk+Wahyih5vyIn+pzofCFrO7FeGHyk5xWEDM5n4
 LXC67FaWOSFZRB2JrLW2CZ5xYr8HqSokM2izRc6pTsL++b2IJtFQ2yCpsDbrXBWnXS0+OWSge
 kCenbRCAQOpxKUvFNGwNSDaEKaedNcJTcLmtccAuVv5RoigIdL6FD5tR3BaI+Q7VF9DMuMZJ+
 2vz1Tz6sdAptEoH4urDe5nAJpIcMr8/ipFUDKcqPT9Wp/P8Vj1ZKQrL5ucgM2ucnTeXszIeJ6
 B6nQil14yWdv9JB+OO4ElDVu5okAMFevQLSluKHmE9YIf7RC0jXtnC6dU13ulOToiZDaINsCL
 oVxpZoNPixhcQuzdm+4VXrQdcp5KS15oCMCbBlLXSBpqPo+furmnUQ8oIH4WsIRhs8KPtvuHs
 feAsN9W9J5AMqDlGHRRjfrGiftRMP7l8cFDSf4qsDQDV8k8puN0vfcVX/9KhuVavTs7DANlhr
 UCPAcNyewu7M7wDt7osVXJKMs4hftxslfXOgbBlzZHRQeN3zYsuO53fsSzI9oApQiv8ZQPULV
 Jv9pgcDbLWR5yMCHJYzsHZpANIMGeyulCk3OGiSNWbhPRtaeUJXtwLV18IEgTpbpkhUrDCXBA
 DQWlnvqg4oX6WEEjDczFGNjKO5A0EP9lOgCFBsFF1p+H7hK4rpMWRj59l99azm8jJotbGUK5g
 1rAitwo5y+JPW4XaI2tJ57MaYK62pj5vueUh+pHnLdDxZSwOUIYYFGh5jfk=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_100459_339649_FEE9A6A8 
X-CRM114-Status: GOOD (  13.02  )
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
 drivers/soc/bcm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

Changes in V2:
- make driver default for BCM2835 instead of selecting in platform Kconfig
  as suggested by Scott Branden

diff --git a/drivers/soc/bcm/Kconfig b/drivers/soc/bcm/Kconfig
index fe1af29..03fa91f 100644
--- a/drivers/soc/bcm/Kconfig
+++ b/drivers/soc/bcm/Kconfig
@@ -3,6 +3,7 @@ menu "Broadcom SoC drivers"
 config BCM2835_POWER
 	bool "BCM2835 power domain driver"
 	depends on ARCH_BCM2835 || (COMPILE_TEST && OF)
+	default y if ARCH_BCM2835
 	select PM_GENERIC_DOMAINS if PM
 	select RESET_CONTROLLER
 	help
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
