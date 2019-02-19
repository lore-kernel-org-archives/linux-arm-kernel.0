Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DFEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:52:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90FBE217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jDZVNYq4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ongw8/sK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FBE217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=QmndZbX2ypkMwnTj9WvwXQY/AsvO2Ju8pkhb/4HCpdA=; b=jDZ
	VNYq4zJkPyivgPA/lDG/GMzDLt9aDQ4SwU4NuYwyAmxBJacu2BY8mhZBxBJbJ4HwBTgK3KhDIPx6l
	NY3s2loOqTp5QMK1NqCTTHT7vds05PlGKX7xIWdC3UT3EU1KANsV2LYqHPTdw6hYAGpYwquEw03/I
	ccM576xCzfX6HLThfSUwEOmGWQshNiozuD/6zLWQV86DlBekbqD7ziQEBcLVBIrc3VCKRlMgABR2e
	aWft6i2sigv5Tfq1fBj7ZEJtyVpd6AJqdDWLZ+F0nWsLPKkS1QyIzY+4ue3cEAdI6h9K4/pt9FjQJ
	CN/sQLL8GbTr3qJmuP9DMTnKebKgeBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwAVL-0008Rm-EE; Tue, 19 Feb 2019 18:52:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwAVH-0008RK-Ou
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 18:52:29 +0000
Received: from localhost.localdomain (unknown [194.230.155.153])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 76E952147C;
 Tue, 19 Feb 2019 18:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550602345;
 bh=7magXceUJ8ImTVgOlwL7w/s4YKCJoWKnahlH0PwJHi8=;
 h=From:To:Cc:Subject:Date:From;
 b=Ongw8/sKOH8mYGN1Ub/4DLqbPV0hMKSJ0Y4Oy62AiNsauBU9BTs9yRp8vH8MZmslX
 CFW5M876pTo2AmDGzsGfqZnl+5lJCLq/HCn99aDVIOoUCZjcUM05miRDesDeoPUU5o
 n9N0lTcQlpnKMyTdE1i1yCaxFGBHldImhe66r5nY=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
 arm@kernel.org
Subject: [GIT PULL] ARM: dts: exynos: Second pull for v5.1
Date: Tue, 19 Feb 2019 19:52:14 +0100
Message-Id: <20190219185214.5544-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_105227_828473_67CA2DA7 
X-CRM114-Status: GOOD (  13.60  )
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


The following changes since commit ec33745bccc8f336957c751f4153421cc9ef5a54:

  ARM: dts: exynos: Fix pinctrl definition for eMMC RTSN line on Odroid X2/U3 (2019-01-25 20:18:10 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-5.1-2

for you to fetch changes up to 625c731d1b2af487fc6be10b9a505699c045813a:

  ARM: dts: exynos: Add support for secondary DAI to Odroid XU4 (2019-02-18 20:52:25 +0100)

----------------------------------------------------------------
Samsung DTS ARM changes for v5.1, part 2

1. Enable ADC on Odroid HC1 board.
2. Fix clkout register failure on Exynos3250.
3. Allow using earlycon on Arndale board.
4. Disable ARM PMU on Odroid XU3 Lite because it is locked by Trusted
   Firmware.
5. Add support for secondary DAI to Odroid XU3 and XU4 boards.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      ARM: dts: exynos: Enable ADC on Odroid HC1

Marek Szyprowski (3):
      ARM: dts: exynos: Add minimal clkout parameters to Exynos3250 PMU
      ARM: dts: exynos: Add stdout path property to Arndale board
      ARM: dts: exynos: Disable ARM PMU on Odroid XU3-lite

Sylwester Nawrocki (2):
      ARM: dts: exynos: Add support for secondary DAI to Odroid XU3
      ARM: dts: exynos: Add support for secondary DAI to Odroid XU4

 arch/arm/boot/dts/exynos3250.dtsi                  | 3 +++
 arch/arm/boot/dts/exynos5250-arndale.dts           | 2 +-
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      | 5 +++++
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi  | 6 ++++--
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 5 -----
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts    | 8 ++++++++
 arch/arm/boot/dts/exynos5422-odroidxu4.dts         | 4 +++-
 7 files changed, 24 insertions(+), 9 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
