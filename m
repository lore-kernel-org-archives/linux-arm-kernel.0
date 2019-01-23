Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01005C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:24:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE0CD20856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EAoJe/39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0CD20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=+ehZ4FS4B5Gn8VgYwrGYTFFW7vrrdrtpkJTchVkqGb8=; b=EAoJe/39yQDE8pIMTbtIinzRMx
	2Eo/jIWFsSAD+mewvXFN/fAEZ2NdPaKMzRxUzvCIJxXTKrKU84a5KB2D/lwBJ42cy+IcQDSvJdmEa
	Zm/tG153coG0tHNQJRMS99XEPOBuoa8iXaoJCnvMKPlAH26aANGkEpZUujS6Pj+J9+OtEPowjCFEl
	usTmALw838dYh2Y9pv8KHWeELVVjxhKI6k+goCmr15Coi/LUJ4o8rT9lttB0duFE1f+OpkTKGehNG
	BfCCh/twLw/7r+tsdHk2TzR3kYQg2d3aOMDSRxPpGNbfmyWY0t1RkMw1BvqClMI4pcvEZVb4HzZh0
	RKgzTk/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmQwb-0001T0-KQ; Wed, 23 Jan 2019 22:24:25 +0000
Received: from mout.kundenserver.de ([212.227.126.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmQwP-0001JN-3f; Wed, 23 Jan 2019 22:24:15 +0000
Received: from localhost.localdomain ([37.4.249.120]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N1fei-1hANmn0yKW-011yQv; Wed, 23 Jan 2019 23:24:05 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
Subject: [PATCH 2/2] arm64: BCM2835: Enable PM driver
Date: Wed, 23 Jan 2019 23:23:56 +0100
Message-Id: <1548282236-3962-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548282236-3962-1-git-send-email-stefan.wahren@i2se.com>
References: <1548282236-3962-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:KMsEy4tq0E++wZU0TsmGImawB2CTDLV7z4DgRtGaxoIzjrTM+nk
 1a7efxHQn4XXnZSO+07WQLkZUzCbDoNbxT4coAqNMA4MG6xOkSzxXLtcIgvjFTFqGdSVOKI
 jwN2Xro43aSoI42TaZVOXiX0vJE480UT+ITLCW+RvNXH/cnz8NNlfvNXVtIpKWpZ29PDYYB
 E8+Z9U3HlgJzb1ZFZG+BQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BXR2+jVRHWU=:xnhajN9LMiNMKO/ClDgvn3
 9edCTvB7NvDsJKcNvC+SVqSVRleO12xCyJLAPJyfT1yIVz/nBcHzi2NOITlFARE4Hc5MP0j16
 hSlhk3BIYqWT1oAySheTjihDBDjch84zIyUXjuLSQSouc6f1n5rdYzMt1iOtNnKnRgr2DaU8g
 Ar1GM3mvGXiwHLjEe4y50b9cQCrgdGYjAta7V4gw5wHYGKAJnGwGV5jVkmknVbBzSPJT20SC0
 kW11I5W5cRb45ERlpJre+fGoCcCitcsb8WLVdntU81em4oGabyh8Un9clXgH2QrHqXuLghGav
 ndrawwT7HyqvTN+sKvy9S9f/j26LZ/uKreTQooklfaDDoOeHcaUfhQejuHzA2qmA+tlIzGDii
 NknFnwTv44RkWh1zY5Ucgb6pB7PyjtpbFGJ1Fr0AiP+VTPttvxLend42wN/mlELDs1nobC412
 h+K4ifmSXrl4bJxZVua64W+Fkg0l1DptqpZPenMh+9Si8vJFLMjlhpIoPwJKRl/NvbvBmOwF1
 VGKqnRVoF+Xf1URH5Sh3Bmy9LX8+5EZ+DH9FGqOaat6CdyFqVwtdg4OP2YJtTb4vQxg8+X07b
 10buSXGz0ZsMrUSXwiHNDuhgj3bT/0r/TL2/EbwbgB6k6PJRRo5mEVegcNEZ7xFqmMCv7joox
 hoeQ6jOxBpG4Kxyhw5VE7Qb/3QGoskK37Y9xijd98XMF+18798BxrwyFpxdo2b1rzTLfXIyhY
 kdDRRmM5xnc+B4FxzMgcUvLJplovPqKaayA9IDRD38LXvk53YI06SNAb788=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_142413_454228_4F976414 
X-CRM114-Status: GOOD (  14.18  )
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
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 251ecf3..e583b04 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -32,6 +32,7 @@ config ARCH_BCM2835
 	select ARM_AMBA
 	select ARM_TIMER_SP804
 	select HAVE_ARM_ARCH_TIMER
+	select BCM2835_POWER
 	help
 	  This enables support for the Broadcom BCM2837 SoC.
 	  This SoC is used in the Raspberry Pi 3 device.
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
