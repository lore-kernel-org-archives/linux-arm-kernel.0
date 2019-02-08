Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90007C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:18:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6073520863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gZYRuLKn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="JAJjBftu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6073520863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Q6PNwYChK6KX7X+XurB2g8CCrk3DFEw2ON90pz1/diU=; b=gZY
	RuLKn6dkSOFG2zJ7FMJYrqWMGm3SKjVmBhXDl/JCuF98ELbVubi7T1EHNcgt+Y8uVKTYUvzo1SNTE
	M6OupIuVQqyYCKY65rDK20bS180UxFjQI5hAZE3RlAZPlRbkx1DzLivWyi4ioqh/DsCG6nl0tBm4O
	hkGR8tqM8YHs+wg0oe0dCz0YuF+5g+5Hm4gC9GLyiSx3r7l79DL2oPg/5KTWSmAGAqgHMZtivMnOe
	VnMjErJw2cP0u+jRP10Z2JB/l7KsmzZ9pGrB/yUHxE1MlBNHKdbNERRtMDVzNAOYuiSPGvvjFGefA
	AApyKU3a6MVC+61mdJL1R//VTXNwQ4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs4Ax-00051u-Cg; Fri, 08 Feb 2019 11:18:31 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs4Ae-00084G-N7
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 11:18:28 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id E2B0925BEE7;
 Fri,  8 Feb 2019 22:13:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1549624429; bh=aWZA4Fk6i1vrJDTx2cEwafCACYgBrCJ8vjTGeLftXzU=;
 h=From:To:Cc:Subject:Date:From;
 b=JAJjBftul55RjxOUux2VU4vtS88izR3aZWPpJPfWgOQcf4mbB9s7HmTpXtRXQpwQQ
 f6Ngl02jx5j1Rz3SjQIDLGpWmBc75tpkg2wC6Cnbfh+nmNce3Gja+MGrq16eOut+hI
 UjiFJ9AvQfn0ySp5HG1OwRB5Wnf99/sYaVw20c3k=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 3D0589401DB; Fri,  8 Feb 2019 12:13:47 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: arm@kernel.org
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v5.1
Date: Fri,  8 Feb 2019 12:13:35 +0100
Message-Id: <cover.1549621233.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_031813_116638_11F8AFC6 
X-CRM114-Status: UNSURE (   9.95  )
X-CRM114-Notice: Please train this message.
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

Please consider these Renesas ARM based SoC defconfig updates for v5.1.


The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm-defconfig-for-v5.1

for you to fetch changes up to 03ff9677930064a495fcce269a0f6f1db5dd9dd9:

  ARM: multi_v7_defconfig: Enable support for RZ/A2 (2019-01-25 11:03:04 +0100)

----------------------------------------------------------------
Renesas ARM Based SoC Defconfig Updates for v5.1

shmobile and multi_v7 defconfig
* Enable support for recently upstreamed RZ/A2 (r7s9210) SoC
* Enable NXP pcf85363 RTC which is used on RZ/G1C (r8a77470) based iWave SBC

shmobile defconfig
* Refresh for changes present in v5.0-rc1

----------------------------------------------------------------
Biju Das (2):
      ARM: shmobile: Enable NXP pcf85363 rtc in shmobile_defconfig
      ARM: multi_v7_defconfig: Enable NXP pcf85363 rtc

Geert Uytterhoeven (3):
      ARM: shmobile: defconfig: Refresh for v5.0-rc1
      ARM: shmobile: defconfig: Enable support for RZ/A2
      ARM: multi_v7_defconfig: Enable support for RZ/A2

 arch/arm/configs/multi_v7_defconfig |  3 +++
 arch/arm/configs/shmobile_defconfig | 48 ++++++++++++++++++-------------------
 2 files changed, 27 insertions(+), 24 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
