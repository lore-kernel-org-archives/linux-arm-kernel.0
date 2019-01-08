Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB0AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:02:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D424214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jvtu0zW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D424214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:Date:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=cQ25CR0lHyhTGed71ov5WhHoASleZUg4dXcWyuTcbvQ=; b=jvtu0zW83X/Tvz
	ALEjp/85CzokcGtyGOwj0RoiISt3QLPsRB8JWhHrF1Ck35KuTSk39CP0xFas9d4efyVlBBfhDnSJU
	cj4agRTodtcMe29Z133Bs+rjP2mMbfvim3bxNA0/ooQZNV6fWUihhu9MO0EWapWomKO3oQKaBwjPO
	j6qRfsMD7RyIDCz47o7FAxitW0b2ju9qHTJ7MvMRTow/VoqPnP21R9Dm9dc7cqw+U9rNtJkgGze9E
	P0BLas9BrXLBEmp0W56pdn31ea1DLbvXqYJ+QYa1lWeoJTE2+/aAwomgJEKsBUUbbCmya81fElpsk
	tRkXJ+JBrzz7X48wSpRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggulU-0007W0-P3; Tue, 08 Jan 2019 17:02:08 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggulD-0007Iw-Gz
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 17:02:05 +0000
Received: from lupine.hi.pengutronix.de
 ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <p.zabel@pengutronix.de>)
 id 1ggul9-0003Il-LC; Tue, 08 Jan 2019 18:01:47 +0100
Message-ID: <1546966907.5406.17.camel@pengutronix.de>
Subject: [RFC, GIT PULL] Late reset controller changes for v5.0
From: Philipp Zabel <p.zabel@pengutronix.de>
To: arm@kernel.org, Olof Johansson <olof@lixom.net>, Arnd Bergmann
 <arnd@arndb.de>
Date: Tue, 08 Jan 2019 18:01:47 +0100
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_090152_175457_8B04753E 
X-CRM114-Status: GOOD (  14.67  )
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
Cc: Dinh Nguyen <dinguyen@kernel.org>, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Dear arm-soc maintainers,

due to a combination of a late merge conflict, early holidays, and the
common cold, I have failed to send the last reset controller pull
request in time for the v5.0-rc1 merge window. As usual there are not
many changes, and they have been carried in linux-next for quite a
while.

One of the changes, commit b3ca9888f35f ("reset: socfpga: add an early
reset driver for SoCFPGA") is necessary for the Stratix10 platform to
boot, since the already merged change 8bb4f3f55961 ("arm64: dts:
stratix10: use "altr,stratix10-rst-mgr" binding") depends on it.

Can you take the whole lot for v5.0-rc2? Should I split out the SoCFPGA
early reset patch + the NULL pointer dereference fix into a separate
"fixes" pull request for v5.0-rc2, postponing the other patches to for-
v5.1? Or do we have to revert 8bb4f3f55961 for now? Please advise.

regards
Philipp


The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-for-5.0-rc2

for you to fetch changes up to d0c2d2101b4c1a41e6ebeca6a28c70df43d2a6a3:

  reset: uniphier-glue: Add AHCI reset control support in glue layer (2019-01-07 16:38:51 +0100)

----------------------------------------------------------------
Late reset controller changes for v5.0

This adds missing deassert functionality to the ARC HSDK reset driver,
fixes some indentation and grammar issues in the kernel docs, adds a
helper to count the number of resets on a device for the non-DT case
as well, adds an early reset driver for SoCFPGA and simple reset driver
support for Stratix10, and generalizes the uniphier USB3 glue layer
reset to also cover AHCI.

----------------------------------------------------------------
Colin Ian King (1):
      reset: fix null pointer dereference on dev by dev_name

Dinh Nguyen (2):
      reset: socfpga: add an early reset driver for SoCFPGA
      ARM: socfpga: dts: document "altr,stratix10-rst-mgr" binding

Eugeniy Paltsev (1):
      ARC: HSDK: improve reset driver

Geert Uytterhoeven (2):
      reset: Improve reset controller kernel docs
      reset: Add reset_control_get_count()

Kunihiko Hayashi (4):
      dt-bindings: reset: uniphier: Replace the expression of USB3 with generic peripherals
      reset: uniphier-usb3: Rename to reset-uniphier-glue
      dt-bindings: reset: uniphier: Add AHCI core reset description
      reset: uniphier-glue: Add AHCI reset control support in glue layer

 .../devicetree/bindings/reset/socfpga-reset.txt    |  3 +-
 .../devicetree/bindings/reset/uniphier-reset.txt   | 25 +++---
 arch/arm/mach-socfpga/socfpga.c                    |  4 +
 drivers/reset/Kconfig                              | 20 +++--
 drivers/reset/Makefile                             |  3 +-
 drivers/reset/core.c                               | 42 +++++++++++
 drivers/reset/reset-hsdk.c                         |  1 +
 drivers/reset/reset-simple.c                       | 13 +---
 drivers/reset/reset-socfpga.c                      | 88 ++++++++++++++++++++++
 ...reset-uniphier-usb3.c => reset-uniphier-glue.c} | 50 +++++++-----
 include/linux/reset.h                              | 15 +++-
 11 files changed, 212 insertions(+), 52 deletions(-)
 create mode 100644 drivers/reset/reset-socfpga.c
 rename drivers/reset/{reset-uniphier-usb3.c => reset-uniphier-glue.c} (73%)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
