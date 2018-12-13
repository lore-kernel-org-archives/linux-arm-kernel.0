Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AAAC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:34:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 112FE20645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tnV2BgXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112FE20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Ax3bkW0udhj4SFrpiie9unKnL7hLUP+l9DcA3IG4TIg=; b=tnV2BgXX5oVBzL
	KDzA2lp8lgo68KAE2E3Wdo0nIXq49+h475Ht0HGgF+K24LcwkH/224MCvcCsIZJ+b/WfcM11JkHqY
	bT6U/IZ2lhOXj/WMdNTnuyQXfVl/8KR2+URhCygENjllRnHEfm3MFB4RdKcLKZ6X8X2kG+DoWz3YT
	YXZ5LW1CeZHLLpcNt2PP/c1Cq4AMS1QFfH6i3XUU94MxIZoJOtuFkIfIdzxFttqsXLFKPQhgC3ZBy
	6M679FApgi3cJrR1+Ni7TteCYdMkkeeWZ7BcZkH0GUQIvHKmdrYeyrgFsdaaX9MyzntSfx9LIXKJQ
	Oub+6UBtkHFom7PiS2LA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQCL-0001RM-T4; Thu, 13 Dec 2018 12:34:37 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQCI-0001GL-8z
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 12:34:35 +0000
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7]
 helo=dude.pengutronix.de.)
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <p.zabel@pengutronix.de>)
 id 1gXQBv-0005iT-Cy; Thu, 13 Dec 2018 13:34:11 +0100
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Dinh Nguyen <dinguyen@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 0/2] reset: socfpga,
 sunxi: declare _reset_init functions in header files
Date: Thu, 13 Dec 2018 13:33:56 +0100
Message-Id: <20181213123358.24391-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_043434_477892_C7F11F82 
X-CRM114-Status: GOOD (  11.46  )
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
Cc: Olof Johansson <olof@lixom.net>, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

this moves the socpfga_reset_init function declaration into a header
file that is included by both mach-socfpga and reset-socfpga code,
as suggested by Stephen. The second patch does the same for
sun6i_reset_init.

Since the socfpga patch avoids a (trivial) merge conflict with the
arm-soc tree, I'd like to apply this to the reset/next branch before
sending a pull request.

regards
Philipp

Philipp Zabel (2):
  reset: sunxi: declare sun6i_reset_init in a header file
  reset: socfpga: declare socfpga_reset_init in a header file

 arch/arm/mach-socfpga/socfpga.c | 3 +--
 arch/arm/mach-sunxi/sunxi.c     | 2 +-
 drivers/reset/reset-socfpga.c   | 2 +-
 drivers/reset/reset-sunxi.c     | 1 +
 include/linux/reset/socfpga.h   | 7 +++++++
 include/linux/reset/sunxi.h     | 7 +++++++
 6 files changed, 18 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/reset/socfpga.h
 create mode 100644 include/linux/reset/sunxi.h

-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
