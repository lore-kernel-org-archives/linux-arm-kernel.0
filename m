Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B625FC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:26:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85FEC206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pSjGbiLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85FEC206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nusmV8DMQcX0LnO/UD/vgBfB6b6pK3uCyQHi7fH5iPg=; b=pSjGbiLQ4SBICO
	HvfSmMR7UYFCg2VPG00svVbjdtt8A/TFY9mUSrovrDTqSt0/xj/spwtrxeZZQNmeDf7MWfpy8GI3Z
	OHuGP9p7ZcupyzfKM9K/jjWVqDZ8VD4LLVVGEfzTEofq8R3UbZWnZzwImGVzc7N/m8qxZvlB4iRf4
	Bid4XzYabBkQ/M3yFoNwbXCP7s+5FwNYeU7RLY49RxvaQp2CNGnaXRM97E+tJkRGx+cm4j777KSZY
	4WImM7zzqEcbMCSaxWCZ+e3K5s7N760RETsiWx9xUOL2b5IydYiC44hPjHLv0QhT8vDe+CjcCjd0+
	VjeLHNNzIE4w+406RDnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUTRo-0007AJ-Lw; Wed, 05 Dec 2018 09:26:24 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUTQr-0006HG-4P
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 09:25:28 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id A75BC20A62; Wed,  5 Dec 2018 10:25:13 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 46A742037D;
 Wed,  5 Dec 2018 10:25:03 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devel@driverdev.osuosl.org
Subject: [PATCH v2 00/15] Cedrus H5 and A64 support with A33 and H3 updates
Date: Wed,  5 Dec 2018 10:24:29 +0100
Message-Id: <20181205092444.29497-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_012525_538070_E7C14254 
X-CRM114-Status: GOOD (  12.92  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Hans Verkuil <hverkuil@xs4all.nl>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, linux-sunxi@googlegroups.com,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series adds support for the Allwinner H5 and A64 platforms to the
cedrus stateless video codec driver, with minor updates to the A33 and
H3 platforms.

It requires changes to the SRAM driver bindings and driver, to properly
support the H5 and the A64 C1 SRAM section. Because a H5-specific
system-control node is introduced, the dummy syscon node that was shared
between the H3 and H5 is removed in favor of each platform-specific node.
A few fixes are included to ensure that the EMAC clock configuration
register is still accessible through the sunxi SRAM driver (instead of the
dummy syscon node, that was there for this purpose) on the H3 and H5.

The reserved memory nodes for the A33 and H3 are also removed in this
series, since they are not actually necessary.

Changes since v1:
* Removed the reserved-memory nodes for the A64 and H5;
* Removed the reserved-memory nodes for the A33 and H3;
* Corrected the SRAM bases and sizes to the best of our knowledge;
* Dropped cosmetic dt changes already included in the sunxi tree.

Paul Kocialkowski (15):
  ARM: dts: sun8i: h3: Fix the system-control register range
  ARM: dts: sun8i: a33: Remove unnecessary reserved memory node
  ARM: dts: sun8i: h3: Remove unnecessary reserved memory node
  soc: sunxi: sram: Enable EMAC clock access for H3 variant
  dt-bindings: sram: sunxi: Add bindings for the H5 with SRAM C1
  soc: sunxi: sram: Add support for the H5 SoC system control
  arm64: dts: allwinner: h5: Add system-control node with SRAM C1
  ARM/arm64: sunxi: Move H3/H5 syscon label over to soc-specific nodes
  dt-bindings: sram: sunxi: Add compatible for the A64 SRAM C1
  arm64: dts: allwinner: a64: Add support for the SRAM C1 section
  dt-bindings: media: cedrus: Add compatibles for the A64 and H5
  media: cedrus: Add device-tree compatible and variant for H5 support
  media: cedrus: Add device-tree compatible and variant for A64 support
  arm64: dts: allwinner: h5: Add Video Engine node
  arm64: dts: allwinner: a64: Add Video Engine node

 .../devicetree/bindings/media/cedrus.txt      |  2 ++
 .../devicetree/bindings/sram/sunxi-sram.txt   |  5 +++
 arch/arm/boot/dts/sun8i-a33.dtsi              | 15 ---------
 arch/arm/boot/dts/sun8i-h3.dtsi               | 18 ++--------
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  6 ----
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 25 ++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  | 33 +++++++++++++++++++
 drivers/soc/sunxi/sunxi_sram.c                | 10 +++++-
 drivers/staging/media/sunxi/cedrus/cedrus.c   | 16 +++++++++
 9 files changed, 92 insertions(+), 38 deletions(-)

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
