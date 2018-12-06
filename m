Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03993C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:16:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C85ED2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dvLQCEnc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="N7bfutnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85ED2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=7usjn8Zz99/s/QLQ4ccuAFCxeV1UkP5w9fxlNEwBGwU=; b=dvL
	QCEncudT3iHfsxTzWjHP6792tswQKyfvsZZ/YOdEdI4oE0FK1bYrzeEEtmbYLMntVtMLBO0jFv1Pb
	wq9lV+gr+rKOR43tkitUvP64SyDbkXhanMiGx9EtAYCqSiWFOqnXwzLr+OxYj3rmOIl7Y5ZVBjQIf
	o2C1f6535po6vkXTE2DEUjqk4nPmh/iluSZDWjAb5Bl1Ip3C512UF/KMcAFqt5PXoXtwQC7zY7bgS
	ob54u+F7xu7TUbOH9bdPrc05WQRwm8wOGS0GhYyNphnaJRJ8hoJTiDg4MsWQ+Bs7CwKdgF5biJIca
	w1QhLovVBzZ9c9D/Lx9OBOvExa/me9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1wa-0004Pv-GY; Thu, 06 Dec 2018 22:16:28 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1ui-00085t-7c
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:14:48 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id D702B25BF77;
 Fri,  7 Dec 2018 08:59:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133575; bh=sPSk17ceX7LxY75JKKNIro5LK7NNOgQDIXckJRFUbp4=;
 h=From:To:Cc:Subject:Date:From;
 b=N7bfutnwXWO3IwZBnILkneOBm7ijQT+fSVp/Fc/SDQ/NRySAZfqsKhsk2sZDJTZyJ
 4XegHXCVSaVQpL63VN8wjd2VhEhZqXUPoilUteaGloO0sqf3a886pbJtO/mfkpfK0p
 Tt/MfqYKfDXUuBiTn3HJkvxV0bi+UgelE+NjZq8w=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id B923EE21700; Thu,  6 Dec 2018 13:59:33 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: arm@kernel.org
Subject: [GIT PULL] Renesas ARM Based SoC Updates for v4.21
Date: Thu,  6 Dec 2018 13:59:31 -0800
Message-Id: <cover.1544132474.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_141432_693672_1BA51A07 
X-CRM114-Status: GOOD (  11.93  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org,
 Olof Johansson <olof@lixom.net>, Simon Horman <horms+renesas@verge.net.au>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC updates for v4.21.


Usually I separate SoC changes for ARM and arm64 into separate branches.
On this occasion I have applied them to a single branch and pull request.
The reason for this is that moving SoC Konfig symbols for both ARM and
arm64 creates a dependency and a combined branch is a clean way to resolve
this.

If separate branches are required then I propose deferring the movement
of ARM (but not arm64) SoC Kconfig symbols to v4.22.


The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v4.21

for you to fetch changes up to 2ed29e15e4b2500ae78de658a18f4482e7ac288b:

  ARM: shmobile: R-Mobile: Move pm-rmobile to drivers/soc/renesas/ (2018-11-30 11:29:11 +0100)

----------------------------------------------------------------
Renesas ARM Based SoC Updates for v4.21

* pm-rmobile driver
  - Move to drivers/soc/renesas/
  - Clean up struct rmobile_pm_domain
* Renesas SoC Kconfig Symbols
  - Move symbols for ARM and SoCs to drivers/soc/renesas/
  - Hide ARCH_RZN1 to improve consistency
* SH-Mobile AG5 (sh73a0) SoC: Remove obsolete inclusion of <asm/smp_twd.h>
* Restrict TWD and SCU to Renesas ARM based SoCs where they are present
* Enable GPIOLIB on Renesas arm64 based SoCs to allow GPIO driver selection

----------------------------------------------------------------
Geert Uytterhoeven (8):
      ARM: shmobile: Restrict SCU support to SoCs that have it
      ARM: shmobile: Restrict TWD support to SoCs that have it
      ARM: shmobile: sh73a0: Remove obsolete inclusion of <asm/smp_twd.h>
      ARM: shmobile: Hide ARCH_RZN1 to improve consistency
      arm64: renesas: Move SoC Kconfig symbols to drivers/soc/renesas/
      ARM: shmobile: Move SoC Kconfig symbols to drivers/soc/renesas/
      ARM: shmobile: R-Mobile: Clean up struct rmobile_pm_domain
      ARM: shmobile: R-Mobile: Move pm-rmobile to drivers/soc/renesas/

Takeshi Kihara (1):
      arm64: renesas: Enable GPIOLIB to allow GPIO driver selection

 arch/arm/mach-shmobile/Kconfig                     | 129 -----------
 arch/arm/mach-shmobile/Makefile                    |   1 -
 arch/arm/mach-shmobile/pm-rmobile.h                |  22 --
 arch/arm/mach-shmobile/smp-sh73a0.c                |   1 -
 arch/arm64/Kconfig.platforms                       |  60 +----
 drivers/soc/renesas/Kconfig                        | 241 +++++++++++++++++++--
 drivers/soc/renesas/Makefile                       |   1 +
 .../soc/renesas/rmobile-sysc.c                     |  37 ++--
 8 files changed, 240 insertions(+), 252 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/pm-rmobile.h
 rename arch/arm/mach-shmobile/pm-rmobile.c => drivers/soc/renesas/rmobile-sysc.c (93%)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
