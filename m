Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67710C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:06:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39A50218E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kzm2tp0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A50218E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=7EthV465oWtikfHfq2CTqcz/5IW0lSwoU/MuNGef138=; b=kzm
	2tp0p/7PC4GU69MyyHBQWSt6+R43aTbCm/Sl4Ojeby1rG9u0h42fsAYmGp9EWWNgLc5kOLfbGEV6k
	oNs8eC8f0o0+KZpcw7mBx6E81wBfYaaetvHHm71PqKPnxD19Oi49fIUqarfPLR/53EFhczNNVU5gz
	pn9x7hdE1OvtykInO/vApbzSXukP+4zRD4O0fpJWMHPaWvsVeJEyZwbdbRzAxO2PwKCUAGIByuq7B
	q89663ng/ftDktGVW91nQ0a3yfm4nGmAZt3ozNkyoDEwBFES7MJNsN0OOqm1S2jCELkiTixR+b4+s
	d0cS4HnCih4X48bNBFsp8eJu70Ccz/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gynfe-00066v-Vu; Wed, 27 Feb 2019 01:06:02 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gynfa-00065x-Vp
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 01:06:00 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3C6480D;
 Tue, 26 Feb 2019 17:05:56 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com
 [10.118.12.119])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 100243F5C1;
 Tue, 26 Feb 2019 17:05:56 -0800 (PST)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 00/10] arm64: add system vulnerability sysfs entries
Date: Tue, 26 Feb 2019 19:05:34 -0600
Message-Id: <20190227010544.597579-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_170559_022963_178728F3 
X-CRM114-Status: GOOD (  10.27  )
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
Cc: mlangsdo@redhat.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
 catalin.marinas@arm.com, julien.thierry@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>,
 stefan.wahren@i2e.com, Andre.Przywara@arm.com, Dave.Martin@arm.com,
 shankerd@codeaurora.org
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

v4->v5:
	Revert the changes to remove the CONFIG_EXPERT hidden
	       options, but leave the detection paths building
	       without #ifdef wrappers. Also remove the
	       CONFIG_GENERIC_CPU_VULNERABILITIES #ifdefs
	       as we are 'select'ing the option in the Kconfig.
	       This allows us to keep all three variations of
	       the CONFIG/enable/disable paths without a lot of
	       (CONFIG_X || CONFIG_Y) checks.
	Various bits/pieces moved between the patches in an attempt
		to keep similar features/changes together.

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

Jeremy Linton (6):
  arm64: Provide a command line to disable spectre_v2 mitigation
  arm64: add sysfs vulnerability show for meltdown
  arm64: Always enable spectrev2 vulnerability detection
  arm64: add sysfs vulnerability show for spectre v2
  arm64: Always enable ssb vulnerability detection
  arm64: add sysfs vulnerability show for speculative store bypass

Marc Zyngier (2):
  arm64: Advertise mitigation of Spectre-v2, or lack thereof
  arm64: Use firmware to detect CPUs that are not affected by Spectre-v2

Mian Yousaf Kaukab (2):
  arm64: add sysfs vulnerability show for spectre v1
  arm64: enable generic CPU vulnerabilites support

 .../admin-guide/kernel-parameters.txt         |   8 +-
 arch/arm64/Kconfig                            |   1 +
 arch/arm64/include/asm/cpufeature.h           |   4 -
 arch/arm64/kernel/cpu_errata.c                | 239 +++++++++++++-----
 arch/arm64/kernel/cpufeature.c                |  47 +++-
 5 files changed, 216 insertions(+), 83 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
