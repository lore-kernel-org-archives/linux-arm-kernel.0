Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17998C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:56:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC1E620878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ORrm5Gw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1E620878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=tPHmdmtlhk53AoQSBzLsEz5XBHOUMbjhl2b18DVvuaU=; b=ORr
	m5Gw6gCUaiWsWJdT4JoawCEYAKoR939RVVZ36z+uXOvCHRoLMKcEcAxEiR3b/j2HoRwk62YhLyvvl
	GXxUVIxhSN/pZSvInddmEtxwTIq9K5FBsnxC/Le5rACiiG8MLlGLNUBdmXcv02FzZn15buEnUjS9r
	i9daj+c/trKxaKyC5pAJVWj3Ik7EfE2xai2KlYOVQS0Ls5ST9oW4dOrTWb58lRQP+xCBh5awDVa3v
	cjMWFnQZDRtBY8+hgaqSI+hOGnIlRWAnGqTprTVAL6T8+kfsGGQgIvFdA2DK+HhaYyACfO2YL9Lt9
	ZhozbnnZjtMWHpmd6WwXnl2mDJ7yMMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi5ij-0004Dm-Jf; Fri, 11 Jan 2019 22:56:09 +0000
Received: from inva021.nxp.com ([92.121.34.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi5ig-0004DG-2G
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 22:56:07 +0000
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B441A20016B;
 Fri, 11 Jan 2019 23:56:03 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7C7DF20004F;
 Fri, 11 Jan 2019 23:56:03 +0100 (CET)
Received: from someleo.am.freescale.net (someleo.am.freescale.net
 [10.81.33.49])
 by inv1260.us-phx01.nxp.com (Postfix) with ESMTP id B9B0D40CD6;
 Fri, 11 Jan 2019 15:56:02 -0700 (MST)
From: Li Yang <leoyang.li@nxp.com>
To: arm@kernel.org
Subject: [GIT PULL v2] updates to soc/fsl drivers for v5.1
Date: Fri, 11 Jan 2019 16:56:00 -0600
Message-Id: <20190111225600.16160-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_145606_243904_9BBEDDE3 
X-CRM114-Status: GOOD (  11.45  )
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
Cc: shawnguo@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi arm-soc maintainers,

This is an updated pull request to replace one problematic patch
regarding to guts driver.  Please ignore the last pull request.


The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v5.1-2

for you to fetch changes up to 3c0d64e867ed78a782a8a00d3b519396d9c5a2db:

  soc: fsl: guts: reuse machine name from device tree (2019-01-11 16:08:43 -0600)

----------------------------------------------------------------
NXP/FSL SoC driver updates for v5.1

DPIO driver
- Clean up the remove path in the dpio driver so that successive
  bind/unbind commands behave properly
- Add the ability to automatically create a device link between a
  consumer device on the fsl-mc bus and a supplier one
- Add prefetch to dpio dequeue to improve performance
- Update the type of dpio APIs to align with buffer pool id register
  field

guts driver
- Prevent allocation failure by reuse the machine type data from device
  tree directly

----------------------------------------------------------------
Ioana Ciocoi Radulescu (2):
      soc: fsl: dpio: Add prefetch instruction
      soc: fsl: dpio: Change bpid type to u16

Ioana Ciornei (6):
      soc: fsl: dpio: cleanup the cpu array on dpaa2_io_down
      soc: fsl: dpio: use a cpumask to identify which cpus are unused
      soc: fsl: dpio: keep a per dpio device MC portal
      soc: fsl: dpio: store a backpointer to the device backing the dpaa2_io
      soc: fsl: dpio: add a device_link at dpaa2_io_service_register
      bus: fsl-mc: automatically add a device_link on fsl_mc_[portal,object]_allocate

Li Yang (1):
      soc: fsl: guts: reuse machine name from device tree

Roy Pledge (1):
      soc: fsl: dpio: perform DPIO Reset on Probe

 drivers/bus/fsl-mc/fsl-mc-allocator.c            | 11 ++++++
 drivers/bus/fsl-mc/mc-io.c                       | 13 +++++++
 drivers/crypto/caam/caamalg_qi2.c                |  6 ++--
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c |  9 ++---
 drivers/soc/fsl/dpio/dpio-cmd.h                  |  1 +
 drivers/soc/fsl/dpio/dpio-driver.c               | 41 ++++++++++++---------
 drivers/soc/fsl/dpio/dpio-service.c              | 46 +++++++++++++++++++++---
 drivers/soc/fsl/dpio/dpio.c                      | 23 ++++++++++++
 drivers/soc/fsl/dpio/dpio.h                      |  4 +++
 drivers/soc/fsl/guts.c                           |  7 ++--
 include/linux/fsl/mc.h                           |  1 +
 include/soc/fsl/dpaa2-io.h                       | 15 +++++---
 12 files changed, 140 insertions(+), 37 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
