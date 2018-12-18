Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E53C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:10:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBEA3218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mqj1gIDD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKBosLUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBEA3218A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=EcpQjrFDhaDB70jsyU4WMJu21by58Xa090S9whKFTHY=; b=Mqj
	1gIDDQWscyC3Tsppdyb3KMX5lJyYAfc17X2oN3VBImm/PPnhI98pQf3Uo2V2qcRAw7kuYxiZuzzdq
	Z7Hl254XFUVOYPxRGx2goQpuFLpM76ftKp37J5XNHo2+gd2evY7eFKLqlev7GksZ8ak6ZgHBOqllg
	g3SFz4vGYWECvKUgpHXb20j7IW94+mMQ01Mh4jjPLAYBf/NxZ61D2liSzURJIUAn4jp3rSNMDbJ37
	A6OYFqg1+Qmlpm6qTwGYtpNxuOhP8gsQNdUxryn1ig/Tvsj3QTO/ZvJRcrBmtL+fdcyfXKxZtgYI9
	Tm/xeyRDVUuf+KIpzAxat2ODM/k0fXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZLhB-0005gm-U9; Tue, 18 Dec 2018 20:10:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZLh8-0005ek-M2
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 20:10:24 +0000
Received: from localhost.localdomain (unknown [178.38.170.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0519121873;
 Tue, 18 Dec 2018 20:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545163811;
 bh=V2Z6FNlObzVrANZZjLMVrzORLYCaCBjOZOSSho75eZ0=;
 h=From:To:Cc:Subject:Date:From;
 b=BKBosLUHWplD0avHxIjeMhwmcP0I+uwNiuLSmufaRimVJTaYdfE3IRUGdaf1YO9Js
 N3ATmM7unm3hqmZ/1s9/zlaxDJ2cFhAe35cl3jsrCSDbi06Mli0McxYsZhQNcjls4v
 DmLpX5yFW6NLRsyF0EoUURoGKRvZ0bPVw9tGpy+4=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
 arm@kernel.org
Subject: [GIT PULL 1/2] ARM: dts: exynos: Second round for v4.21
Date: Tue, 18 Dec 2018 21:10:02 +0100
Message-Id: <20181218201003.12806-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_121022_733465_A40012C7 
X-CRM114-Status: GOOD (  11.17  )
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
Cc: linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit 57b13b8b34002ce8f1d822ea05f0a84e5bc3a64a:

  ARM: dts: exynos: remove display-port node from Arndale (2018-12-06 19:47:15 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.21-2

for you to fetch changes up to 8ac686d7dfed721102860ff2571e6b9f529ae81a:

  ARM: dts: exynos: Specify I2S assigned clocks in proper node (2018-12-13 21:56:07 +0100)

----------------------------------------------------------------
Samsung DTS ARM changes for v4.21, part 2

1. Add missing CPUs in cooling maps for Odroid X2 (missed in previous
   round of fixups).
2. Fix clock configuration in audio subsystem on Odroid XU3/XU4.

----------------------------------------------------------------
Markus Reichl (1):
      ARM: dts: exynos: Add missing CPUs in cooling maps for Odroid X2

Sylwester Nawrocki (1):
      ARM: dts: exynos: Specify I2S assigned clocks in proper node

 arch/arm/boot/dts/exynos4412-prime.dtsi           | 6 ++++--
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi | 9 ++++-----
 arch/arm/boot/dts/exynos5422-odroidxu4.dts        | 9 ++++-----
 3 files changed, 12 insertions(+), 12 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
