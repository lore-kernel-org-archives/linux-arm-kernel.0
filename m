Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFA8C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:08:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F396821850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dwO+BSFo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F396821850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=rGsdjbe+h1eyJDGOvD2CiYM2u53BWRGS2K8s2Jk0KzY=; b=dwO
	+BSFo9BN9KHYQrF/XU8t1RSxROT+Aw6hxGGdY05zKfE0cY7rcVt53Gm09xQi3Ch6T8ppZPFWmTwBn
	0wntZGR0fE95XMiplAqrbsiDnNbJ38pLvu9Ohyc8mUdPNtBfQPlenBJBhIHvsWNDPcHFjAHFMnxMd
	xKbmkdD5IIaXmEWRjYdZEQXwksaHrrhT3xbXJ4JgQ00zaC7krRcMouSxKkTWGpjO93nRQTTMejzo5
	lmYTve2ZXRI+1OyTrWgkRIwFa9kRRGjCDch1eePxbzSRBPYKj1tPX45XCaZLOlL7N4SqtuOAN+yn9
	2Ztbe7E6bjH1DBALLRPV/TlneYxQQEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmJCq-00024V-Su; Wed, 23 Jan 2019 14:08:40 +0000
Received: from mout.kundenserver.de ([212.227.126.133])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmJCe-0001vD-Sf; Wed, 23 Jan 2019 14:08:30 +0000
Received: from localhost.localdomain ([37.4.249.120]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N3Gok-1hDIHZ0JN4-010Iay; Wed, 23 Jan 2019 15:08:19 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
Subject: [PATCH 1/2] ARM: defconfig: Enable BCM2835_POWER for bcm2835 and
 multi_v7
Date: Wed, 23 Jan 2019 15:07:49 +0100
Message-Id: <1548252470-17920-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:e9pNLCSybfljrGd5+fxdGN2ZZLv3cVhT1OyF2hYB4GTsVLmOXuc
 koHn/2AZeOJEnq7zQBYX7fHniirhT+siG1UmrdC7F8L/IPONzHXbONbasI/md9vrQZMIeFy
 DTEBJ6phwZtj5iMAqCE81Ft0FOMmDxzNjbmCOyPjiXUYrOv04vXBVUzwoEpg8MJxZXmM38L
 CE2OeAdCiquAwfixO6onw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nwdBAEx86Hs=:WKKLLsYI/4tUsHq/E17g0P
 yL6nC70g0MNnu9Z81dqVeUz56nha5OLxjnbHQFdh/7BRnieRRD1URNNjeGwCg5JKYzGwAdnze
 BcvQuto2ZncZNJUH7cxYVeMyOKFsnF3yIscM1qgHR5PIFQnQMlqYn6Ft3DY9N/LMbEviYWzbu
 9BSGrPU1AcM7bAZservMgpKAwgiFp5xopIjpq0/6RtjZg2B8xhhAhyOLQL5b3pKbuILPecHRG
 B301/fbIdRataGGgMjgtPrzFnj7sL+YL+c6zF9uenV3kxKMJtJJu1GvenNmZ/17CBAl1eliA1
 9kJ933v38AboUUa5emViuzr/bjuzkVy5NaVebp/xavhM89sudaPNRtfECjFplW1COsWkZ/Zhb
 ZHC2Y+HWD6o0nn1prXoLtuv+AIQv50WGi+9DDn56mTn/PNCSeYKe+XGdQXM6J3mOsWtjlpfAY
 epqbzUFTk5ltLh1SXsLuybWom/vrKEOumquee3IEn78H2FqSez1aJNY+LAYwRjoGNOLBAqo1f
 gfiqu00pYkth1jDlNsRQnlSFqWPjOq1HoN1bgX9ryryMOTu/LRWyvE5Rvgzzf4GRQm/Au6G6w
 w/ChL4PFMxcrE6Ggdpu1Ge8Z2WOIApKwE6wuOHKRzegDfyjJdw6DiS2LNBHnHHwwStmjR2sLS
 8H5HhfxzNigDvkd+jWAsy5X7urIZJ3LXc0I4o7Psy3fl0LTyWvXxGELL+JyAfVuSiBhQvrJVv
 UsaImV8ieguVg+ViP93JRNCoOD12l37oOIwH3k/RX1YkBgpBw4ItgnnIinY=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_060829_230015_ABB536BB 
X-CRM114-Status: GOOD (  14.09  )
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
 arch/arm/configs/bcm2835_defconfig  | 1 +
 arch/arm/configs/multi_v7_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index bb6a35f..28aacdd 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -132,6 +132,7 @@ CONFIG_SND_BCM2835=m
 CONFIG_MAILBOX=y
 CONFIG_BCM2835_MBOX=y
 # CONFIG_IOMMU_SUPPORT is not set
+CONFIG_BCM2835_POWER=y
 CONFIG_RASPBERRYPI_POWER=y
 CONFIG_PWM=y
 CONFIG_PWM_BCM2835=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index ffaf5c0..7deb404 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -900,6 +900,7 @@ CONFIG_TEGRA_IOMMU_SMMU=y
 CONFIG_REMOTEPROC=m
 CONFIG_ST_REMOTEPROC=m
 CONFIG_RPMSG_VIRTIO=m
+CONFIG_BCM2835_POWER=y
 CONFIG_RASPBERRYPI_POWER=y
 CONFIG_QCOM_GSBI=y
 CONFIG_QCOM_PM=y
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
