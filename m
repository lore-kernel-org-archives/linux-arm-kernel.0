Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D253C282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:07:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F25218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JA0OWmVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F25218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=fmePYvoAU+UYyRysgAFxQ3nD58NN62ol8y1DFGGf3fE=; b=JA0
	OWmVwLQtyaD+Lp1SddnrrdMhRyfjqnaQOqzTKq4VakvrSQixt6Wz/hpQP55M2Nkv6d965MOf8iLWd
	QcW7LWRSM/eXr0lJ/Lkimzt2Tt+Ah+0bu8wc5lZdOHLIOlE1pL7RdKtr9ORuUY8YKFtx8mHPMSeAD
	2SLQOQsyf9cD/Y0X7tsav88scP9C46e3ZZccdk92GIQQsb1TIF8g6YN/tEuShqnnXBTkZZhQS+MB1
	OXmqUW+s/bmpGttHUGQBefatINHAfwIc+1UbsGQ5akqsj461Dq5ifHw85zVp8JqU7QRCqlF6ulKH5
	yAxufDg+3b/Sng5m96uxZ69dYjvQKrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn5sz-0005KX-9j; Fri, 25 Jan 2019 18:07:25 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn5sw-0005JE-F4
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 18:07:23 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 440F8EBD;
 Fri, 25 Jan 2019 10:07:20 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com
 [10.118.12.119])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9ADDA3F5AF;
 Fri, 25 Jan 2019 10:07:19 -0800 (PST)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 00/12] arm64: add system vulnerability sysfs entries
Date: Fri, 25 Jan 2019 12:06:59 -0600
Message-Id: <20190125180711.1970973-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_100722_517100_3301301D 
X-CRM114-Status: UNSURE (   9.42  )
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
Cc: stefan.wahren@i2se.com, mlangsdo@redhat.com, suzuki.poulose@arm.com,
 marc.zyngier@arm.com, catalin.marinas@arm.com, julien.thierry@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 Jeremy Linton <jeremy.linton@arm.com>, steven.price@arm.com, ykaukab@suse.de,
 dave.martin@arm.com, shankerd@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Arm64 machines should be displaying a human readable
vulnerability status to speculative execution attacks in
/sys/devices/system/cpu/vulnerabilities 

This series enables that behavior by providing the expected
functions. Those functions expose the cpu errata and feature
states, as well as whether firmware is responding appropriately
to display the overall machine status. This means that in a
heterogeneous machine we will only claim the machine is mitigated
or safe if we are confident all booted cores are safe or
mitigated.

v3->v4:
	Drop the patch which selectivly exports sysfs entries
	Remove the CONFIG_EXPERT hidden options which allowed
	       the kernel to be built without the vulnerability
	       detection code.
	Pick Marc Z's patches which invert the white/black
	       lists for spectrev2 and clean up the firmware
	       detection logic.
	Document the existing kpti controls
	Add a nospectre_v2 option to boot time disable the
	     mitigation

v2->v3:
	Remove "Unknown" states, replace with further blacklists
	       and default vulnerable/not affected states.
	Add the ability for an arch port to selectively export
	       sysfs vulnerabilities.

v1->v2:
	Add "Unknown" state to ABI/testing docs.
	Minor tweaks.

Jeremy Linton (8):
  Documentation: Document arm64 kpti control
  arm64: Provide a command line to disable spectre_v2 mitigation
  arm64: Remove the ability to build a kernel without ssbd
  arm64: remove the ability to build a kernel without hardened branch
    predictors
  arm64: remove the ability to build a kernel without kpti
  arm64: add sysfs vulnerability show for meltdown
  arm64: add sysfs vulnerability show for spectre v2
  arm64: add sysfs vulnerability show for speculative store bypass

Marc Zyngier (2):
  arm64: Advertise mitigation of Spectre-v2, or lack thereof
  arm64: Use firmware to detect CPUs that are not affected by Spectre-v2

Mian Yousaf Kaukab (2):
  arm64: add sysfs vulnerability show for spectre v1
  arm64: enable generic CPU vulnerabilites support

 .../admin-guide/kernel-parameters.txt         |  14 +-
 arch/arm64/Kconfig                            |  39 +--
 arch/arm64/include/asm/cpufeature.h           |   8 -
 arch/arm64/include/asm/fixmap.h               |   2 -
 arch/arm64/include/asm/kvm_mmu.h              |  19 --
 arch/arm64/include/asm/mmu.h                  |  19 +-
 arch/arm64/include/asm/sdei.h                 |   2 +-
 arch/arm64/kernel/Makefile                    |   3 +-
 arch/arm64/kernel/asm-offsets.c               |   2 -
 arch/arm64/kernel/cpu_errata.c                | 242 ++++++++++++------
 arch/arm64/kernel/cpufeature.c                |  41 ++-
 arch/arm64/kernel/entry.S                     |  15 +-
 arch/arm64/kernel/sdei.c                      |   2 -
 arch/arm64/kernel/vmlinux.lds.S               |   8 -
 arch/arm64/kvm/Kconfig                        |   3 -
 arch/arm64/kvm/hyp/hyp-entry.S                |   4 -
 arch/arm64/kvm/hyp/switch.c                   |   4 -
 arch/arm64/mm/context.c                       |   6 -
 arch/arm64/mm/mmu.c                           |   2 -
 arch/arm64/mm/proc.S                          |   2 -
 20 files changed, 207 insertions(+), 230 deletions(-)

-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
