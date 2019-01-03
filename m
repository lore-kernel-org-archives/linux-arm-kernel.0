Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E496AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:49:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFB0120815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fuPYOuBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB0120815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=UIlpsVsfMOx3rlJeLXnovYnPiGKpqZr8BcGWQZFVryk=; b=fuP
	YOuBDqq8cAkgKvaXeCLOr8RaMIlR6Cp+7tdJW0sdyBMOCWP2NPG5TN/UXmpSuzyNpJCsyqwuRlzgu
	10DqWLvBmXn43ue/8ZFDGu4Zb61zCMRRH8nK878H79C5tjlr9oxhvEsFyTiXXRsWHNj6Wbq+rYtzm
	a42sJzK1IEDZZVO8yo48Mhhy/ePz7wRBjMuPTnvdt37E78qr5W1gTGVxGC0WxnznhOyFNe0qt/rJS
	6yxAc1T5rF9paZv5lhfrNbUMbAZsAxknjd2sq2zxQEJjhnIEyxRutUlH3BZz1vXXVir7OPtBo5xUD
	v/NfpuWExb8kGQ/bf2sk58mN2VO3P1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gerCU-0000hJ-13; Thu, 03 Jan 2019 00:49:30 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gerCQ-0000gg-ER
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 00:49:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A54B80D;
 Wed,  2 Jan 2019 16:49:24 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com
 [10.118.12.119])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 425AC3F5AF;
 Wed,  2 Jan 2019 16:49:23 -0800 (PST)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/7] add system vulnerability sysfs entries
Date: Wed,  2 Jan 2019 18:49:14 -0600
Message-Id: <20190103004921.1928921-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_164926_492816_4D5E7F18 
X-CRM114-Status: UNSURE (   6.63  )
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
Cc: mark.rutland@arm.com, mlangsdo@redhat.com, suzuki.poulose@arm.com,
 marc.zyngier@arm.com, catalin.marinas@arm.com, julien.thierry@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 Jeremy Linton <jeremy.linton@arm.com>, steven.price@arm.com, ykaukab@suse.de,
 dave.martin@arm.com, shankerd@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series was originally by Mian Yousaf Kaukab.

Arm64 machines should be displaying a human readable
vulnerability status to speculative execution attacks in
/sys/devices/system/cpu/vulnerabilities 

This series enables that behavior by providing the expected
functions. Those functions expose the cpu errata and feature
states, as well as whether firmware is responding appropriately
to display the overall machine status. This means that in a
heterogeneous machine we will only claim the machine is mitigated
or safe if we are confident all booted cores are safe or
mitigated. Otherwise, we will display unknown or unsafe
depending on how much of the machine configuration can
be assured.

v1->v2:
	Add "Unknown" state to ABI/testing docs.
	Minor tweaks.
	
Jeremy Linton (3):
  sysfs/cpu: Add "Unknown" vulnerability state
  arm64: add sysfs vulnerability show for meltdown
  arm64: add sysfs vulnerability show for spectre v2

Mian Yousaf Kaukab (4):
  arm64: kpti: move check for non-vulnerable CPUs to a function
  arm64: add sysfs vulnerability show for spectre v1
  arm64: add sysfs vulnerability show for speculative store bypass
  arm64: enable generic CPU vulnerabilites support

 .../ABI/testing/sysfs-devices-system-cpu      |   1 +
 arch/arm64/Kconfig                            |   1 +
 arch/arm64/kernel/cpu_errata.c                | 107 +++++++++++++++++-
 arch/arm64/kernel/cpufeature.c                |  42 +++++--
 4 files changed, 138 insertions(+), 13 deletions(-)

-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
