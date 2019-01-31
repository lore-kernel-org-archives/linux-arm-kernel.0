Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93ABFC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:25:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D29220B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vb/wms1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D29220B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MLSaOJTSH3BrLixnutOX8oK6gAxNdLAby8WVj5bFnN4=; b=Vb/wms1eRI1sqZ
	H3WRa5ayh/ZOY+7RHmrktkkdB7Wkrk7pRhF0LSC6g2Cfw4mMK9Vf8kzK3A8Gs4JSpIS+/qv8lASr/
	uqTEGxsTkEig446zcpkBCAQ5mxy5fZJk+SmDv+r7Q6kCOIekbC5Xg3r0EU3T3ZFs87xcjIbwqGinY
	je+G6OphNYG+By3kcggwbYPckR7CsFeyVwSPSu/e1d7+zvNo4xoFxnWn5E77HJtCppoG5ndWKNmVU
	NTmw9KrbJPYQFKSGwl+lF6vop8u35EwTjyexRoLAydk8Uqi1bcAgv7Ma4Sz1Bp6tvA2+tVEItyeqs
	eMk6d7G/cKQGSrAaWkyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpF96-0003Hp-6l; Thu, 31 Jan 2019 16:24:56 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpF8M-00031b-Sj
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 16:24:12 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id 6B5D4809F;
 Thu, 31 Jan 2019 16:24:19 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: arm@kernel.org
Subject: [GIT PULL 2/3] dts changes for ti81xx for v5.1
Date: Thu, 31 Jan 2019 08:23:55 -0800
Message-Id: <pull-1548951676-587288@atomide.com-2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <pull-1548951676-587288@atomide.com>
References: <pull-1548951676-587288@atomide.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_082410_962357_108E01CA 
X-CRM114-Status: GOOD (  10.06  )
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit d27cda291b2341d39692421b4e64940879ff9dd8:

  ARM: ti81xx: Add hwmod boilerplate for all GPIO and SPI peripherals (2019-01-24 08:43:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.1/dt-ti-81xx-signed

for you to fetch changes up to d031773169df2de868c1b6ff75679ddac5d4a7ec:

  ARM: dts: Adds device tree file for McGill's IceBoard, based on TI AM3874 (2019-01-24 10:22:43 -0800)

----------------------------------------------------------------
dts updates for ti81xx for v5.1 merge window

Two changes to add support for McGill University's IceBoard telescope
ARM + FPGA instrumentation board. This board is used for several
telescopes around the world, see the related device tree commit for
some interesting links for more information.

Note that these changes are based on the related ti81xx soc changes.

----------------------------------------------------------------
Graeme Smecher (2):
      ARM: dts: ti81xx: Add dts boilerplate for all GPIO and SPI peripherals
      ARM: dts: Adds device tree file for McGill's IceBoard, based on TI AM3874

 arch/arm/boot/dts/Makefile            |   1 +
 arch/arm/boot/dts/am3874-iceboard.dts | 496 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dm814x.dtsi         |  64 ++++-
 3 files changed, 560 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/am3874-iceboard.dts

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
