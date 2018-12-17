Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B510AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:32:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CE7420874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bSyMJ5RD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNLrM5r0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE7420874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=3HZyGqTFooYs1YN2e2+u3OdN3fieY1e/Zam88ox+NBc=; b=bSyMJ5RDCUm/tP
	1zZxZBy+euaMc2Ne4liRIuThmKU+Z1e5Cl74uo0pT8jVzOdPkMo/o+v7BVYhkFoe9eC4QJkfzDbkm
	CcjAlNTShCjwKVUC+Cdh0gWZJgHEzJW37Emh5qQvU0rLLVkKDY+6CWFPPBc3rpCEKZm/vSqkoFVXD
	4HXJ1EpHxi8gsmm5/pgSc07/Je1wic4/EexWAJvqLziredjZ2qMKdOvyBrlvrWHYMx6WSllRxAhAw
	C4wabOQZXnKxKwVD1hmiNCdTyukEqWKrmdRSYb7O4u/zTqUnsvnCHBwLIOT+NYleLEHPHW8DLvlaX
	CQLdxBxjhb8K0QFocUWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYt04-0004T5-Sn; Mon, 17 Dec 2018 13:32:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYt01-0004SA-V3
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 13:31:59 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5329320874;
 Mon, 17 Dec 2018 13:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545053507;
 bh=RROCKWO7y99FBn51hx7L9DPJ6Fqnzv6/FKM4opZeHo8=;
 h=Date:From:To:Cc:Subject:From;
 b=ZNLrM5r0L1WCq244DdR3MbyFRFl1FLxKBCK02xIJbayyvgL2fhRFnIv66Puj9BNW/
 XZnPjdqwNm3Rp6jSs89Sgqcb+J9ZNbSkFJic6BUqSnKBp4NpzzBboSo3s0WLDzIe+v
 a1S6Xsdzp5Q4Ms/rKI2I0Im3ppYDlQeVm8cW10Bk=
Date: Mon, 17 Dec 2018 21:30:37 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: arm@kernel.org
Subject: [GIT PULL] i.MX8MQ device tree support for 4.21
Message-ID: <20181217133036.GA24973@dragon>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_053158_017195_A58E2CCE 
X-CRM114-Status: GOOD (  13.70  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Stephen Boyd <sboyd@kernel.org>,
 linux-imx@nxp.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

It's the initial device tree support for the first ARM64 i.MX processor,
which has been floating around for a couple of release cycles.  Due to
the last minute discussion on fine-grind SoC specific option, it comes
late.  But we appreciate that you consider to pull it for 4.21, as we
have more development lined up based on this initial support.  Thanks.

Note: the pull request is based on tag imx-dt64-4.21 (already pulled)
with one stable commit from clk tree merged in to resolve dependency on
i.MX8MQ clock ID.

Shawn


The following changes since commit 35a38903b9a579f5c6305b4424fdd715aec75eef:

  Merge commit '1cf3817bf1f52e57b3f5eb0413ee0d7f0c2e9829' into imx8mq/dt (2018-12-16 17:27:56 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx8mq-4.21

for you to fetch changes up to 3bbc9abbfb8cc6d76b388699501eeda005850929:

  arm64: dts: imx8mq-evk: enable watchdog (2018-12-16 17:28:02 +0800)

----------------------------------------------------------------
i.MX8MQ device tree support for 4.21:
 - It contains the initial device tree support for i.MX8MQ - the first
   ARM64 i.MX processor.  It features a quad Cortex-A53 core that
   operates at speeds of up to 1.3 GHz, a Cortex-M4 core for
   low-power processing, a DRAM controller that supports 32-bit/16-bit
   LPDDR4/DDR4/DDR3L memory, and hardware acceleration for 4K video
   playback.
 - A couple of patches from Baruch that add watchdog device for i.MX8MQ
   enable it for imx8mq-evk board.

----------------------------------------------------------------
Baruch Siach (2):
      arm64: dts: imx8mq: add watchdog devices
      arm64: dts: imx8mq-evk: enable watchdog

Lucas Stach (4):
      arm64: add basic Kconfig symbols for i.MX8
      arm64: add basic DTS for i.MX8MQ
      arm64: add support for i.MX8M EVK board
      MAINTAINERS: add i.MX8 DT path to i.MX architecture

 MAINTAINERS                                    |   1 +
 arch/arm64/Kconfig.platforms                   |   8 +
 arch/arm64/boot/dts/freescale/Makefile         |   2 +
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts   | 303 ++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h | 623 +++++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi      | 416 +++++++++++++++++
 6 files changed, 1353 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-evk.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq.dtsi

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
