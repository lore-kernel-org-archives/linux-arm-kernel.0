Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1EFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:35:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3487F20685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Opk8Mlxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3487F20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=dUshlq4k6nPp+xsQUS/ty2Q5Ev3rc0gdkpBFxhKRhmU=; b=Opk
	8Mlxk7cJ+46DkVxyjDjo5Ss+ksFYKvToV5AENRJt1YX8ErApaGaq1ja/lwUulEUU8viTXzBWjojvQ
	s1XyEA38AeczrKDf+pnml4pFMERfc5JuZwn9MVsw4lBceb7eeL2+jiHbeBNrq2BLQqH5+JMIvS06e
	sB7tMpj3z08Q0LREA2m2i1vJi2pfyAOXJp5qIewM9NOCbZl7Nd2N70uylv49IEBgOAdV4zyG5P2xe
	WtpRECEsdESM3vL2RlAcqM2IRaGlA8FOnnskqSDZXoKWl4dGvKu22kWI0pDL/1zqat4ycNshuwlSg
	/CNA6a2nm2FIPvJWpgcUugQN1L8oIRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghLV9-00045E-Vw; Wed, 09 Jan 2019 21:35:03 +0000
Received: from inva020.nxp.com ([92.121.34.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghLUs-0003oc-HN
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 21:35:01 +0000
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 67B221A00CD;
 Wed,  9 Jan 2019 22:34:43 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 284421A0077;
 Wed,  9 Jan 2019 22:34:43 +0100 (CET)
Received: from someleo.am.freescale.net (someleo.am.freescale.net
 [10.81.33.49])
 by inv1260.us-phx01.nxp.com (Postfix) with ESMTP id 6893E40CAF;
 Wed,  9 Jan 2019 14:34:42 -0700 (MST)
From: Li Yang <leoyang.li@nxp.com>
To: arm@kernel.org
Subject: [GIT PULL] updates to soc/fsl drivers for v5.1
Date: Wed,  9 Jan 2019 15:34:42 -0600
Message-Id: <20190109213442.14821-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_133447_527452_E5974005 
X-CRM114-Status: GOOD (  10.58  )
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

Please help to look into the following changes and merge them if
they look good.


The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v5.1

for you to fetch changes up to ffe9670a44674ba38b7246e6134de297adad30a3:

  soc: fsl: dpio: Change bpid type to u16 (2019-01-09 14:52:13 -0600)

----------------------------------------------------------------
NXP/FSL SoC driver updates for v5.1

- Clean up the remove path in the dpio driver so that successive
  bind/unbind commands behave properly
- Add the ability to automatically create a device link between a
  consumer device on the fsl-mc bus and a supplier one
- Use devm_kstrdup_const() for RO data and prevent potential NULL
  dereference on allocation failure in guts driver
- Add prefetch to dpio dequeue to improve performance
- Update the type of dpio APIs to align with buffer pool id register
  field

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

Nicholas Mc Guire (1):
      soc: fsl: guts: us devm_kstrdup_const() for RO data

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
 drivers/soc/fsl/guts.c                           |  3 +-
 include/linux/fsl/mc.h                           |  1 +
 include/soc/fsl/dpaa2-io.h                       | 15 +++++---
 12 files changed, 138 insertions(+), 35 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
