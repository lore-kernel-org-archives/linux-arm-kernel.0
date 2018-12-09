Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E177C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:50:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43BD920661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MRSUS1Po";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHKU5dzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BD920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=8cy44/OcIgDwtwJYIjDdnWj1dlVPLHsOzekoizVu1Eg=; b=MRSUS1PoTap+hTPGyuNIwlkd1r
	2vxuiD/9EyHyH7EcF3dtI5bB1mEHn/G1m6PLlXikQUvZuQU4TrrWTU2IoR5GtQr4jf8AJ+3MRNsVR
	9/0nXIr/AovVRhoIZ5XpZ8t3OqHazFBgPTMmWQLMGpPiSkJHK7B+B4CaQS+I7Uql2aesJawyVrGBA
	+LAzdzDCc32ADvRB+XRwIHwMhqgAeDzEv0eCA4DxctdGhP8D/gXyoNOkoo3hVMgLZ/VLGd2OEJYcM
	ce3EJnKmjVesLcO1IdgXSnpNXI0MaWpbZ+It/b0IBeV++HujozKzsCsp/A5W8+nZ8hPwjplzS/0dQ
	75lWzDsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVxbM-0004iI-W9; Sun, 09 Dec 2018 11:50:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVxab-0002op-Au
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 11:49:40 +0000
Received: from localhost.localdomain (unknown [178.38.170.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CDB2B208E7;
 Sun,  9 Dec 2018 11:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544356168;
 bh=7jGy5fK06sx5jssyFS+lxvgyeVglkdKuKLJLqNMGjso=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dHKU5dzXojYQ8FKlORxstTVV5p164koa7o3wf68zfpl6RjDhB/77f+SV1Jzn/S/qg
 4dxdHI1O9dmMCL1jPpDoubgTuZotw1yfRaDIfigi7Cyq6tQfJvbfjOr7hjUGmn6jmZ
 ZtR7BJ2+9T3VQgvH7mVigLToeCdmddTChXfSIX/o=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
 arm@kernel.org
Subject: [GIT PULL 4/4] ARM: samsung: SoC/mach for 4.21
Date: Sun,  9 Dec 2018 12:49:11 +0100
Message-Id: <20181209114911.25194-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181209114911.25194-1-krzk@kernel.org>
References: <20181209114911.25194-1-krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_034937_482494_5D6679DF 
X-CRM114-Status: GOOD (  11.40  )
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

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.21

for you to fetch changes up to cafbc79e327f44411b8bd8bdc101b9e6c65ab42a:

  ARM: exynos: Remove secondary startup initialization from smp_prepare_cpus (2018-11-18 15:12:50 +0100)

----------------------------------------------------------------
Samsung mach/soc changes for v4.21

Just cleanups of: legacy way of setting external wakeup interrupts, old
power management debugging functions and duplicated secondary startup
initialization.

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (2):
      ARM: exynos: Remove no longer needed s3c_pm_check_*() calls
      ARM: samsung: Limit SAMSUNG_PM_DEBUG config option to non-Exynos platforms

Krzysztof Kozlowski (2):
      ARM: s5pv210: Remove legacy setting of external wakeup interrupts
      ARM: exynos: Remove legacy setting of external wakeup interrupts

Pankaj Dubey (1):
      ARM: exynos: Remove secondary startup initialization from smp_prepare_cpus

 arch/arm/mach-exynos/common.h  |  2 --
 arch/arm/mach-exynos/platsmp.c | 26 --------------------------
 arch/arm/mach-exynos/suspend.c | 37 ++++++++++++++++---------------------
 arch/arm/mach-s5pv210/common.h |  1 -
 arch/arm/mach-s5pv210/pm.c     | 16 ++++++++++++----
 arch/arm/plat-samsung/Kconfig  |  1 +
 6 files changed, 29 insertions(+), 54 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
