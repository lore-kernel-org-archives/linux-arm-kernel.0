Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF4DC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:49:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EEE32081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jgFIit75";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRgvvmCt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EEE32081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=OiLhFJPASBR3Xp3kKJs1619g4/wp6hpJn53PV1sjp9g=; b=jgFIit75XMArf+vkjA635J6VNh
	hj3WTp31EcayaAwXXxyqlmHl6X1NnsRPgum7o1Rj+tN62guJiAzocBiEW6p0w/qKBoy+XyHMIlh37
	JLLWm2ofgHEy9CFo0hO1kT4Crqm/bVPv4gwLd932xzMPEvEnNS9pTEOk64iUScHf5UczL6f/2z265
	dXwmGEKk7tKRS4F+vObD6V/Rr6lSOkW85VYfYUU5AMJTzZedI0kcGaa7umg4wPtkP1zHa9Ic67ZOQ
	IJGU+RioI/roNvpJ41ULtt0TJ8wrAkzOptuWC4qVsIz5LSeF1FV9GvOxcL0vpDWS6Kz6ej/mmHk6K
	zVmoh/Uw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVxaf-0002qr-5T; Sun, 09 Dec 2018 11:49:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVxab-0002oB-Av
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 11:49:38 +0000
Received: from localhost.localdomain (unknown [178.38.170.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E060920874;
 Sun,  9 Dec 2018 11:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544356166;
 bh=/Ot7Gzx7qA2GKIHFnhJiOxMrvQy7iQmiBjYCm2bGsZU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BRgvvmCtyugB6yjwCtG2J4oYWzUwXnMhkVm1AxxHDbwHLTkgALpI69wkRzTQV0lFW
 db3YmOLAfVFv+1uf5xPX0zx7IgSXRsoW1huDPMeQfOXLrd1uPvUiAQ7egIKaDgol/6
 CubNMEkgJrFAuzskjnDBO0DpqcZqReZm9VkQfPjo=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
 arm@kernel.org
Subject: [GIT PULL 3/4] arm64: dts: exynos: Pull for v4.21
Date: Sun,  9 Dec 2018 12:49:10 +0100
Message-Id: <20181209114911.25194-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181209114911.25194-1-krzk@kernel.org>
References: <20181209114911.25194-1-krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_034937_467341_22CF9A48 
X-CRM114-Status: GOOD (  10.47  )
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

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.21

for you to fetch changes up to 9deffb5ee78e41e2a5d6c448874a24caec6467d0:

  arm64: dts: exynos: Add all CPUs in cooling maps (2018-11-18 15:18:42 +0100)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v4.21

1. Update DWC3 hardware modules to Exynos5433 specific variant.
2. Update cooling maps to include all CPU devices in multiple DTS files.

----------------------------------------------------------------
Marek Szyprowski (1):
      arm64: dts: exynos: Update DWC3 modules on Exynos5433 SoCs

Viresh Kumar (1):
      arm64: dts: exynos: Add all CPUs in cooling maps

 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi | 36 +++++++++++++++++---------
 arch/arm64/boot/dts/exynos/exynos5433.dtsi     | 24 ++++++++++++-----
 2 files changed, 42 insertions(+), 18 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
