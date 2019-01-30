Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5403EC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:54:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 249C72086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g56XBPZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249C72086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=3T0uiRBatEEBk0S0jED9BApxH0cP7Bn2vE93Jm8bQA4=; b=g56XBPZD0wcbIC
	NNlc5lwXevCT00NtJcKQBPXCf9pW5HB9/6thxgFjrmVffikD8vBemPftzAH9P1wTqAUA9bOuqKECW
	uLjr5sj6CqD95sxdmF+MCSCp5xqhFKs5kKn26GPt9ia2/OyFow82MhJ2h8YurEQVsgj7nIvO+U4Gl
	aS9RplWf9UgikiPKQgUGiRDFheyHPi/3LFNeE1SpIydl1FUBTStGvZC4azOFGYvhTyJ6Cnf3b0+OB
	GHwfPhNHMISmQZDZ+4aMGl66Vsnf7faf/AMEDLv/LwD1hfO0nLeb5N813SwmCadq/ItHXKMwm3DXA
	pqJ1FNllgapODR3euM2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1got8c-0004sx-3V; Wed, 30 Jan 2019 16:54:58 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1got8Y-0004sH-9M
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 16:54:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14F2680D;
 Wed, 30 Jan 2019 08:54:53 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90A613F589;
 Wed, 30 Jan 2019 08:54:51 -0800 (PST)
Date: Wed, 30 Jan 2019 16:54:49 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: ARM SoC Team <arm@kernel.org>, ALKML <linux-arm-kernel@lists.infradead.org>
Subject: [GIT PULL] ARM: dts: vexpress: updates for v5.1
Message-ID: <20190130165449.GB19556@e107155-lin>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_085454_326572_E439C1BE 
X-CRM114-Status: GOOD (  11.73  )
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

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/vexpress-updates-5.1

for you to fetch changes up to cc0dbf43668db407692deaf2023d4adbeeef9633:

  arm: dts: vexpress-v2p-ca15_a7: Add cpu dynamic-power-coefficient information (2019-01-29 15:30:00 +0000)

----------------------------------------------------------------
ARMv7 Vexpress updates for v5.1

Couple of simple changes to add dynamic-power-coefficient information
for CPUs on TC2 and fix tuple used for uart and mmci interrupts with
lists.

----------------------------------------------------------------
Dietmar Eggemann (1):
      arm: dts: vexpress-v2p-ca15_a7: Add cpu dynamic-power-coefficient information

Sudeep Holla (1):
      ARM: dts: vexpress: use list instead of tuple for mmci interrupts

Vladimir Murzin (1):
      ARM: dts: mps2: use list instead of tuple for uart interrupts

 arch/arm/boot/dts/mps2.dtsi                | 6 +++---
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi    | 2 +-
 arch/arm/boot/dts/vexpress-v2m.dtsi        | 2 +-
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 5 +++++
 4 files changed, 10 insertions(+), 5 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
