Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFC3C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:51:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69DA52084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o+zT/8ZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69DA52084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:Date:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=lWugk7weEWrnKuJKrqpix5mT1iDrPmXoOPWKlPj8k/w=; b=o+zT/8ZRgEaivD
	P+Qi9qnTJ2uXphLmd+Ru+b98yeuncdowAEa3wqXFghpf4T2kUZm8CrvLMekoms5AXGfzDR0uxNs8m
	r23JWEuhuYZEk0q4B6XduMndXwRZ5RBEqGCjc/X2Lb6xMdWy5DOu3M/rZ1BrwUy3mU3YS9dQ/35Vd
	ylF5oKkgQ19qCxdGroof7TN3zXzbKjM7j93OTjbRkKDeyd8faWZPR70DYdMgIwmlttjnp+r54Pqp4
	m2mnyKGN2YJzigFk82jZ+944PC57Oh7y89gOOU3dvPCQkG4H7ctJ3IG6s+TmtIQ90nLnt2GYxapvI
	BZBWidXF0T524pHu6XeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs9Ms-0004XI-Aj; Fri, 08 Feb 2019 16:51:10 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs9Mo-0004WT-NE
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 16:51:08 +0000
Received: from lupine.hi.pengutronix.de
 ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <p.zabel@pengutronix.de>)
 id 1gs9Mm-0006xQ-J0; Fri, 08 Feb 2019 17:51:04 +0100
Received: from pza by lupine with local (Exim 4.89)
 (envelope-from <p.zabel@pengutronix.de>)
 id 1gs9Mm-00079A-8y; Fri, 08 Feb 2019 17:51:04 +0100
Message-ID: <1549644664.24981.1.camel@pengutronix.de>
Subject: Reset controller changes for v5.1
From: Philipp Zabel <p.zabel@pengutronix.de>
To: arm@kernel.org
Date: Fri, 08 Feb 2019 17:51:04 +0100
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_085106_932666_D2935B82 
X-CRM114-Status: GOOD (  13.91  )
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
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Dear arm-soc maintainers,

The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-for-5.1

for you to fetch changes up to dbfc54534dfcaee004d54137d9b34d000f847e41:

  dt-bindings: reset: meson: add g12a bindings (2019-02-08 17:31:33 +0100)

----------------------------------------------------------------
Reset controller changes for v5.1

This adds the include/linux/reset directory to MAINTAINERS for reset
specific headers and adds headers for sunxi and socfpga in there to
get rid of a few extern function declarations.
There is a new reset driver for the Broadcom STB reset controller and
the i.MX7 system reset controller driver is extended to support i.MX8MQ
as well. Finally, there is a new header with reset id constants for
the Meson G12A SoC, which has a reset controller identical to Meson AXG
and thus can reuse its driver and DT bindings.

----------------------------------------------------------------
Andrey Smirnov (3):
      dt-bindings: reset: imx7: Document usage on i.MX8MQ SoCs
      reset: imx7: Add plubming to support multiple IP variants
      reset: imx7: Add support for i.MX8MQ IP block variant

Florian Fainelli (2):
      dt-bindings: reset: Add document for Broadcom STB reset controller
      reset: Add Broadcom STB SW_INIT reset controller driver

Jerome Brunet (1):
      dt-bindings: reset: meson: add g12a bindings

Philipp Zabel (3):
      MAINTAINERS: use include/linux/reset for reset controller related headers
      reset: sunxi: declare sun6i_reset_init in a header file
      reset: socfpga: declare socfpga_reset_init in a header file

 .../bindings/reset/brcm,brcmstb-reset.txt          |  27 ++++
 .../devicetree/bindings/reset/fsl,imx7-src.txt     |   7 +-
 MAINTAINERS                                        |   1 +
 arch/arm/mach-socfpga/socfpga.c                    |   3 +-
 arch/arm/mach-sunxi/sunxi.c                        |   2 +-
 drivers/reset/Kconfig                              |  12 +-
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-brcmstb.c                      | 132 ++++++++++++++++
 drivers/reset/reset-imx7.c                         | 172 +++++++++++++++++++--
 drivers/reset/reset-socfpga.c                      |   2 +-
 drivers/reset/reset-sunxi.c                        |   1 +
 .../dt-bindings/reset/amlogic,meson-g12a-reset.h   | 134 ++++++++++++++++
 include/dt-bindings/reset/imx8mq-reset.h           |  64 ++++++++
 include/linux/reset/socfpga.h                      |   7 +
 include/linux/reset/sunxi.h                        |   7 +
 15 files changed, 550 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt
 create mode 100644 drivers/reset/reset-brcmstb.c
 create mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-reset.h
 create mode 100644 include/dt-bindings/reset/imx8mq-reset.h
 create mode 100644 include/linux/reset/socfpga.h
 create mode 100644 include/linux/reset/sunxi.h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
