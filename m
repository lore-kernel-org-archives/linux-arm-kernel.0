Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E55C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:53:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABB442086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="swwklaOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB442086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ElyYBT/kroB2467wuyJG3OkbNCaq54S8P28yn6VdRzE=; b=swwklaOzoWJU/n
	1rdoV1iL5CbDJr/r1wOtypwDQ5n9fe5dZkbIhC+2J8Q/74iqgtxYZMrOsJeWuvuKb2ANnI6X9S3T2
	M75swxK4Fwxx4WKqLxIdrHJMiUuCdLp5tCDyQ/cIfpDBTDWLvcW37CaFm2e0czT1w2TY1HA0raM4Y
	KrspBbXKe9Zr5x0eGt14+1dJG7mDe/665Cuozhak76hH1VkVSCTM9N3K9bxGRIUYlRU5ATfxI6FO1
	8kqGz7sUY/TWC72QBXEl8iiUyaPCrlbR83azWbSH2iXuI2kMDY62PrLuaHi9h5tBDZImUHf0JdTcG
	kjdeIJih8Q+3uJx4NxLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1got7W-0004Wo-B1; Wed, 30 Jan 2019 16:53:50 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1got7E-0004Kf-EI
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 16:53:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08E1880D;
 Wed, 30 Jan 2019 08:53:30 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 837783F589;
 Wed, 30 Jan 2019 08:53:28 -0800 (PST)
Date: Wed, 30 Jan 2019 16:53:19 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: ARM SoC Team <arm@kernel.org>, ALKML <linux-arm-kernel@lists.infradead.org>
Subject: [GIT PULL] arm64: dts: juno/fast models: updates for v5.1
Message-ID: <20190130165319.GA19556@e107155-lin>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_085332_993788_9C6FC665 
X-CRM114-Status: GOOD (  12.96  )
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi ARM SoC Team,

Please pull !

Regards,
Sudeep

--
The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/juno-updates-5.1

for you to fetch changes up to 4daa001a17739947bf966e388e8a287db80d478b:

  arm64: dts: juno: Add cpu dynamic-power-coefficient information (2019-01-29 15:31:37 +0000)

----------------------------------------------------------------
ARMv8 Juno/fast models updates for v5.1

1. Support for Fixed Virtual Platforms(FVP) Base RevC model to enable
   development of software around the new features available

2. Addition of dynamic-power-coefficient information for CPUs on Juno

3. Miscellaneous changes like re-ordering device nodes, using existing
   macros for GIC flags in interrupt-maps and using list instead of
   tuple(which is wrong but works as number of interrupt cells is 1)
   for mmci interrupts

----------------------------------------------------------------
Dietmar Eggemann (1):
      arm64: dts: juno: Add cpu dynamic-power-coefficient information

Jean-Philippe Brucker (1):
      arm64: dts: fast models: Add DTS fo Base RevC FVP

Sudeep Holla (3):
      arm64: dts: juno/fast models: using GIC macros instead of hardcoded values
      arm64: dts: models: use list instead of tuple for mmci interrupts
      arm64: dts: juno/fast models: sort couple of device nodes

 arch/arm64/boot/dts/arm/Makefile                   |   1 +
 arch/arm64/boot/dts/arm/foundation-v8-gicv2.dtsi   |   2 +-
 arch/arm64/boot/dts/arm/foundation-v8-gicv3.dtsi   |   2 +-
 arch/arm64/boot/dts/arm/foundation-v8.dtsi         | 106 ++++----
 arch/arm64/boot/dts/arm/fvp-base-revc.dts          | 277 +++++++++++++++++++++
 arch/arm64/boot/dts/arm/juno-base.dtsi             | 108 ++++----
 arch/arm64/boot/dts/arm/juno-r2.dts                |   6 +
 arch/arm64/boot/dts/arm/juno.dts                   |   6 +
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts         | 106 ++++----
 .../boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi      |  27 ++
 arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi   |  14 +-
 11 files changed, 488 insertions(+), 167 deletions(-)
 create mode 100644 arch/arm64/boot/dts/arm/fvp-base-revc.dts
 create mode 100644 arch/arm64/boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
